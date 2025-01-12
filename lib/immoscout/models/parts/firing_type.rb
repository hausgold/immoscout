# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared firing-type-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class FiringType < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :firing_type
      end
    end
  end
end
