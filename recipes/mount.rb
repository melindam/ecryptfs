::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

include_recipe 'ecryptfs::default'

unless node['ecryptfs']['passphrase']
  # if no passphrase but a signature, fail the run cause something is wrong
  if node['ecryptfs']['signature']
    Chef::Application.fatal!("Passphrase without Signature!")
  else
    # If not mounted,
    #   create a passphrase
    #   get the signature from the output file
    # else 
    #  throw a failure because if mounted and we do not know the passphrase, we are hosed.
    if %x(df | grep #{node['ecryptfs']['mount']}).empty?
      node.set['ecryptfs']['passphrase'] = secure_password
      execute "mount-ecryptfs" do
        command "mount -t ecryptfs -o no_sig_cache,key=passphrase:passphrase_passwd=#{node['ecryptfs']['passphrase']}," +
                "ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=#{node['ecryptfs']['ecryptfs_passthrough']}," +
                "ecryptfs_enable_filename_crypto=#{node['ecryptfs']['ecryptfs_enable_filename_crypto']} " +
                "#{node['ecryptfs']['lower_directory']} #{node['ecryptfs']['mount']} > #{node['ecryptfs']['mount_results_file']}"
        action :run
      end
      # get the signature made from the mount output      
      ruby_block "get-signature" do
        block do
          sig = %x(grep sig= #{node['ecryptfs']['mount_results_file']} | cut -d'=' -f 2)
          node.set['ecryptfs']['signature'] = sig.delete!("\n")
        end
        action :run
      end
    else
      Chef::Application.fatal!("Mounted ecryptfs directory but no passphrase or signature!")
    end
  end
else
  # If you have a passphrase but no signature, this will be a problem!
  unless node['ecryptfs']['signature']
    Chef::Application.fatal!("Signature without passphrase!")
  end
end


ruby_block "update fstab file" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/fstab")
    fe.insert_line_if_no_match(/#{node['ecryptfs']['mount']}/,
                               "#{node['ecryptfs']['lower_directory']} #{node['ecryptfs']['mount']} ecryptfs  no_sig_cache  0 0")
    fe.write_file
  end
  action :run
end

template "/root/.ecryptfsrc" do
  source "ecryptfsrc.erb"
  mode "0600"
  backup false
  variables( 
    :pph =>  node['ecryptfs']['reboot'] ? node['ecryptfs']['passphrase'] : "UnspecifiedPassphrase",
    :sig => node['ecryptfs']['reboot'] ? node['ecryptfs']['signature'] : "UnspecifiedSignature"
  )
  action :create
end

file "/tmp/sigFile.txt" do
  backup false
  action :delete
end