# frozen_string_literal: true

require "immoscout/version"
require 'immoscout/configuration'

module Immoscout
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Immoscout::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
