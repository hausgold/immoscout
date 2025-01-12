# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared URLs-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Urls < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :url, coerce: Immoscout::Models::Parts::Url, array: true
      end
    end
  end
end
