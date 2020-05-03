require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

	def setup
		@book1 = books(:book1)
		@book2 = books(:book2)
		@user = users(:luffy)
	end

	test "book interface" do
		login_as(@user, :scope => :user)

		#books/index

		get books_path
		assert_template 'books/index'
		assert_select "a[href=?]", book_path(@book1)
		assert_select "a[href=?]", user_path(@user)
		assert_select "img"

		#books/show

		get book_path(@book2)
		assert_select "a[href=?]", edit_book_path(@book2), count: 0
		assert_select "a", text: 'Destroy', count: 0
		get book_path(@book1)
		assert_template 'books/show'
		assert_select "a[href=?]", edit_book_path(@book1)
		assert_select "a", text: 'Destroy'
		assert_difference 'Book.count', -1 do
			delete book_path(@book1)
		end
		assert_redirected_to books_path
		follow_redirect!

		#books/create

		assert_select "h2", text: "New book"
		assert_no_difference 'Book.count' do
		  post books_path, params: {book:
		                           {title: "",
		                            body: ""}}
		end
		assert_select "div#error_explanation"
		assert_difference 'Book.count', 1 do
		  post books_path, params: {book:
		                           {title: "title",
		                            body: "body"}}
		end
		@new_book = Book.find_by(title: "title")
		assert_not flash.empty?
		assert_redirected_to book_path(@new_book)

		#books/edit

		get edit_book_path(@book2)
		follow_redirect!
		assert_template 'books/index'
		get edit_book_path(@new_book)
		assert_template 'books/edit'
		patch book_path(@new_book), params: {book:
		                           {title: "",
		                            body: ""}}
		assert_select "div#error_explanation"
		patch book_path(@new_book), params: {book:
		                           {title: "title_editted",
		                            body: "body_editted"}}
		assert_not flash.empty?
		assert_redirected_to book_path(@new_book)
	end
end
