require 'json'

module Immoscout
  module Models
    module Concerns
      module Renderable
        extend ActiveSupport::Concern

        included do
          def as_json
            wrapped? ? to_json_wrapped : to_json_unwrapped
          end

          def to_json
            as_json.to_json
          end
          alias_method :to_s, :to_json

          private

          def wrapped?
            self.class.try(:json_wrapper)
          end

          def to_h
            self.class.properties.each_with_object({}) do |(key, value), memo|
              property = value.fetch(:alias, key)
              rendered = send(key)
              memo[property] = rendered.try(:as_json) || rendered
              memo
            end
          end

          def to_json_wrapped
            { self.class.try(:json_wrapper) => to_json_unwrapped }
          end

          def to_json_unwrapped
            to_h
              .compact
              .stringify_keys
              .deep_transform_keys { |key| key.camelize :lower }
          end
        end

        class_methods do
        end
      end
    end
  end
end
