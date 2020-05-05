require 'test_helper'

class BookCommentTest < ActiveSupport::TestCase

	def setup
		@book = books(:book1)
		@user = users(:luffy)
		@comment = BookComment.new(content:"example", user_id: @user.id, book_id: @book.id)
	end

	test "should be valid" do
		assert @comment.valid?
	end
end
