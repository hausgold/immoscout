# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      class EnergyCertificate < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable
        property :energy_certificate_availability
        property :energy_certificate_creation_date
        property :energy_efficiency_class
      end
    end
  end
end
