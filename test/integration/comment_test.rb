require 'test_helper'

class CommentTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

	def setup
		@user = users(:luffy)
		@book = books(:book1)
		@comment = book_comments(:comment)

		login_as(@user, :scope => :user)
	end

	test "comment interface" do
		get book_path(@book)
		assert_select "form"

		#comment fails

		assert_no_difference 'BookComment.count' do
			post comment_path(@book), params: {book_comment:{content:"  "}}
		end
		assert_template 'books/show'
		assert_select "div#error_explanation"

		#comment succeeds

		assert_difference 'BookComment.count', 1 do
			post comment_path(@book), params: {book_comment:{content:"comment"}}
		end
		follow_redirect!
		assert_not flash.empty?
	end
end
