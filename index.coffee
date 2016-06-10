document.on "DOMContentLoaded", ->
  document.body.innerHTML = """
    <form>
    <input type="URL" placeholder="Paste a URL to add another guitar" value="">
    </form>
    <div id="articles"></div>
    <style>
      html { background: #333; }
      body, article,div { padding: 0; margin: auto; position: relative;}
      form { width: 300mm; margin: 10mm auto;}
      form input { width: 100%; margin: auto; font: 4mm/4mm Consolas; }
      #articles { margin: 10mm auto; width: 300mm; position: relative; overflow:hidden;}
      article { margin: 0; color: white; font: 4mm/4mm Consolas; width: 100mm; float: left; outline: 1px solid black; overflow:hidden;}
      article img { width: 100mm; height: 100mm; object-fit: cover; background-color: black; display:block;}
      article .title { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm;}
      article .price { white-space: nowrap; position: absolute; background: black; margin: 1mm; padding: 1mm; top: 5mm;}
    </style>
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
    <div class="title">#{simplifiedTitle d.title}</div>
    <div class="price">#{d.price}</div>
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
