class BookCommentsController < ApplicationController

	before_action :set_book

	def create
		@comment = current_user.book_comments.new(comment_params)
		@comment.book = @book
		if @comment.save
			flash[:notice] = "successfully upload comment!"
			redirect_to @book
		else
			@book_new = Book.new
		    @user = @book.user
		    @comments = BookComment.all
			render "books/show"
		end
	end

	def destroy
		BookComment.find_by(user_id: current_user, book_id: params[:id]).destroy
		flash[:notice] = "successfully deleted!"
		redirect_to @book
	end

	private

	def set_book
		@book = Book.find(params[:id])
	end

	def comment_params
		params.require(:book_comment).permit(:content)
	end

end
