class SearchesController < ApplicationController
	include ApplicationHelper

	def search
		@book = Book.new
		if params[:search][:target] == "book"
			@books = Book.where(['title LIKE ?', search_by(params[:search][:key],
														params[:search][:way])])
			render 'books/index' and return
		elsif params[:search][:target] == "user"
			@users = User.where(['name LIKE ?', search_by(params[:search][:key],
															params[:search][:way])])
			render 'users/index' and return
		end
		flash[:notice] = "Select what you want to search"
		redirect_to current_user
	end

end
