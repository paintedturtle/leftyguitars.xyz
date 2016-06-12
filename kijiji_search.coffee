window = require('x-ray')()
window.concurrency(1)
window.throttle(1, 333)

KijijiSearch = module.exports

KijijiSearch.attributes =
  "addresses":[".title a[href]@href"]

KijijiSearch.read = (address, done) ->
  console.info read:address
  window(address, KijijiSearch.attributes) (error, output) ->
    console.info window:arguments
    done error, output
