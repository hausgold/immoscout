# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      # Shared country-region-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class InternationalCountryRegion < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :country
        property :region
      end
    end
  end
end
