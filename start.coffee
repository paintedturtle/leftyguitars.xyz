require("./Number")
{readFileSync} = require "fs"
JSONfromHTTPRequest = require("body/json")
Cryptography = require('crypto')
Immutable = require('immutable')
files = require("facts")()


Scripts =
  d3: readFileSync "d3.min.js", "UTF-8"
  facts: readFileSync "Facts.pack.js", "UTF-8"

sources = """
  http://www.kijiji.ca/b-guitar/alberta/lefty/k0c613l9003?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/alberta/left-handed/k0c613l9003?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/alberta/left-hand/k0c613l9003?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/alberta/lefthand/k0c613l9003?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/british-columbia/lefty/k0c613l9007?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/british-columbia/left-handed/k0c613l9007?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/british-columbia/left-hand/k0c613l9007?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/british-columbia/lefthand/k0c613l9007?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/manitoba/lefty/k0c613l9006?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/manitoba/left-handed/k0c613l9006?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/manitoba/left-hand/k0c613l9006?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/manitoba/lefthand/k0c613l9006?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/new-brunswick/lefty/k0c613l9005?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/new-brunswick/left-handed/k0c613l9005?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/new-brunswick/left-hand/k0c613l9005?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/new-brunswick/lefthand/k0c613l9005?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/nova-scotia/lefty/k0c613l9002?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/nova-scotia/left-handed/k0c613l9002?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/nova-scotia/left-hand/k0c613l9002?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/nova-scotia/lefthand/k0c613l9002?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/ontario/lefty/k0c613l9004?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/ontario/left-handed/k0c613l9004?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/ontario/left-hand/k0c613l9004?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/ontario/lefthand/k0c613l9004?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitare/quebec/lefty/k0c613l9001?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitare/quebec/left-handed/k0c613l9001?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitare/quebec/left-hand/k0c613l9001?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitare/quebec/lefthand/k0c613l9001?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitare/quebec/gauchère/k0c613l9001?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/saskatchewan/lefty/k0c613l9009?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/saskatchewan/left-handed/k0c613l9009?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/saskatchewan/left-hand/k0c613l9009?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/saskatchewan/lefthand/k0c613l9009?price=__1000
  http://www.kijiji.ca/b-guitar/territories/lefty/k0c613l9010?price=__1000
  http://www.kijiji.ca/b-guitar/territories/left-handed/k0c613l9010?price=__1000
  http://www.kijiji.ca/b-guitar/territories/left-hand/k0c613l9010?price=__1000
  http://www.kijiji.ca/b-guitar/territories/lefthand/k0c613l9010?price=__1000
  http://www.kijiji.ca/b-guitar/prince-edward-island/lefty/k0c613l9011?price=__1000
  http://www.kijiji.ca/b-guitar/prince-edward-island/left-handed/k0c613l9011?price=__1000
  http://www.kijiji.ca/b-guitar/prince-edward-island/left-hand/k0c613l9011?price=__1000
  http://www.kijiji.ca/b-guitar/prince-edward-island/lefthand/k0c613l9011?price=__1000
""".split("\n")

console.info sources

instruments = require("facts")()
instruments.datoms = Immutable.Stack(Immutable.fromJS(require("./instruments.datoms.json")))

# console.info instruments.query()

instruments.on "transaction", ->
  write "instruments.datoms.json", JSON.stringify(instruments.datoms, undefined, "  "), "UTF-8", (error) ->
    console.error error if error
    console.info "Wrote instruments.datoms.json to file system"

service = require("http").createServer (request, response) ->
  console.info request:identifier=decodeURIComponent(request.url.replace("/",""))
  switch
    when request.method is "POST"
      switch
        when identifier is ""
          JSONfromHTTPRequest request, (error, data) ->
            console.info post:data
            addInstrument data.location
            response.writeHead 201, "Content-Length":2, "Content-Type":"application/json; charset=UTF-8"
            response.end "[]"
        when identifier.length is 64
          console.info {identifier}
          JSONfromHTTPRequest request, (error, data) ->
            console.info post:data
            instruments.advance identifier, {pocketd:yes}
            response.writeHead 201, "Content-Length":2, "Content-Type":"application/json; charset=UTF-8"
            response.end "[]"
        else
          response.writeHead 500, "Content-Length":0, "Content-Type":"text/plain; charset=UTF-8"
          response.end ""

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
    when identifier in [""]
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
  if error then throw error
  console.info listening:service.address()
  # console.info opening:"http://localhost:8080/index.html"
  # exec "open http://localhost:8080/index.html", (error, stdout, stderr) ->
  #   if error then console.error(stderr) and throw error else console.info(stdout)

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
  articles = instruments.query().sort (a, b) ->
    a["access time"] - b["access time"]
  article = articles[0]
  return if article["access time"] > (Date.now() - 45.minutes())
  console.info "Advancing stale article":article
  console.info before:article
  Kijiji.read article.address, (error, output) ->
    console.error error if error
    throw error if error
    console.info after:output
    advancements = {}
    for key, value of output
      advancements[key] = value unless Immutable.is Immutable.fromJS(value), Immutable.fromJS(article[key])
    console.info changes:advancements
    instruments.advance article.id, advancements


setInterval advanceOldestArticle, 2.seconds()
