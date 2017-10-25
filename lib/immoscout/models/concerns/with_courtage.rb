require_relative '../parts/courtage'

module Immoscout
  module Models
    module Concerns
      module WithCourtage
        extend ActiveSupport::Concern

        included do
          property :courtage,
                   coerce: Immoscout::Models::Parts::Courtage,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
