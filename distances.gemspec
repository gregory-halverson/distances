# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distances/version'

Gem::Specification.new do |spec|
  spec.name          = "distances"
  spec.version       = Distances::VERSION
  spec.authors       = ["Gregory H. Halverson"]
  spec.email         = ["gregory.halverson@gmail.com"]
  spec.summary       = %q{Distances}
  spec.description   = %q{Convert between metric, imperial, and astronomical distances.}
  spec.homepage      = "https://github.com/gregory-halverson/distances"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
