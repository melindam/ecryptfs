ecryptfs Cookbook
====================
Ecryptfs cookbook for encrypting a file system RHEL/CentOS only 


Requirements
------------
Cookbook requirements needs a file system directory name to mount. Future enhancements could be for other
options to be specified like ecryptfs_key_bytes other than default 16

e.g.
#### packages
- `ecryptfs-utils` - ecryptfs needs this package installed for RHEL

Attributes
----------
[:ecyptfs][:mount_point]File system name which is encrypted 

e.g.
#### ecryptfs::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
   <tr>
    <th>Mount Point</th>
    <th>String</th>
    <th>File system mount point, can be off of system directory, or a new directory</th>
    <th>Default</th>
  </tr>
</table>


Usage
-----
#### ecryptfs::default

e.g.
Just include `ecryptfs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs]"
  ]
}
```

#### ecryptfs::reboot
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ecryptfs::reboot]"
   ]
}
```

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Melinda Moran 
