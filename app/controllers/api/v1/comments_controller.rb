class Api::V1::CommentsController < ApplicationController
  protect_from_forgery except: [:create]
  before_filter :authenticate_user!

  def create
    id = params[:book_id]
    comment = params[:comment]
    c = Comment.new(
      user_id: current_user.id,
      book_id: id,
      body: comment
    )
    if c.save
      @message = 'コメントを投稿しました'
    else
      @message = 'コメントを投稿出来ませんでした'
    end
  end
end
