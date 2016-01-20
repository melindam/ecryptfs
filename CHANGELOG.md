ecryptfs CHANGELOG
======================

This file is used to list changes made in each version of the jmh-ecryptfs cookbook.

0.1.4
- [Scott Marshall] - updates to conditional work flow
- [Scott Marshall] - removed `[first_mount]`
- [Scott Marshall] - rubocop and food critic run

0.1.3
- [Melinda Moran] - changed logic to keep /root/.ecryptfsrc file - but excludes the passphrase in it.

0.1.2 
- [Melinda Moran] - Mistaken brackets in .ecryptfsrc file would not allow for reboot mount with correct passphrase, including fnek signature.

0.1.1
- [Melinda Moran] - Clean up logic to use node variable [:ecryptfs][:reboot_enabled] when want to manually reboot system
    and have file system auto mount
0.1.0
-----
- [Melinda Moran] - Initial release of ecryptfs



- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
