require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:ryan)
    @other_user = users(:archer)
    @category = categories(:first)
    @other_user_category = categories(:second)
  end
  
  test "must be logged in to create a category" do
    get new_category_path
    assert_redirected_to login_path
  end
  
  test "create invalid category" do
    log_in_as(@user)
    dup_category_name = @category.name
    post categories_path, params: { category: { name: dup_category_name,
                                                user_id: @user.id } }
    assert_redirected_to categories_path
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-danger'
  end
  
  test "create valid category" do
    log_in_as(@user)
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "test category",
                                                  user_id: @user.id } }
    end
    assert_redirected_to categories_path
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-success'
    assert_match 'test category', response.body
  end
  
  test "cannot delete other users category" do
    log_in_as(@other_user)
    get categories_path
    assert_no_difference 'Category.count' do
      delete category_path(@category)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-danger'
  end
  
  test "successfully delete category" do
    log_in_as(@other_user)
    get categories_path
    assert_difference 'Category.count', -1 do
      delete category_path(@other_user_category)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-success'
  end
  
  test "admin can delete other users categories" do
    log_in_as(@user)
    get categories_path
    assert_difference 'Category.count', -1 do
      delete category_path(@other_user_category)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert-success'
  end
  
  test "must be logged in to edit a category" do
    get edit_category_path @category
    assert_redirected_to login_path
  end
  
  test "cannot edit other users categories" do
    log_in_as(@other_user)
    get edit_category_path @category
    assert_redirected_to root_url
    assert_not flash.empty?
  end
  
end
