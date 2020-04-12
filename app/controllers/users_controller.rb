class UsersController < ApplicationController

  def show
  	@book = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books.all
  end

  def index
  	@users = User.all
  	@book = Book.new
  	@user = current_user
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	user = User.find(params[:id])
  	if user.update(user_params)
      flash[:notice] = "Successfully updated."
      redirect_to user_path(user)
    else
      @user = user
      render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
