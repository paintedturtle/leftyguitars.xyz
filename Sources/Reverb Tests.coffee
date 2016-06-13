Reverb = require("./Reverb")
cheerio = require "cheerio"
tape = require "tape"

tape "Reverb.Article.address", (test) ->
  test.same Reverb.Article.address("123"), "https://reverb.com/item/123"
  test.end()

tape "Reverb.Article.identify", (test) ->
  identifier = Reverb.Article.identify "https://reverb.com/item/2303695-lefty-epiphone-sg-with-hard-case-in-ottawa-canada"
  test.same identifier, "2303695"
  test.end()

tape "Read current article from Reverb", (test) ->
  Reverb.Article.read "https://reverb.com/item/2303695", (error, data) ->
    test.same error, null
    test.same Object.keys(data), ["title","description","photographs","address","price","publication time"]
    test.end()

tape "Read search results from Reverb", (test) ->
  address = Reverb["search addresses"][0]
  Reverb.Search.read address, (error, addresses) ->
    test.same error, null
    test.ok addresses.length
    test.ok addresses.every (address) -> address.match /reverb\.com/
    test.end()

# {read} = require("./kijiji_search")
#
# read "http://www.kijiji.ca/b-guitar/new-brunswick/left-handed/k0c613l9005?price=__1000&minNumberOfImages=1", (error, data) ->
#   console.error error if error
#   console.info data
#
# read "http://www.kijiji.ca/b-guitar/new-brunswick/left-hande/k0c613l9005?price=__1000", (error, data) ->
#   console.error error if error
#   console.info data
