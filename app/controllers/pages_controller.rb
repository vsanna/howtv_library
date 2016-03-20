class PagesController < ApplicationController
  before_filter :authenticate_user!

  def top
    @new_books = Book.order(created_at: :desc).first(3)
    @rent_books = Rent.eager_load(:book)
                      .search({
                        user_id_eq: current_user.id,
                        ended_at_null: true
                      }).result.order(created_at: :desc).first(5)
  end
end
