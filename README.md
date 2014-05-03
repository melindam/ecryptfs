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
* `node['ecryptfs']['mount_point']` - System directory and mount point which is encrypted. 
* `node['ecryptfs']['passphrase']` - Choose your own, or chef will create a secure one for you.
  - highly recommend you choose one, then remove it from your role, or node and replace it only when you need to reboot
    your system. 


Recipes
-------

#### ecryptfs::default
ecryptfs file system mount created, mounted, encrypted passphrase defined if one not given. See http://ecryptfs.org

#### ecryptfs::reboot
will prepare the secure passphrase and signature cache key in /root/ directory for auto-mount to take place when system 
is rebooted manually.  These files are not in place if the system crashes, the passphrase will `MANUALLY` have to be entered, or 
chef-client will have to be run manually, then the system can manually be rebooted for auto-mount to work.

#### ecryptfs::secure_system

Include the recipe in your node's `runlist` when your system is finished rebooting and state of system should resume 
encrypting the file system and remove auto-mount config files needed.  If added with the `ecryptfs::reboot` recipe, it will remove 
that recipe and `ecryptfs::secure_system` from the node's runlist.


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
default_attributes(
  { :ecryptfs => 
    {  :mount_point => "/var/SecureDir" 
    }
} )
```

#### ecryptfs::reboot
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]",
    "recipe[ecryptfs::reboot]"
   ]
}
```
#### ecryptfs::secure_system

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]",
    "recipe[ecryptfs::reboot]",
    "recipe[ecryptfs::secure_system]"
   ]
}
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

