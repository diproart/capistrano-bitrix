module Capistrano
  class Bitrix::Mysql < Capistrano::Plugin
    include BitrixCommon
    def set_defaults
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/mysql.rake', __FILE__)
    end
  end
end