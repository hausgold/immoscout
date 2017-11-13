require "faraday"
require "faraday_middleware"

module Immoscout
  module Api
    module Connection
      def connection
        @connection ||= Faraday::Connection.new(url: url) do |builder|
          builder.request(
            :oauth,
            token: config.oauth_token,
            token_secret: config.oauth_token_secret,
            consumer_key: config.consumer_key,
            consumer_secret: config.consumer_secret
          )
          builder.request  :multipart
          builder.request  :url_encoded
          builder.request  :json
          builder.response :follow_redirects
          builder.response :json, content_type: /\bjson$/
          builder.adapter :net_http
        end
        @connection
      end
    end
  end
end
