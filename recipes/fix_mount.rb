#
# ecryptfs still needs a file for booting
# file created for reboot /root/.ecryptfsrc and if its there, remove it
# check to see if this node has the recipe defined to run reboot_mount
#
ruby_block 'remove ecryptfs::reboot_mount from run list' do
  block do
    %x(/bin/rm -rf /root/.ecryptfs*)
    node.run_list.remove('recipe[ecryptfs::reboot_mount]')
  end
  only_if { node.run_list.include?('recipe[ecryptfs::reboot_mount]') }
end