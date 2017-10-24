require_relative '../parts/price'

module Immoscout
  module Resources
    module Concerns
      module WithPrice
        extend ActiveSupport::Concern

        included do
          property :price,
                   coerce: Immoscout::Resources::Parts::Price,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
