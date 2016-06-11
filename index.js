// Generated by CoffeeScript 1.10.0
(function() {
  var POST, key, render, simplifiedTitle;

  document.on("DOMContentLoaded", function() {
    return document.body.innerHTML = "<form>\n<input type=\"URL\" placeholder=\"Paste a URL to add another guitar\" value=\"\">\n</form>\n<div id=\"articles\"></div>\n<div id=\"paintedturtle\">\n  <h6>This site is hosted by</h6>\n  <a href=\"\">Painted Turtle instruments</a><br>\n  Well-worm lefty guitars in Ottawa<br>\n  <a href=\"mailto:instruments@paintedturtle.xyz\">instruments@paintedturtle.xyz</a>\n</div>\n<style>\n  html { background: #333; }\n  body, article,div { padding: 0; margin: auto; position: relative;}\n  form { width: 300mm; margin: 10mm auto;}\n  form input { width: 100%; margin: auto; font: 4mm/4mm Consolas; }\n  #articles { margin: 10mm auto; width: auto; position: relative; overflow:hidden;}\n  article { margin: 0; color: white; font: 4mm/4mm Consolas; width: 33%; float: left; outline: 1px solid black; overflow:hidden;}\n  article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}\n  article .title { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm;}\n  article .price { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; top: 5mm;}\n</style>";
  });

  document.on("DOMContentLoaded", function() {
    return d3.json("database.json", function(error, database) {
      if (error) {
        console.error(error);
      }
      window.instruments = Facts();
      window.instruments.datoms = Immutable.Stack(Immutable.fromJS(database));
      console.info(window.instruments.query());
      return render(window.instruments.query());
    });
  });

  document.on("input", "input", function(event, input) {
    console.info(input);
    console.info({
      "input": input.value
    });
    if (input.validity.valid) {
      return POST(input.value);
    }
  });

  key = function(d) {
    return d["title"];
  };

  render = function(data) {
    var article;
    data = data.sort(function(a, b) {
      return b["access time"] - a["access time"];
    });
    article = d3.select("#articles").selectAll("article").data(data, (function(d) {
      return d.title;
    }));
    article.enter().append("article");
    article.html(function(d) {
      return "<div class=\"title\">" + (simplifiedTitle(d.title)) + "</div>\n<div class=\"price\">" + d.price + "</div>\n<img src=\"" + d.photographs[0] + "\">";
    });
    return article.exit().remove();
  };

  simplifiedTitle = function(title) {
    return title.replace(/guitar\s?/i, "").replace(/lefty\s?/i, "").replace(/left[- ]handed\s?/i, "").replace(/left[- ]hand\s?/i, "").replace("()", "");
  };

  POST = function(location) {
    return d3.xhr(window.location).header("Content-Type", "application/json").post(JSON.stringify({
      location: location
    }), function(error, serialized) {
      var data;
      return console.info(data = JSON.parse(serialized));
    });
  };

}).call(this);
