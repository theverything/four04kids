(function() {
  var ajax, styles, template, width, wrapperClass, xml;

  wrapperClass = ".kids404-wrapper";

  width = 500;

  styles = "<style>\n  #kids404 {\n    perspective: 1000;\n    text-align: left;\n    box-sizing: content-box;\n    margin: 10px 0;\n  }\n  #kids404.flipped " + wrapperClass + " {\n    transform: rotateY(180deg);\n    -webkit-transform: rotateY(180deg);\n    -moz-transform: rotateY(180deg);\n  }\n  " + wrapperClass + " {\n    font-family: Helvetica, Arial, Sans-Serif;\n    font-weight: 300;\n    margin: 0px auto;\n    width: " + width + "px;\n    box-shadow: 0 0 4px black;\n    padding: 10px 10px 23px 10px;\n    border-radius: 3px;\n    position: relative;\n    height: 235px;\n    transition: 0.5s;\n    transform-style: preserve-3d;\n    -webkit-transform-style: preserve-3d;\n    -moz-transform-style: preserve-3d;\n    line-height: 1;\n    box-sizing: content-box;\n  }\n  " + wrapperClass + " .front h2, " + wrapperClass + " .back h2 {\n    margin-top: 0;\n    margin-bottom: 10px;\n    text-transform: uppercase;\n    font-weight: 200;\n  }\n  " + wrapperClass + " .geo-city {\n    font-weight: 500;\n    color: #FF6D00;\n  }\n  " + wrapperClass + " .image {\n    float: left;\n    width: 160px;\n    height: 200px;\n  }\n  " + wrapperClass + " .image img {\n    max-width: 160px;\n    max-height: 200px;\n  }\n  " + wrapperClass + " .info {\n    margin-left: 10px;\n    position: relative;\n    left: 10px;\n    top: 0px;\n    line-height: 14px;\n  }\n  " + wrapperClass + " .info h3, " + wrapperClass + " .info h4 {\n    margin: 0px 0 18px;\n  }\n  " + wrapperClass + " .info h3 {\n    font-weight: bold;\n  }\n  " + wrapperClass + " .info .question {\n    font-weight: bold;\n    margin-bottom: 20px;\n  }\n  " + wrapperClass + " .btn-404 {\n    text-decoration: none;\n    color: white;\n    padding: 10px 34px;\n    background-color: #FF6D00;\n    margin-right: 10px;\n    border-radius: 3px;\n  }\n  " + wrapperClass + " .more-info {\n    position: absolute;\n    right: 0px;\n    bottom: 3px;\n    cursor: pointer;\n  }\n  " + wrapperClass + " .more-info span {\n    border-radius: 8px;\n    font-size: 10px;\n    background-color: #ccc;\n    padding: 3px 6px;\n    color: white;\n    font-weight: 500;\n    font-family: Courier New;\n  }\n\n  " + wrapperClass + " .front, " + wrapperClass + " .back {\n    backface-visibility: hidden;\n    -webkit-backface-visibility: hidden;\n    -moz-backface-visibility: hidden;\n    position: absolute;\n    top: 15px;\n    left: 10px;\n    width: " + width + "px;\n    height: 235px;\n  }\n  " + wrapperClass + " .back {\n    -webkit-transform: rotateY(180deg);\n    -moz-transform: rotateY(180deg);\n    transform: rotateY(180deg);\n  }\n  " + wrapperClass + " .front {\n    z-index: 2;\n  }\n  " + wrapperClass + " h3, " + wrapperClass + " h4, " + wrapperClass + " h2 {\n    font-weight: 300;\n    line-height: 1;\n    font-family: Helvetica, Arial, Sans-Serif;\n  }\n  " + wrapperClass + " h2 {\n    font-size: 24px;\n  }" + wrapperClass + " h3 {\n    font-size: 22px;\n  }" + wrapperClass + " h4 {\n    font-size: 16px;\n  }" + wrapperClass + " a {\n    font-size: 14px;\n  }\n</style>";

  template = function(data) {
    var ageString, agedImage, date, day, html, kid, location, missing, missingLink, month, months, year;
    kid = data.kid;
    location = data.meta.location;
    missing = kid.missing_date;
    year = parseInt(missing.slice(0, 4), 10);
    month = parseInt(missing.slice(5, 7), 10);
    day = parseInt(missing.slice(8, 10), 10);
    date = new Date(year, month - 1, day);
    ageString = kid.age ? "" + kid.age + " Years Old" : "Age Not Provided";
    if (kid.aged_photo_url) {
      agedImage = "http://missingkids.com/" + kid.aged_photo_url;
    } else {
      agedImage = "http://placehold.it/160x200&text=No+Aged+Photo+Found";
    }
    console.log(kid);
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    missingLink = kid.missing_url;
    return html = "" + styles + "\n<div class=\"" + (wrapperClass.slice(1)) + "\">\n  <div class=\"front\">\n    <h2>Missing Person Near <span class=\"geo-city\">" + location.city + "</span></h2>\n    <div class=\"image\">\n      <img src=\"http://missingkids.com/" + kid.image_url + "\">\n    </div>\n    <div class=\"info\">\n      <h3>" + kid.full_name + "</h3>\n      <h4>Current Age " + ageString + "</h4>\n      <h4>Missing From " + kid.missing_city + ", " + kid.missing_state + "\n      <br>since " + months[month - 1] + " " + day + ", " + year + "</h4>\n      <h4 class=\"question\">Have You Seen This Person?</h4>\n      <br>\n      <a href=\"" + missingLink + "\" class=\"btn-404\">SEEN</a>\n      <a href=\"#\" onclick=\"showKid(" + kid.id + ");return false;\" class=\"btn-404\">NO</a>\n    </div>\n    <div class=\"more-info\" onclick=\"document.getElementById('kids404').className = 'flipped';\">\n      <span>?</span>\n    </div>\n  </div>\n  <div class=\"back\">\n    <h2>Missing Person Near <span class=\"geo-city\">" + location.city + "</span></h2>\n    <div class=\"image\">\n      <img src=\"" + agedImage + "\">\n    </div>\n    <div class=\"info\">\n      <p>" + kid.circumstance + "</p>\n      <p><a href=\"" + missingLink + "\">Read More about " + kid.full_name + "</a></p>\n      <p>Brought to you by <a href=\"http://404kids.org\">404kids</a>.</p>\n    </div>\n    <div class=\"more-info\" onclick=\"document.getElementById('kids404').className = '';\">\n      <span>x</span>\n    </div>\n  </div>\n</div>";
  };

  xml = null;

  ajax = function(opts) {
    xml = new XMLHttpRequest();
    xml.onreadystatechange = function() {
      if (xml.readyState === 4 && xml.status === 200) {
        return opts.done();
      }
    };
    xml.open("GET", opts.url, true);
    return xml.send();
  };

  window.showKid = function(exclude) {
    if (exclude == null) {
      exclude = null;
    }
    return ajax({
      url: "http://404kids.org/api/random?exclude=" + exclude,
      done: function() {
        var container, data, html, script;
        data = JSON.parse(xml.responseText);
        html = template(data);
        container = document.getElementById("kids404") || document.createElement('div');
        container.id = "kids404";
        container.innerHTML = html;
        script = document.getElementById("kids404-script") || document.getElementById("404kids") || document.getElementById("404kids-script");
        return script.parentNode.insertBefore(container, script);
      }
    });
  };

  showKid();

}).call(this);
