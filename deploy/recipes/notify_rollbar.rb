#
# Cookbook Name:: deploy
# Recipe:: readycart
#


execute "Notify rollbar of deployment" do
  environment = node[:deploy]['readycart'][:scm][:revision]
  access_token = '7ac65697d0964dd9834a222341209467'
  revision = node[:deploy]['readycart'][:scm][:revision]
  command "curl https://api.rollbar.com/api/1/deploy/ -F access_token=$ACCESS_TOKEN -F environment=$ENVIRONMENT -F revision=$REVISION -F local_username=$LOCAL_USERNAME"
  action :run
end
