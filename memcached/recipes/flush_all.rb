node[:opsworks][:layers][:memcached][:instances].each do |instance_name, instance|
  Chef::Log.debug("Flushing #{instance_name}")
  execute "flush all memcached instances" do
    command "nc #{instance['ip']} 11211 <<< 'flush_all'"
    action :run
  end
end
