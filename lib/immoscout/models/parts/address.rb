# frozen_string_literal: true

require_relative '../base'
require_relative '../parts/coordinate'
require_relative '../parts/geo_hierarchy'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      class Address < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable
        property :street
        property :house_number
        property :postcode
        property :city
        property :wgs84_coordinate, coerce: Immoscout::Models::Parts::Coordinate
        property :geo_hierarchy,
                 coerce: Immoscout::Models::Parts::GeoHierarchy,
                 readonly: true
      end
    end
  end
end
