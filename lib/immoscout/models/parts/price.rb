# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      # Shared price-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Price < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :value
        property :currency
        property :marketing_type
        property :price_interval_type
      end
    end
  end
end
