require 'test_helper'

class EditPostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)
    @other_user = users(:archer)
    @user_post = posts(:post_1)
    @archer_post = posts(:archer_post)
  end
  
  test "redirect to login on edit when user is not logged in" do
    get edit_post_path @user_post
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "user can only edit their own posts" do
    log_in_as(@other_user)
    get edit_post_path @user_post
    assert_redirected_to @user_post
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-warning'
    assert_match "You can only edit your own posts", response.body
  end
  
  test "admin user can edit all posts" do
    log_in_as(@user)
    get edit_post_path @archer_post
    assert flash.empty?
  end
  
end
