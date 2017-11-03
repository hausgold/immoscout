# frozen_string_literal: true

module Immoscout
  module Models
    class Base
      def initialize(hash = {})
        hash
          .deep_stringify_keys
          .deep_transform_keys(&:underscore)
          .deep_symbolize_keys
          .each do |key, value|
          property = self.class.find_property(key)
          unless property
            # puts "ignore #{key} property..."
            next
          end
          coerce_klass = property.fetch(:coerce, nil)
          if coerce_klass
            send("#{key}=", coerce_klass.new(value))
          else
            send("#{key}=", value)
          end
        end
      end
    end
  end
end
