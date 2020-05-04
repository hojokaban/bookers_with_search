require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase

	def setup
		@user = users(:luffy)
		@book = books(:book1)
		@favorite = Favorite.new(book_id: @book.id, user_id: @user.id)
		@favorite.save
	end

	test "should be valid" do
		assert @favorite.valid?
	end

	test "one user has one favorite for one book at most" do
		assert_not Favorite.new(book_id: @book.id, user_id: @user.id).valid?
	end
end