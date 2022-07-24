class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]


  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books

  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end





  private


  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user.id) 
    end
    
    
  end
end