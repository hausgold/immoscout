# frozen_string_literal: true

module Immoscout
  module Resources
    module Parts
      class Courtage < Base
        property :has_courtage, from: :hasCourtage
        property :courtage
        property :courtage_note, from: :courtageNote
      end
    end
  end
end