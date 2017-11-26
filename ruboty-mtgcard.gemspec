# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/mtgcard/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-mtgcard'
  spec.version       = Ruboty::Mtgcard::VERSION
  spec.authors       = ['TAGAWA Takao']
  spec.email         = ['dounokouno@gmail.com']

  spec.summary       = 'A Ruboty plugin that returns MTG card illustration URL.'
  spec.homepage      = 'https://github.com/dounokouno/ruboty-mtgcard'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ruboty'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
end
