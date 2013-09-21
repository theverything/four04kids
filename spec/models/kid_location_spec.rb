require_relative '../spec_helper'

describe Kid do
  it "should be savable with an address" do
    kid = Kid.new(first_name: "Test", last_name: "Kid", missing_state: "WA", image_url: "http://1bog.org/files/2013/02/solar-kid.jpg")
    kid.save

    expect(kid).to be_valid
  end

  it "should not be valid while blank" do
    kid_location = Kid.new()
    kid_location.save
    expect(kid_location).to_not be_valid
  end

  it "should be able to get proximity models" do
    kid1 = Kid.new(first_name: "Test", last_name: "Kid", missing_city: "Seattle", missing_state: "WA", image_url: "http://1bog.org/files/2013/02/solar-kid.jpg")
    kid2 = Kid.new(first_name: "Test", last_name: "Kid", missing_city: "Seattle", missing_state: "WA", image_url: "http://1bog.org/files/2013/02/solar-kid.jpg")
    kid1.save
    kid2.save
    
    expect(kid1.nearbys).to_not be_blank
    expect(Kid.near("Seattle, WA")).to_not be_blank
  end

  it "should be able to get proximity via ip address" do
    kid1 = Kid.new(first_name: "Test", last_name: "Kid", missing_city: "Seattle", missing_state: "WA", image_url: "http://1bog.org/files/2013/02/solar-kid.jpg")
    kid2 = Kid.new(first_name: "Test", last_name: "Kid", missing_city: "Seattle", missing_state: "WA", image_url: "http://1bog.org/files/2013/02/solar-kid.jpg")
    kid1.save
    kid2.save

    expect(Kid.near("173.160.181.220")).to_not be_blank
  end

end
