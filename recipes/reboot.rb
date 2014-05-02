# ecryptfs still needs to have a file for booting
# files created for reboot 

template "/root/.ecryptfsrc" do
  source "ecryptfsrc.erb"
  mode "0600" 
  backup false
end

#directory "/root/.ecryptfs" do
#  owner "root"
#  group "root"
#  mode "0700"  
#end

#file "/root/.ecryptfs/sig-cache.txt" do
#  owner "root"
#  group "root"
#  mode "0600" 
#  backup false
#  content node[:ecryptfs][:signature]
#end