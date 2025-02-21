# Amiga WHD CF Creator

A simple Linux script to create a Compact Flash image that can be directly used with an Amiga 1200.

## Steps

1. **Create a Bootable Amiga Hard Disk:**  
   Use FS-UAE or a similar emulator to create a bootable Amiga hard disk. I followed [this guide by John "Chucky" Hertell](https://wordpress.hertell.nu/?p=859) (a PDF copy is included in this repo).

2. **Assumed Workbench Image Location:**  
   Place your Amiga Workbench hard disk image at:  
   `./amiga-os-3141-workbench.hdf`. Or change the name in the script

3. **Required Tools:**  
   - **xdftool** and **rdbtool** from [amitools](https://github.com/cnvogelg/amitools/) (easily installable on Linux).  
   - **pdf3aio** and **hst.images** binaries (included in this repo, with sources in `./zips`).

4. **Game and Software Files:**  
   - Place all your ADF files in the `./ADF` directory.  
   - Copy WHDLoad packages into `./WHD`, e.g., `./WHD/Download/Games/`.

5. **Adapt the script executable:**  
   Edit `./createWB.sh` as you see fit, e.g., change the CF card size (see below).

6. **Make the script executable:**  
   `chmod +x ./createWB.sh`

7. **Start script:**  
   Start the script by running:  
   `./createWB.sh`
   *(This will take a long time due to `.lha` extraction)*

8. **Copy the image to your CF card:**  
   Use dd to copy the image to your CF card. For example, if your CF card is at `/dev/sda`, run:  
   `sudo dd if=./WBTest.hdf of=/dev/sda bs=1M status=progress`

**⚠️ CRITICAL WARNING:** **Ensure you specify the correct `/dev/sdX` for your CF card. Using the wrong device path (e.g., your main hard drive) will result in **irreversible data loss** and could render your system unbootable. Double-check before executing the command!**



# Script

This script will perform the following tasks:

- Create a new blank HDF image at `./WBTest.hdf`.  
- Partition the image as follows:  
  - 1 GB boot partition.  
  - Two 4 GB partitions for Programs and Data.  
  - The remaining space (~32 GB CF) allocated to the WHD/ADF partition.  
- Copy all ADF files to the HDF image.  
- Extract all `.lha` archives from:  
  - `./WHD/Download/Games/`  
  - `./WHD/Download/Demos/`  
  into the WHD partition.



## IMPORTANT

This script assumes a CF Flash card with an exact size of 31,268,664 KB.

If your CF card has a different size, you must adjust the script accordingly.

### How to Find the Exact CF Size:

1. Run the following command to check your disk size:  
   `fdisk /dev/sdX`  
   Replace `/dev/sdX` with your actual device identifier.

2. Look for output similar to:  
   `Disk /dev/sdX: 29.82 GiB, 32019111936 bytes, 62537328 sectors`

3. Calculate the size in KB:  
   Divide the number of bytes by 1024.  
   For example:  
   `32019111936 / 1024 = 31268664`

Make sure to update the script with this exact value for accurate partitioning.



 
## Disclaimer

There may be simpler methods or WHD-Tools that handle everything online. However, this script works for me. Since I struggled to assemble a CF image that boots properly, I’m sharing this in case someone else finds it useful.


## LICENSE

This script is licensed under the MIT License (see the LICENSE file for details).

**⚠️ DISCLAIMER:** This script is provided "as is", without any warranty of any kind. Use it at your own risk. The authors are not responsible for any damage or data loss resulting from its use.


