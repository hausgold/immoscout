# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'
require_relative 'geo_code'

module Immoscout
  module Models
    module Parts
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
