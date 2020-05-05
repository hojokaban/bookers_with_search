class BookCommentsController < ApplicationController

	def create
		@comment = current_user.book_comments.new(comment_params)
		@book = Book.find(@comment.book_id)
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
		@comment = BookComment.find(params[:id])
		book = Book.find(@comment.book_id)
		if @comment.user == current_user
			@comment.destroy
			flash[:notice] = "successfully deleted!"
		else
			flash[:notice] = "You cannot delete this comment"
		end
		redirect_to book
	end

	private

	def comment_params
		params.require(:book_comment).permit(:content, :book_id)
	end

end
