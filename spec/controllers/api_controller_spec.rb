require 'spec_helper'

describe ApiController do
  fixtures :kids

  describe "GET 'random'" do
    it "returns http success" do
      get 'random'
      kid = assigns(:kid)
      kid.should be_a(Kid)
      response.should be_success
    end

    it "excludes ids if specified" do
      8.times do
        get 'random', exclude: 1
        kid = assigns(:kid)
        kid.id.should_not be(1)
      end
    end

    it "includes request location in json response" do
      get 'random'
      json = JSON.parse(response.body)
      json['kid'].should_not be_nil
      location = json['meta']['location']
      location.should_not be_nil
      location["ip"].should eq("50.78.167.161")
      location["country_code"].should eq("US")
      location["country_name"].should eq("United States")
      location["region_code"].should eq("WA")
      location["region_name"].should eq("Washington")
      location["city"].should eq("Bellevue")
      location["zipcode"].should eq("")
      location["latitude"].should eq(47.6104)
      location["longitude"].should eq(-122.2007)
      location["metro_code"].should eq("819")
      location["areacode"].should eq("425")
    end

    it "allows a `limit` parameter" do
      get 'random', {limit: "10"}
      assigns(:limit).should eq(10)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "allows filtering by parameters" do
      get 'index', missing_state: "WA"
      assigns(:kids).each do |kid|
        kid.missing_state.should eq("WA")
      end
    end

    it "should paginate" do
      get 'index', {per_page: 200}
      assigns(:per_page).should eq(100)
      get 'index', {per_page: 2}
      assigns(:per_page).should eq(2)
      (kids = assigns(:kids)).to_a.length.should eq(2)
      get 'index', {per_page: 2, page: 2}
      assigns(kids).should_not eq(kids)
    end
  end

end
