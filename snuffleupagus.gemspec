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
  s.required_ruby_version     = ['>= 2.6.0', '< 3.2.0']

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless s.respond_to?(:metadata)

  s.metadata['allowed_push_host'] = 'https://rubygems.org'
  s.metadata['rubygems_mfa_required'] = 'true'

  s.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rubocop', '~> 1.26'
  s.add_development_dependency 'rubocop-rake', '~> 0.6'
  s.add_development_dependency 'rubocop-rspec', '~> 2.9'
  s.add_development_dependency 'timecop', '~> 0'

  s.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.executables = `git ls-files`.split("\n").map do |f|
    f =~ %r{^bin/(.*)} ? Regexp.last_match(1) : nil
  end.compact
  s.require_path = 'lib'
end
