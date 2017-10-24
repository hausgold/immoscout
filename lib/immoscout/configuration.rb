# frozen_string_literal: true

module Immoscout
  class Configuration
    include ActiveSupport::Configurable
    config_accessor(:consumer_key)
    config_accessor(:consumer_secret)

    config_accessor(:oauth_token)
    config_accessor(:oauth_token_secret)

    config_accessor(:use_sandbox) { true }

    config_accessor(:api_version) { "v1.0" }

    config_accessor(:api_url_live) do
      "https://rest.immobilienscout24.de/restapi/api/offer/#{api_version}"
    end
    config_accessor(:api_url_sandbox) do
      "https://rest.sandbox-immobilienscout24.de/restapi/api/offer/#{api_version}"
    end
  end
end
