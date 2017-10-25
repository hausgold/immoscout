# frozen_string_literal: true

module Immoscout
  module Resources
    class HouseBuy < Residential
      property :building_type, from: :buildingType
      property :lodger_flat, from: :lodgerFlat
      property :construction_phase, from: :constructionPhase
      property :plot_area, from: :plotArea
    end
  end
end
