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
