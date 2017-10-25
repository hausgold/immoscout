# frozen_string_literal: true

require_relative '../base'

module Immoscout
  module Resources
    module Parts
      class EnergySource < Base
        property :energy_source_enev2014, from: :energySourceEnev2014
      end
    end
  end
end
