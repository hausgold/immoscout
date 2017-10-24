module Immoscout
  module Api
    module Request
      def get(path, payload = nil)
        request(:get, path, payload)
      end

      def post(path, payload = nil)
        request(:post, path, payload)
      end

      def put(path, payload = nil)
        request(:put, path, payload)
      end

      def delete(path, payload = nil)
        request(:delete, path, payload)
      end

      def request(method, path, payload = nil)
        response = connection.send(method, path) do |request|
          request.headers['Content-Type'] = "application/json;charset=UTF-8"
          request.headers['Accept']       = "application/json"
          request.body                    = payload if payload
        end
        raise Immoscout::Errors::NotFound unless response.success?
        response.body
      end
    end
  end
end
