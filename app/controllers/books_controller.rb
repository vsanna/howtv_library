class BooksController < ApplicationController
  before_filter :authenticate_admin!

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def authenticate_admin!
    if !user_signed_in? || !current_user.admin?
      redirect_to root_path, notice: 'このページにはアクセスできません'
    end
  end
end
