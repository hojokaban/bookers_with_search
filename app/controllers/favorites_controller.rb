class FavoritesController < ApplicationController
	
	def create
		redirect_to books_path
	end

	def destroy
		redirect_to books_path
	end

end
