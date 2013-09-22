(($) ->
  $.fn.four04 = (options) ->
    settings = $.extend(
      color: "#FF6D00"
      backgroundColor: "white"
      bareCSS: "true"
      width: 500
      wrapperClass: "kids404-wrapper"
      kidsId: "kids404"
      cssFile: "../src/embed-jquery.css"
      apiURL: "http://404kids.org/api/random"
      htmlTemplate: """
  <div class="{{wrapperClass}}">
    <div class="front">
      <h2>Missing Person Near <span class="geo-city">Seattle</span></h2>
      <div class="image">
        <img src="http://missingkids.com/{{image_url}}">
      </div>
      <div class="info">
        <h3>{{full_name}}</h3>
        <h4>Current Age {{ageString}}</h4>
        <h4>Missing From {{missing_city}}, {{missing_state}}
        <br>since {{month}} {{day}}, {{year}}</h4>
        <h4 class="question">Have You Seen This Person?</h4>
        <br>
        <a href="{{missingLink}}" class="btn">SEEN</a>
        <a href="#" onclick="showKid({{id}});return false;" class="btn">NO</a>
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

      <p>If you have any information to report on one of our featured subjects, we urge you to <a href="{{missingLink}}">fill out a report</a> immediately.</p>
      <div class="more-info" onclick="document.getElementById('kids404').className = '';">
        <span>x</span>
      </div>
    </div>
  </div>
  """



    , options)
    
    @.attr("id", "#{settings.kidsId}")
    window.kidsCont = @
    # load json
    jqxhr = $.getJSON settings.apiURL, (data) ->
      kid = data.kid
      # console.log kid
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
      console.log kid.age
      console.log kid.missing_url
      console.log kid.id
      window.kidView = 
        wrapperClass: settings.wrapperClass
        image_url: kid.image_url
        full_name: kid.full_name
        ageString: if kid.age then "#{kid.age} Years Old" else "Age Not Provided"
        missing_city: kid.missing_city
        missing_state: kid.missing_state
        year: parseInt(kid.missing_date.slice(0,4), 10)
        month: months[parseInt(kid.missing_date.slice(5,7), 10)]
        day: parseInt(kid.missing_date.slice(8,10), 10)
        missingLink: kid.missing_url
        id: kid.id
    .done( ->
      window.kidsCont.html Mustache.render(settings.htmlTemplate, window.kidView)
      )
    .error( ->
      console.log "error loading json data."
      )
  # public methods
  @showKid = (exclude) ->
    console.log "public showKid triggered => #{exclude}"
) jQuery