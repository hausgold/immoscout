# frozen_string_literal: true

module Immoscout
  module Resources
    class Apartment < Residential
      def type
        # TODO: also support apartmentRent
        :apartmentBuy
      end

      property :apartment_type, from: :apartmentType
      property :floor
      property :lift
    end
  end
end
