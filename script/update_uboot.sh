#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
sdcard=$1
message "check uboot ...."
if [ ! -f ${OPI_UBOOT_OUTPUT_DIR}/u-boot-sunxi-with-spl.bin  ]
then
	message "u-boot-sunxi-with-spl.bin   not foud !"
	exit 0
fi

if [ -f $sdcard ]
then
	echo "sdcard dev not found!!!"
	exit 0
fi

echo "mount -t vfat $sdcard"1" $OPI_SDCARD_BOOT"
mount -t vfat $sdcard"1" $OPI_SDCARD_BOOT

cd ${OPI_UBOOT_OUTPUT_DIR}

cp boot.scr ${OPI_SDCARD_BOOT}/

cp script.bin ${OPI_SDCARD_BOOT}/

cp u-boot-sunxi-with-spl.bin ${OPI_SDCARD_BOOT}/

dd if=/dev/zero of=$sdcard bs=1k seek=8 count=1015
dd if=u-boot-sunxi-with-spl.bin of=$sdcard bs=1k seek=8
echo ""
echo "^_^"
