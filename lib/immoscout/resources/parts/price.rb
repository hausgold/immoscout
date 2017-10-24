# frozen_string_literal: true

module Immoscout
  module Resources
    module Parts
      class Price < Base
        property :value
        property :currency
        property :marketing_type, from: :marketingType
        property :price_interval_type, from: :priceIntervalType
      end
    end
  end
end
