# frozen_string_literal: true

require 'simplecov'
SimpleCov.command_name 'specs'

require 'bundler/setup'
require 'immoscout'
require 'rspec/json_expectations'
require 'vcr'
require 'webmock'
require 'active_support'

# Load all support helpers and shared examples
Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }

TEST_CONFIG = begin
  load_method = YAML.respond_to?(:unsafe_load) ? :unsafe_load : :load
  YAML.send(load_method, File.read(File.join(__dir__, 'test_config.yml')))
rescue Errno::ENOENT
  {}
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Enable the focus inclusion filter and run all when no filter is set
  # See: http://bit.ly/2TVkcIh
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true

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
