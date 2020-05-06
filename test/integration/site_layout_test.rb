require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

	def setup
		@user = users(:luffy)
	end

	test "layout links" do
		get root_path
		assert_template 'books/home'
		assert_select "a[href=?]", root_path
		assert_select "a[href=?]", about_book_path
		assert_select "a[href=?]", new_user_session_path, count: 2
		assert_select "a[href=?]", new_user_registration_path, count: 2
		assert_select "form[action=?]", search_path, count: 0
	end

	test "should not redirect to when not logged in" do

		get books_path
		assert_redirected_to new_user_session_path
		get users_path
		assert_redirected_to new_user_session_path
		get book_path(1)
		assert_redirected_to new_user_session_path
		get user_path(1)
		assert_redirected_to new_user_session_path
		get edit_book_path(1)
		assert_redirected_to new_user_session_path
		get edit_user_path(1)
		assert_redirected_to new_user_session_path

	end

	test "layout links when logged in" do
		login_as(@user, :scope => :user)
		get root_path
		assert_template 'books/home'
		assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", books_path
		assert_select "a[href=?]", users_path
		assert_select "a[href=?]", destroy_user_session_path
		assert_select "form[action=?]", search_path
	end

	test "should search" do
		login_as(@user, :scope => :user)
		get search_path, params: {search: {searched_item: "ffy"}}
		assert_template 'users/index'
		assert_match @user.name, response.body
		assert_no_match users(:zoro).name, response.body
	end

end
