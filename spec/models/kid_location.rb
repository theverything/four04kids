require_relative '../spec_helper'

describe KidLocation do
  it "should be savable with an address" do
    kid_location = KidLocation.new(address: "Seattle, WA")
    kid_location.save
    expect(kid_location).to be_valid
  end

  it "should not be valid while blank" do
    kid_location = KidLocation.new()
    kid_location.save
    expect(kid_location).to_not be_valid
  end

  it "should be able to get proximity models" do
    kid1 = KidLocation.new(address: "999 3rd Ave, Seattle, WA 98104")
    kid2 = KidLocation.new(address: "600 4th Ave, Seattle, WA") 
    kid1.save
    kid2.save
    
    expect(kid1.nearbys).to_not be_blank
    expect(KidLocation.near("Seattle, WA")).to_not be_blank
  end

end
