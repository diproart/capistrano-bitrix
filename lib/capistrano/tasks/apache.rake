git_plugin = self

namespace :bitrix do
  desc 'Setup Apache configuration'
  task :apache_config do
    on roles(fetch(:bitrix_apache, :web)) do |role|
      git_plugin.bitrix_switch_user(role) do
        git_plugin.template('nginx', "/tmp/apache_#{fetch(:apache_config)}", role)
        sudo :mv, "/tmp/apache_#{fetch(:apache_conf)} #{fetch(:apache_sap)}/#{fetch(:apache_config)}"
        sudo :ln, '-fs', "#{fetch(:apache_sap)}/#{fetch(:apache_config)} #{fetch(:apache_sep)}/#{fetch(:apache_config)}"
      end
    end
  end
end