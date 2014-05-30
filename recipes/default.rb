#
# Cookbook Name:: ecryptfs
# Recipe:: default
#
# Copyright 2014, melindam
#
#
yum_package "ecryptfs-utils" do
  action :install
end

directory "#{node[:ecryptfs][:mount]}" do
  recursive true
  owner "root"
  group "root"
  mode "0755"  
  action :create
end

directory "#{node[:ecryptfs][:lower_directory]}" do
  recursive true
  owner "root"
  group "root"
  mode "0755"  
  action :create
end

include_recipe 'ecryptfs::mount'

# Make sure files exist for rebooting of the system but do not include the secure passphrase
# If we want to reboot the system, set node variable [:ecryptfs][:reboot] = true

#if node[:ecryptfs][:reboot]
#  include_recipe 'ecryptfs::reboot'
#end
