document.on "DOMContentLoaded", ->
  document.body.innerHTML = """
    <header>
      <h1>Lefty Guitars For Sale Under $1000</h1>
    </header>
    <div id="articles"></div>

    <div id="hosted">
      <h6>This site is hosted by</h6>
      <div id="paintedturtle">
        <a href="">Painted Turtle instruments</a><br>
        Well-worm lefty guitars in Ottawa, Ontario<br>
        <a href="mailto:instruments@paintedturtle.xyz">instruments@paintedturtle.xyz</a>
      </div>
    </div>
    <div id="links">
      <h6>Lefty Links</h6>
      <div id="jerrysleftyguitars">
        <a href="">Jerry’s Lefty Guitars</a><br>
        World’s finest collection of lefty guitars in Sarasota, Florida<br>
        <a href="mailto:instruments@paintedturtle.xyz">instruments@paintedturtle.xyz</a>
      </div>
      <div id="leftyguitarsonly">
        <a href="">Lefty Guitars Only</a><br>
        Expensive lefty guitars in East Greenwich, Rhode Island<br>
        <a href="mailto:instruments@paintedturtle.xyz">instruments@paintedturtle.xyz</a>
      </div>
    </div>
    <style>
      html { background: #333; color: white;}
      body { font: 4mm/4mm Consolas; }
      body, article, div, header, footer, h1, h2, h3, h4, h5, h6 { padding: 0; margin: auto; position: relative; font: inherit; }
      body > header { position: absolute; top: -100%; }
      form { width: 300mm; margin: 10mm auto;}
      form input { width: 100%; margin: auto; font: 4mm/4mm Consolas; }
      #articles { margin: auto; width: auto; position: relative; overflow:hidden;}
      article { margin: 0; color: white; font: 4mm/4mm Consolas; width: 33.333%; float: left; outline: 1px solid black; overflow:hidden;}
      article img { width: 100%; height: 100mm; object-fit: cover; background-color: black; display:block;}
      article .title { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 10mm;}
      article .price { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 5mm;}
      article .address { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; bottom: 0mm;}
      article:not(:hover) a { background: transparent; color: inherit;}
      article:hover a { background: hsl(333, 50%, 50%); color: black; text-decoration: underline;}

      #add { position: fixed; top: 0; left: 0; right: 0;}
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
