require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ryan)
    @post = posts(:post_1)
  end
  
  test "should get new" do
    log_in_as @user
    get new_post_path
    assert_response :success
  end

  test "should get show" do
    log_in_as users(:ryan)
    get post_path @post
    assert_response :success
  end

end
