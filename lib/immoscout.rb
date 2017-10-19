# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/configurable'
require 'hashie'

require "immoscout/version"
require 'immoscout/configuration'
require 'immoscout/resources'

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
end
