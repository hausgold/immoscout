require_relative '../parts/api_search_data'

module Immoscout
  module Resources
    module Concerns
      module WithApiSearchData
        extend ActiveSupport::Concern

        included do
          property :api_search_data,
                   coerce: Immoscout::Resources::Parts::ApiSearchData,
                   default: {},
                   from: :apiSearchData
        end

        class_methods do
        end
      end
    end
  end
end
