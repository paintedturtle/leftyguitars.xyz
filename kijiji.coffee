Kijiji = module.exports

Kijiji.Date = require('d3').time.format("%d-%b-%y")

Kijiji.attributes =
  "title":"[itemprop=name]"
  "description":"[itemprop=description]"
  "price":"[itemprop=price]"
  "photographs":["ul.photo-navigation img@src"]
  "publication date":"table.ad-attributes tr:first-child td"

window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)

Kijiji.read = (address, done) ->
  id = Kijiji.parseIdentifierFromAddress(address)
  address = Kijiji.address(id)
  console.info read:address
  window(address, Kijiji.attributes) (error, output) ->
    output["address"] = address
    output["publication date"] = Kijiji.Date.parse(output["publication date"])
    output["description"] = output["description"].trim()
    output["access time"] = Date.now()
    output["photographs"] = output["photographs"].filter (p) -> p.match("play-button") is p.match("youtube") is null
    done error, output

Kijiji.address = (id) ->
  "http://www.kijiji.ca/v-view-details.html?adId=#{id}"

Kijiji.parseIdentifierFromAddress = (address) ->
  console.info parseIdentifierFromAddress:address
  if id = address.match(/adId=([0-9]+)/)?[1]
    return Number(id)
  else
    return Number address.split("?")[0].split("/").pop()
