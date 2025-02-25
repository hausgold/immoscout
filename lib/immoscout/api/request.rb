# frozen_string_literal: true

module Immoscout
  module Api
    # An abstract HTTP/API request.
    module Request
      def get(path, payload = nil, multipart = nil)
        request(:get, path, payload, multipart)
      end

      def post(path, payload = nil, multipart = nil)
        request(:post, path, payload, multipart)
      end

      def put(path, payload = nil, multipart = nil)
        request(:put, path, payload, multipart)
      end

      def delete(path, payload = nil, multipart = nil)
        request(:delete, path, payload, multipart)
      end

      # rubocop:disable Metrics/MethodLength -- because of the header handling
      def request(method, path, payload = nil, multipart = nil)
        connection.send(method, path, multipart) do |request|
          if multipart
            request.headers['Content-Type'] = 'multipart/form-data'
          else
            request.body = payload if payload
            request.headers['Content-Type'] = 'application/json;charset=UTF-8'
          end
          request.headers['Accept'] = 'application/json'
          request.headers['User-Agent'] =
            "RubyImmoscout/#{Immoscout::VERSION}"
        end
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
