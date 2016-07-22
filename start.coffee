require "./Number"
{readFileSync}      = require "fs"
Cryptography        = require "crypto"
Facts               = require "facts"
Immutable           = require "immutable"
JSONfromHTTPRequest = require "body/json"
Kijiji              = require "./Sources/Kijiji"

instruments = require("facts")()
instruments.datoms = Immutable.Stack(Immutable.fromJS(require("./article.datoms.json")))
instruments.on "transaction", ->
  write "article.datoms.json", JSON.stringify(instruments.datoms, undefined, "  "), "UTF-8", (error) ->
    if error then throw error
    console.info "SAVED":"article.datoms.json"
  write "article.database.json", JSON.stringify(instruments.database(), undefined, "  "), "UTF-8", (error) ->
    if error then throw error
    console.info "SAVED":"article.database.json"
  write "articles.json", JSON.stringify(instruments.query(), undefined, "  "), "UTF-8", (error) ->
    if error then throw error
    console.info "SAVED":"articles.json"

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
    when identifier is "filters"
      outputBuffer = new Buffer filtersHTML(), "UTF-8"
      send response, output =
        file:"filters.html"
        type:"text/html; charset=UTF-8"
        size:outputBuffer.length
        data:outputBuffer
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

addInstrument.fromKijiji = (address, callback) ->
  Kijiji.Article.read address, (error, output) ->
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
    <title>Lefty Guitars For Sale in Canada</title>
    <meta charset="UTF-8">
    <meta description="A growing index of left handed guitars and basses for sale in Canada for less than $1000 CAD">
    <meta keywords="lefty left hand left-handed left-hand lefthand guitar bass guitars basses electric acoustic for sale Canada CAD 🐢">
    <script charset="UTF-8">
    window.articles = #{JSON.stringify(instruments.query(), undefined, "  ")}
    #{readFileSync "d3.min.js", "UTF-8"}
    #{compile readFileSync "Number.coffee", "UTF-8"}
    #{compile readFileSync "document.coffee", "UTF-8"}
    #{compile readFileSync "index.coffee", "UTF-8"}
    </script>
  """

filtersHTML = ->
  return """
    <!DOCTYPE HTML>
    <title>Filter Controls</title>
    <meta charset="UTF-8">
    <script charset="UTF-8">
    window.articles = #{JSON.stringify(instruments.query(), undefined, "  ")}
    #{readFileSync "d3.min.js", "UTF-8"}
    #{compile readFileSync "Number.coffee", "UTF-8"}
    #{compile readFileSync "document.coffee", "UTF-8"}
    #{compile readFileSync "index.coffee", "UTF-8"}
    </script>
  """

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

compile = require("coffee-script").compile

mime = require("mime")

read = require("fs").readFile

watch = require("fs").watch

write = require("fs").writeFile

advanceOldestArticle = ->
  articles = instruments.query()
    .filter (article) -> (article["approved"] or article["pocketd"]) and (article["expired"] is undefined) and (article["trashed"] is undefined)
    .filter (article) -> article["access time"] < (Date.now() - 66.minutes())
    .sort (a, b) -> a["access time"] - b["access time"]
    .reverse()
  if article = articles[0]
    console.info "READ #{article.id}":article.address
    Kijiji.Article.read article.address, (error, output) ->
      if error then throw error
      console.info output
      advancements = {}
      for key, value of output
        advancements[key] = value unless Immutable.is Immutable.fromJS(value), Immutable.fromJS(article[key])
      console.info "PULL #{article.id}":advancements
      instruments.advance article.id, advancements
      setTimeout advanceOldestArticle, 1/10
  else
    setTimeout findNovelArticles, 33.minutes()
    setTimeout advanceOldestArticle, 1.minutes()



findNovelArticles = ->
  Kijiji.sources.forEach (source) ->
    Kijiji.Search.read source, (error, addresses) ->
      novelAddresses = addresses.filter (address) -> instruments.pull(identifyInstrumentAddress(address)) is undefined
      console.info "#{source} novelty": novelAddresses
      novelAddresses.forEach (address) -> addInstrument.fromKijiji(address, (error, identifier) ->)

setTimeout findNovelArticles,    1.seconds()
setTimeout advanceOldestArticle, 1.seconds()

# console.info article = instruments.pull "XXX"

# instruments.advance "4710afa5d6310b719dd8bf369a29f17b3ae689d95f5639e5682cd7ed5417289b", expired:Date.now()
# instruments.advance "88b030b94e6286425aafd9915f85715aeaa684a3b1608800b12b7d34df0db5d8", pocketd:Date.now()
# addInstrument.fromKijiji "http://www.kijiji.ca/v-view-details.html?adId=1172979691", -> console.info(arguments, "Done")

# Kijiji.Article.read "http://www.kijiji.ca/v-view-details.html?adId=1172979691", (error, output) -> console.info(output)
