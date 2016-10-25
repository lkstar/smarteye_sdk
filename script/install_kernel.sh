#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
sdcard=$1
message "check uIamge ...."
if [ ! -f ${OPI_KERNEL_OUTPUT_DIR}/uImage  ]
then
	message "uImage  not foud !"
	exit 0
fi

if [ -f $sdcard ]
then
	echo "sdcard dev not found!!!"
	exit 0
fi

mount -t vfat $sdcard"1" $OPI_SDCARD_BOOT
mount -t ext4 $sdcard"2" $OPI_SDCARD_ROOT

cd ${OPI_KERNEL_OUTPUT_DIR}

cp uImage		${OPI_SDCARD_BOOT}/
cp config		${OPI_SDCARD_BOOT}/
cp System.map	${OPI_SDCARD_BOOT}/

cp -a ./lib  ${OPI_SDCARD_ROOT}/

echo ""
echo "^_^"
