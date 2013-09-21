wrapperClass = ".kids404-wrapper"
width = 500
styles = """
<style>
  #kids404 {
    perspective: 1000;
  }
  #kids404.flipped #{wrapperClass} {
    transform: rotateY(180deg);
    -webkit-transform: rotateY(180deg);
    -moz-transform: rotateY(180deg);
  }
  #{wrapperClass} {
    font-family: Helvetica, Arial, Sans-Serif;
    font-weight: 300;
    margin: 0px auto;
    width: #{width}px;
    box-shadow: 0 0 4px black;
    padding: 10px 10px 23px 10px;
    border-radius: 3px;
    position: relative;
    height: 190px;
    transition: 0.5s;
    transform-style: preserve-3d;
    -webkit-transform-style: preserve-3d;
    -moz-transform-style: preserve-3d;
  }
  #{wrapperClass} .image {
    float: left;
    width: 160px;
    height: 200px;
  }
  #{wrapperClass} .image img {
    max-width: 160px;
    max-height: 200px;
  }
  #{wrapperClass} .info {
    margin-left: 10px;
    position: relative;
    left: 10px;
    top: 6px;
  }
  #{wrapperClass} .info h3 {
    margin: 0px;
  }
  #{wrapperClass} .btn {
    text-decoration: none;
    color: white;
    padding: 10px 34px;
    background-color: #ccc;
    margin-right: 10px;
    border-radius: 3px;
  }
  #{wrapperClass} .btn-yes {
    background-color: rgba(0,162,0,0.8)
  }
  #{wrapperClass} .more-info {
    position: absolute;
    right: 0px;
    bottom: 6px;
    cursor: pointer;
  }
  #{wrapperClass} .more-info span {
    border-radius: 8px;
    font-size: 10px;
    background-color: #ccc;
    padding: 3px 6px;
    color: white;
    font-weight: 500;
    font-family: Courier New;
  }

  #{wrapperClass} .front, #{wrapperClass} .back {
    backface-visibility: hidden;
    -webkit-backface-visibility: hidden;
    -moz-backface-visibility: hidden;
    position: absolute;
    top: 10px;
    left: 10px;
    width: #{width}px;
    background-color: white;
    height: 200px;
  }
  #{wrapperClass} .back {
    -webkit-transform: rotateY(180deg);
    -moz-transform: rotateY(180deg);
    transform: rotateY(180deg);
  }
  #{wrapperClass} .front {
    z-index: 2;
  }
  #{wrapperClass} h3, #{wrapperClass} h4 {
    font-weight: 300;
    letter-spacing: 1px;
  }
</style>
"""
template = (kid) ->
  html = """
  #{styles}
  <div class="#{wrapperClass.slice(1)}">
    <div class="front">
      <div class="image">
        <img src="http://missingkids.com/#{kid.image_url}">
      </div>
      <div class="info">
        <h3>#{kid.full_name}</h3>
        <h4>#{kid.age} Years Old</h4>
        <h4>Missing From #{kid.missing_city}, #{kid.missing_state}</h4>
        <h4>Have You Seen This Person?</h4>
        <a href="#" class="btn btn-yes">Yes</a><a href="#" class="btn">No</a>
      </div>
      <div class="more-info" onclick="document.getElementById('kids404').className = 'flipped';">
        <span>?</span>
      </div>
    </div>
    <div class="back">
      <p>More Information!</p>
      <p>This person was first reported missing after leaving school in Tacoma, WA.</p>
      <p>If you have any information report, please
      <a href="#">fill out a report</a>. It takes less than 60 seconds.</p>
      <div class="more-info" onclick="document.getElementById('kids404').className = '';">
        <span>x</span>
      </div>
    </div>
  </div>
  """
xml = null
ajax = (opts) ->
  xml = new XMLHttpRequest()
  xml.onreadystatechange = ->
    if xml.readyState == 4 && xml.status == 200
      opts.done()
  xml.open("GET", opts.url, true)
  xml.send()
showKid = ->
  ajax
    url: "http://fouroh4kids.herokuapp.com/api/random"
    done: ->
      data = JSON.parse(xml.responseText)
      kid = data.kid
      html = template(kid)
      container = document.createElement('div')
      container.id = "kids404"
      container.innerHTML = html
      script = document.getElementById("404kids-script")
      body = document.getElementsByTagName('body')[0]
      body.insertBefore(container, script)
showKid()


