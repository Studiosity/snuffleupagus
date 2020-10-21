# frozen_string_literal: true

require File.expand_path('lib/snuffleupagus/version', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name                      = 'snuffleupagus'
  s.version                   = Snuffleupagus::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.authors                   = ['Andrew Bromwich']
  s.email                     = ['abromwich@studiosity.com']
  s.homepage                  = 'https://github.com/Studiosity/snuffleupagus'
  s.description               = 'Simple auth token generator/validator'
  s.summary                   = "snuffleupagus-#{s.version}"
  s.required_rubygems_version = '> 1.3.6'
  s.required_ruby_version     = ['>= 2.5.0', '< 2.8.0']

  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 0.49'
  s.add_development_dependency 'timecop', '~> 0'

  s.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.executables = `git ls-files`.split("\n").map do |f|
    f =~ %r{^bin/(.*)} ? Regexp.last_match(1) : nil
  end.compact
  s.require_path = 'lib'
end
