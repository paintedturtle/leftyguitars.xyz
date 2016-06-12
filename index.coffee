document.on "DOMContentLoaded", ->
  document.body.innerHTML = """
    <header>
      <h1>Lefty Guitars For Sale Under $1000</h1>
    </header>

    <h2 hidden>Current</h2>
    <div id="current"></div>

    <h2>Recently Departed</h2>
    <div id="expired" class="diminished articles"></div>

    <h2>Undefined Price</h2>
    <div id="noprice" class="diminished articles"></div>

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
      form { width: 300mm; margin: 10mm auto;}
      form input { width: 100%; margin: auto; font: 4mm/4mm Consolas; }
      #current { margin: auto; width: auto; position: relative; overflow:hidden; color: white;}
      #current article { margin: 0; color: white; width: 33.333%; float: left; overflow:hidden;}
      #current article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}
      #current article .address { white-space: nowrap; position: absolute; background: hsla(0, 0%, 0%, 0.66); margin: 0 2mm; padding: 1mm; bottom: 19mm;}
      #current article .title { white-space: nowrap; position: absolute; background: hsla(0, 0%, 0%, 0.66); margin: 0 2mm; padding: 1mm; bottom: 13mm;}

      #current article .id { white-space: nowrap; position: absolute; margin: 1mm; padding: 1mm; top: 0; left:0; font-size: 50%; }
      #current article .publication { white-space: nowrap; position: absolute; margin: 1mm; padding: 1mm; top: 0mm; background:black; display:none;}

      #current article .price { position: absolute; margin: 0 2mm; height:5mm; left: 0; bottom: 8mm; background: hsla(0, 0%, 0%, 0.66); right:0; overflow:hidden; }
      #current article .price .label { white-space: nowrap; position: absolute; margin: 0; width: 15mm; height:4mm; padding: 1mm 1mm 2mm; top: 0; left:0; background:transparent; text-align: right;}
      #current article .price .graphic { position: absolute; margin: 1mm 1px 0.33mm; height:3.66mm; bottom: 0; left:17mm; background:hsla(0, 0%, 99%, 1);}

      #current article .duration { position: absolute; margin: 0 2mm 0; height:6mm; left: 0; bottom: 2mm; right:0; background: hsla(0, 0%, 0%, 0.66); overflow:hidden; }
      #current article .duration .label { white-space: nowrap; position: absolute; margin: 0; width: 15mm; height:4mm; padding: 1mm 1mm 2mm; top: 0; left:0; background:transparent; text-align: right; color: hsla(0, 0%, 66%, 1);}
      #current article .duration .graphic { position: absolute; margin: 1mm 1px 1.33mm; height:3.66mm; bottom: 0mm; left:17mm; background:hsla(0, 0%, 66%, 1);}


      article:not(:hover) a { background: transparent; color: inherit;}
      article a[href]:not(:visited) { color: hsl(205, 50%, 50%); }
      article a[href]:visited { color: hsl(278, 50%, 50%); }

      h2 { margin: 10mm auto 0; }
      div.diminished.articles { margin: 0 auto 10mm; width: auto; position: relative; overflow:hidden; color: white;}
      div.diminished.articles article { margin: 0; color: white; width: 10%; float: left; overflow:hidden;}
      div.diminished.articles article img { width: 100%; height: 50mm; object-fit: cover; background-color: black; display:block;}


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
  if location.hostname is "localhost"
    document.body.innerHTML += """
      <form id="add">
        <input type="URL" placeholder="Paste a URL to add another guitar" value="">
      </form>
      <form id="pocket">
        <input type="text" placeholder="Paste an ID to pocket an article" value="" maxlength="64" minlength="64">
      </form>
      <div id="pocketd" class="diminished articles"></div>
    """

document.on "DOMContentLoaded", ->
  d3.json "database.json", (error, database) ->
    if error then console.error(error)
    window.instruments = Facts()
    window.instruments.datoms = Immutable.Stack Immutable.fromJS(database)
    {current, expired, noprice, pocketd} = window.instruments.query().reduce(toCurrentExpiredNoprice)
    render current
    renderExpiredArticles expired
    renderArticlesWithoutPrices noprice
    renderPocket pocketd if location.hostname is "localhost"

toCurrentExpiredNoprice = (reduction, guitar) ->
  reduction ?= {}
  reduction.current ?= []
  reduction.expired ?= []
  reduction.noprice ?= []
  reduction.pocketd ?= []
  if guitar.pocketd
    reduction.pocketd.push(guitar)
    return reduction
  if guitar.expired
    reduction.expired.push(guitar)
    return reduction
  if Number.isNaN Number guitar["price"].replace("$","").replace(",",".").split(".")[0]
    reduction.noprice.push(guitar)
    return reduction
  reduction.current.push(guitar)
  return reduction

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


render = (data) ->
  data = data.sort (a, b) -> b["access time"] - a["access time"]
  article = d3.select("#current").selectAll("article").data(data, ((d) -> d.id) )
  article.enter().append("article")
    .attr id:(d) -> d.id
  article.html (d) -> """
    <div class="title">#{simplifiedTitle(d.title) or 'Untitled'}</div>
    <div class="address"><a target="#{d.id}" href="#{d.address}">#{simplifiedAddress d.address}</a></div>
    <div class="price">
      <div class="graphic" style="width:#{Number(d["price"].replace("$","").replace(",",".").split(".")[0])/13}%"></div>
      <div class="label">$ #{ Number(d["price"].replace("$","").replace(",",".").split(".")[0]) }</div>
    </div>
    <div class="duration">
      <div class="graphic" style="width:#{Math.round (Date.now() - Date.parse(d["publication date"])) / 24.hours() * 1.25 }%"></div>
      <div class="label">#{Math.round (Date.now() - Date.parse(d["publication date"])) / 24.hours() } days</div>
    </div>
    <img src="#{d.photographs[0]}">
    <div class="id">#{d.id if location.hostname is "localhost"}</div>
    """
  article.exit().remove()

renderPocket = (data) ->
  article = d3.select("#pocketd").selectAll("article").data(data, ((d) -> d.id))
  article.enter().append("article")
    .attr id:(d) -> d.id
  article.html (d) -> """
    <img src="#{d.photographs[0]}">
    """
  article.exit().remove()

renderExpiredArticles = (data) ->
  article = d3.select("#expired").selectAll("article").data(data, ((d) -> d.id))
  article.enter().append("article")
    .attr id:(d) -> d.id
  article.html (d) -> """
    <img src="#{d.photographs[0]}">
    """
  article.exit().remove()

renderArticlesWithoutPrices = (data) ->
  console.info noprice:data
  article = d3.select("#noprice").selectAll("article").data(data, ((d) -> d.id))
  article.enter().append("article")
    .attr id:(d) -> d.id
  article.html (d) -> """
    <img src="#{d.photographs[0]}">
    """
  article.exit().remove()

simplifiedTitle = (title) ->
  title
    .replace(/guitar\s?/i, "")
    .replace(/lefty\s?/i, "")
    .replace(/left[- ]handed\s?/i, "")
    .replace(/left[- ]hand\s?/i, "")
    .replace("()", "")

simplifiedAddress = (input) ->
  input
    .replace("http://www.kijiji.ca", "kijiji")
    .replace("/v-view-details.html?adId=", "#")


POST = (location) ->
  d3.xhr(window.location)
    .header "Content-Type", "application/json"
    .post JSON.stringify({location}), (error, serialized) ->
      console.info data = JSON.parse(serialized)
