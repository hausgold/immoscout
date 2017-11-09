# frozen_string_literal: true

require_relative '../base'
require_relative '../concerns/propertiable'
require_relative '../concerns/renderable'

module Immoscout
  module Models
    module Parts
      class PublishChannel < Base
        include Immoscout::Models::Concerns::Renderable
        include Immoscout::Models::Concerns::Propertiable
        property :id, alias: :@id, default: 10_000
      end
    end
  end
end
