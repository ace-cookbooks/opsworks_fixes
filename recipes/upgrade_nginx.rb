yum_repository 'nginx' do
  description 'nginx stable repo'
  baseurl 'http://nginx.org/packages/centos/6/$basearch/'
  enabled true
  priority 9

  action :create
end

yum_repository 'nginx' do
  description 'nginx mainline repo'
  baseurl 'http://nginx.org/packages/mainline/centos/6/$basearch/'
  enabled false
  priority 9

  action :create
end

include_recipe 'nginx::service'

package 'nginx' do
  action :upgrade
  notifies :restart, 'service[nginx]'
end

# Make sure that default.conf and example_ssl.conf are not present
bash "remove default nginx config" do
  user "root"
  code <<-EOH
  rm -f /etc/nginx/conf.d/default.conf
  rm -f /etc/nginx/conf.d/example_ssl.conf
  EOH
end
