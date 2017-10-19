# frozen_string_literal: true

module Immoscout
  module Resources
    class Price < Base
      property :value
      property :currency
      property :marketing_type, from: :marketingType
      property :price_interval_type, from: :priceIntervalType
    end
  end
end
