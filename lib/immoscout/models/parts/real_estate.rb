# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared real-estate-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class RealEstate < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :id, alias: :@id
      end
    end
  end
end
