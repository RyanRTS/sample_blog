require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:ryan)
    @post = @user.posts.build(title: 'Lorem', content: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "should have user id" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "content should be present" do
    @post.content = "  "
    assert_not @post.valid?
  end
  
  test "title should be present" do
    @post.title = "  "
    assert_not @post.valid?
  end
  
end
