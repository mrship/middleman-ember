# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/ember/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-ember"
  spec.version       = Middleman::Ember::VERSION
  spec.authors       = ["Andy Shipman"]
  spec.email         = ["andy@cllearview.com"]
  spec.description   = "Ember support for Middleman"
  spec.summary       = "Add Ember assets to a Middleman project. Support for production version of Ember when building."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'middleman-core'
  spec.add_dependency 'ember-source'
  spec.add_dependency 'ember-data-source'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
