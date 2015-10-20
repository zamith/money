# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money/version'

Gem::Specification.new do |spec|
  spec.name          = "money"
  spec.version       = Money::VERSION
  spec.authors       = ["Zamith"]
  spec.email         = ["zamith.28@gmail.com"]
  spec.summary       = %q{Handles money in Ruby}
  spec.description   = %q{Handles money in Ruby. Everything from arithmetic
                          with different currencies, to converting currencies.}
  spec.homepage      = "https://github.com/zamith/money"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3"
end
