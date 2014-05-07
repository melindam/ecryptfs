# creates mount for first time, if this file system was not mounted before use passphrase provided or create a passphrase
#TODO need to determine if a desire to have multiple encrypted mount points for the system

mount_pt = node[:ecryptfs][:mount]
lower_dir = node[:ecryptfs][:mount]

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

# Checks to see if the mount has been successful first time, otherwise don't get new passphrase
if !(node[:ecryptfs][:first_mount])
  node.set_unless[:ecryptfs][:passphrase] = secure_password   
end

passph = node[:ecryptfs][:passphrase]
 
#TODO actually add entry every time mount (like hostsfile does), not just append to fstab 

# Get mount key signature from the passphrase provided, and store it in node variable.
# Add entry in the fstab file for the new mount point if the entry is not already there.
ruby_block "get-signature" do
  block do
    sig = %x(grep sig= /tmp/sigFile.txt | cut -d'=' -f 2)
    node.set_unless[:ecryptfs][:signature] = sig.delete!("\n")
    if %x(grep #{mount_pt} /etc/fstab | grep ecryptfs).empty?
      %x(echo "#{lower_dir} #{mount_pt} ecryptfs  no_sig_cache  0 0" >> /etc/fstab)
    end
    node.set[:ecryptfs][:first_mount] = true
  end
  action :nothing 
end

#TODO if the /root/.ecryptfsrc file exists and tries to mount after 2nd time, the mount failes
# Mount command with all options available first time, or successive times if unmounted when reboot has not taken place. 
# Passphrase is not kept on system, only could be seen on manual chef-client run.
execute "mount-ecryptfs" do
  command "mount -t ecryptfs -o no_sig_cache,key=passphrase:passphrase_passwd='#{passph}',ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=n,ecryptfs_enable_filename_crypto=n #{lower_dir} #{mount_pt} > /tmp/sigFile.txt"  
  notifies :run, "ruby_block[get-signature]", :immediately
  action :run
  only_if do (%x{df | grep #{mount_pt}}).empty? end
end  

file "/tmp/sigFile.txt" do
  action :delete
end