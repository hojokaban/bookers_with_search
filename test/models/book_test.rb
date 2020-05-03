require 'test_helper'

class BookTest < ActiveSupport::TestCase

	def setup
		@book = books(:book1)
	end

	test "should be valid" do
		assert @book.valid?
	end

	test "title should be present" do
		@book.title = "  "
		assert_not @book.valid?
	end

	test "body should be present" do
		@book.body = "  "
		assert_not @book.valid?
	end

	test "body should be maximum 200 letters" do
		@book.body = "a"*201
		assert_not @book.valid?
	end

end
