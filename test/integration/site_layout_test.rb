require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

	test "layout links" do
		get root_path
		assert_template 'books/home'
		assert_select "a[href=?]", root_path
		assert_select "a[href=?]", about_book_path
		assert_select "a[href=?]", new_user_session_path, count: 2
		assert_select "a[href=?]", new_user_registration_path, count: 2
	end

	def setup
		@user = users(:luffy)
	end

	test "layout links when logged in" do
		login_as(@user, :scope => :user)
		get root_path
		assert_template 'books/home'
		assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", books_path
		assert_select "a[href=?]", users_path
		assert_select "a[href=?]", destroy_user_session_path
	end
end
