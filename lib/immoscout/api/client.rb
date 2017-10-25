require 'singleton'
require_relative "connection"
require_relative "request"

module Immoscout
  module Api
    class Client
      include Singleton
      include Immoscout::Api::Connection
      include Immoscout::Api::Request

      def url
        config.use_sandbox ? config.api_url_sandbox : config.api_url_live
      end

      def config
        Immoscout.configuration
      end
    end
  end
end
