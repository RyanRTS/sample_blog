require 'test_helper'

class UserSignupTestTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)  
  end
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {  name: "",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {  name: "ryan",
                                          email: "ryan@mail.com",
                                          password: "password",
                                          password_confirmation: "password" } }
    end
    assert_redirected_to root_url
  end
  
end
