# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      # Shared URL-related property definitions.
      # See: https://bit.ly/3CSGnmN
      class Url < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable

        property :scale, alias: :@scale
        property :href, alias: :@href
      end
    end
  end
end
