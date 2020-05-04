require 'test_helper'

class FavoriteInterfaceTest < ActionDispatch::IntegrationTest
	include Warden::Test::Helpers

	def setup
		@user = users(:luffy)
		@book = books(:book1)
		login_as(@user, :scope => :user)
	end

	test "favorite interface" do
		assert_difference 'Favorite.count', 1 do
			post favorite_path(@book)
		end
		assert_redirected_to books_path
		follow_redirect!
		assert_select "i.fas"
#		assert_difference 'Favorite.count', -1 do
#			delete favorite_path(@book)
#		end

	end

end
