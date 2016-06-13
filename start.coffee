require("./Number")
{readFileSync} = require "fs"
JSONfromHTTPRequest = require("body/json")
Cryptography = require('crypto')
Immutable = require('immutable')
files = require("facts")()

Scripts =
  d3: readFileSync "d3.min.js", "UTF-8"
  facts: readFileSync "Facts.pack.js", "UTF-8"


instruments = require("facts")()
instruments.datoms = Immutable.Stack(Immutable.fromJS(require("./instruments.datoms.json")))

# console.info instruments.query()

instruments.on "transaction", ->
  write "instruments.datoms.json", JSON.stringify(instruments.datoms, undefined, "  "), "UTF-8", (error) ->
    if error then throw error
    console.info "SAVED":"instruments.datoms.json"

service = require("http").createServer (request, response) ->
  console.info request:identifier=decodeURIComponent(request.url.replace("/",""))
  switch
    when request.method is "POST"
      switch
        when identifier is ""
          JSONfromHTTPRequest request, (error, data) ->
            console.info "POST":data
            if error then throw error
            addInstrument data.location
            response.writeHead 201, "Content-Length":2, "Content-Type":"application/json; charset=UTF-8"
            response.end "[]"
        when identifier.length is 64
          JSONfromHTTPRequest request, (error, input) ->
            console.info "POST #{identifier}":input
            if error then throw error
            instruments.advance identifier, input
            response.writeHead 201, "Content-Length":2, "Content-Type":"application/json; charset=UTF-8"
            response.end "[]"
        else
          response.writeHead 500, "Content-Length":0
          response.end()

    when identifier is "database.json"
      database = instruments.database()
      serialized = JSON.stringify(instruments.database(), undefined, "  ")
      outputBuffer = new Buffer serialized, "UTF-8"
      send response, out =
        file:"database.json"
        type:"application/json; charset=UTF-8"
        size:outputBuffer.length
        data:outputBuffer
      write "database.json", serialized, "UTF8"
    when identifier is ""
      indexHTML (error, HTML) ->
        if error then throw error
        outputBuffer = new Buffer HTML, "UTF-8"
        send response, output =
          file:"index.html"
          type:"text/html; charset=UTF-8"
          size:outputBuffer.length
          data:outputBuffer
        write "index.html", HTML, "UTF8"
    when /js/.test identifier
      sendScript(identifier, response)
    when /png|jpg|svg|woff/.test identifier
      sendBinary(identifier, response)
    else
      console.error unhandled:identifier
      response.writeHead 404, "Content-Length":0
      response.end()

service.listen 8080, (error) ->
  if error then throw error else console.info listening:service.address()

addInstrument = (location, callback) ->
  switch
    when location.match("kijiji") then addInstrument.fromKijiji(location, callback)
    else throw "unknown instrument host"

Kijiji = require "./kijiji"

addInstrument.fromKijiji = (location, callback) ->
  Kijiji.read location, (error, output) ->
    throw error if error
    address = output.address
    identifier = identifyInstrumentAddress(address)
    instruments.advance identifier, output
    console.info identifier:output
    callback error, identifier

identifyInstrumentAddress = (address) ->
  hash = Cryptography.createHash('sha256')
  hash.update(address)
  hash.digest('hex')


indexHTML = (callback) ->
  callback undefined, """
    <!DOCTYPE HTML>
    <meta charset="UTF-8">
    <meta description="A growing index of left handed guitars and basses for sale. Prices are in Canadian Dollars.">
    <meta keywords="lefty left-handed left-hand lefthand guitar bass guitars basses electric acoustic for sale 🐢">
    <meta name="author" content="Painted Turtle Instruments">
    <title>Lefty Guitars For Sale Under $1000 CAD</title>
    <script charset="UTF-8">
    #{Scripts.d3}
    #{Scripts.facts}
    #{compile readFileSync "Number.coffee", "UTF-8"}
    #{compile readFileSync "document.coffee", "UTF-8"}
    #{compile readFileSync "index.coffee", "UTF-8"}
    window.instruments = Facts()
    window.instruments.datoms = Immutable.Stack(Immutable.fromJS(#{JSON.stringify(instruments.database())}))
    </script>
  """

sendScript = (identifier, response) ->
  if script = files.pull(identifier)
    send response, out =
      file:identifier
      type:"application/ecmascript; charset=UTF-8"
      size:script.size
      data:script.data
  else
    initialize identifier, -> sendScript(identifier, response)

sendBinary = (identifier, response) ->
  read identifier, (error, data) ->
    if error then throw error else send response, output =
      file:identifier
      type:mime.lookup(identifier)
      size:data.length
      data:data

send = (response, output) ->
  response.writeHead 200, "Content-Length":output.size, "Content-Type":output.type
  response.end output.data

  console.info "send":
    file: output.file
    type: output.type
    size: output.size
    data: output.data.constructor.name

initialize = (identifier, done) ->
  if files.pull(identifier) is undefined
    watch identifier, (event) -> if event is "change" then memorize identifier
    console.info watching:identifier
    memorize identifier, done
  else
    done()

memorize = (identifier, done) ->
  read identifier, (error, data) ->
    files.advance identifier,
      size:data.length
      data:data.toString("UTF-8")
    console.info memorized:identifier
    if done then done()

compile = require("coffee-script").compile

echo = (identifier) -> files.pull(identifier).data

exec = require("child_process").exec

mime = require("mime")

parallel = require("async").parallel

read = require("fs").readFile

watch = require("fs").watch

write = require("fs").writeFile


advanceOldestArticle = ->
  articles = instruments.query()
    .filter (article) -> article.approved?
    .filter (article) -> article.expired is undefined
    .sort (a, b) -> a["access time"] - b["access time"]
  article = articles[0]
  if article["access time"] < (Date.now() - 30.minutes())
    console.info "READ #{article.id}":article.address
    Kijiji.read article.address, (error, output) ->
      if error then throw error
      advancements = {"access time":Date.now()}
      advancements[key] = value unless Immutable.is Immutable.fromJS(value), Immutable.fromJS(article[key]) for key, value of output
      console.info "PULL #{article.id}":advancements
      instruments.advance article.id, advancements

setInterval advanceOldestArticle, 2.seconds()

findNovelArticles = ->
  Kijiji.sources.forEach (source) ->
    Kijiji.Search.read source, (error, addresses) ->
      novelAddresses = addresses.filter (address) -> instruments.pull(identifyInstrumentAddress(address)) is undefined
      console.info "#{source} novelty": novelAddresses
      novelAddresses.forEach (address) -> addInstrument.fromKijiji(address, (error, identifier) ->)

# setTimeout findNovelArticles, 15.seconds()
