require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
  	@user = users(:luffy)
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "  "
  	assert_not @user.valid?
  end

  test "name should be minimum 2 letters" do
  	@user.name = "l"
  	assert_not @user.valid?
  end

  test "name should be maximum 20 letters" do
  	@user.name = "a"*21
  	assert_not @user.valid?
  end

  test "introduction should be maximum 50 letters" do
  	@user.introduction = "a"*51
  	assert_not @user.valid?
  end

end
