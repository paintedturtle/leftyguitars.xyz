JSONfromHTTPRequest = require("body/json")
Cryptography = require('crypto')
Immutable = require('immutable')
files = require("facts")()

instruments = require("facts")()
instruments.datoms = Immutable.Stack(Immutable.fromJS(require("./instruments.datoms.json")))

console.info instruments.query()

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
      serialized = JSON.stringify(database, undefined, "  ")
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
        send response, output =
          file:"index.html"
          type:"text/html; charset=UTF-8"
          size:HTML.length
          data:HTML
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
    <title>Lefty Guitars For Sale Under $1000</title>
    <script src="Facts.pack.js" charset="UTF-8"></script>
    <script src="Number.js" charset="UTF-8"></script>
    <script src="d3.min.js" charset="UTF-8"></script>
    <script src="document.js" charset="UTF-8"></script>
    <script src="index.js" charset="UTF-8"></script>
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
