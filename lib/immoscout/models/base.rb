# frozen_string_literal: true

module Immoscout
  module Models
    class Base
      attr_reader :base

      def initialize(hash = {})
        define_singleton_method(:base) { hash }
        set_properties
      end

      private

      def prepared_hash
        base
          .deep_stringify_keys
          .deep_transform_keys(&:underscore)
          .deep_symbolize_keys
      end

      def set_properties
        prepared_hash.each do |key, value|
          property = self.class.find_property(key)
          unless property
            # TODO: add optional logger
            # puts "#{self.class.name} - missing property '#{key}'"
            next
          end

          set_property(property, key, value)
        end
      end

      def set_property(property, key, value)
        coerce_klass = property.fetch(:coerce, nil)
        if coerce_klass
          if property.fetch(:array, false)
            send("#{key}=", value.map { |elem| coerce_klass.new(elem) })
          else
            send("#{key}=", coerce_klass.new(value))
          end
        else
          send("#{key}=", value)
        end
      end
    end
  end
end
