require File.expand_path('lib/snuffleupagus/version', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name                      = 'snuffleupagus'
  s.version                   = Snuffleupagus::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.authors                   = [ 'Andrew Bromwich' ]
  s.email                     = [ 'abromwich@studiosity.com' ]
  s.homepage                  = 'https://studiosity.com'
  s.description               = 'Simple auth token generator/validator'
  s.summary                   = "snuffleupagus-#{s.version}"
  s.required_rubygems_version = '> 1.3.6'

  s.add_development_dependency 'timecop'

  s.files = `git ls-files`.split($\)
  s.executables = `git ls-files`.split("\n").map{ |f| f =~ /^bin\/(.*)/ ? $1 : nil }.compact
  s.require_path = 'lib'
end
