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
		@book = Book.find(params[:id])
		@book_new = Book.new
		@user = @book.user
		@comment = BookComment.new
	end

	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
		if book.save
			flash[:notice] = "Book was successfully created."
			redirect_to book_path(book)
		else
			@books = Book.all
			@book = book
			@user = current_user
			render :index
		end
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_url
		end
	end


	def update
		book = Book.find(params[:id])
		if book.update(book_params)
			flash[:notice] = "Book was successfully updated."
			redirect_to book_path(book)
		else
			@book = book
			render :edit
		end
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