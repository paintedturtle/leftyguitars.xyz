Kijiji = require("./Kijiji")
cheerio = require "cheerio"
tape = require "tape"

tape "Kijiji.address", (test) ->
  test.same Kijiji.Article.address("123"), "http://www.kijiji.ca/v-view-details.html?adId=123"
  test.end()

tape "Read current article from Kijiji", (test) ->
  Kijiji.Article.read "http://www.kijiji.ca/v-view-details.html?adId=1165646316", (error, data) ->
    test.same error, null
    test.same Object.keys(data), ["title","description","photographs","location","address","access time","price","publication time"]
    test.same data.location, ["Halifax", "NS", "B3H2H4"]
    test.same data.price, 300
    test.end()

tape "Read expired article from Kijiji", (test) ->
  Kijiji.Article.read "http://www.kijiji.ca/v-view-details.html?adId=1164371061", (error, data) ->
    test.same error, null
    test.same Object.keys(data), ["expired", "address", "access time"]
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
