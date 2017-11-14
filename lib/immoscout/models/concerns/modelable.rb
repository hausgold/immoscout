require 'json'

module Immoscout
  module Models
    module Concerns
      module Modelable
        extend ActiveSupport::Concern

        included do
          cattr_accessor :json_wrapper, :unpack_collection
          cattr_reader :api, instance_accessor: false do
            Immoscout::Api::Client.instance
          end

          def api
            self.class.api
          end

          def handle_response(response)
            self.class.handle_response(response)
          end
        end

        class_methods do
          def unpack(hash)
            hash.values.first
          end

          def from_raw(raw_hash)
            hash = raw_hash.is_a?(String) ? JSON.parse(raw_hash) : raw_hash
            new(unpack(hash))
          end

          def handle_response(response)
            return response if response.success?
            raise Immoscout::Errors::Failed, response
          end
        end
      end
    end
  end
end
