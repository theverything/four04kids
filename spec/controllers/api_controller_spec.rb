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
  end

end
