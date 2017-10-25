# frozen_string_literal: true

require_relative '../base'

module Immoscout
  module Models
    module Parts
      class ApiSearchData < Base
        property :search_field1, from: :searchField1
        property :search_field2, from: :searchField2
        property :search_field3, from: :searchField3
      end
    end
  end
end
