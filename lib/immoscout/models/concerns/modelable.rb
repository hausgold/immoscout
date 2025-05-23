# frozen_string_literal: true

module Immoscout
  module Models
    module Concerns
      # Provides base functionality to reference/map/(de)serialize
      # models against the immoscout API.
      module Modelable
        extend ActiveSupport::Concern

        included do
          cattr_accessor :json_wrapper, :unpack_collection
          cattr_reader :api, instance_accessor: false do
            Immoscout::Api::Client.instance
          end

          delegate :api, to: :class

          delegate :handle_response, to: :class

          delegate :id_from_response, to: :class
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

          def id_from_response(response)
            response
              .body
              .fetch('common.messages')
              .first
              .dig('message', 'id')
          end
        end
      end
    end
  end
end
