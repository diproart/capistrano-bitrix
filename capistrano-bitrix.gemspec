# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/bitrix/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-bitrix'
  spec.version = Capistrano::BITRIXVERSION
  spec.authors = ['Alexey Volkov']
  spec.email = ['diproart@gmail.com']
  spec.description = %q{Capistrano for Bitrix}
  spec.summary = %q{Capistrano for Bitrix}
  spec.homepage = 'https://github.com/diproart/capistrano-bitrix'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 2.2.0'

  spec.files = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.7'
  spec.add_dependency 'capistrano-bundler'

  spec.post_install_message = %q{
    All plugins need to be explicitly installed with install_plugin
  }
end