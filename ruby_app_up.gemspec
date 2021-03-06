# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_app_up/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_app_up"
  spec.version       = RubyAppUp::VERSION
  spec.authors       = ["Jeff Dickey"]
  spec.email         = ["jdickey@seven-sigma.com"]
  spec.summary       = %q{Basic fire-and-forget onstreaming of a Rails app.}
  spec.description   = %q{Clones a Rails app from a Git repo and gets it set
                          up. Assumes rbenv and a fairly standard Rake setup,
                          including Rails-type database setup.}
  spec.homepage      = "https://github.com/jdickey/ruby_app_up/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'git'
  spec.add_dependency 'pastel'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry'
end
