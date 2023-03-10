require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end
  
  
  test "should get signup" do
    get login_path
    assert_response :success
    assert_select "h1", "Log in"
    
     get signup_path
  end
end


