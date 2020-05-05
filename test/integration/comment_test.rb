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
		assert_match @comment.content, response.body
		assert_select "form"
		assert_select "a", text:"Delete", count: 0

		#comment create fails

		assert_no_difference 'BookComment.count' do
			post comment_path, params: {book_comment:{content:"  ",
			                                          book_id: @book.id}}
		end
		assert_template 'books/show'
		assert_select "div#error_explanation"
		#comment create succeeds

		assert_difference 'BookComment.count', 1 do
			post comment_path, params: {book_comment:{content:"comment",
			                                           book_id: @book.id}}
		end
		follow_redirect!
		assert_not flash.empty?

		#comment destroy by user

		@comment_new = BookComment.find_by(content:"comment")
		assert_select "a", text:"Delete"
		assert_difference 'BookComment.count', -1 do
			delete comments_path(@comment_new)
		end
		assert_redirected_to book_path(@book)
		follow_redirect!
		assert_not flash.empty?

		#comment of other_user's destroy

	    assert_select "a", text:"Delete", count: 0
	  #  assert_no_difference 'BookComment.count' do
		#	delete comments_path(@comment)
		#end
	end
end
