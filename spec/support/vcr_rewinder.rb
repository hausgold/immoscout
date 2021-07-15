# frozen_string_literal: true

require 'vcr'
require 'set'
USED_CASSETTES = Set.new

module CassetteReporter
  def insert_cassette(name, options = {})
    USED_CASSETTES << VCR::Cassette.new(name, options).file
    super
  end
end
VCR.extend(CassetteReporter)

RSpec.configure do |config|
  config.after(:suite) do
    cassettes = Dir['spec/fixtures/vcr_cassettes/*.yml'].map do |d|
      File.expand_path(d)
    end - USED_CASSETTES.to_a
    if cassettes.any?
      puts "Found #{cassettes.count} unused vcr cassettes"
      if ENV.fetch('CLEAN_VCR', false)
        puts 'cleaning up...'
        cassettes.map { |f| File.delete(f) }
      end
    end
  end
end
