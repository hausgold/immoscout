module Immoscout
  module Resources
    module Concerns
      module Renderable
        extend ActiveSupport::Concern

        included do
          def as_json
            {
              "realestates.#{json_root_type}" => \
                deep_transform_keys do |key|
                  key.camelize :lower
                end
            }
          end
          alias_method :to_hash, :as_json
          alias_method :to_h, :as_json
          alias_method :inspect, :as_json

          def to_json
            as_json.to_json
          end
          alias_method :to_s, :to_json

          private

          def json_root_type
            defined?(:type) ? type : default_json_root_type
          end

          def default_json_root_type
            self.class.name.demodulize.camelize(:lower)
          end
        end

        class_methods do
        end
      end
    end
  end
end
