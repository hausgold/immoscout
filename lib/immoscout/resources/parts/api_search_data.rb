# frozen_string_literal: true

module Immoscout
  module Resources
    module Parts
      class ApiSearchData < Base
        property :search_field1, from: :searchField1
        property :search_field2, from: :searchField2
        property :search_field3, from: :searchField3
      end
    end
  end
end
