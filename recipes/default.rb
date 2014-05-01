#
# Cookbook Name:: ecryptfs
# Recipe:: default
#
# Copyright 2014, melindam
#
# All rights reserved - Do Not Redistribute
#
yum_package "ecryptfs-utils" do
  action :install
end

directory "#{node[:ecryptfs][:mount]}" do
  owner "root"
  group "root"
  mode "0755"  
  action :create
end

node.set[:ecryptfs][:active] = true

include_recipe 'ecryptfs::mount'

# Make sure no residual files and recipes in the role exist for rebooting of the system
# when we don't want to perform a reboot
# If we want to reboot the system, include recipe in the role called ecryptfs::reboot_mount

#include_recipe 'ecryptfs::fix_mount'
