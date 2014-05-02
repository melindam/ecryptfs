#
# ecryptfs still needs a file for booting
# file created for reboot /root/.ecryptfsrc and if its there, remove it
# check to see if this node has the recipe defined to run reboot_mount
#
ruby_block 'remove reboot and secure_system recipes from run list' do
  block do
    %x(/bin/rm -rf /root/.ecryptfs*)
    node.run_list.remove('recipe[ecryptfs::reboot]')
    node.run_list.remove('recipe[ecryptfs::secure_system]')

  end
  #only_if { node.run_list.include?('recipe[ecryptfs::reboot]') }
end