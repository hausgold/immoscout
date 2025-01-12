# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared courtage-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Courtage < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :has_courtage
        property :courtage
        property :courtage_note
      end
    end
  end
end
