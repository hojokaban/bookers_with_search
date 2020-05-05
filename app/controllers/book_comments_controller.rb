class BookCommentsController < ApplicationController

	def create
		if BookComment.new(user_id: current_user.id, book_id: params[:id]).save
			flash[:notice] = "successfully upload comment!"
		else
			redirect_to book_path(params[:id])
		end
	end

	def destroy
	end

end
