module Immoscout
  module Api
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

      def request(method, path, payload = nil, multipart = nil)
        connection.send(method, path, multipart) do |request|
          if multipart
            request.headers['Content-Type'] = "multipart/form-data"
          else
            request.body                    = payload if payload
            request.headers['Content-Type'] = "application/json;charset=UTF-8"
          end
          request.headers['Accept'] = "application/json"
          request.headers['User-Agent'] = \
            "HausgoldImmoscout/#{Immoscout::VERSION}"
        end
      end
    end
  end
end
