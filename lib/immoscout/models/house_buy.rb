# frozen_string_literal: true

require_relative 'residential'

module Immoscout
  module Models
    class HouseBuy < Residential
      property :building_type, from: :buildingType
      property :lodger_flat, from: :lodgerFlat
      property :construction_phase, from: :constructionPhase
      property :plot_area, from: :plotArea

      def self.identifies?(hash)
        (
          hash.count == 1 && hash.keys.first =~ /^realestates.houseBuy/
        ) || hash["@xsi.type"] == "offerlistelement:OfferHouseBuy"
      end
    end
  end
end
