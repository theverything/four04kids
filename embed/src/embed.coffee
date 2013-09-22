wrapperClass = ".kids404-wrapper"
width = 500
styles = """
<style>
  #kids404 {
    perspective: 1000;
    text-align: left;
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
  }
  #{wrapperClass} .front h2 {
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
    top: 17px;
  }
  #{wrapperClass} .info h3, #{wrapperClass} .info h4 {
    margin: 0px 0 10px;
  }
  #{wrapperClass} .info h3 {
    font-weight: bold;
  }
  #{wrapperClass} .info .question {
    font-weight: bold;
  }
  #{wrapperClass} .btn {
    text-decoration: none;
    color: white;
    padding: 10px 34px;
    background-color: #FF6D00;
    margin-right: 10px;
    border-radius: 3px;
  }
  #{wrapperClass} .btn-yes {
    background-color: rgba(0,162,0,0.8)
  }
  #{wrapperClass} .more-info {
    position: absolute;
    right: 0px;
    bottom: -35px;
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
template = (data) ->
  kid = data.kid
  location = data.meta.location
  missing = kid.missing_date
  year = parseInt(missing.slice(0,4), 10)
  month = parseInt(missing.slice(5,7), 10)
  day = parseInt(missing.slice(8,10), 10)
  date = new Date(year, month-1, day)
  ageString = if kid.age then "#{kid.age} Years Old" else "Age Not Provided"
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
        <br>since #{months[month]} #{day}, #{year}</h4>
        <h4 class="question">Have You Seen This Person?</h4>
        <br>
        <a href="#{missingLink}" class="btn">SEEN</a>
        <a href="#" onclick="showKid(#{kid.id});return false;" class="btn">NO</a>
      </div>
      <div class="more-info" onclick="document.getElementById('kids404').className = 'flipped';">
        <span>?</span>
      </div>
    </div>
    <div class="back">
      <p>This service is brought to you by <a href="http://404kids.org">404kids</a>, and is intended to help reclaim
      the visibility and independence of missing children.</p>

      <p>If you would like to aid in
      the search for missing and exploited adolescents, please <a href="http://404kids.org/docs">add this widget to your site</a>.</p>

      <p>If you have any information to report on one of our featured subjects, we urge you to <a href="#{missingLink}">fill out a report</a> immediately.</p>
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
      script = document.getElementById("404kids-script")
      body = document.getElementsByTagName('body')[0]
      body.insertBefore(container, script)
showKid()


