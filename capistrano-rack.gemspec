# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano/rack/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-rack"
  spec.version       = Capistrano::Rack::VERSION
  spec.authors       = ["Faissal Elamraoui"]
  spec.email         = ["amr.faissal@gmail.com"]

  spec.summary       = %q{Capistrano with Rackspace}
  spec.description   = %q{Capistrano recipe to be served with Rackspace}
  spec.homepage      = "https://amrfaissal.github.io/capistrano-rack/"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "capistrano", "~> 3.5", ">= 3.0.0"
  spec.add_runtime_dependency "fog", "~> 1.38"
  spec.add_development_dependency "bundler", "~> 1.12", ">= 1.12.3"
  spec.add_development_dependency "rake", "~> 11.1", ">= 11.1.2"
  spec.add_development_dependency "rspec", "~> 3.4", ">= 3.4.0"
end
