# ecryptfs still needs to have a file for booting
# files created for reboot 

template "/root/.ecryptfsrc" do
  source "ecryptfsrc.erb"
  mode "0600" 
  backup false
end

#Do we want to set the value back to nil?  Or member to manually do it?
# node.set[:ecryptfs][:reboot_enabled] = nil
