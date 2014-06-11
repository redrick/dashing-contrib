# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dashing-contrib/version'

Gem::Specification.new do |spec|
  spec.name          = "dashing-contrib"
  spec.version       = DashingContrib::VERSION
  spec.executables = %w(dashing-contrib)
  spec.authors       = ["Jing Dong"]
  spec.email         = ["jing.dong@activars.com"]
  spec.description   = %q{Dashing Contrib aims to make templates plugins easy to maintain and contribute}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'dotenv', '~> 0.11.1'
  spec.add_dependency 'thor', '~> 0.18.1'

  spec.add_development_dependency "rake"
end
