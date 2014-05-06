default[:ecryptfs][:mount] = '/private/secure_mount'
default[:ecryptfs][:lower_directory] = nil
default[:ecryptfs][:active] = true
default[:ecryptfs][:reboot_enabled] = false

default[:ecryptfs][:passphrase] = nil
default[:ecryptfs][:signature] = nil

#default[:ecryptfs][:restart_enabled] = false