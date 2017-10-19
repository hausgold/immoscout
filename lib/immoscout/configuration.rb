# frozen_string_literal: true

module Immoscout
  class Configuration
    include ActiveSupport::Configurable
    config_accessor(:access_token)
    config_accessor(:use_sandbox) { false }
  end
end
