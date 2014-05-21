ecryptfs Cookbook
====================
Ecryptfs cookbook for encrypting a file system RHEL/CentOS only 


Requirements
------------
Cookbook requirements needs a file system directory name to mount. 
For true security replace the :passphrase with something you 

(Future enhancements will be options like ecryptfs_key_bytes other than default 16, 
lower directory and private directory could be specified differently)

#### cookbooks
- `openssl` 

#### packages
- `ecryptfs-utils` - ecryptfs needs this package installed for RHEL

Attributes
----------
* `node['ecryptfs']['mount']` - System directory and mount point which is encrypted. 
* `node['ecryptfs']['lower_directory'] ` - System file system or directory to house mount point. If nil, uses `node['ecryptfs']['mount']`
* `node['ecryptfs']['passphrase']` - Choose your own, or chef will create a secure one for you.
  - highly recommend you choose one, then remove it from your role, or node and replace it only when you need to reboot
    your system. 
* `node['ecryptfs']['reboot_enabled']` - Set this node variable in the role immediately before you want to reboot your system to allow for the auto mount of the file system to take place.
* `node['ecryptfs']['active']` - Default = true.  So other cookbooks know ecrypfs file system is available to the node.

Recipes
-------

#### ecryptfs::default
ecryptfs file system mount created, mounted, encrypted passphrase defined if one not given. See http://ecryptfs.org

#### ecryptfs::reboot_enabled
Prepares the secure passphrase and signature cache key in /root/ directory for auto-mount to take place when system 
is manually rebooted.  These files are not on the system by default, and if the system crashes, the passphrase will 
`MANUALLY` have to be entered for the file system to mount, or the variable `node['ecryptfs]['reboot_enabled'] = true` 
must be set, and then run chef-client for auto-mount to work.

#### ecryptfs::secure_system
Include the recipe in your node's `runlist` when your system is finished rebooting and state of system should resume 
encrypting the file system and remove auto-mount config files needed. 

Usage
-----

#### ecryptfs::default
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]"
  ]
}

override_attributes(
   :ecryptfs => {  
     :mount => "/var/SecureDir" 
    }
)

```

#### ecryptfs::reboot_enabled
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]"
   ]
}
   
 override_attributes (
  :ecryptfs => {
    :mount => "/var/SecureDir", 
    :reboot_enabled => true
  }
 )  
```


Contributing
------------

*  Fork the repository on Github
*  Create a named feature branch (like `add_component_x`)
*  Write your change
*  Write tests for your change (if applicable)
*  Run the tests, ensuring they all pass
*  Submit a Pull Request using Github

License and Authors
-------------------
Authors: Melinda Moran 

