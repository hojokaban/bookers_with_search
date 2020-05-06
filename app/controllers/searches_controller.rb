class SearchesController < ApplicationController

	def search
		@users = User.where(['name LIKE ?', "%#{params[:search][:searched_item]}%"])
		@book = Book.new
		render 'users/index'
	end

end
