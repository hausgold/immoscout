# frozen_string_literal: true

module Immoscout
  module Api
    # A connection builder/handler for reusable connections.
    module Connection
      def connection
        @connection ||= Faraday::Connection.new(url: url) do |builder|
          configure_oauth(builder)
          builder.request :multipart
          builder.request :url_encoded
          builder.request :json
          builder.response :follow_redirects
          builder.response :json, content_type: /\bjson$/
          builder.adapter :net_http
        end
      end

      protected

      def configure_oauth(builder)
        builder.request(
          :oauth1,
          :header,
          token: config.oauth_token,
          token_secret: config.oauth_token_secret,
          consumer_key: config.consumer_key,
          consumer_secret: config.consumer_secret
        )
      end
    end
  end
end
