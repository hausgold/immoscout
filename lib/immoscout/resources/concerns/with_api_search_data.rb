module Immoscout
  module Resources
    module Concerns
      module WithApiSearchData
        extend ActiveSupport::Concern

        included do
          property :api_search_data,
                   coerce: ApiSearchData,
                   default: {},
                   from: :apiSearchData
        end

        class_methods do
        end
      end
    end
  end
end
