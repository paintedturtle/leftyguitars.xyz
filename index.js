// Generated by CoffeeScript 1.10.0
(function() {
  var POST, render, simplifiedTitle, toCurrentAndExpired;

  document.on("DOMContentLoaded", function() {
    document.body.innerHTML = "<header>\n  <h1>Lefty Guitars For Sale Under $1000</h1>\n</header>\n<div id=\"articles\"></div>\n\n<div class=\"turtle\">🐢</div>\n\n<footer>\n\n  <div id=\"host\">\n    <h6>This site is hosted by</h6>\n    <div id=\"paintedturtle\">\n      <strong><a target=\"paintedturtle\" href=\"https://paintedturtle.xyz/instruments\">Painted Turtle instruments</a></strong><br>\n      Well-worm lefty guitars &amp; basses<br>\n      Ottawa, Ontario, Canada<br>\n      <a href=\"mailto:instruments@paintedturtle.xyz\">instruments@paintedturtle.xyz</a>\n      <a href=\"https://paintedturtle.xyz/instruments\" class=\"window\"><img src=\"paintedturtleinstruments.png\" alt=\"Visit the Painted Turtle Instruments Website\"></a>\n    </div>\n  </div>\n  <div id=\"links\">\n    <h6>Lefty Links</h6>\n    <div id=\"jerrysleftyguitars\">\n      <strong><a target=\"jerrysleftyguitars\" href=\"https://www.jerrysleftyguitars.com/\">Jerry’s Lefty Guitars</a></strong><br>\n      World’s finest collection of lefty guitars<br>\n      Sarasota, Florida, USA<br>\n      <a href=\"mailto:jerry@jerrysleftyguitars.com\">jerry@jerrysleftyguitars.com</a>\n    </div>\n    <div id=\"adkguitar\">\n      <a target=\"leftyguitarsonly\" href=\"https://www.adkguitar.com/\">Adirondack Guitar</a><br>\n      Large selection of new lefty guitars<br>\n      Hudson Falls, New York, USA<br>\n      <a href=\"mailto:support@adkguitar.com\">support@adkguitar.com</a>\n    </div>\n    <div id=\"leftyguitarsonly\">\n      <a target=\"leftyguitarsonly\" href=\"http://leftyguitarsonly.com/\">Lefty Guitars Only</a><br>\n      Very spendy lefty acoustic &amp; electic guitars<br>\n      East Greenwich, Rhode Island, USA<br>\n      <a href=\"mailto:sales@leftyguitarsonly.com\">sales@leftyguitarsonly.com</a>\n    </div>\n\n  </div>\n</footer>\n<style>\n  body, article, div, header, footer, h1, h2, h3, h4, h5, h6 { padding: 0; margin: auto; position: relative; font: inherit; }\n  a { color: inherit; text-decoration: inherit; }\n  strong { font-weight: inherit; }\n  html { background: #111; color: hsla(0, 0%, 100%, 0.5);}\n  body { font: 4mm/4mm \"Avenir\", sans-serif; font-weight: 600; }\n  body > header { position: absolute; top: -100%; }\n  form { width: 300mm; margin: 10mm auto;}\n  form input { width: 100%; margin: auto; font: 4mm/4mm Consolas; }\n  #articles { margin: auto; width: auto; position: relative; overflow:hidden; color: white;}\n  article { margin: 0; color: white; width: 33.333%; float: left; outline: 1px solid black; overflow:hidden;}\n  article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}\n  article .title { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 10mm;}\n  article .price { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 5mm;}\n  article .address { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 0mm;}\n  article:not(:hover) a { background: transparent; color: inherit;}\n  article:hover a { background: hsl(333, 50%, 50%); color: black; text-decoration: underline;}\n\n  #add { position: fixed; top: 0; left: 0; right: 0;}\n\n\n  body > footer { line-height: 5mm; }\n\n  #host { position: absolute; top: 0; left: 0; width: 33.333%; text-align: right; }\n  #host > h6 { padding: 10mm 2mm 2mm; }\n  #links { margin: 0 0 0 66.666%;  }\n  #links > h6 { padding: 10mm 2mm 2mm; }\n  #links > div { margin: 4mm 0; padding: 2mm; }\n\n  a.window { display:block; box-shadow: 0 0 1mm 0 black; border-top: 1mm solid hsla(0, 0%, 100%, 0.44);}\n  a.window img { width: 100%; display:block;}\n\n  #paintedturtle { padding: 2mm; margin: 4mm 0;}\n  #paintedturtle strong a[href] { color:hsl(333,88%,72%); }\n  #paintedturtle a.window { position: absolute; left: 100%; right:-100%; top: -21mm; transform: scale(0.88)rotate(-1.11deg); transition: all 222ms ease-out;}\n  #paintedturtle a.window:hover { transform: scale(0.99)rotate(+0.11deg); }\n\n  body .turtle { text-align: center; padding: 3% 1% 1%; color: white; font-size: 200%;}\n</style>";
    if (location.hostname === "localhost") {
      return document.body.innerHTML += "<form id=\"add\">\n<input type=\"URL\" placeholder=\"Paste a URL to add another guitar\" value=\"\">\n</form>";
    }
  });

  document.on("DOMContentLoaded", function() {
    return d3.json("database.json", function(error, database) {
      var current, expired, ref;
      if (error) {
        console.error(error);
      }
      window.instruments = Facts();
      window.instruments.datoms = Immutable.Stack(Immutable.fromJS(database));
      ref = window.instruments.query().reduce(toCurrentAndExpired), current = ref.current, expired = ref.expired;
      return render(current);
    });
  });

  toCurrentAndExpired = function(reduction, guitar) {
    if (reduction == null) {
      reduction = {};
    }
    if (reduction.current == null) {
      reduction.current = [];
    }
    if (reduction.expired == null) {
      reduction.expired = [];
    }
    if (guitar.expired) {
      reduction.expired.push(guitar);
    } else {
      reduction.current.push(guitar);
    }
    return reduction;
  };

  document.on("input", "input", function(event, input) {
    var reset;
    if (input.validity.valid) {
      POST(input.value);
      reset = function() {
        return input.value = "";
      };
      return setTimeout(reset, 100);
    }
  });

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
      return "<div class=\"title\">" + (simplifiedTitle(d.title) || 'Untitled') + "</div>\n<div class=\"price\">" + d.price + "</div>\n<div class=\"address\"><a target=\"new\" href=\"" + d.address + "\">" + (d.address.replace("http://www.", "")) + "</a></div>\n<img src=\"" + d.photographs[0] + "\">";
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
