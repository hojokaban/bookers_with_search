require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

  def setup
  	@user = users(:luffy)
  	@other_user = users(:zoro)
  	login_as(@user, :scope => :user)
  end

  test "should see following/followers count" do

  	get users_path
  	assert_match @user.following.count.to_s, response.body
  	assert_match @user.followers.count.to_s, response.body
  	assert_select "a[href=?]", following_user_path(@user)
  	assert_select "a[href=?]", followers_user_path(@user)
  	assert_match "1 following", response.body
  	assert_match "1 follower", response.body

  end

  test "following page" do

  	get following_user_path(@user)
  	assert_select "h2", "User Following"
  	assert_match @user.following.first.name, response.body
  	assert_match "1 following", response.body

  end

  test "followers page" do

  	get followers_user_path(@user)
  	assert_select "h2", "User Followers"
  	assert_match @user.followers.first.name, response.body
  	assert_match "1 follower", response.body

  end

end
