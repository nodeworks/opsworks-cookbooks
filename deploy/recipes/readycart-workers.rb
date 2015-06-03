#
# Cookbook Name:: deploy
# Recipe:: readycart
#

include_recipe 'deploy'

if node["opsworks"].has_key?("instance") && node["opsworks"]["instance"].has_key?("layers") && node["opsworks"]["instance"]["layers"].include?("other")
  execute "change www-data home directory" do
    command "if echo ~www-data | grep www-data > /dev/null; then echo 0; else sudo usermod -d /home/www-data www-data > /dev/null; fi"
    action :run
  end
end

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'other'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an Other app")
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
