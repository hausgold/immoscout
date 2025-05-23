# frozen_string_literal: true

module Immoscout
  module Models
    module Parts
      # Shared contact-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Contact < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :id, alias: :@id
        property :external_id, alias: :@external_id
      end
    end
  end
end
