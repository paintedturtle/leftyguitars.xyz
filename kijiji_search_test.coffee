{read} = require("./kijiji_search")

read "http://www.kijiji.ca/b-guitar/new-brunswick/left-handed/k0c613l9005?price=__1000&minNumberOfImages=1", (error, data) ->
  console.error error if error
  console.info data

read "http://www.kijiji.ca/b-guitar/new-brunswick/left-hande/k0c613l9005?price=__1000", (error, data) ->
  console.error error if error
  console.info data
