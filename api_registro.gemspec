# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_registro/version'

Gem::Specification.new do |spec|
  spec.name          = "api_registro"
  spec.version       = ApiRegistro::VERSION
  spec.authors       = ["Daniel Quirino Oliveira"]
  spec.email         = ["danielqo@gmail.com"]
  spec.description   = %q{A client for APIRegistro.com.br API}
  spec.summary       = %q{APIRegistro.com.br API client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency             "httparty"
end
