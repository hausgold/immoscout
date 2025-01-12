# frozen_string_literal: true

module Immoscout
  module Api
    # The immoscout API client object.
    class Client
      include Singleton
      include Immoscout::Api::Connection
      include Immoscout::Api::Request

      attr_writer :user_name

      def user_name
        @user_name || config.user_name
      end

      def url
        config.use_sandbox ? config.api_url_sandbox : config.api_url_live
      end

      def config
        Immoscout.configuration
      end
    end
  end
end
