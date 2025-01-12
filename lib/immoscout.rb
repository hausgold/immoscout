# frozen_string_literal: true

require 'zeitwerk'
require 'active_support/concern'
require 'active_support/configurable'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/module'
require 'singleton'
require 'faraday'
require 'faraday_middleware'
require 'json'

# The top-namespace of the +immoscout+ gem.
module Immoscout
  # Setup a Zeitwerk autoloader instance and configure it
  loader = Zeitwerk::Loader.for_gem

  # Finish the auto loader configuration
  loader.setup

  # Make sure to eager load all constants
  loader.eager_load

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      self.configuration = Configuration.new
    end
  end
end
