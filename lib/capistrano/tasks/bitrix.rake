git_plugin = self

namespace :bitrix do
  desc "Setup Apache/Nginx config"
  task :config do
    on roles(fetch(:bitrix_role)) do |role|
      git_plugin.upload_bitrix(role)
    end
  end

  desc "Backup files"
  task :backup_fs do
    on roles(fetch(:bitrix_role)) do |role|
      #
    end
  end

  desc "Backup db"
  task :backup_db do
    on roles(fetch(:bitrix_role)) do |role|
      #
    end
  end
end