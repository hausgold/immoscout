# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'immoscout/version'

Gem::Specification.new do |spec|
  spec.name          = 'immoscout'
  spec.version       = Immoscout::VERSION
  spec.authors       = ['Marcus Geissler']
  spec.email         = ['marcus.geissler@hanseventures.com']

  spec.summary       = 'Ruby client for the Immobilienscout24 REST API'
  spec.homepage      = 'https://github.com/hausgold/immoscout'
  spec.license       = 'MIT'

  spec.required_ruby_version = '~> 2.5'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'activesupport', '>= 5.2.0'
  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'faraday_middleware', '~> 1.0'
  spec.add_dependency 'simple_oauth', '>= 0.3'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '>= 1.16', '< 3'
  spec.add_development_dependency 'factory_bot', '~> 4.11'
  spec.add_development_dependency 'railties', '>= 4.2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rdoc', '~> 6.1'
  spec.add_development_dependency 'redcarpet', '~> 3.4'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-json_expectations', '~> 1.4'
  spec.add_development_dependency 'rubocop', '~> 0.63.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.31'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'terminal-table', '~> 1.8'
  spec.add_development_dependency 'timecop', '~> 0.9.1'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.5'
  spec.add_development_dependency 'yard', '~> 0.9.18'
  spec.add_development_dependency 'yard-activesupport-concern', '~> 0.0.1'
end
