module NoticeToSlack
  extend ActiveSupport::Concern


  class << self
    def on_book_return rent
      text = <<TEXT
```
書籍が返却されました。

書籍名: #{rent.book.title}
返却予定日: #{rent.end_at}
借り主: #{rent.user.family_name}
```
TEXT
      base_to_slack text
    end

    def on_book_borrow rent
      text = <<TEXT
```
書籍が貸し出されました。

書籍名: #{rent.book.title}
返却日: #{rent.end_at}
借り主: #{rent.user.family_name}
```
TEXT
      base_to_slack text
    end

    def on_request req
      text = <<TEXT
```
リクエストが来ました。

リクエストタイプ: #{req.request_type_i18n}
送信者: #{req.user.family_name} #{req.user.given_name}
内容:
#{req.body}
```
TEXT
      base_to_slack text
    end


    def base_to_slack text = nil, channel = ENV['SLACK_TEST'], username = 'request', icon_emoji = ':tada'
      begin
        Slack.chat_postMessage(
          text: text,
          channel: channel,
          username: username,
          icon_emoji: icon_emoji
        )
      rescue :e
        Rails.logger.info :e
      end
    end
  end
end
