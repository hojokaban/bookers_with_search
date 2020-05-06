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

	test "should search book or user" do
		#search user

		login_as(@user, :scope => :user)
		get search_path, params: {search: {key: "Luffy",
											target: "user",
											way: 4}}
			assert_template 'users/index'
			assert_match @user.name, response.body
			assert_no_match users(:zoro).name, response.body

		#search book

		get search_path, params: {search: {key: "book1",
											target: "book",
											way: 4}}
			assert_template 'books/index'
			assert_match books(:book1).title, response.body
			assert_no_match books(:book2).title, response.body
	end

	test "should search correctly by each way of selection" do
			login_as(@user, :scope => :user)
			get search_path, params: {search: {key: "Monkey D Luffy",
												target: "user",
												way: 1}}
			assert_match @user.name, response.body
			get search_path, params: {search: {key: "Monkey D",
												target: "user",
												way: 2}}
			assert_match @user.name, response.body
			get search_path, params: {search: {key: "D Luffy",
												target: "user",
												way: 3}}
			assert_match @user.name, response.body
			get search_path, params: {search: {key: "D Luffy",
												target: "user",
												way: 0}}
			assert_not flash.empty?
			get search_path, params: {search: {key: "D Luffy",
												target: "",
												way: 4}}
			assert_not flash.empty?
			assert_redirected_to user_path(@user)

	end

end
