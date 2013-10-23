wrapperClass = ".kids404-wrapper"
width = 500
styles = """
<style>
  #kids404 {
    perspective: 1000;
    text-align: left;
    box-sizing: content-box;
    margin: 10px 0;
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
    height: 235px;
    transition: 0.5s;
    transform-style: preserve-3d;
    -webkit-transform-style: preserve-3d;
    -moz-transform-style: preserve-3d;
    line-height: 1;
    box-sizing: content-box;
  }
  #{wrapperClass} .front h2, #{wrapperClass} .back h2 {
    margin-top: 0;
    margin-bottom: 10px;
    text-transform: uppercase;
    font-weight: 200;
  }
  #{wrapperClass} .geo-city {
    font-weight: 500;
    color: #FF6D00;
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
    top: 0px;
    line-height: 14px;
  }
  #{wrapperClass} .info h3, #{wrapperClass} .info h4 {
    margin: 0px 0 18px;
  }
  #{wrapperClass} .info h3 {
    font-weight: bold;
  }
  #{wrapperClass} .info .question {
    font-weight: bold;
    margin-bottom: 20px;
  }
  #{wrapperClass} .btn-404 {
    text-decoration: none;
    color: white;
    padding: 10px 34px;
    background-color: #FF6D00;
    margin-right: 10px;
    border-radius: 3px;
  }
  #{wrapperClass} .more-info {
    position: absolute;
    right: 0px;
    bottom: 3px;
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
    top: 15px;
    left: 10px;
    width: #{width}px;
    height: 235px;
  }
  #{wrapperClass} .back {
    -webkit-transform: rotateY(180deg);
    -moz-transform: rotateY(180deg);
    transform: rotateY(180deg);
  }
  #{wrapperClass} .front {
    z-index: 2;
  }
  #{wrapperClass} h3, #{wrapperClass} h4, #{wrapperClass} h2 {
    font-weight: 300;
    line-height: 1;
    font-family: Helvetica, Arial, Sans-Serif;
  }
  #{wrapperClass} h2 {
    font-size: 24px;
  }#{wrapperClass} h3 {
    font-size: 22px;
  }#{wrapperClass} h4 {
    font-size: 16px;
  }#{wrapperClass} a {
    font-size: 14px;
  }
</style>
"""
template = (data) ->
  kid = data.kid
  location = data.meta.location
  missing = kid.missing_date
  year = parseInt(missing.slice(0,4), 10)
  month = parseInt(missing.slice(5,7), 10)
  day = parseInt(missing.slice(8,10), 10)
  date = new Date(year, month-1, day)
  ageString = if kid.age then "#{kid.age} Years Old" else "Age Not Provided"
  if kid.aged_photo_url
    agedImage = "http://missingkids.com/#{kid.aged_photo_url}"
  else
    agedImage = "http://placehold.it/160x200&text=No+Aged+Photo+Found"
  console.log kid
  months = [
    "January"
    "February"
    "March"
    "April"
    "May"
    "June"
    "July"
    "August"
    "September"
    "October"
    "November"
    "December"
  ]
  missingLink = kid.missing_url
  html = """
  #{styles}
  <div class="#{wrapperClass.slice(1)}">
    <div class="front">
      <h2>Missing Person Near <span class="geo-city">#{location.city}</span></h2>
      <div class="image">
        <img src="http://missingkids.com/#{kid.image_url}">
      </div>
      <div class="info">
        <h3>#{kid.full_name}</h3>
        <h4>Current Age #{ageString}</h4>
        <h4>Missing From #{kid.missing_city}, #{kid.missing_state}
        <br>since #{months[month-1]} #{day}, #{year}</h4>
        <h4 class="question">Have You Seen This Person?</h4>
        <br>
        <a href="#{missingLink}" class="btn-404">SEEN</a>
        <a href="#" onclick="showKid(#{kid.id});return false;" class="btn-404">NO</a>
      </div>
      <div class="more-info" onclick="document.getElementById('kids404').className = 'flipped';">
        <span>?</span>
      </div>
    </div>
    <div class="back">
      <h2>Missing Person Near <span class="geo-city">#{location.city}</span></h2>
      <div class="image">
        <img src="#{agedImage}">
      </div>
      <div class="info">
        <p>#{kid.circumstance}</p>
        <p><a href="#{missingLink}">Read More about #{kid.full_name}</a></p>
        <p>Brought to you by <a href="http://404kids.org">404kids</a>.</p>
      </div>
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
window.showKid = (exclude=null) ->
  ajax
    url: "http://404kids.org/api/random?exclude=#{exclude}"
    done: ->
      data = JSON.parse(xml.responseText)
      html = template(data)
      container = document.getElementById("kids404") || document.createElement('div')
      container.id = "kids404"
      container.innerHTML = html
      script = document.getElementById("kids404-script") || document.getElementById("404kids") || document.getElementById("404kids-script")
      script.parentNode.insertBefore(container, script)
showKid()


