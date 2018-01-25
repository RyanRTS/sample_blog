require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category should not be valid" do
    category = Category.new(name: "", user_id: nil)
    assert_not category.valid?
  end
  
  test "category should be valid" do
    category = Category.new(name: 'Name', user_id: users(:ryan).id)
    assert category.valid?
  end
  
end
