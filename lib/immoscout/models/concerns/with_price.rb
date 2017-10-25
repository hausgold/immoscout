require_relative '../parts/price'

module Immoscout
  module Models
    module Concerns
      module WithPrice
        extend ActiveSupport::Concern

        included do
          property :price,
                   coerce: Immoscout::Models::Parts::Price,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
