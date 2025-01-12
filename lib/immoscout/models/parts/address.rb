# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared address-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Address < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :street
        property :house_number
        property :postcode
        property :city
        property :wgs84_coordinate, coerce: Immoscout::Models::Parts::Coordinate
        property :international_country_region,
                 coerce: Immoscout::Models::Parts::InternationalCountryRegion
        property :geo_hierarchy,
                 coerce: Immoscout::Models::Parts::GeoHierarchy,
                 readonly: true
      end
    end
  end
end
