# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'starling_terminal/version'

Gem::Specification.new do |spec|
  spec.name          = 'starling_terminal'
  spec.version       = StarlingTerminal::VERSION
  spec.authors       = ['Tim Rogers']
  spec.email         = ['tim@gocardless.com']

  spec.summary = 'A tool for viewing your Starling Bank statement from your terminal'
  spec.homepage      = 'https://github.com/timrogers/starling-terminal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'starling-ruby', '~> 0.2.0'
  spec.add_dependency 'terminal-table', '~> 1.8.0'
  spec.add_dependency 'colorize', '~> 0.8.1'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2.3'
  spec.add_development_dependency 'reek', '~> 4.7.0'
  spec.add_development_dependency 'rspec-snapshot', '~> 0.1.1'
  spec.add_development_dependency 'webmock', '~> 3.9.2'
  spec.add_development_dependency 'yard', '~> 0.9.14'
end
