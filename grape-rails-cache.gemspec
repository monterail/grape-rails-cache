# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape/rails/cache/version'

Gem::Specification.new do |spec|
  spec.name          = "grape-rails-cache"
  spec.version       = Grape::Rails::Cache::VERSION
  spec.authors       = ["Tymon Tobolski"]
  spec.email         = ["tymon.tobolski@monterail.com"]
  spec.description   = %q{HTTP and server side cache integration for Grape and Rails}
  spec.summary       = %q{HTTP and server side cache integration for Grape and Rails}
  spec.homepage      = "https://github.com/monterail/grape-rails-cache"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "grape"
  spec.add_dependency "activesupport"
  spec.add_dependency "uber", "~> 0.0.15"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
