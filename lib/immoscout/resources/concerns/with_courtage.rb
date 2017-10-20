module Immoscout
  module Resources
    module Concerns
      module WithCourtage
        extend ActiveSupport::Concern

        included do
          property :courtage,
                   coerce: Immoscout::Resources::Courtage,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
