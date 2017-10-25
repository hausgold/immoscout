# frozen_string_literal: true

module Immoscout
  class Configuration
    include ActiveSupport::Configurable
    config_accessor(:consumer_key) { ENV["IMMOSCOUT_CONSUMER_KEY"] }
    config_accessor(:consumer_secret) { ENV["IMMOSCOUT_CONSUMER_SECRET"] }

    config_accessor(:oauth_token) { ENV["IMMOSCOUT_OAUTH_TOKEN"] }
    config_accessor(:oauth_token_secret) { ENV["IMMOSCOUT_OAUTH_TOKEN_SECRET"] }

    config_accessor(:use_sandbox) { false }

    config_accessor(:api_version) { "v1.0" }

    config_accessor(:api_url_live) do
      "https://rest.immobilienscout24.de/restapi/api/offer/#{api_version}"
    end
    config_accessor(:api_url_sandbox) do
      "https://rest.sandbox-immobilienscout24.de/restapi/api/offer/#{api_version}"
    end
  end
end
