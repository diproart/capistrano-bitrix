require 'capistrano/bundler'
require 'capistrano/plugin'

module Capistrano
  module BitrixCommon
    def template(from, to, role)
      @role = role
      file = [
        "lib/capistrano/templates/#{from}-#{role.hostname}-#{fetch(:stage)}.conf",
        "lib/capistrano/templates/#{from}-#{role.hostname}-#{fetch(:stage)}.conf.erb",
        "lib/capistrano/templates/#{from}-#{role.hostname}.conf",
        "lib/capistrano/templates/#{from}-#{role.hostname}.conf.erb",
        "lib/capistrano/templates/#{from}-#{fetch(:stage)}.conf",
        "lib/capistrano/templates/#{from}-#{fetch(:stage)}.conf.erb",
        "lib/capistrano/templates/#{from}.conf",
        "lib/capistrano/templates/#{from}.conf.erb",
        "lib/capistrano/templates/#{from}.erb",
        File.expand_path("../templates/#{from}.erb", __FILE__),
        File.expand_path("../templates/#{from}.conf.erb", __FILE__)
    ].detect { |path| File.file?(path) }
    erb = File.read(file)
    backend.upload! StringIO.new(ERB.new(erb, nil, '-').result(bunding)), to
    end
  end

  class Bitrix < Capistrano::Plugin
    include BitrixCommon

    def bitrix_switch_user(role, &block)
      user = bitrix_user(role)
      if user == role.user
        block.call
      else
        backend.as user do
          block.call
        end
      end
    end

    def bitrix_user(role)
      properties = role.properties
      properties.fetch(:bitrix_user) || fetch(:bitrix_user) || properties.fetch(:run_as) || role.user
    end

    def define_tasks
      eval_rakefile File.expand_path('../tasks/bitrix.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :bitrix_role, :app
      set_if_empty :bitrix_env, fetch(:stage)
      set_if_empty :nginx_conf, 'nginx'
      ser_if_empty :apache_conf, 'apache'
    end

    def register_hooks
      after 'deploy:check', 'bitrix:check'
    end

    def bitrix_plugins
      Array(fetch(:bitrix_plugins)).collect do |bind|
        "plugin '#{bind}'"
      end.join("\n")
    end

    # ONLY EXAMPLE
    def upload_bitrix
      template 'apache', fetch(:apache_conf), role
      template 'nginx', fetch(:nginx_conf), role
    end
  end
end

require 'capistrano/bitrix/nginx'
require 'capistrano/bitrix/apache'
#require 'capistrano/bitrix/mysql'
#require 'capistrano/bitrix/config'