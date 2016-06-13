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

    <div class="turtle">🐢</div>

    <footer>
      <div id="host">
        <h6>This site is hosted by</h6>
        <div id="paintedturtle">
          <strong><a target="paintedturtle" href="https://paintedturtle.xyz/instruments">Painted Turtle instruments</a></strong><br>
          Well-worm lefty guitars &amp; basses<br>
          Ottawa, Ontario, Canada<br>
          <a href="mailto:instruments@paintedturtle.xyz">instruments@paintedturtle.xyz</a>
          <a href="https://paintedturtle.xyz/instruments" class="window"><img src="paintedturtleinstruments.png" alt="Visit the Painted Turtle Instruments Website"></a>
        </div>
      </div>
      <div id="links">
        <h6>Lefty Links</h6>
        <div id="jerrysleftyguitars">
          <strong><a target="jerrysleftyguitars" href="https://www.jerrysleftyguitars.com/">Jerry’s Lefty Guitars</a></strong><br>
          World’s finest collection of lefty guitars<br>
          Sarasota, Florida, USA<br>
          <a href="mailto:jerry@jerrysleftyguitars.com">jerry@jerrysleftyguitars.com</a>
        </div>
        <div id="adkguitar">
          <a target="leftyguitarsonly" href="https://www.adkguitar.com/">Adirondack Guitar</a><br>
          Large selection of new lefty guitars<br>
          Hudson Falls, New York, USA<br>
          <a href="mailto:support@adkguitar.com">support@adkguitar.com</a>
        </div>
        <div id="leftyguitarsonly">
          <a target="leftyguitarsonly" href="http://leftyguitarsonly.com/">Lefty Guitars Only</a><br>
          Very spendy lefty acoustic &amp; electic guitars<br>
          East Greenwich, Rhode Island, USA<br>
          <a href="mailto:sales@leftyguitarsonly.com">sales@leftyguitarsonly.com</a>
        </div>
        <div id="leftyguitars.be">
          <a target="leftyguitars.be" href="http://leftyguitars.be/">Lefty Guitars</a><br>
          Europe’s ultimate choice in lefty guitars and basses<br>
          Peulis, Belgium<br>
          <a href="mailto:patrick@leftyguitars.be">patrick@leftyguitars.be</a>
        </div>
      </div>
    </footer>

    <style>
      body, article, div, header, footer, h1, h2, h3, h4, h5, h6 { padding: 0; margin: auto; position: relative; font: inherit; }
      a { color: inherit; text-decoration: inherit; }
      strong { font-weight: inherit; }
      html { background: #111; color: hsla(0, 0%, 100%, 0.5);}
      body { font: 4mm/4mm "Avenir", sans-serif; font-weight: 600; }
      body > header { position: absolute; top: -100%; }

      body > h1 { text-align: center; margin: 4mm 10mm 4mm; color: white;}

      form input[type=text], form input[type=url] { width: 100%; margin: auto; font: 4mm/4mm Consolas; box-sizing: border-box;}

      div.natural.articles { margin: auto; width: auto; position: relative; overflow:hidden; color: white;}
      div.natural.articles article { margin: 0; color: white; width: 33.333%; float: left; overflow:hidden;}
      div.natural.articles article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}
      div.natural.articles article .address { white-space: nowrap; position: absolute; background: hsla(0, 0%, 0%, 0.66); margin: 0 2mm; padding: 1mm; bottom: 19mm;}
      div.natural.articles article .title { white-space: nowrap; position: absolute; background: hsla(0, 0%, 0%, 0.66); margin: 0 2mm; padding: 1mm; bottom: 13mm;}

      div.natural.articles article .id { white-space: nowrap; position: absolute; margin: 1mm; padding: 1mm; top: 0; left:0; font-size: 50%; }
      div.natural.articles article .publication { white-space: nowrap; position: absolute; margin: 1mm; padding: 1mm; top: 0mm; background:black; display:none;}

      div.natural.articles article .price { position: absolute; margin: 0 2mm; height:5mm; left: 0; bottom: 8mm; background: hsla(0, 0%, 0%, 0.66); right:0; overflow:hidden; }
      div.natural.articles article .price .label { white-space: nowrap; position: absolute; margin: 0; width: 15mm; height:4mm; padding: 1mm 1mm 2mm; top: 0; left:0; background:transparent; text-align: right; color:hsla(0, 0%, 66%, 1);}
      div.natural.articles article .price .graphic { position: absolute; margin: 1mm 1px 0.33mm; height:3.66mm; bottom: 0; left:17mm; background:hsla(0, 0%, 55%, 1);}

      div.natural.articles article .duration { position: absolute; margin: 0 2mm 0; height:6mm; left: 0; bottom: 2mm; right:0; background: hsla(0, 0%, 0%, 0.66); overflow:hidden; }
      div.natural.articles article .duration .label { white-space: nowrap; position: absolute; margin: 0; width: 15mm; height:4mm; padding: 1mm 1mm 2mm; top: 0; left:0; background:transparent; text-align: right; color: hsla(0, 0%, 66%, 1);}
      div.natural.articles article .duration .graphic { position: absolute; margin: 1mm 1px 1.33mm; height:3.66mm; bottom: 0mm; left:17mm; background:hsla(0, 0%, 55%, 1);}

      div.natural.articles article button { position: absolute; top: 0; display:block; width:50%;}
      div.natural.articles article button.discard { left: 0; }
      div.natural.articles article button.approve { right: 0; }

      article:not(:hover) a { background: transparent; color: inherit;}
      article a[href]:not(:visited) { color: hsl(205, 50%, 50%); }
      article a[href]:visited { color: hsl(278, 50%, 50%); }

      h2 { margin: 20mm auto 0; }
      div.diminished.articles { margin: 0 auto 20mm; width: auto; position: relative; overflow:hidden; color: white;}
      div.diminished.articles article { margin: 0; color: white; width: 10%; float: left; overflow:hidden;}
      div.diminished.articles article img { width: 100%; height: 50mm; object-fit: cover; background-color: black; display:block;}

      #trashed { margin: auto; }
      #trashed article { opacity:0.33; }
      #trashed article:hover { opacity:0.99; }

      body > footer { line-height: 5mm; }

      #host { position: absolute; top: 0; left: 0; width: 33.333%; text-align: right; }
      #host > h6 { padding: 10mm 2mm 2mm; }
      #links { margin: 0 0 0 66.666%;  }
      #links > h6 { padding: 10mm 2mm 2mm; }
      #links > div { margin: 4mm 0; padding: 2mm; }

      a.window { display:block; box-shadow: 0 0 1mm 0 black; border-top: 1mm solid hsla(0, 0%, 100%, 0.44);}
      a.window img { width: 100%; display:block;}

      #paintedturtle { padding: 2mm; margin: 4mm 0;}
      #paintedturtle strong a[href] { color:hsl(333,88%,72%); }
      #paintedturtle a.window { position: absolute; left: 100%; right:-100%; top: -21mm; transform: scale(0.88)rotate(-1.11deg); transition: all 222ms ease-out;}
      #paintedturtle a.window:hover { transform: scale(0.99)rotate(+0.11deg); }

      body .turtle { text-align: center; padding: 3% 1% 1%; color: white; font-size: 200%;}
    </style>
  """
  if location.hostname.length is 9
    document.body.innerHTML += """
      <form id="add"><input type="URL" placeholder="Paste a URL to add another guitar" value=""></form>
      <form id="pocket"><input type="text" placeholder="Paste an ID to pocket an article" value="" maxlength="64" minlength="64"></form>
      <h2>Pocketd</h2>
      <div id="pocketd" class="natural articles"></div>
      <h2>Trashed</h2>
      <div id="trashed" class="diminished articles"></div>
    """

document.on "DOMContentLoaded", ->
  {current, expired, pocketd, novelty, trashed} = window.instruments.query().reduce(toCurrentExpiredNoprice, {})
  renderCurrentArticles current
  renderExpiredArticles expired
  if location.hostname.length is 9
    renderNovelty novelty
    renderPocket pocketd
    renderTrash trashed

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
  console.info discard:button
  id = button.closest("article").id
  d3.xhr("#{window.location}#{id}")
    .header "Content-Type", "application/json"
    .post JSON.stringify({trashed:yes}), (error, response) ->
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
  {current} = window.instruments.query().reduce(toCurrentExpiredNoprice, {})
  console.info current.length
  if input.value
    pattern = new RegExp "\\b#{input.value}", "i"
  else
    pattern = new RegExp "."
  console.info pattern
  renderCurrentArticles current.filter (article) -> pattern.test(article["title"]) or pattern.test(article["description"])

document.on "input", "#pricelimit input", (event, input) ->
  limit = Number(input.value)
  {current} = window.instruments.query().reduce(toCurrentExpiredNoprice, {})
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
    <div class="title">#{article.title or 'Untitled'}</div>
    <div class="address"><a target="#{article.id}" href="#{article.address}">#{simplifiedAddress article.address}</a></div>
    <div class="price">
      <div class="graphic" style="width:#{article.price/13}%"></div>
      <div class="label">$ #{ Math.ceil(article.price) }</div>
    </div>
    <div class="duration">
      <div class="graphic" style="width:#{Math.round((Date.now()-article["publication time"]) / 24.hours()) * 1.25 }%"></div>
      <div class="label">#{ Math.round((Date.now()-article["publication time"]) / 24.hours()) } #{if Math.round((Date.now()-article["publication time"]) / 24.hours()) > 1 then 'days' else 'day'}</div>
    </div>
    <img src="#{article.photographs[0]}">
  """
  if location.hostname is "localhost" and article.approved is undefined
    output += """
      <div class="id">#{if location.hostname is "localhost" then article.id else ""}</div>
      <button class="discard">⌫</button>
      <button class="approve">👀</button>
    """
  return output


renderExpiredArticles = (data) ->
  sorted = data
    .sort (a, b) -> b["access time"] - a["access time"]
    .slice(0, 10)
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
