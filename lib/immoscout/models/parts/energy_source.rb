# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      # Shared energy-source-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class EnergySource < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :energy_source_enev2014
      end
    end
  end
end
