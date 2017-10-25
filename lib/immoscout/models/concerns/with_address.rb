require_relative '../parts/address'

module Immoscout
  module Models
    module Concerns
      module WithAddress
        extend ActiveSupport::Concern

        included do
          property :address,
                   coerce: Immoscout::Models::Parts::Address,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
