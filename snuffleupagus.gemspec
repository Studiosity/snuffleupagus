require File.expand_path('lib/snuffleupagus/version', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name                      = 'snuffleupagus'
  s.version                   = Snuffleupagus::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.authors                   = ['Andrew Bromwich']
  s.email                     = ['abromwich@studiosity.com']
  s.homepage                  = 'https://studiosity.com'
  s.description               = 'Simple auth token generator/validator'
  s.summary                   = "snuffleupagus-#{s.version}"
  s.required_rubygems_version = '> 1.3.6'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'timecop'

  s.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.executables = `git ls-files`.split("\n").map do |f|
    f =~ %r{^bin/(.*)} ? Regexp.last_match(1) : nil
  end.compact
  s.require_path = 'lib'
end
