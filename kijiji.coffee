window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)

Kijiji = module.exports

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

Kijiji.Date = require('d3').time.format("%d-%b-%y")

Kijiji.address = (id) ->
  "http://www.kijiji.ca/v-view-details.html?adId=#{id}"

Kijiji.attributes =
  "expired":".expired-ad-container"
  "title":"[itemprop=name]"
  "description":"[itemprop=description]"
  "price":"[itemprop=price]"
  "photographs":["ul.photo-navigation img@src"]
  "publication date":"table.ad-attributes tr:first-child td"

Kijiji.read = (address, done) ->
  id = Kijiji.parseIdentifierFromAddress(address)
  address = Kijiji.address(id)
  window(address+"&siteLocale=en_CA", Kijiji.attributes) (error, output) ->
    output["address"] = address
    output["access time"] = Date.now()
    if output["expired"]?
      output["expired"] = Date.now()
      delete output["photographs"]
    else
      output["publication time"] = Kijiji.Date.parse(output["publication date"]).getTime()
      output["description"] = output["description"]?.trim()
      output["photographs"] = output["photographs"].filter (p) -> p.match("play-button") is p.match("youtube") is null
    delete output["publication date"]
    done error, output

Kijiji.parseIdentifierFromAddress = (address) ->
  if id = address.match(/adId=([0-9]+)/)?[1]
    return Number(id)
  else
    identifier = Number address.split("?")[0].split("/").pop()
    if Number.isNaN identifier
      return undefined
    else
      return identifier


Kijiji.Search =
  attributes: {
    "addresses":[".title a[href]@href"]
  }
  read: (address, done) ->
    console.info "kijiji search read":address
    window(address, Kijiji.Search.attributes) (error, output) ->
      console.error error if error
      identifiers = output.addresses.map(Kijiji.parseIdentifierFromAddress)
      identifiers = identifiers.filter (address) -> address isnt undefined
      done error, identifiers.map(Kijiji.address)
