# frozen_string_literal: true

require_relative '../base'

module Immoscout
  module Models
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
