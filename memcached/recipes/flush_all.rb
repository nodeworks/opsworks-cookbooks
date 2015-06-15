node[:opsworks][:layers][:memcached][:instances].each do |instance_name, instance|
  Chef::Log.debug("Flushing #{instance_name}")
  execute "flush all memcached instances" do
    command "echo 'flush_all' | nc #{instance['ip']} 11211"
    action :run
  end
end
