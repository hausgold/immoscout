# frozen_string_literal: true

require 'json'
require_relative '../concerns/modelable'

module Immoscout
  module Models
    module Actions
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

        class_methods do
        end
      end
    end
  end
end
