if node["opsworks"].has_key?("instance") && node["opsworks"]["instance"].has_key?("layers") && node["opsworks"]["instance"]["layers"].include?("memcached")
  node[:opsworks][:layers]['memcached'][:instances].each do |instance_name, instance|
    execute "create public/private files directory" do
      command "nc #{instance['ip']} 11211 <<< 'flush_all'"
      action :run
    end
  end
end
