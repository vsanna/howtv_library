class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  def show
    @book = Book.find(params[:id])
  end
end
