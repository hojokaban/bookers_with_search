class BooksController < ApplicationController

	def home
	end
	
	def about
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@bookx = Book.find(params[:id])
		@book = Book.new
		@user = @bookx.user
	end

	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		book.save
		redirect_to book_path(book)
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end


	def update
		book = Book.find(params[:id])
		book.update(book_params)
		redirect_to book_path(book)
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private

	def book_params
		params.require(:book).permit(:title, :body)
	end
end