// Generated by CoffeeScript 1.10.0
(function() {
  var read;

  read = require("./kijiji").read;

  read("http://www.kijiji.ca/v-view-details.html?adId=1165646316", function(error, data) {
    if (error) {
      console.error(error);
    }
    return console.info(data);
  });

  read("http://www.kijiji.ca/v-view-details.html?adId=1170859970", function(error, data) {
    if (error) {
      console.error(error);
    }
    return console.info(data);
  });

  read("http://www.kijiji.ca/v-guitar/ottawa/epiphone-dot-es335-pristine-with-hard-case-left-hand/1171635084", function(error, data) {
    if (error) {
      console.error(error);
    }
    return console.info(data);
  });

}).call(this);
