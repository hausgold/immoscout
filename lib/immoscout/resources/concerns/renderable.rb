module Immoscout
  module Resources
    module Concerns
      module Renderable
        extend ActiveSupport::Concern

        included do
          attr_writer :type

          def type
            @type || default_type
          end

          def as_json
            {
              "realestates.#{type}" => super.deep_transform_keys do |key|
                key.camelize :lower
              end
            }
          end

          def to_json
            as_json.to_json
          end

          private

          def default_type
            self.class.name.split("::").last.camelize(:lower)
          end
        end

        class_methods do
        end
      end
    end
  end
end
