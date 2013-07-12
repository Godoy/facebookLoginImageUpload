require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get participate" do
    get :participate
    assert_response :success
  end

end
