class BookCommentsController < ApplicationController

	def create
		@book = Book.find(params[:id])
		@comment = current_user.book_comments.new(comment_params)
		@comment.book = @book
		if @comment.save
			flash[:notice] = "successfully upload comment!"
			redirect_to @book
		else
			@book_new = Book.new
		    @user = @book.user
			render "books/show"
		end
	end

	def destroy
	end

	private

	def comment_params
		params.require(:book_comment).permit(:content)
	end

end
