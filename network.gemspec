# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'network/version'

Gem::Specification.new do |spec|
  spec.name          = "network"
  spec.version       = Network::VERSION
  spec.authors       = ["Ashley Penney"]
  spec.email         = ["ashley.penney@puppetlabs.com"]
  spec.summary       = %q{Library to return network information..}
  spec.description   = %q{Library to abstract away OS differences for network information.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
