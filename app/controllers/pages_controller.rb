class PagesController < ApplicationController
  before_filter :authenticate_user!

  def top
    @new_books = Book.order(created_at: :desc).first(3)
  end
end
