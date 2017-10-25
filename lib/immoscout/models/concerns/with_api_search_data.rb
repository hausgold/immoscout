require_relative '../parts/api_search_data'

module Immoscout
  module Models
    module Concerns
      module WithApiSearchData
        extend ActiveSupport::Concern

        included do
          property :api_search_data,
                   coerce: Immoscout::Models::Parts::ApiSearchData,
                   default: {},
                   from: :apiSearchData
        end

        class_methods do
        end
      end
    end
  end
end
