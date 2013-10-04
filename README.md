[![Code Climate](https://codeclimate.com/github/theverything/four04kids.png)](https://codeclimate.com/github/theverything/four04kids)

# Embedding Widget

### Installation

[Live Demo](https://s3.amazonaws.com/404kids/public/demo.html)

Simply drop this line of code on your page:

~~~HTML
<script id='kids404-script' src="https://s3.amazonaws.com/404kids/src/embed.js" type="text/javascript"></script>
~~~

# API

### index `/api/index`

This API returns a list of missing persons in the US.

##### Optional Parameters

- **missing_state**: a 2-digit capitalized state name abbreviation, like *WA*. Default: *nil*
- **sex**: 'Male' or 'Female'. Default: *nil*
- **page**: The page of API responses you wish to fetch. Use this for pagination. Default: *1*.
- **per_page**: How many results you would like returned per page. Maximum: *100*. Default: *100*.

*If you would like to use more advanced filters, feel free to [file an issue](https://github.com/theverything/four04kids/issues/new) or [contribute some code](https://github.com/theverything/four04kids/blob/master/app/controllers/api_controller.rb).*

##### Response

~~~javascript
{
  "api": [
    {
      "id": 1291,
      "missing_city": "Gaithersburg",
      "missing_state": "MD",
      "missing_county": "Montgomery",
      "missing_country": "US",
      "missing_date": "2013-10-02",
      "age": 15,
      "thumbnail_url": "/photographs/USMDr13047111c1t.jpg",
      "image_url": "/photographs/USMDr13047111c1.jpg",
      "aged_photo_url": null,
      "case_number": "r13047111",
      "org_prefix": "USMD",
      "first_name": "Jacob",
      "last_name": "Harris",
      "middle_name": "",
      "full_name": "Jacob  Harris",
      "missing_url": "http://www.missingkids.com/missingkids/servlet/PubCaseSearchServlet?act=viewPoster&caseNum=r13047111&orgPrefix=USMD",
      "weight": null,
      "height": null,
      "eye_color": null,
      "hair_color": null,
      "race": null,
      "sex": null,
      "circumstance": null,
      "has_aged_photo": null
    }, { ... }, ...
  ]
}
~~~

### random `/api/random`

This API call returns a random missing person within 500 miles of the request's location.

##### Parameters

- **exclude**: an `id` to exclude from your search results. Use this to ensure you don't get the same result twice in a row.
- **limit**: mile radius to return geoquery results for. **Default**: 500.
- **location**: use a specific location for request. Defaults to `request.ip`. Valid formats include an ip address [`50.78.167.161`] or address [`bethesda, md`, `421 fairview ave n. seattle`]. To specify a latitude/longitude, use the query format `location[]=latitude&location[]=longitude`.

##### Response

~~~javascript
{
  "kid": {
    "id": 2598,
    "missing_city": "Tacoma",
    "missing_state": "WA",
    "missing_county": "Pierce",
    "missing_country": "US",
    "missing_date": "2000-09-21",
    "age": 29,
    "thumbnail_url": "/photographs/NCMC1152881c1t.jpg",
    "image_url": "/photographs/NCMC1152881c1.jpg",
    "aged_photo_url": "/photographs/NCMC1152881e1.jpg",
    "case_number": "1152881",
    "org_prefix": "NCMC",
    "first_name": "Jennifer",
    "last_name": "Enyart",
    "middle_name": "Mae",
    "full_name": "Jennifer Mae Enyart",
    "missing_url": "http://www.missingkids.com/missingkids/servlet/PubCaseSearchServlet?act=viewPoster&caseNum=1152881&orgPrefix=NCMC",
    "weight":120,
    "height":63,
    "eye_color":"blue",
    "hair_color":"blonde",
    "race":"White",
    "sex":"Female",
    "circumstance":"Jennifer's photo is shown age-progressed to 26 years.  She was last seen on September 21, 2000.  She may have traveled to Florida. Jennifer may use the alias name Rochelle Smith.",
    "has_aged_photo":true
  },
  "meta": {
    "location": {
      "ip": "50.78.167.161",
      "country_code": "US",
      "country_name": "United States",
      "region_code": "WA",
      "region_name": "Washington",
      "city": "Bellevue",
      "zipcode": "",
      "latitude": 47.6104,
      "longitude": -122.2007,
      "metro_code": "819",
      "areacode": "425"
    }
  }
}
~~~

**N.B.**: If you specify a `location` paramater, the `meta.location` response will take the following form:

~~~javascript
"location":{
   "__type":"Location:http://schemas.microsoft.com/search/local/ws/rest/v1",
   "bbox":[
      47.61845726388513,
      -122.34203041025808,
      47.62618269902648,
      -122.32674911192248
   ],
   "name":"421 Fairview Ave N, Seattle, WA 98109",
   "point":{
      "type":"Point",
      "coordinates":[
         47.6223199814558,
         -122.33438976109028
      ]
   },
   "address":{
      "addressLine":"421 Fairview Ave N",
      "adminDistrict":"WA",
      "adminDistrict2":"King Co.",
      "countryRegion":"United States",
      "formattedAddress":"421 Fairview Ave N, Seattle, WA 98109",
      "locality":"Seattle",
      "postalCode":"98109"
   },
   "confidence":"Medium",
   "entityType":"Address",
   "geocodePoints":[
      {
         "type":"Point",
         "coordinates":[
            47.6223199814558,
            -122.33438976109028
         ],
         "calculationMethod":"InterpolationOffset",
         "usageTypes":[
            "Display"
         ]
      },
      {
         "type":"Point",
         "coordinates":[
            47.6223199814558,
            -122.3343227058649
         ],
         "calculationMethod":"Interpolation",
         "usageTypes":[
            "Route"
         ]
      }
   ],
   "matchCodes":[
      "Ambiguous",
      "Good"
   ]
}
~~~

### Contributing

All code related to our embedded widget can be found in `[/embed](https://github.com/theverything/four04kids/tree/master/embed)`.

All source code is maintained in coffeescript and automatically compiled and minified to javascript. Run `[guard](https://github.com/guard/guard)` from the command line while editing the coffeescript source file to automate this process.

Pull requests are always welcome for contributions to our backend or embedded widget!

### Credit

- [theverything](https://github.com/theverything)
- [tylermorgan86](https://github.com/tylermorgan86)
- [hstove](https://github.com/hstove)
