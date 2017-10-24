require_relative '../parts/address'

module Immoscout
  module Resources
    module Concerns
      module WithAddress
        extend ActiveSupport::Concern

        included do
          property :address,
                   coerce: Immoscout::Resources::Parts::Address,
                   default: {}
          property :show_address, from: :showAddress
        end

        class_methods do
        end
      end
    end
  end
end
