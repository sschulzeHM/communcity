require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show_user" do
    get :show_user
    assert_response :success
  end

  test "should get show_organisation" do
    get :show_organisation
    assert_response :success
  end

end
