# frozen_string_literal: true

module Immoscout
  module Resources
    class Courtage < Base
      property :has_courtage, from: :hasCourtage
      property :courtage
      property :courtage_note, from: :courtageNote
    end
  end
end
