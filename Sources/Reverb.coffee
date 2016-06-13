window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)


Reverb = module.exports

Reverb.sources = """
  https://reverb.com/marketplace/electric-guitars/left-handed?product_type=electric-guitars&category=left-handed&item_region=CA&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
  https://reverb.com/marketplace/bass-guitars/left-handed?product_type=bass-guitars&category=left-handed&item_region=CA&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
  https://reverb.com/marketplace/acoustic-guitars/left-handed?product_type=acoustic-guitars&category=left-handed&item_region=&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
""".split("\n")

Reverb.Article =
  address: (identifier) ->
    "https://reverb.com/item/#{identifier}"
  identify: (address) ->
    return identifier
  attributes:
    "expired":".expired-ad-container"
    "title":"[itemprop=name]"
    "description":"[itemprop=description]"
    "price string":"[itemprop=price]"
    "photographs":["ul.photo-navigation img@src"]
    "publication date":"table.ad-attributes tr:first-child td"
  read = (address, done) ->
    id = Kijiji.parseIdentifierFromAddress(address)
    console.info "Kijiji.read":id
    address = Kijiji.address(id)
    window(address+"&siteLocale=en_CA", Kijiji.attributes) (error, output) ->
      output["address"] = address
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
      console.info "kijiji output":output
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
