class PagesController < ApplicationController
  before_filter :authenticate_user!

  def top
    @books = Book.all
    @book = @books.first
  end
end
