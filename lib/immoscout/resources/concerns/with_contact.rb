module Immoscout
  module Resources
    module Concerns
      module WithContact
        extend ActiveSupport::Concern

        included do
          property :contact, coerce: Immoscout::Resources::Contact, default: {}
        end

        class_methods do
        end
      end
    end
  end
end
