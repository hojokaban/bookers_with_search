class FavoritesController < ApplicationController
	
	def create
		#binding.pry
		book = Book.find(params[:book_id])
		Favorite.new(book_id: book.id,
			         user_id: current_user.id).save
		redirect_to books_path
	end

	def destroy
		redirect_to books_path
	end

end
