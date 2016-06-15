Kijiji = require("./Kijiji")
cheerio = require "cheerio"
tape = require "tape"

tape "Kijiji.address", (test) ->
  test.same Kijiji.Article.address("123"), "http://www.kijiji.ca/v-view-details.html?adId=123"
  test.end()

tape "parse location attributes from Kijiji string", (test) ->
  parsed = Kijiji.Location.parse "140 Dundonald St, Fredericton, NB E3B 1W8, Canada \n View map"
  test.same parsed, ["Fredericton", "NB", "E3B1W8"]
  parsed = Kijiji.Location.parse "Montréal, QC H1E1Z9 \n View map"
  test.same parsed, ["Montréal", "QC", "H1E1Z9"]
  parsed = Kijiji.Location.parse "Channel-Port aux Basques, NL A0M1C0 \n View map"
  test.same parsed, ["Channel-Port aux Basques", "NL", "A0M1C0"]
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
