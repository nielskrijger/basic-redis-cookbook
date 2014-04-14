include_recipe "ark"

#
# Create user and group
#

group node['redis']['group'] do
  system true
  gid node['redis']['gid']
end

user node['redis']['user'] do
  group node['redis']['group']
  home node['redis']['homedir']
  system true
  action :create
  manage_home true
  uid node['redis']['uid']
end

#
# Create directories
#

directories = [node['redis']['conf_dir'],
               File.dirname(node['redis']['conf']['logfile']),
               node['redis']['conf']['dir']]
directories.each do |dir|
  directory dir do
    action :create
    recursive true
    owner node['redis']['user']
    group node['redis']['group']
    mode '0755'
  end
end

file node['redis']['conf']['logfile'] do
  owner node['redis']['user']
  group node['redis']['group']
  mode '0644'
  action :create_if_missing
end

#
# Install redis
#

target = "/usr/local/redis-#{node['redis']['version']}" # By default 'ark' extracts to /usr/local

ark "redis" do
  url node['redis']['url']
  version node['redis']['version']
  action :install_with_make # :configure is not required
  prefix_root '/usr/local/bin/redis'

  not_if do
    ::File.exists?("#{target}/src/redis-server")
  end
end

#
# Create Redis configuration
#

template "/etc/init/redis.conf" do
  mode '0644'
  source "init.redis.conf.erb"
end

template node['redis']['conf_file'] do
  mode '0644'
  owner node['redis']['user']
  group node['redis']['group']
  source "redis.conf.erb"
end

service "redis" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end