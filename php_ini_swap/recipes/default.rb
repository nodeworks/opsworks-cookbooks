#
# Cookbook Name:: php_ini_swap
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/php.ini" do
  source "php.ini"
  mode "0644"
end

execute "install-drush" do
  command "sudo apt-get install drush -y && sudo drush > null && sudo chown -R ubuntu:ubunutu /home/ubuntu/.drush"
  action :run
end
