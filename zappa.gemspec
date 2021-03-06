# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zappa/version'

Gem::Specification.new do |spec|
  spec.name          = 'zappa'
  spec.version       = Zappa::VERSION
  spec.authors       = ['Varun Srinivasan']
  spec.email         = ['varunsrin@gmail.com']
  spec.summary       = 'Ruby gem for manipulating audio files.'
  spec.description   = 'Zappa is a DSP toolbox for manipulating audio files.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'
end
