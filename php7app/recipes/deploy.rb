include_recipe 's3_file'
tag = 'latest'

app = search("aws_opsworks_app","deploy:true").first
app_dir = "/srv/www/#{app[:shortname]}"
tmp_dir = "/tmp/opsworks/#{app[:shortname]}"

# download the app artifact
artifact = "/tmp/#{app[:shortname]}.zip"
s3_file "#{artifact}" do
        remote_path "#{app[:name]}.zip"
        bucket "opsworks"
        s3_url "https://s3-eu-west-1.amazonaws.com/opsworks"
        aws_access_key_id app[:app_source][:user]
        aws_secret_access_key app[:app_source][:password]
end

directory "#{tmp_dir}" do
    mode "0755"
    recursive true
end

execute "unzip #{artifact} -d #{tmp_dir}"

execute 'create git repository' do
    cwd "#{tmp_dir}"
    command "find . -type d -name .git -exec rm -rf {} \\;; find . -type f -name .gitignore -exec rm -f {} \\;; git init; git add .; git config user.name 'AWS OpsWorks'; git config user.email 'root@localhost'; git commit -m 'Create temporary repository from downloaded contents.'"
end

deploy "#{app_dir}" do
    repository tmp_dir
    user "root"
    group "root"
    environment app[:environment]
    symlink_before_migrate({})
end

directory "#{app_dir}/current/.git" do
    recursive true
    action :delete
end

nginx_site "#{app[:shortname]}" do
    template "nginx-template.conf.erb"
    enable true
    variables({
        :domains => app[:domains].first,
        :root => "#{app_dir}/current/#{app[:attributes][:document_root]}"
    })
end

service "nginx" do
    action :reload
end

# clean up
file "#{artifact}" do
    action :delete
    backup false
end

directory "#{tmp_dir}" do
    recursive true
    action :delete
end
