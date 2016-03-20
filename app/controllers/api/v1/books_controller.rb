class Api::V1::BooksController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: [:borrow, :return]


  def index_or_search
    if params[:query][:search_key].blank?
      @books = Book.eager_load(:rents, :comments).all.order(created_at: :desc).paginate(page: params[:page])
    elsif
      @books = Book.eager_load(:rents, :comments).search({
                      title_or_author_or_publisher_cont: params[:query][:search_key]
                   }).result.order(created_at: :desc).paginate(page: params[:page])
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

      text = <<TEXT
```
書籍が貸し出されました。

書籍名: #{rent.book.title}
返却日: #{rent.end_at}
借り主: #{rent.user.family_name}
```
TEXT
      Slack.chat_postMessage(
        text: text,
        channel: ENV['SLACK_TEST'],
        username: 'request',
        icon_emoji: ':tada:'
      )
    else
      @message = '貸出に失敗しました。'
    end
  end

  def return
    book = Book.find(params[:id])
    book.in_shelf!
    rent = Rent.where(user_id: current_user.id, book_id: book.id, ended_at: nil).last
    rent.returned!
    @message = '返却しました。'

    text = <<TEXT
```
書籍が返却されました。

書籍名: #{rent.book.title}
返却予定日: #{rent.end_at}
借り主: #{rent.user.family_name}
```
TEXT
    Slack.chat_postMessage(
      text: text,
      channel: ENV['SLACK_TEST'],
      username: 'request',
      icon_emoji: ':tada:'
    )
  end

  private
  def set_count books
    @total =  books.count
    @left_count = @total - (params[:page].to_i) * 30 # 1ページにつき30件返す
  end
end
