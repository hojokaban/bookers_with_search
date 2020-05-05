class BooksController < ApplicationController

	before_action :set_book, only: [:show, :edit, :update, :destroy]

	def home
	end
	
	def about
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def show
		@book_new = Book.new
		@user = @book.user
		@comment = BookComment.new
		@comments = BookComment.all
	end

	def create
		@book = current_user.books.new(book_params)
		if @book.save
			flash[:notice] = "Book was successfully created."
			redirect_to @book
		else
			@books = Book.all
			render :index
		end
	end

	def edit
		redirect_to books_url if @book.user != current_user
	end


	def update
		if @book.update(book_params)
			flash[:notice] = "Book was successfully updated."
			redirect_to @book
		else
			render :edit
		end
	end

	def destroy
		@book.destroy
		redirect_to books_path
	end

	private

		def set_book
			@book = Book.find(params[:id])
		end

		def book_params
			params.require(:book).permit(:title, :body)
		end
end