module Immoscout
  module Models
    module Concerns
      module Renderable
        extend ActiveSupport::Concern

        included do
          def as_json
            {
              type_identifier => \
                deep_transform_keys do |key|
                  key.camelize :lower
                end
            }.delete_empty
          end
          alias_method :to_hash, :as_json
          alias_method :to_h, :as_json
          alias_method :inspect, :as_json

          def to_json
            as_json.to_json
          end
          alias_method :to_s, :to_json
        end

        class_methods do
        end
      end
    end
  end
end
