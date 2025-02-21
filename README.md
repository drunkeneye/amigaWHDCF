# Amiga WHD CF Creator

This is a small Linux script to create an compact flash image that can be directly
used with an Amiga 1200.

**Prerequisite**: You must create a bootable Amiga Harddisk using FS-UAE or
similar. I think i followed https://wordpress.hertell.nu/?p=859. A PDF copy
of this webpage is located in this repo too.

Assume that the Amiga Workbench Harddisk is in ./amiga-os-3141-workbench.hdf
You then need xdftool and rdbtool. Both can be installed under Linux easily,
from amitools, see
https://github.com/cnvogelg/amitools/

finally, you need pdf3aio (binary is in this repo) and hst.images (binary is
also here). the sources can be found in ./zips

After that put all your ADFs you want to have in ./ADF
Then copy WHD into WHD, e.g. WHD/Download/Games etc.

The script will then extract all LHA in ./WHD/Download/Games etc.
and copy them over to the harddisk.

*Disclaimer*:
Yes, there are possibly easier ways to get this steps done and also some
WHD-Tool that can access everything online. But this script works for me.
Since I had a hard time to put together a CF image that just boots,
i wanted to share this, just in case someones wants to have the same thing.
