require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:ryan)
    @category = categories(:first)
  end
  
  test "subscription needs to have a category and user" do
    @user = nil
    @category = nil
    subscription = Subscription.new(user: @user, category: @category)
    assert_not subscription.valid?
  end
  
  test "vaid subscription" do
    subscription = Subscription.new(user: @user, category: @category)
    assert subscription.valid?
  end

end