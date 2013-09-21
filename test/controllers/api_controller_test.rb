require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get random" do
    get :random
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
