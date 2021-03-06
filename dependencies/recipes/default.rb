#
# Cookbook Name:: dependencies
# Recipe:: default

include_recipe 'packages'
include_recipe 'gem_support'
include_recipe node[:opsworks][:ruby_stack]

case node[:platform]
when 'centos','redhat','fedora','amazon'
  # this should actually iterate over node[:dependencies][:rpms]
  node[:dependencies][:debs].each do |rpm, version|
    Chef::Log.info("preparing installation of dependency: rpm #{rpm.inspect}")
    package rpm do
      action :upgrade
      version(version)
    end
  end
when 'debian','ubuntu'
  node[:dependencies][:debs].each do |deb, version|
    Chef::Log.info("preparing installation of dependency: dpkg #{deb.inspect}")
    package deb do
      action :upgrade
      version(version)
    end
  end
end

node[:dependencies][:gems].each do |gem_name, version|
  Chef::Log.info("Preparing installation of dependency: Gem #{gem_name}")
  gem_package gem_name do
    version(version)
    retries 2
    gem_binary node[:dependencies][:gem_binary]
    options '--no-ri --no-rdoc'
  end
end

if node["opsworks"].has_key?("instance") && node["opsworks"]["instance"].has_key?("layers") && node["opsworks"]["instance"]["layers"].include?("readycart_app")
  execute "change www-data home directory" do
    command "if echo ~www-data | grep www-data > /dev/null; then echo 0; else sudo service php-fpm stop > /dev/null && sudo service nginx stop > /dev/null && sudo usermod -d /home/www-data www-data > /dev/null && sudo service nginx start > /dev/null && sudo service php-fpm start > /dev/null; fi"
    action :run
  end
end
