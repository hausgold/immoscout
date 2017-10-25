require_relative '../parts/contact'

module Immoscout
  module Models
    module Concerns
      module WithContact
        extend ActiveSupport::Concern

        included do
          property :contact,
                   coerce: Immoscout::Models::Parts::Contact,
                   default: {}
        end

        class_methods do
        end
      end
    end
  end
end
