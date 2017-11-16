# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require "bundler/setup"
require "immoscout"
require "rspec/json_expectations"
require "pry"
require "vcr"
require "webmock"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

TEST_CONFIG = begin
                YAML.load_file File.join(__dir__, 'test_config.yml')
              rescue Errno::ENOENT
                {}
              end

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
    Immoscout.configure do |immo|
      TEST_CONFIG.each do |key, value|
        immo.send("#{key}=", value)
      end
      immo.use_sandbox = true # always use the sandbox url for tests!
    end
  end
end
