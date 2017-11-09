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
        end

        class_methods do
          def unpack(hash)
            hash.values.first
          end

          def new_raw(raw_hash)
            new(unpack(raw_hash))
          end

          def handle_response(response)
            return response if response.success?
            raise Immoscout::Errors::NotFound, response.body
          end
        end
      end
    end
  end
end