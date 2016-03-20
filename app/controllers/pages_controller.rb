class PagesController < ApplicationController
  before_filter :authenticate_user!, except:[:top]

  def top
    if !user_signed_in?
      redirect_to sign_in_path
      return
    end
    @new_books = Book.order(created_at: :desc).first(3)
    @rent_books = Rent.eager_load(:book)
                      .search({
                        user_id_eq: current_user.id,
                        ended_at_null: true
                      }).result.order(created_at: :desc).first(5)
  end

  def mypage
    @my_renting_books = Rent.eager_load(:book).search(user_id_eq: current_user.id, ended_at_null: true).result
    @my_rent_history = Rent.eager_load(:book).search(user_id_eq: current_user.id).result
    @my_comments = Comment.eager_load(:book).search(user_id_eq: current_user.id).result
  end
end
