class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: [:borrow]


  def index_or_search
    if params[:query][:search_key].blank?
      @books = Book.eager_load(:rents, :comments).all.paginate(page: params[:page])
    elsif
      @books = Book.eager_load(:rents, :comments).search({
                      title_or_author_or_publisher_cont: params[:query][:search_key]
                   }).result.paginate(page: params[:page])
    end
    set_count @books
  end

  def show
    @book = Book.find(params[:id])
    @comments = @book.comments
  end

  def borrow
    book_id = params[:id]
    user_id = current_user.id

    # 既にレンタルしていないかチェック
    rent = Rent.search({
      book_id_eq: book_id,
      user_id_eq: user_id,
      ended_at_not_null: true
    }).result
    if !rent.blank?
      @message = '既に借りています'
      return
    end

    rent = Rent.new(
      book_id: book_id,
      user_id: user_id,
      start_at: Date.today,
      end_at: Date.today + 7
    )
    if rent.save
      Book.find(book_id).in_use!
      @message = '貸し出ししました。'
    else
      @message = '貸出に失敗しました。'
    end
  end

  private
  def set_count books
    @total =  books.count
    @left_count = @total - (params[:page].to_i) * 30 # 1ページにつき30件返す
  end
end
