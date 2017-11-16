# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "immoscout/version"

Gem::Specification.new do |spec|
  spec.name          = "immoscout"
  spec.version       = Immoscout::VERSION
  spec.authors       = ["Marcus Geissler"]
  spec.email         = ["marcus.geissler@hanseventures.com"]

  spec.summary       = 'Ruby client for the Immobilienscout24 REST API'
  spec.homepage      = "https://github.com/hausgold/immoscout"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "activesupport", ">= 3.2.0"
  spec.add_dependency "faraday", ">= 0.10.0"
  spec.add_dependency "faraday_middleware", ">= 0.9.0"
  spec.add_dependency "simple_oauth", ">= 0.3"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-json_expectations"
  spec.add_development_dependency "vcr", ">= 3.0.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
end
