require 'test_helper'

class CreatePostTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)
    @other_user = users(:archer)
    @post = posts(:post_1)
    @archer_post = posts(:archer_post)
    @category = categories(:first)
  end
  
  test "must be logged in to create a new post" do
    get new_post_path
    assert_redirected_to login_path
    assert_not flash.empty?
  end
  
  test "creat invalid post" do
    log_in_as @user
    post posts_path, params: { post: {  title: "",
                                        content: "",
                                        user_id: nil } }
    assert_select 'div.alert'
    assert_template 'posts/new'
  end
  
  test "create valid post" do
    log_in_as @user
    post posts_path, params: { post: {  title: @post.title,
                                        content: @post.content,
                                        user_id: @user,
                                        category_id: @category.id } }
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end
  
  test "unauthorized user should not delete post" do
    log_in_as @other_user
    assert_no_difference 'Post.count' do
      delete post_path @post
    end
  end
  
  test "admin user can delete other user's posts" do
    log_in_as @user
    assert_difference 'Post.count', -1 do
      delete post_path @archer_post
    end
  end
  
end
