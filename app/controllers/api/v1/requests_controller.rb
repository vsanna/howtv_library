class Api::V1::RequestsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: [:create]
  include NoticeToSlack

  def create
    req = Request.new(
      request_type: params[:query][:type].to_i,
      body: params[:query][:body],
      user_id: current_user.id
    )
    if req.save
      @message = 'ご意見ありがとうございます!slackでもご意見お待ちしております!'
      NoticeToSlack.on_request req
    else
      @message = '正しく送信できませんでした...'
    end
  end
end
