class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show
  	@book = Book.new
  	@books = @user.books.all
  end

  def index
  	@users = User.all
  	@book = Book.new
  end

  def edit
      redirect_to current_user unless @user == current_user
  end

  def update
  	if @user.update(user_params)
      flash[:notice] = "successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
    	params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
