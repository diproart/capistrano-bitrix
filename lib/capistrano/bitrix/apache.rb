module Capistrano
  class Bitrix::Apache < Capistrano::Plugin
    include BitrixCommon
    def set_defaults
      set_if_empty :apache_conf, -> { "#{fetch(:application)}_#{fetch(:stage)}.conf" }
      set_if_empty :apache_sap, '/etc/apache2/sites-available'
      set_if_empty :apache_sep, '/etc/apache2/sites-enabled'
      set_if_empty :apache_server_name, -> { "localhost #{fetch(:application)}.local" }
      set_if_empty :apache_use_ssl, false
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/apache.rake', __FILE__)
    end
  end
end