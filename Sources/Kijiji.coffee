window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)

Kijiji = module.exports

Kijiji.Date = require('d3').time.format("%d-%b-%y")

Kijiji.Article = {}

Kijiji.Article.address = (id) ->
  "http://www.kijiji.ca/v-view-details.html?adId=#{id}"

Kijiji.Article.attributes =
  "expired":".expired-ad-container"
  "title":"[itemprop=name]"
  "description":"[itemprop=description]"
  "price string":"[itemprop=price]"
  "photographs":["ul.photo-navigation img@src"]
  "publication date":"table.ad-attributes tr:first-child td"

Kijiji.Article.read = (address, done) ->
  id = Kijiji.Article.parseIdentifierFromAddress(address)
  console.info "READ article from Kijiji":id
  address = Kijiji.Article.address(id)
  window(address+"&siteLocale=en_CA", Kijiji.Article.attributes) (error, output) ->
    output["address"] = address
    output["access time"] = Date.now()
    if output["expired"]?
      output["expired"] = Date.now()
      delete output["photographs"]
    else
      output["price"] = Number output["price string"].replace("$","")
      output["publication time"] = Kijiji.Date.parse(output["publication date"]).getTime()
      output["description"] = output["description"]?.trim()
      output["photographs"] = output["photographs"].filter (p) -> p.match("play-button") is p.match("youtube") is null
    delete output["publication date"]
    delete output["price string"]
    console.info "READ article from Kijiji":output
    done error, output

Kijiji.Article.parseIdentifierFromAddress = (address) ->
  if id = address.match(/adId=([0-9]+)/)?[1]
    return Number(id)
  else
    identifier = Number address.split("?")[0].split("/").pop()
    if Number.isNaN identifier
      return undefined
    else
      return identifier


Kijiji.Search =
  attributes:
    title: "title"
    addresses: [".title a[href]@href"]

  read: (address, done) ->
    window(address, Kijiji.Search.attributes) (error, output) ->
      if error
        console.error "Kijiji.Search.read #{address}":error
        done error
      else
        identifiers = output.addresses.map(Kijiji.Article.parseIdentifierFromAddress)
        identifiers = identifiers.filter (address) -> address isnt undefined
        done error, identifiers.map(Kijiji.Article.address)


Kijiji.sources = """
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
  http://www.kijiji.ca/b-guitar/saskatchewan/lefthand/k0c613l9009?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/territories/lefty/k0c613l9010?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/territories/left-handed/k0c613l9010?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/territories/left-hand/k0c613l9010?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/territories/lefthand/k0c613l9010?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/prince-edward-island/lefty/k0c613l9011?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/prince-edward-island/left-handed/k0c613l9011?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/prince-edward-island/left-hand/k0c613l9011?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/prince-edward-island/lefthand/k0c613l9011?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/newfoundland/lefty/k0c613l9008?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/newfoundland/left-handed/k0c613l9008?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/newfoundland/left-hand/k0c613l9008?price=__1000&minNumberOfImages=1
  http://www.kijiji.ca/b-guitar/newfoundland/lefthand/k0c613l9008?price=__1000&minNumberOfImages=1
""".split("\n")
