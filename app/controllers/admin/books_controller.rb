class Admin::BooksController < ApplicationController

  def index
    @books = Book.all.order(created_at: :desc).paginate(page: params[:page])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to admin_root_path, notice:'保存できました'
    else
      render 'new', alert: '保存できませんでした'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to admin_root_path, notice:'保存できました'
    else
      render 'edit', alert: '保存できませんでした'
    end
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:isbn10,:isbn13,:title,:author,:published_at,:publisher,:status,:hires_image,:large_image,:description,:url,:category)
  end

  def authenticate_admin!
    if !user_signed_in? || !current_user.admin?
      redirect_to root_path, notice: 'このページにはアクセスできません'
    end
  end
end
