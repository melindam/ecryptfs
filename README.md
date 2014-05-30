ecryptfs Cookbook
====================
Ecryptfs cookbook for encrypting a file system RHEL/CentOS only 


Requirements
------------
Cookbook requirements needs a file system directory name to mount. 
For true security allow the :passphrase to be auto generated with OpenSSL Chef secure_passphrase call.

(Future enhancements will be options like ecryptfs_key_bytes other than default 16)

#### cookbooks
- `openssl` 

#### packages
- `ecryptfs-utils` - ecryptfs needs this package installed for RHEL/CentOS

Attributes
----------
* `node['ecryptfs']['mount']` - System directory and mount point which is encrypted. 
* `node['ecryptfs']['lower_directory'] ` - System file system or directory to house mount point. If nil, uses `node['ecryptfs']['mount']`
* `node['ecryptfs']['passphrase']` - Choose your own, or chef will create a secure one for you.
  - highly recommend remove it from your role, or node and replace it only when you need to reboot your system. 
* `node['ecryptfs']['reboot']` - Set this node variable in the role immediately before you want to reboot your system to allow for the auto mount of the file system to take place.  Must manually remove the variable for the secure data to be removed from system.
* `node['ecryptfs']['active']` - Default = true.  So other cookbooks know ecrypfs file system is available to the node.

Recipes
-------

#### ecryptfs::default
ecryptfs file system mount created, mounted, encrypted passphrase defined if one not given. See http://ecryptfs.org

#### ecryptfs::mount
Prepares the secure passphrase and signature cache key in /root/ directory for auto-mount to take place when system 
is manually rebooted.  If the system crashes, file `/root/.ecryptfsrc` will have to be removed or the variable `node['ecryptfs]['reboot'] = true` must be set, 
and then run chef-client for auto-mount to work.
If the file system becomes unmounted without the `['reboot']` variable set, remove the file /root/.ecryptfsrc and
re-run the chef-client, and it will automount. If the file `/root/.ecryptfsrc` is there, next chef run will fail - unable to mount with 
bogus data in the .ecryptfsrc file.


Usage
-----

#### ecryptfs 
```
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]"
  ]
}
override_attributes(
   :ecryptfs => {  
     :mount => "/var/SecureDir",
     :lower_directory "/var" 
    }
)
```

#### ecryptfs with system ready to be rebooted
```
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]"
   ]
}   
override_attributes (
  :ecryptfs => {
    :mount => "/var/SecureDir",
    :lower_directory "/var", 
    :reboot => true
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

