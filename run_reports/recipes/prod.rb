#
# Cookbook Name:: run_reports
# Recipe:: dev
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "run reports" do
  command "cd /srv/www/readycart_workers/current && php run cron --env=prod && php run reports --env=prod"
  action :run
end
