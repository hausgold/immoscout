# frozen_string_literal: true

require_relative '../base'

module Immoscout
  module Resources
    module Parts
      class Contact < Base
        property :@id, from: :id
        alias_method :id, :@id
      end
    end
  end
end
