class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  require_relative "./disney_crawler.rb"

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          crawler = DisneyCrawler.new

          if event.message['text'] == "Disney sea"
            park = "sea"
          else
            park = "land"
          end

          disney_text = crawler.crawl(park)




          message = {
              type: 'text',
              text: disney_text#['text']+ '。どうもDisneyNavigatorと申します!!!'
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end
end
