require_relative '../parts/energy_source'

module Immoscout
  module Models
    module Concerns
      module WithEnergySource
        extend ActiveSupport::Concern

        included do
          property :energy_sources_enev2014,
                   from: :energySourcesEnev2014,
                   coerce: Immoscout::Models::Parts::EnergySource
        end

        class_methods do
        end
      end
    end
  end
end
