# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/user_agent/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-user_agent"
  spec.version       = Rack::UserAgent::VERSION
  spec.authors       = ["Takashi Kokubun"]
  spec.email         = ["takashikkbn@gmail.com"]
  spec.summary       = %q{Rack::Request extension for handling User-Agent.}
  spec.description   = %q{Rack::Request extension for handling User-Agent.}
  spec.homepage      = "https://github.com/k0kubun/rack-user_agent"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 3.2.0'

  spec.add_dependency "rack", ">= 1.5"
  spec.add_dependency "woothee", ">= 1.0.0"

  spec.add_development_dependency "bundler", ">= 1.10"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rack-test"
end
