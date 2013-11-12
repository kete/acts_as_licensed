# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_licensed/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "acts_as_licensed"
  spec.version       = ActsAsLicensed::VERSION
  spec.email         = ["eoin@rabidtech.co.nz"]
  spec.authors       = ["Eoin Kelly", "Kieran Pilkington", "James Stradling"]
  spec.date          = "2013-11-12"
  spec.description   = "Provides a basic content licensing system to Rails apps"
  spec.email         = "eoin@rabidtech.co.nz"
  spec.homepage      = "http://github.com/kete/acts_as_licensed"
  spec.summary       = "Provides a basic content licensing system to Rails apps"
  spec.licenses      = ["MIT"]

  spec.extra_rdoc_files = [ "README.md" ]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("railties", ">= 3.0.0")

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
