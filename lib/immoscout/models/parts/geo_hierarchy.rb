# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared geo-hierarchy-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class GeoHierarchy < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :continent, coerce: Immoscout::Models::Parts::GeoCode
        property :country, coerce: Immoscout::Models::Parts::GeoCode
        property :region, coerce: Immoscout::Models::Parts::GeoCode
        property :city, coerce: Immoscout::Models::Parts::GeoCode
        property :quarter, coerce: Immoscout::Models::Parts::GeoCode
        property :neighbourhood, coerce: Immoscout::Models::Parts::GeoCode
      end
    end
  end
end
