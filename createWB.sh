#!/bin/sh

SRC="System"
DEST="AmigaOS"
PROGRAMS="Programs"
DATA="Data"
GAMES="Games"
DEMOS="Demos"

# Delete
echo "Removing old..."
rm -rf $SRC
rm $SRC.blkdev
rm $SRC.xdfmeta

rm -rf $DEST
rm $DEST.blkdev
rm $DEST.xdfmeta

rm -rf ./DeluxePaintIII
rm -rf ./DirectoryOpus4
rm -rf ./WHDLoad
rm -rf ./Icons


# Unpack
echo "Unpacking workbench and adf"
xdftool amiga-os-3141-workbench.hdf unpack . fsuae


echo "Partitioning SDA"
#sudo chmod 777 ./WBTest.hdf

rm ./WBTest.hdf

./hst.imager blank ./WBTest.hdf 31268664KB
./hst.imager rdb init ./WBTest.hdf
./hst.imager rdb fs add ./WBTest.hdf  pfs3aio PFS3
./hst.imager rdb fs add ./WBTest.hdf  $SRC/L/FastFileSystem  DOS3

./hst.imager rdb part add ./WBTest.hdf DH0 DOS3 1gb --bootable
./hst.imager rdb part add ./WBTest.hdf DH1 PFS3 4gb
./hst.imager rdb part add ./WBTest.hdf DH2 PFS3 4gb
./hst.imager rdb part add ./WBTest.hdf DH3 PFS3 '*'

./hst.imager rdb part format ./WBTest.hdf 1 AmigaOS
./hst.imager rdb part format ./WBTest.hdf 2 Programs
./hst.imager rdb part format ./WBTest.hdf 3 Data
./hst.imager rdb part format ./WBTest.hdf 4 WHD

xdftool ./WBTest.hdf open part=DH0 + unpack . fsuae

rdbtool ./WBTest.hdf info

# Workbench
echo "RSyncing Workbench"
rsync -rt $SRC/* $DEST/


# ROMS
echo "Copying ROMs"
cp -vp roms/* $DEST/Devs/Kickstarts/



find . -type f -name '*.DS_Store*' -ls -delete


# Show partitions
echo "Packing files into CF"
rdbtool ./WBTest.hdf info

# Pack DH0
echo "Packing Workbench"
xdftool ./WBTest.hdf open part=DH0 + pack $DEST

# Pack DH1
# this doesnt quite work with dopus..
echo "Copying ADFs"
$ ./hst.imager fs copy ADF ./WBTest.hdf/rdb/dh3/ADF

echo "Packing Games"
find WHD/Download/Games -type f -iname "*.lha" -exec sh -c 'dir=$(basename "{}" | cut -c1 | tr "[:lower:]" "[:upper:]"); ./hst.imager fs extract "{}" "././WBTest.hdf/rdb/dh3/Games/$dir"' \;

echo "Packing Demos"
find WHD/Download/Demos -type f -iname "*.lha" -exec sh -c 'dir=$(basename "{}" | cut -c1 | tr "[:lower:]" "[:upper:]"); ./hst.imager fs extract "{}" "././WBTest.hdf/rdb/dh3/Demos/$dir"' \;


echo "Done"
fs-uae
