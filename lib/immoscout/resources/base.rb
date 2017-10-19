# frozen_string_literal: true

module Immoscout
  module Resources
    class Base < Hashie::Trash
      include Hashie::Extensions::Dash::Coercion
      include Hashie::Extensions::Dash::PropertyTranslation
      include Hashie::Extensions::IndifferentAccess
    end
  end
end
