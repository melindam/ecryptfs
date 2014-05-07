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

include_recipe 'ecryptfs::mount'

# Make sure no residual files and recipes in the role exist for rebooting of the system
# when we don't want to perform a reboot
# If we want to reboot the system, set node variable [:ecryptfs][:reboot_enabled]


if node[:ecryptfs][:reboot_enabled]
  include_recipe 'ecryptfs::reboot_enabled'
else    
  include_recipe 'ecryptfs::secure_system'
end
