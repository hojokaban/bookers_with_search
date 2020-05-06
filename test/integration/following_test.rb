require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

  def setup
  	@user = users(:luffy)
  	@other_user = users(:zoro)
  	login_as(@user, :scope => :user)
  end

  test "should see following/followers count" do

  	get books_path
  	assert_match @user.following.count.to_s, response.body
  	assert_match @user.followers.count.to_s, response.body
  	assert_select "a[href=?]", following_user_path(@user), count:2
  end

end
