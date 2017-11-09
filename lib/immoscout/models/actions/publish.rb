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
            klass = self.class
            response = klass.api.post("publish", as_json)
            klass.handle_response(response)
            self
          end

          def destroy
            klass = self.class
            response = klass.api.delete(
              "publish/#{real_estate.id}_#{publish_channel.id}"
            )
            klass.handle_response(response)
            self
          end
        end

        class_methods do
        end
      end
    end
  end
end
