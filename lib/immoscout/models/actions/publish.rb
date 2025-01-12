# frozen_string_literal: true

module Immoscout
  module Models
    module Actions
      # Actions to publish a Real Estate.
      module Publish
        extend ActiveSupport::Concern

        included do
          include Immoscout::Models::Concerns::Modelable

          def save
            response = api.post('publish', as_json)
            handle_response(response)
            self
          end

          def destroy
            response = api.delete(
              "publish/#{real_estate.id}_#{publish_channel.id}"
            )
            handle_response(response)
            self
          end
        end
      end
    end
  end
end
