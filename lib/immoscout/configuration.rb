# frozen_string_literal: true

module Immoscout
  # The configuration object of the +immoscout+ gem.
  class Configuration < ActiveSupport::OrderedOptions
    # Track our configurations settings (+Symbol+ keys) and their defaults as
    # lazy-loaded +Proc+'s values
    class_attribute :defaults,
                    instance_reader: true,
                    instance_writer: false,
                    instance_predicate: false,
                    default: {}

    # Create a new +Configuration+ instance with all settings populated with
    # their respective defaults.
    #
    # @param args [Hash{Symbol => Mixed}] additional settings which
    #   overwrite the defaults
    # @return [Configuration] the new configuration instance
    def initialize(**args)
      super()
      defaults.each { |key, default| self[key] = instance_exec(&default) }
      merge!(**args)
    end

    # A simple DSL method to define new configuration accessors/settings with
    # their defaults. The defaults can be retrieved with
    # +Configuration.defaults+ or +Configuration.new.defaults+.
    #
    # @param name [Symbol, String] the name of the configuration
    #   accessor/setting
    # @param default [Mixed, nil] a non-lazy-loaded static value, serving as a
    #   default value for the setting
    # @param block [Proc] when given, the default value will be lazy-loaded
    #   (result of the Proc)
    def self.config_accessor(name, default = nil, &block)
      # Save the given configuration accessor default value
      defaults[name.to_sym] = block || -> { default }

      # Compile reader/writer methods so we don't have to go through
      # +ActiveSupport::OrderedOptions#method_missing+.
      define_method(name) { self[name] }
      define_method("#{name}=") { |value| self[name] = value }
    end

    config_accessor(:consumer_key) { ENV.fetch('IMMOSCOUT_CONSUMER_KEY', nil) }
    config_accessor(:consumer_secret) do
      ENV.fetch('IMMOSCOUT_CONSUMER_SECRET', nil)
    end

    config_accessor(:oauth_token) { ENV.fetch('IMMOSCOUT_OAUTH_TOKEN', nil) }
    config_accessor(:oauth_token_secret) do
      ENV.fetch('IMMOSCOUT_OAUTH_TOKEN_SECRET', nil)
    end

    config_accessor(:use_sandbox) { false }

    config_accessor(:api_version) { 'v1.0' }

    config_accessor(:user_name) { 'me' }

    config_accessor(:api_url_live) do
      'https://rest.immobilienscout24.de/' \
        "restapi/api/offer/#{api_version}"
    end
    config_accessor(:api_url_sandbox) do
      'https://rest.sandbox-immobilienscout24.de/' \
        "restapi/api/offer/#{api_version}"
    end
  end
end
