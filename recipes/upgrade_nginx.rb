#get the metadata
execute "yum-makecache" do
  command "yum -q makecache"
  action :nothing
end
#reload internal Chef yum cache
ruby_block "reload-internal-yum-cache" do
  block do
    Chef::Provider::Package::Yum::YumCache.instance.reload
  end
  action :nothing
end

template "/etc/yum.repos.d/nginx.repo" do
  source 'repo.erb'
  mode '0644'
  variables({
    :repo_name => 'nginx',
    :description => 'nginx repo',
    :url => 'http://nginx.org/packages/centos/6/$basearch/',
    :enabled => true,
    :priority => '10'
  })
  # FIXME: Update syntax once chef is upgraded past 0.9
  notifies :run, resources(:execute => "yum-makecache"), :immediately
  notifies :create, resources(:ruby_block => "reload-internal-yum-cache"), :immediately
end

include_recipe 'nginx::service'

package 'nginx' do
  action :upgrade
  notifies :restart, resources(:service => 'nginx')
end

# Make sure that default.conf and example_ssl.conf are not present
bash "remove default nginx config" do
  user "root"
  code <<-EOH
  rm -f /etc/nginx/conf.d/default.conf
  rm -f /etc/nginx/conf.d/example_ssl.conf
  EOH
end
