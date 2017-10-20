# frozen_string_literal: true

module Immoscout
  module Resources
    class House < Residential
      def type
        # TODO: also support houseRent
        :houseBuy
      end
    end
  end
end
