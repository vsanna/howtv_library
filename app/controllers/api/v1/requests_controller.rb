class Api::V1::RequestsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery except: [:create]

  def create
    req = Request.new(
      request_type: params[:query][:type].to_i,
      body: params[:query][:body],
      user_id: current_user.id
    )
    if req.save
      @message = 'ご意見ありがとうございます!slackでもご意見お待ちしております!'

      text = <<TEXT
```
リクエストが来ました。

リクエストタイプ: #{req.request_type_i18n}
送信者: #{req.user.family_name} #{req.user.given_name}
内容:
#{req.body}
```
TEXT
      Slack.chat_postMessage(
        text: text,
        channel: ENV['SLACK_TEST'],
        username: 'request',
        icon_emoji: ':tada:'
      )
    else
      @message = '正しく送信できませんでした...'
    end
  end
end
