# frozen_string_literal: true

require_relative '../base'

module Immoscout
  module Resources
    module Parts
      class Coordinate < Base
        property :latitude
        property :longitude
      end
    end
  end
end
