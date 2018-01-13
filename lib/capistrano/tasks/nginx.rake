git_plugin = self

namespace :bitrix do
  desc 'Setup Nginx configuration'
  task :nginx_config do
    on roles(fetch(:bitrix_nginx, :web)) do |role|
      git_plugin.bitrix_switch_user(role) do
        git_plugin.template('nginx', "/tmp/nginx_#{fetch(:nginx_config)}", role)
        sudo :mv, "/tmp/nginx_#{fetch(:nginx_conf)} #{fetch(:nginx_sap)}/#{fetch(:nginx_config)}"
        sudo :ln, '-fs', "#{fetch(:nginx_sap)}/#{fetch(:nginx_config)} #{fetch(:nginx_sep)}/#{fetch(:nginx_config)}"
      end
    end
  end
end