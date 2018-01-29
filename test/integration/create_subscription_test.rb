require 'test_helper'

class CreateSubscriptionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:ryan)
    @another_user = users(:archer)
    @category = categories(:first)
    @another_category = categories(:second)
    # @subscription_ryan = subscriptions(:one)
    @subscription_archer = subscriptions(:two)     
  end
  
  test "must be logged in to view subscriptions" do
    get subscriptions_path
    assert_redirected_to login_path
  end
  
  test "same user cannot subscribe to one category multiple times" do
    log_in_as @user
    post subscriptions_path, params: { user_id: @user.id, category_id: @category.id } 
    assert_no_difference 'Subscription.count' do
      post subscriptions_path, params: { user_id: @user.id, category_id: @category.id } 
    end
    assert_redirected_to @category
  end
  
  test "successfully create a new subscription" do
    log_in_as @user
    assert_difference 'Subscription.count', 1 do
      post subscriptions_path, params: { user_id: @user.id, category_id: @category.id }
    end
  end
  
  test "subscribe button should display on category page when user is not subscribed" do
    log_in_as @user
    get category_path @category
    assert_select 'input[value = subscribe]'
    post subscriptions_path, xhr: true, params: { user_id: @user.id, category_id: @category.id }
    get category_path @category
    assert_select 'input[value = unsubscribe]'
  end
    
end
