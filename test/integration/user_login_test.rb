require 'test_helper'

class UserLoginTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'session/new'
    post login_path params: { session: { email: "", password: "" } }
    assert_template 'session/new'
    assert_not flash.empty?
  end
  
  test "login with valid information" do
    get login_path
    assert_template 'session/new'
    post login_path params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to root_url
  end
  
end
