class SearchesController < ApplicationController

	def search
		@book = Book.new
		if params[:search][:target] == "user"
			@users = User.where(['name LIKE ?', "%#{params[:search][:searched_item]}%"])
			render 'users/index' and return
		elsif params[:search][:target] == "book"
			@books = Book.where(['title LIKE ?', "%#{params[:search][:searched_item]}%"])
			render 'books/index' and return
		end
		flash[:notice] = "Select what you want to search"
		redirect_to current_user
	end

end
