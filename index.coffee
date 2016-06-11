document.on "DOMContentLoaded", ->
  document.body.innerHTML = """
    <header>
      <h1>Lefty Guitars For Sale Under $1000</h1>
    </header>
    <div id="articles"></div>

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
      #articles { margin: auto; width: auto; position: relative; overflow:hidden; color: white;}
      article { margin: 0; color: white; width: 33.333%; float: left; outline: 1px solid black; overflow:hidden;}
      article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}
      article .title { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 10mm;}
      article .price { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 5mm;}
      article .address { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 0mm;}
      article:not(:hover) a { background: transparent; color: inherit;}
      article:hover a { background: hsl(333, 50%, 50%); color: black; text-decoration: underline;}

      #add { position: fixed; top: 0; left: 0; right: 0;}


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
    """

document.on "DOMContentLoaded", ->
  d3.json "database.json", (error, database) ->
    if error then console.error(error)
    window.instruments = Facts()
    window.instruments.datoms = Immutable.Stack Immutable.fromJS(database)
    console.info window.instruments.query()
    render window.instruments.query()

document.on "input", "input", (event, input) ->
  console.info input
  console.info "input":input.value
  if input.validity.valid then POST input.value

key = (d) -> d["title"]

render = (data) ->
  data = data.sort (a, b) -> b["access time"] - a["access time"]
  article = d3.select("#articles").selectAll("article").data(data, ((d) -> d.title) )
  article.enter().append("article")
  article.html (d) -> """
    <div class="title">#{simplifiedTitle(d.title) or 'Untitled'}</div>
    <div class="price">#{d.price}</div>
    <div class="address"><a href="#{d.address}">#{d.address.replace("http://www.", "")}</a></div>
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


POST = (location) ->
  d3.xhr(window.location)
    .header "Content-Type", "application/json"
    .post JSON.stringify({location}), (error, serialized) ->
      console.info data = JSON.parse(serialized)
