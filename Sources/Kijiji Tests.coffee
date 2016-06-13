{read} = require("./kijiji")

read "http://www.kijiji.ca/v-view-details.html?adId=1165646316", (error, data) ->
  console.error error if error
  console.info data

read "http://www.kijiji.ca/v-view-details.html?adId=1170859970", (error, data) ->
  console.error error if error
  console.info data

read "http://www.kijiji.ca/v-guitar/ottawa/epiphone-dot-es335-pristine-with-hard-case-left-hand/1171635084", (error, data) ->
  console.error error if error
  console.info data


# {read} = require("./kijiji_search")
#
# read "http://www.kijiji.ca/b-guitar/new-brunswick/left-handed/k0c613l9005?price=__1000&minNumberOfImages=1", (error, data) ->
#   console.error error if error
#   console.info data
#
# read "http://www.kijiji.ca/b-guitar/new-brunswick/left-hande/k0c613l9005?price=__1000", (error, data) ->
#   console.error error if error
#   console.info data
