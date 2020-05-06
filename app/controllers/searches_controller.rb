class SearchesController < ApplicationController

	def search
		@book = Book.new
	#	@users = User.where(['name LIKE ?', "%#{params[:search][:searched_item]}%"])
	#	render 'users/index'
		@books = Book.where(['title LIKE ?', "%#{params[:search][:searched_item]}%"])
		render 'books/index'
	end

end
