#
# Cookbook Name:: deploy
# Recipe:: readycart
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

execute "create public/private files directory" do
  command "sudo mkdir -p /srv/www/readycart/current/sites/default/files/private"
  action :run
end

execute "change ownership of site files" do
  command "sudo chown -R www-data:www-data /srv/www/readycart/current"
  action :run
end
