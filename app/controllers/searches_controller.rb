class SearchesController < ApplicationController

	def search
		@users = User.where(['name LIKE ?', "%#{params[:name]}%"])
		@book = Book.new
		render 'users/index'
	end

end
