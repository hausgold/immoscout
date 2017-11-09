module Immoscout
  module Models
    module Concerns
      module Propertiable
        extend ActiveSupport::Concern

        included do
          cattr_reader :properties, instance_accessor: false do
            {}
          end

          # :reek:ControlParameter - standard stuff, reek!
          # :reek:TooManyStatements
          def method_missing(method_name, *arguments, &block)
            if method_name =~ /build\_(\w+)/
              match         = Regexp.last_match(1).intern
              properties    = self.class.properties
              coerce_klass  = properties.fetch(match).fetch(:coerce, nil)
              return super if !properties.keys.include?(match) || !coerce_klass
              send("#{match}=", coerce_klass.new)
            else
              super
            end
          end

          def attributes
            self.class.properties.keys.sort
          end

          # :reek:BooleanParameter - standard stuff, reek!
          def respond_to_missing?(method_name, include_private = false)
            method_name.to_s.start_with?('build_') || super
          end
        end

        class_methods do
          def property(name, **opts)
            attr_accessor(name)
            alias_name = opts.fetch(:alias, false)
            if alias_name
              alias_method alias_name, name
              alias_method "#{opts.fetch(:alias)}=", "#{name}="
            end
            properties[name] = opts
          end

          def find_property(name)
            properties[name] || properties.values.detect do |value|
              value[:alias] == name
            end
          end
        end
      end
    end
  end
end
