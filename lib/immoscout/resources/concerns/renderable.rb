module Immoscout
  module Resources
    module Concerns
      module Renderable
        extend ActiveSupport::Concern

        included do
          def as_json
            {
              "realestates.#{json_root_type}" => \
                super.deep_transform_keys do |key|
                  key.camelize :lower
                end
            }
          end

          def to_json
            as_json.to_json
          end

          def inspect
            as_json
          end

          private

          def json_root_type
            try :type || default_json_root_type
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
