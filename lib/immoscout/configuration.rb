# frozen_string_literal: true

module Immoscout
  # The configuration object of the +immoscout+ gem.
  class Configuration
    include ActiveSupport::Configurable

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
