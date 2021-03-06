window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)

Reverb = module.exports

Reverb["search addresses"] = """
  https://reverb.com/marketplace/electric-guitars/left-handed?product_type=electric-guitars&category=left-handed&item_region=CA&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
  https://reverb.com/marketplace/bass-guitars/left-handed?product_type=bass-guitars&category=left-handed&item_region=CA&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
  https://reverb.com/marketplace/acoustic-guitars/left-handed?product_type=acoustic-guitars&category=left-handed&item_region=&year_min=&year_max=&price_min=&price_max=1000.00&ships_to=CA&item_region=CA
""".split("\n")

Reverb.Article =
  address: (identifier) ->
    "https://reverb.com/item/#{identifier}"

  identify: (address) ->
    if matches = address.match(/\/item\/([0-9]+)\-/)
      matches[1]
    else
      undefined

  attributes:
    "expired":".expired-ad-container"
    "title":"[itemprop=name]"
    "description":"[itemprop=description]"
    "price string":"[itemprop=price]"
    "photographs":["ul.photo-navigation img@src"]
    "publication date":"table.ad-attributes tr:first-child td"
  read: (address, done) ->
    identifier = Reverb.Article.identify(address)
    console.info "Kijiji.read":identifier
    address = Reverb.Article.address(identifier)
    window(address+"&siteLocale=en_CA", Reverb.Article.attributes) (error, output) ->
      output["address"] = address
      if output["expired"]?
        output["expired"] = Date.now()
        delete output["photographs"]
      else
        output["price"] = Number output["price string"].replace("$","")
        output["publication time"] = output["publication date"]
        output["description"] = output["description"]?.trim()
        output["photographs"] = output["photographs"].filter (p) -> p.match("play-button") is p.match("youtube") is null
      delete output["publication date"]
      delete output["price string"]
      console.info "kijiji output":output
      done error, output

Reverb.Search =
  attributes:
    "addresses":[".product .product-image a[href]@href"]

  read: (address, done) ->
    console.info "Reverb.Search.read":address
    window(address, Reverb.Search.attributes) (error, output) ->
      if error
        done error
      else
        done error, output.addresses.map(Reverb.Article.identify).map(Reverb.Article.address)
