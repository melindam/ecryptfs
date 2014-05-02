# creates mount for first time

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

#TODO might NOT need to use the node.set function if we don't need it for next time reboot - can use a new passphrase
node.set_unless[:ecryptfs][:passphrase] = secure_password

mount_pt = node[:ecryptfs][:mount]
passph = node[:ecryptfs][:passphrase] 

ruby_block "get-signature" do
  block do
    sig = %x(/bin/grep sig= /tmp/sigFile.txt | /bin/cut -d'=' -f 2)
    node.set[:ecryptfs][:signature] = sig.delete!("\n")
    %x(/bin/rm -f /tmp/sigFile.txt)
    if %x(/bin/grep #{mount_pt} /etc/fstab).empty?
           %x(/bin/echo "#{mount_pt} #{mount_pt} ecryptfs  no_sig_cache  0 0" >> /etc/fstab)
    end
  end
  action :nothing 
end

execute "mount-ecryptfs" do
  command "printf 'n\n' | /bin/mount -t ecryptfs -o no_sig_cache,key=passphrase:passphrase_passwd='#{passph}',ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=n #{mount_pt} #{mount_pt} > /tmp/sigFile.txt"  
  notifies :run, "ruby_block[get-signature]", :immediately
  action :run
  only_if do (%x{/bin/df | /bin/grep #{mount_pt}}).empty? end
end  
