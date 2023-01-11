# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'countless/rake_tasks'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# Configure all code statistics directories
Countless.configure do |config|
  config.stats_base_directories = [
    { name: 'Top-levels', dir: 'lib',
      pattern: %r{/lib(/immoscout)?/[^/]+\.rb$} },
    { name: 'Top-levels specs', test: true, dir: 'spec',
      pattern: %r{/spec(/immoscout)?/[^/]+_spec\.rb$} },
    { name: 'APIs', pattern: 'lib/immoscout/api/**/*.rb' },
    { name: 'Errors', pattern: 'lib/immoscout/errors/**/*.rb' },
    { name: 'Models', pattern: 'lib/immoscout/models/**/*.rb' },
    { name: 'Models specs', test: true,
      pattern: 'spec/models/**/*_spec.rb' }
  ]
end
