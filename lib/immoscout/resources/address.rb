# frozen_string_literal: true

module Immoscout
  module Resources
    class Address < Base
      class Coordinate < Base
        property :latitude
        property :longitude
      end

      property :street
      property :house_number, from: :houseNumber
      property :postcode
      property :city
      property :wgs84_coordinate,
               from: :wgs84Coordinate,
               coerce: Coordinate,
               default: {}
    end
  end
end
