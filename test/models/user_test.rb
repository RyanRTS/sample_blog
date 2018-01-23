require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:ryan)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "email should be unique" do
    dup_user =  @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end
  
  test "email should be lower case in db" do
    mixed_case_email = "FOOBaR@GMaile.com"
    @user.email = mixed_case_email
    @user.save
    assert mixed_case_email.downcase, @user.reload.email
  end
  
end
