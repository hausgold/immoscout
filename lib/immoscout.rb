# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/configurable'
require 'active_support/core_ext/hash'

require 'immoscout/version'
require 'immoscout/configuration'
require 'immoscout/models'

module Immoscout
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset_configuration!
    self.configuration = Configuration.new
  end
end
