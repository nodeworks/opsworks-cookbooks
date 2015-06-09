#
# Cookbook Name:: run_reports
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "create public/private files directory" do
  command "cd /srv/www/readycart_reports/current && php run reports"
  action :run
end
