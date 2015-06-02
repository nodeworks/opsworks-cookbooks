#
# Cookbook Name:: mtu_size
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "change-mtu-size" do
  command "sudo ip link set dev eth0 mtu 1500"
  action :run
end
