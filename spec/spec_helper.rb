# frozen_string_literal: true

require "bundler/setup"
require "immoscout"
require "rspec/json_expectations"
require "pry"
require "vcr"
require "webmock"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include RSpec::JsonExpectations::Matchers
  config.include FileFixture

  config.before do
    Immoscout.reset_configuration!
  end

  config.before(vcr: true) do
    Immoscout.configure do |immoscout_config|
      immoscout_config.consumer_key = 'value'
      immoscout_config.consumer_secret = 'value'
      immoscout_config.oauth_token = 'value'
      immoscout_config.oauth_token_secret = 'value'
      immoscout_config.use_sandbox = true
    end
  end
end
