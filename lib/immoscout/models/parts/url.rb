# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared URL-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Url < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :scale, alias: :@scale
        property :href, alias: :@href
      end
    end
  end
end
