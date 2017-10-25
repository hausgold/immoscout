# frozen_string_literal: true

require_relative '../base'
require_relative '../parts/coordinate'

module Immoscout
  module Models
    module Parts
      class Address < Base
        property :street
        property :house_number, from: :houseNumber
        property :postcode
        property :city
        property :wgs84_coordinate,
                 from: :wgs84Coordinate,
                 coerce: Immoscout::Models::Parts::Coordinate,
                 default: {}
      end
    end
  end
end
