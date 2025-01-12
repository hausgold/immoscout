# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared search-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class ApiSearchData < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :search_field1
        property :search_field2
        property :search_field3
      end
    end
  end
end
