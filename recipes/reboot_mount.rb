# ecryptfs still needs to have a file for booting
# file created for reboot /root/.ecryptfsrc


directory "/root/.ecryptfs" do
  owner "root"
  group "root"
  mode "0700"  
  action :create
end

template "/root/.ecryptfsrc" do
  source "ecryptfsrc.erb"
  mode "0600" 
  backup false
  action :create
end

file "/root/.ecryptfs/sig-cache.txt" do
  owner "root"
  group "root"
  mode "0600" 
  backup false
  content node[:ecryptfs][:signature]
  action :create
end
