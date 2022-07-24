class BooksController < ApplicationController
  before_action :authenticate_user!

  before_action :correct_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @books = Book.all

    @book = Book.new(book_params)
    @book.user_id =current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      render :index
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
   end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @book1 = Book.find(params[:id])
    @user = @book1.user

  end

  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end




   private

  def book_params
    params.require(:book).permit( :title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
    redirect_to books_path
    end
  end


end