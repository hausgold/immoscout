# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'immoscout/version'

Gem::Specification.new do |spec|
  spec.name = 'immoscout'
  spec.version = Immoscout::VERSION
  spec.authors = ['Marcus Geissler']
  spec.email = ['marcus3006@gmail.com']

  spec.license = 'MIT'
  spec.summary = 'Ruby client for the Immobilienscout24 REST API'

  base_uri = "https://github.com/hausgold/#{spec.name}"
  spec.metadata = {
    'homepage_uri' => base_uri,
    'source_code_uri' => base_uri,
    'changelog_uri' => "#{base_uri}/blob/master/CHANGELOG.md",
    'bug_tracker_uri' => "#{base_uri}/issues",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{spec.name}"
  }

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'activesupport', '>= 6.1'
  spec.add_dependency 'faraday', '~> 1.10'
  spec.add_dependency 'faraday_middleware', '~> 1.2'
  spec.add_dependency 'simple_oauth', '>= 0.3'
end
