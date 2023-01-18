# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      # Shared geo-coding-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class GeoCode < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :geo_code_id
        property :full_geo_code_id
      end
    end
  end
end
