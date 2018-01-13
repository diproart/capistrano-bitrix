module Capistrano
  class Bitrix::Nginx < Capistrano::Plugin
    include BitrixCommon
    def set_defaults
      set_if_empty :nginx_conf, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
      set_if_empty :nginx_sap, '/etc/nginx/sites-available'
      set_if_empty :nginx_sep, '/etc/nginx/sites-enabled'
      set_if_empty :nginx_server_name, -> { "localhost #{fetch(:application)}.local" }
      set_if_empty :nginx_use_ssl, false
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/nginx.rake', __FILE__)
    end
  end
end