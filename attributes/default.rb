default[:ecryptfs][:mount] = '/secure_mount'
default[:ecryptfs][:lower_directory] = '/secure_mount'

#default[:ecryptfs][:passphrase] = 'ourSecurePassPhrase'

default[:ecryptfs][:reboot] = false
default[:ecryptfs][:first_mount] = false

default[:ecryptfs][:active] = true