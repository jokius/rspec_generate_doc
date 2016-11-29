# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_generate_doc/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec_generate_doc'
  spec.version       = RspecGenerateDoc::VERSION
  spec.authors       = ["Igor Kutyavin"]
  spec.email         = ["djok69@gmail.com"]

  spec.summary       = %q{Generate documentation api of rspec tests}
  spec.homepage      = 'https://github.com/jokius/rspec_api_docs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'rspec-rails'
end
