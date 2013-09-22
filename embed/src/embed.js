(function() {
  var ajax, styles, template, width, wrapperClass, xml;

  wrapperClass = ".kids404-wrapper";

  width = 500;

  styles = "<style>\n  #kids404 {\n    perspective: 1000;\n    text-align: left;\n  }\n  #kids404.flipped " + wrapperClass + " {\n    transform: rotateY(180deg);\n    -webkit-transform: rotateY(180deg);\n    -moz-transform: rotateY(180deg);\n  }\n  " + wrapperClass + " {\n    font-family: Helvetica, Arial, Sans-Serif;\n    font-weight: 300;\n    margin: 0px auto;\n    width: " + width + "px;\n    box-shadow: 0 0 4px black;\n    padding: 10px 10px 23px 10px;\n    border-radius: 3px;\n    position: relative;\n    height: 235px;\n    transition: 0.5s;\n    transform-style: preserve-3d;\n    -webkit-transform-style: preserve-3d;\n    -moz-transform-style: preserve-3d;\n  }\n  " + wrapperClass + " .front h2 {\n    margin-top: 0;\n    margin-bottom: 10px;\n    text-transform: uppercase;\n    font-weight: 200;\n  }\n  " + wrapperClass + " .geo-city {\n    font-weight: 500;\n    color: #FF6D00;\n  }\n  " + wrapperClass + " .image {\n    float: left;\n    width: 160px;\n    height: 200px;\n  }\n  " + wrapperClass + " .image img {\n    max-width: 160px;\n    max-height: 200px;\n  }\n  " + wrapperClass + " .info {\n    margin-left: 10px;\n    position: relative;\n    left: 10px;\n    top: 17px;\n  }\n  " + wrapperClass + " .info h3, " + wrapperClass + " .info h4 {\n    margin: 0px 0 10px;\n  }\n  " + wrapperClass + " .info h3 {\n    font-weight: bold;\n  }\n  " + wrapperClass + " .info .question {\n    font-weight: bold;\n  }\n  " + wrapperClass + " .btn {\n    text-decoration: none;\n    color: white;\n    padding: 10px 34px;\n    background-color: #FF6D00;\n    margin-right: 10px;\n    border-radius: 3px;\n  }\n  " + wrapperClass + " .btn-yes {\n    background-color: rgba(0,162,0,0.8)\n  }\n  " + wrapperClass + " .more-info {\n    position: absolute;\n    right: 0px;\n    bottom: -35px;\n    cursor: pointer;\n  }\n  " + wrapperClass + " .more-info span {\n    border-radius: 8px;\n    font-size: 10px;\n    background-color: #ccc;\n    padding: 3px 6px;\n    color: white;\n    font-weight: 500;\n    font-family: Courier New;\n  }\n\n  " + wrapperClass + " .front, " + wrapperClass + " .back {\n    backface-visibility: hidden;\n    -webkit-backface-visibility: hidden;\n    -moz-backface-visibility: hidden;\n    position: absolute;\n    top: 15px;\n    left: 10px;\n    width: " + width + "px;\n    height: 200px;\n  }\n  " + wrapperClass + " .back {\n    -webkit-transform: rotateY(180deg);\n    -moz-transform: rotateY(180deg);\n    transform: rotateY(180deg);\n  }\n  " + wrapperClass + " .front {\n    z-index: 2;\n  }\n  " + wrapperClass + " h3, " + wrapperClass + " h4 {\n    font-weight: 300;\n    letter-spacing: 1px;\n  }\n</style>";

  template = function(kid) {
    var ageString, date, day, html, missing, missingLink, month, months, year;
    missing = kid.missing_date;
    year = parseInt(missing.slice(0, 4), 10);
    month = parseInt(missing.slice(5, 7), 10);
    day = parseInt(missing.slice(8, 10), 10);
    date = new Date(year, month - 1, day);
    ageString = kid.age ? "" + kid.age + " Years Old" : "Age Not Provided";
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    missingLink = kid.missing_url;
    return html = "" + styles + "\n<div class=\"" + (wrapperClass.slice(1)) + "\">\n  <div class=\"front\">\n    <h2>Missing Person Near <span class=\"geo-city\">Seattle</span></h2>\n    <div class=\"image\">\n      <img src=\"http://missingkids.com/" + kid.image_url + "\">\n    </div>\n    <div class=\"info\">\n      <h3>" + kid.full_name + "</h3>\n      <h4>Current Age " + ageString + "</h4>\n      <h4>Missing From " + kid.missing_city + ", " + kid.missing_state + "\n      <br>since " + months[month] + " " + day + ", " + year + "</h4>\n      <h4 class=\"question\">Have You Seen This Person?</h4>\n      <br>\n      <a href=\"" + missingLink + "\" class=\"btn\">SEEN</a>\n      <a href=\"#\" onclick=\"showKid(" + kid.id + ");return false;\" class=\"btn\">NO</a>\n    </div>\n    <div class=\"more-info\" onclick=\"document.getElementById('kids404').className = 'flipped';\">\n      <span>?</span>\n    </div>\n  </div>\n  <div class=\"back\">\n    <p>This service is brought to you by <a href=\"http://404kids.org\">404kids</a>, and is intended to help reclaim\n    the visibility and independence of missing children.</p>\n\n    <p>If you would like to aid in\n    the search for missing and exploited adolescents, please <a href=\"http://404kids.org/docs\">add this widget to your site</a>.</p>\n\n    <p>If you have any information to report on one of our featured subjects, we urge you to <a href=\"" + missingLink + "\">fill out a report</a> immediately.</p>\n    <div class=\"more-info\" onclick=\"document.getElementById('kids404').className = '';\">\n      <span>x</span>\n    </div>\n  </div>\n</div>";
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
        var body, container, data, html, kid, script;
        data = JSON.parse(xml.responseText);
        kid = data.kid;
        html = template(kid);
        container = document.getElementById("kids404") || document.createElement('div');
        container.id = "kids404";
        container.innerHTML = html;
        script = document.getElementById("404kids-script");
        body = document.getElementsByTagName('body')[0];
        return body.insertBefore(container, script);
      }
    });
  };

  showKid();

}).call(this);
