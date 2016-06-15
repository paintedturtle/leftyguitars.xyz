document.on "DOMContentLoaded", ->
  document.body.innerHTML = """
    <header>
      <h1>Lefty Guitars For Sale Under $1000 CAD</h1>
    </header>
    <div id="novelty" class="natural articles"></div>

    <div id="search" style="box-sizing: border-box;">
      <input type="text" placeholder="Search" style="text-align:center; font:inherit; width:25%; box-sizing: border-box; background:transparent; padding: 1mm 1mm 0.66mm; border:2px solid grey; border-radius:1mm; color: white; margin: 4mm auto; display:block; font-size:150%;">
    </div>

    <div id="pricelimit" style="height:4mm; margin: 2mm 33.3% 10mm; position: relative;">
      <label class="min" style="position: absolute; right: 100%; margin:0 2mm;">$100</label>
      <label class="max" style="position: absolute; left: 100%; margin:0 2mm; ">$1000</label>
      <input type="range" min="100" max="1000" value="1000" style="position: absolute; top: -0.3mm; left: 0; right: 0; width: 100%; margin:0; padding:0; display:block;">
    </div>

    <div id="filter" hidden>
      <button>All</button>
      <button>Acoustic</button>
      <button>Electric</button>
      <button>Guitar</button>
      <button>Bass</button>
    </div>

    <h1>
      <span id="selection-size">N</span> lefty guitars for sale under $<span id="price-limit">1000</span> CAD
    </h1>

    <form id="sort" hidden>
      <button>All</button>
      <button>Oldest first</button>
      <button>Newest first</button>
      <button>Low-to-High</button>
      <button>High-to-Low</button>
    </form>

    <h2 hidden>Current</h2>
    <div id="current" class="natural articles"></div>

    <h2>Dearly Departed</h2>
    <div id="expired" class="diminished articles"></div>

    <footer>
      <div id="host">
        <h2>This site is hosted by:</h2>
        <div id="paintedturtle" class="space">
          <strong><a target="paintedturtle" href="https://paintedturtle.xyz/instruments">Painted Turtle instruments</a></strong><br>
          Well-worm lefty guitars &amp; basses<br>
          Ottawa, Ontario, Canada<br>
          <a href="mailto:instruments@paintedturtle.xyz">instruments@paintedturtle.xyz</a>
        </div>
      </div>
      <div id="links">
        <h2>Lefty Shops</h2>
        <div id="jerrysleftyguitars" class="space">
          <strong><a target="jerrysleftyguitars" href="https://www.jerrysleftyguitars.com/">Jerry’s Lefty Guitars</a></strong><br>
          World’s finest collection of lefty guitars<br>
          Sarasota, Florida, USA<br>
          <a href="mailto:jerry@jerrysleftyguitars.com">jerry@jerrysleftyguitars.com</a>
        </div><div id="leftyguitars.be" class="space">
          <strong><a target="leftyguitars.be" href="http://leftyguitars.be/">LeftyGuitars.BE</a></strong><br>
          Europe’s spot for lefty guitars &amp; basses<br>
          Peulis, Belgium, EU<br>
          <a href="mailto:patrick@leftyguitars.be">patrick@leftyguitars.be</a>
        </div><div id="leftyguitarsonly" class="space">
          <strong><a target="leftyguitarsonly" href="http://leftyguitarsonly.com/">Lefty Guitars Only</a></strong><br>
          Very spendy lefty acoustic &amp; electic guitars<br>
          East Greenwich, Rhode Island, USA<br>
          <a href="mailto:sales@leftyguitarsonly.com">sales@leftyguitarsonly.com</a>
        </div><div id="leftyvintageguitars" class="space">
          <strong><a target="leftyvintageguitars" href="http://www.leftyvintageguitars.com/">Lefty Vintage Guitars</a></strong><br>
          Valuable, vintage, left handed guitars<br>
          Undisclosed, Florida, USA<br>
          <a href="mailto:alex57@comcast.net">alex57@comcast.net</a>
        </div><div id="adkguitar" class="space">
          <strong><a target="adkguitar" href="https://www.adkguitar.com/">Adirondack Guitar</a></strong><br>
          Large selection of new lefty guitars<br>
          Hudson Falls, New York, USA<br>
          <a href="mailto:support@adkguitar.com">support@adkguitar.com</a>
        </div><div id="southpawguitars" class="space">
          <strong><a target="taniguchi-gakki" href="https://www.southpawguitars.com/">South Paw Guitars</a></strong><br>
          Large selection of new lefty guitars<br>
          Houston, Texas, USA<br>
          <a href="mailto:info@southpawguitars.com">info@southpawguitars.com</a>
        </div><div id="taniguchi-gakki" class="space">
          <strong><a target="taniguchi-gakki" href="https://shop.taniguchi-gakki.jp/products/list.php?category_id=6">Taniguchi Gakki</a></strong><br>
          Fender &amp; Tokai lefties! &amp; accordians!<br>
          Tokyo, Japan<br>
          <a href="mailto:info@taniguchi-gakki.jp">info@taniguchi-gakki.jp</a>
        </div>
        <h2>Lefty Communities</h2>
        <div id="leftyguitartrader" class="space">
          <strong><a target="leftyguitartrader" href="http://www.leftyguitartrader.com/forum/forum.php">Lefty Guitar Trader</a></strong><br>
          Friendly discussion forums &amp; classifieds<br>
          <a target="leftyguitartrader" href="http://www.leftyguitartrader.com/forum/forumdisplay.php?8-Lefty-Guitars">▸ Guitars For Sale</a><br>
          <a target="leftyguitartrader" href="http://www.leftyguitartrader.com/forum/forumdisplay.php?9-Lefty-Bass">▸ Bass Guitars For Sale</a><br>
          <a target="leftyguitartrader" href="http://www.leftyguitartrader.com/forum/forumdisplay.php?2-Lefty-Guitar-Discussion">▸ Lefty Guitar Discussion</a><br>
        </div>
        <div id="leftyguitartrader" class="space">
          <strong><a target="leftyfrets" href="http://www.leftyfrets.net/forum.php">Lefty Frets</a></strong><br>
          Friendly discussion forums &amp; classifieds<br>
          <a target="leftyfrets" href="http://www.leftyfrets.net/forumdisplay.php?7-Left-Handed-Acoustic-Instruments-For-Sale">▸ Acoustic Instruments For Sale</a><br>
          <a target="leftyfrets" href="http://www.leftyfrets.net/forumdisplay.php?10-Left-Handed-Electric-Instruments-For-Sale">▸ Electric Instruments For Sale</a><br>
          <a target="leftyfrets" href="http://www.leftyfrets.net/forumdisplay.php?11-General-Lefty-Discussion">▸ General Lefty Discussion</a><br>
        </div>
      </div>
    </footer>

    <h2>Trash Heap</h2>
    <div id="trashed" class="diminished articles"></div>

    <style>
      body, article, div, header, footer, h1, h2, h3, h4, h5, h6 { padding: 0; margin: auto; position: relative; font: inherit; }
      a { color: inherit; text-decoration: inherit; }
      strong { font-weight: inherit; }
      html { background: #111; color: hsla(0, 0%, 100%, 0.5);}
      body { font: 3.8mm/4mm "Avenir", sans-serif; font-weight: 600; }
      body > header { position: absolute; top: -100%; }

      body > h1 { text-align: center; margin: 4mm 10mm 4mm; color: white;}

      form input[type=text], form input[type=url] { width: 100%; margin: auto; font: 4mm/4mm Consolas; box-sizing: border-box;}

      div.natural.articles { margin: auto; width: auto;  position: relative; overflow:hidden; color: white; }
      div.natural.articles article { height: 100mm; margin: 0; color: white; width: 33.333%; float: left; overflow:hidden;}
      div.natural.articles article img { width:100%; height: 100mm; object-fit: cover; background-color: black; display:block; position: absolute; bottom:0; }
      div.natural.articles article .id { white-space: nowrap; position: absolute; margin: 1mm; padding: 1mm; bottom: 0; left:0; font-size: 50%; }
      div.natural.articles article .position { position: absolute; top:0; left:0; right: 0; margin: 1mm;}
      div.natural.articles article .address > span  { white-space: nowrap; background: hsla(0, 0%, 0%, 0.66); padding: 1mm; display:inline-block; }
      div.natural.articles article .title > span   { white-space: nowrap; background: hsla(0, 0%, 0%, 0.66); padding: 1mm; display:inline-block; }
      div.natural.articles article .location > span { white-space: nowrap; background: hsla(0, 0%, 0%, 0.66); padding: 1mm; display:inline-block;}
      div.natural.articles article .duration > span { white-space: nowrap; background: hsla(0, 0%, 0%, 0.66); padding: 1mm; display:inline-block;}

      div.natural.articles article .price {white-space: nowrap; overflow:hidden;  }
      div.natural.articles article .price .label { display:inline-block;  margin: 0;  color:hsla(0, 0%, 66%, 1); background: hsla(0, 0%, 0%, 0.66); padding: 1mm;}
      div.natural.articles article .price .graphic { display:inline-block; background: hsla(0, 0%, 0%, 0.66); padding: 1mm;}
      div.natural.articles article .price .graphic strong { display:inline-block; height:2mm; background:hsla(0, 0%, 55%, 1);}


      div.natural.articles article button { position: absolute; top: 0; display:block; width:50%;}
      div.natural.articles article button.discard { left: 0; }
      div.natural.articles article button.approve { right: 0; }

      article:not(:hover) a { background: transparent; color: inherit;}
      article a[href]:not(:visited) { color: hsl(205, 50%, 50%); }
      article a[href]:visited { color: hsl(278, 50%, 50%); }

      h2 { margin: 20mm 4mm 4mm; }
      div.diminished.articles { margin: auto; width: auto; position: relative; overflow:hidden; color: white; }
      div.diminished.articles article { margin: 0; color: white; width: 10%; float: left; overflow:hidden;}
      div.diminished.articles article img { width: 100%; height: 66mm; object-fit: cover; background-color: black; display:block;}
      div.diminished.articles article { opacity:0.33; }
      div.diminished.articles article:hover { opacity:0.99; }

      #trashed article { opacity: 0.11;}
      #trashed article, #trashed article img { height:33mm; }

      body > footer { border-top:5mm solid transparent; border-bottom:5mm solid transparent; font: 3.9mm/5mm "Avenir", sans-serif; font-weight: 400; overflow:hidden;}

      #host { position:absolute; left: 0; top: 0;}
      #host > h2 { margin: 5mm; }
      #links { margin:0 0 0 90mm; }
      #links > h2 { margin: 5mm; border-top: 1px solid #444; padding-top:4mm;}

      div.space { padding:5mm; width: 80mm; display:inline-block; cursor:default; transition: color 188ms linear;}
      div.space:hover { color:hsl(0,0%,77%); }
      div.space strong { color:hsl(0,0%,77%); font-weight: 600;}
      div.space strong a[href] { }
      div.space a[href]:hover { color:hsl(55,88%,77%); }

      #paintedturtle:hover strong a[href] { text-decoration:underline;}
      #paintedturtle strong a[href] { color:hsl(333,88%,72%); font-weight: 600;}

      body .turtle { text-align: center; padding: 3% 1% 1%; color: white; font-size: 200%;}
    </style>
  """
  if location.hostname.length is 9
    document.body.innerHTML += """
      <h2>Pocketd</h2>
      <div id="pocketd" class="natural articles"></div>
      <form id="add" hidden><input type="URL" placeholder="Paste a URL to add another guitar" value=""></form>
      <form id="pocket" hidden><input type="text" placeholder="Paste an ID to pocket an article" value="" maxlength="64" minlength="64"></form>
    """

document.on "DOMContentLoaded", ->
  {current, expired, pocketd, novelty, trashed} = window.articles.reduce(toCurrentExpiredNoprice, {})
  renderNovelty novelty if location.hostname.length is 9
  renderCurrentArticles current
  renderExpiredArticles expired
  renderTrash trashed
  renderPocket pocketd if location.hostname.length is 9

toCurrentExpiredNoprice = (reduction, guitar) ->
  reduction.trashed ?= []
  reduction.novelty ?= []
  reduction.current ?= []
  reduction.expired ?= []
  reduction.pocketd ?= []
  if guitar.pocketd
    reduction.pocketd.push(guitar)
    return reduction
  if guitar.trashed
    reduction.trashed.push(guitar)
    return reduction
  if guitar.expired
    reduction.expired.push(guitar)
    return reduction
  if guitar.approved
    reduction.current.push(guitar)
    return reduction
  else
    reduction.novelty.push(guitar)
    return reduction

document.on "click", "button.discard", (event, button) ->
  id = button.closest("article").id
  d3.xhr("#{window.location}#{id}")
    .header "Content-Type", "application/json"
    .post JSON.stringify({trashed:Date.now()}), (error, response) ->
      console.error error if error
      console.info response.statusText
      console.info response.responseText

document.on "click", "button.approve", (event, button) ->
  id = button.closest("article").id
  d3.xhr("#{window.location}#{id}")
    .header "Content-Type", "application/json"
    .post JSON.stringify({approved:yes}), (error, response) ->
      console.error error if error
      console.info response.statusText
      console.info response.responseText

document.on "input", "#search input", (event, input) ->
  {current} = window.articles.reduce(toCurrentExpiredNoprice, {})
  if input.value
    pattern = new RegExp "\\b#{input.value}", "i"
  else
    pattern = new RegExp "."
  renderCurrentArticles current.filter (article) -> pattern.test(article["title"]) or pattern.test(article["description"])

document.on "input", "#pricelimit input", (event, input) ->
  limit = Number(input.value)
  {current} = window.articles.reduce(toCurrentExpiredNoprice, {})
  d3.select("#price-limit").html limit
  renderCurrentArticles current.filter (article) ->
    return article["price"] < limit

document.on "input", "#add input", (event, input) ->
  console.info advance:input.value
  if input.validity.valid
    d3.xhr("#{window.location}")
      .header "Content-Type", "application/json"
      .post JSON.stringify({location:input.value}), (error, response) ->
        console.error error if error
        console.info response.statusText
        console.info JSON.parse(response.responseText)
        input.value = ""

document.on "input", "#pocket input", (event, input) ->
  console.info pocket:input.value
  console.info pocket:input.value.length
  if input.validity.valid
    d3.xhr("#{window.location}#{input.value}")
      .header "Content-Type", "application/json"
      .post JSON.stringify({pocketd:yes}), (error, response) ->
        console.error error if error
        console.info response.statusText
        console.info JSON.parse(response.responseText)
        input.value = ""

byAddressInAscendingOrder  = (a, b) -> d3.ascending(a["address"], b["address"])
byAddressInDescendingOrder = (a, b) -> d3.descending(a["address"], b["address"])

renderCurrentArticles = (data) ->
  sorted = data
    .sort byAddressInDescendingOrder
    .sort (a, b) -> b["publication time"] - a["publication time"]
  d3.select("#selection-size").html sorted.length

  article = d3.select("#current").selectAll("article").data(sorted, ((d) -> d.id))
  article.order()
  article.enter().append("article")
  article.attr id:(d) -> d.id
  article.html naturalArticleHTML
  article.exit().remove()

naturalArticleHTML = (article) ->
  output = """
    <img src="#{article.photographs?[0]}">
    <div class="position">
      <div class="address">
        <span><a target="#{article.id}" href="#{article.address}">#{simplifiedAddress article.address}</a></span>
      </div>
      <div class="title">
        <span>#{article.title or 'Untitled'}</span>
      </div>
      <div class="location">
        <span>#{article.location?.slice(0,2).join(" ")}</span>
      </div>

      <div>
      <span class="label" style="padding: 1mm; background: hsla(0, 0%, 0%, 0.66);"><span style="width:#{article.price/10}%; display:inline-block; height:1mm; background:#fff; "></span></span><span class="label" style="padding: 1mm; background: hsla(0, 0%, 0%, 0.66);">$<strong>#{ Math.ceil(article.price) }</strong></span>
      </div>

      <div class="duration" hidden>
        #{ Math.round((Date.now()-article["publication time"]) / 24.hours()) } #{if Math.round((Date.now()-article["publication time"]) / 24.hours()) > 1 then 'days' else 'day'}
      </div>
    </div>
  """
  if location.hostname is "localhost"
    output += """
      <div class="id">#{if location.hostname is "localhost" then article.id else ""}</div><br>
    """
  if location.hostname is "localhost" and article.approved is undefined and article.pocketd is undefined
    output += """
      <button class="discard">⌫</button>
      <button class="approve">👀</button>
    """
  return output


renderExpiredArticles = (data) ->
  sorted = data
    .sort (a, b) -> b["access time"] - a["access time"]
    .slice(0, 20)
  article = d3.select("#expired").selectAll("article").data(sorted, ((d) -> d.id))
  article.order()
  article.enter().append("article")
  article.attr id:(d) -> d.id
  article.html (d) -> """
    <a target="#{d.id}" href="#{d.address}"><img src="#{d.photographs[0]}"></a>
    """
  article.exit().remove()

renderTrash = (data) ->
  sorted = data
    .sort (a, b) -> b["access time"] - a["access time"]
    .slice(0, 60)
  article = d3.select("#trashed").selectAll("article").data(sorted, ((d) -> d.id))
  article.order()
  article.enter().append("article")
  article.attr id:(d) -> d.id
  article.html (d) -> """
    <a target="#{d.id}" href="#{d.address}"><img src="#{d.photographs[0]}"></a>
    """
  article.exit().remove()

renderPocket = (data) ->
  article = d3.select("#pocketd").selectAll("article").data(data, ((d) -> d.id))
  article.enter().append("article")
  article.attr id:(d) -> d.id
  article.html naturalArticleHTML
  article.exit().remove()

renderNovelty = (data) ->
  article = d3.select("#novelty").selectAll("article").data(data, ((d) -> d.id))
  article.enter().append("article")
  article.attr id:(d) -> d.id
  article.html naturalArticleHTML
  article.exit().remove()

simplifiedTitle = (string) ->
  string
    .replace(/guitar\s?/i, "")
    .replace(/lefty\s?/i, "")
    .replace(/left[- ]handed\s?/i, "")
    .replace(/left[- ]hand\s?/i, "")
    .replace("()", "")

simplifiedAddress = (string) ->
  string
    .replace("http://www.kijiji.ca", "kijiji")
    .replace("/v-view-details.html?adId=", "#")
