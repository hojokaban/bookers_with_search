require 'test_helper'

class UsersInterfaceTest < ActionDispatch::IntegrationTest
  
  include Warden::Test::Helpers

	def setup
		@user = users(:luffy)
		@other_user = users(:zoro)
		@book = books(:book1)
	end

	test "users interface" do
		login_as(@user, :scope => :user)

		#users/index

		get users_path
		assert_template 'users/index'
		assert_select "img"
		assert_match @user.name, response.body
		assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", edit_user_path(@user)

		#users/edit

		get edit_user_path(@other_user)
		assert_redirected_to user_path(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: {user:
		                           {name: "",
		                            introduction: ""}}
		assert_select "div#error_explanation"
		patch user_path(@user), params: {user:
		                           {name: "luffi-taro",
		                            introduction: ""}}
		assert_not flash.empty?
		assert_redirected_to user_path(@user)
		follow_redirect!

		#users/show

		assert_select "a[href=?]", book_path(@book)
		assert_select "a[href=?]", edit_user_path(@user)

	end
end
