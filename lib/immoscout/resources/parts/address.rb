# frozen_string_literal: true
require_relative '../parts/coordinate'

module Immoscout
  module Resources
    module Parts
      class Address < Base
        property :street
        property :house_number, from: :houseNumber
        property :postcode
        property :city
        property :wgs84_coordinate,
                 from: :wgs84Coordinate,
                 coerce: Immoscout::Resources::Parts::Coordinate,
                 default: {}
      end
    end
  end
end
