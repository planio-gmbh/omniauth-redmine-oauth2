# frozen_string_literal: true

require File.expand_path(
  File.join('..', 'lib', 'omniauth', 'redmine_oauth2', 'version'),
  __FILE__
)

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-redmine-oauth2'
  gem.version       = OmniAuth::RedmineOauth2::VERSION
  gem.license       = 'MIT'
  gem.summary       = %(A Redmine OAuth2 strategy for OmniAuth 1.x)
  gem.description   = %(A Redmine OAuth2 strategy for OmniAuth 1.x. This allows you to login to OAuth enabled Redmine with your Ruby app.)
  gem.authors       = ['Jens Kraemer']
  gem.email         = ['jens@planio.com']
  gem.homepage      = 'https://github.com/planio-gmbh/omniauth-redmine-oauth2'

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.4'

  gem.add_runtime_dependency 'omniauth', '~> 1.8'
  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.5'

  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
end

