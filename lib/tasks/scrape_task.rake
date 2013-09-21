namespace :scrape do
  desc "Scrape the missing kids database."
  task mk: :environment do
    require 'net/http'
    require 'json'
    require 'date'

    # states = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC",
    #   "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN",
    #   "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO",
    #   "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV",
    #   "NY", "MP", "OH", "OK", "OR", "PA", "PR", "RI", "SC",
    #   "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI",
    #   "WV", "WY"]
    states = ["WA", "ID"]

    states.each do |state|
      puts "Starting #{state}..."
      # set the initial request
      http = Net::HTTP.new("www.missingkids.com")
      path = "/missingkids/servlet/JSONDataServlet?action=publicSearch&searchLang=en_US&search=new&subjToSearch=child&missState=#{state}&missCountry=US"

      # get the cookie
      r = http.get(path)
      cookie = {'Cookie'=>r.to_hash['set-cookie'].collect{|ea|ea[/^.*?;/]}.join}

      # get the total number of pages
      json = JSON.parse(r.body)
      total_pages = json['totalPages']
      total_records = json['totalRecords']
      puts "Total pages: #{total_pages}"
      puts "Total pages: #{total_records}"

      # iterate through the pages and insert the data into database
      total_pages.times do |i|
        page = http.get("/missingkids/servlet/JSONDataServlet?action=publicSearch&searchLang=en_US&goToPage=#{i + 1}", cookie)
        kids = JSON.parse(page.body)
        kids['persons'].each do |kid|
          nk = Kid.new
          nk.case_number = kid['caseNumber']
          nk.org_prefix = kid['orgPrefix']
          nk.first_name = kid['firstName'].capitalize
          nk.last_name = kid['lastName'].capitalize
          nk.middle_name = kid['middleName'].capitalize
          nk.missing_city = kid['missingCity'].capitalize
          nk.missing_state = kid['missingState'].upcase
          nk.missing_county = kid['missingCounty'].capitalize
          nk.missing_country = kid['missingCountry'].upcase
          nk.missing_date = kid['missingDate'].blank? ? Date.new(1900,1,1) : DateTime.parse(kid['missingDate'])
          nk.age = kid['age']
          nk.thumbnail = kid['hasThumbnail']
          nk.poster = kid['hasPoster']
          nk.thumbnail_url = kid['thumbnailUrl']
          if nk.save
            print "."
          else
            print "F"
          end
        end
      end
      puts "Finished #{state}"
    end
  end

  desc "Find out if a kid has an aged photo."
  task aged_image: :environment do
    require 'net/http'
    require 'json'

    kids = Kid.all
    kids.each do |kid|
      uri = URI("http://www.missingkids.com/missingkids/servlet/JSONDataServlet?action=childDetail&caseNum=#{kid.case_number}&orgPrefix=#{kid.org_prefix}")
      page = Net::HTTP.get(uri)
      json = JSON.parse(page)
      unless json["status"] == "error"
        if kid.update_attribute(:has_aged_photo, json["childBean"]["hasAgedPhoto"])
          print "."
        else
          print "F"
        end
      else
        puts "\nid: #{kid.id} - #{kid.first_name} #{kid.last_name} has no info."
      end
    end
  end

  desc "Set kid's aged photo."
  task set_aged_image_url: :environment do
    kids = Kid.where("has_aged_photo = true")
    kids.each do |kid|
      new_url =  kid.image_url.gsub(/c{1}(?=\d.jpg)/, "e")
      kid.update_attribute(:aged_photo_url, new_url)
    end
  end
end
