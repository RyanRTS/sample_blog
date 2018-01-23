require 'test_helper'

class EditUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)
    @other = users(:archer)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: {   name: "",
                                                email: "test@invalid",
                                                password: "foo",
                                                password_confirmation: "bar" } }
    assert_template "users/edit"
    assert_select 'div.alert', "The form contains 4 errors."
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: {   name: "Test Edit",
                                                email: "test@valid.com",
                                                password: "password123",
                                                password_confirmation: "password123" } }
    assert_redirected_to @user
    assert_equal @user.reload.name, "Test Edit"
    assert_not flash.empty?
  end
  
  test "should redirect to login page when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_path
  end
  
  test "user can only edit their own profile" do
    log_in_as(@user)
    get edit_user_path(@other)
    assert_redirected_to root_url
    assert_not flash.empty?
  end
  
end
