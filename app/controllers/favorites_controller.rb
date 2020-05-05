class FavoritesController < ApplicationController
	
	def create
		#binding.pry
		book = Book.find(params[:book_id])
		Favorite.new(book_id: book.id,
			         user_id: current_user.id).save
		redirect_back(fallback_location: books_path)
	end

	def destroy
		#binding.pry
		Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
		redirect_back(fallback_location: books_path)
	end

end
