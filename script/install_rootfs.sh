#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
sdcard=$1
message "check rootfs ...."
if [ ! -d ${OPI_SYSTEM_OUTPUT_DIR}/bin  ]
then
	message "not foud rootfs !"
	exit 0
fi

if [ -f $sdcard ]
then
	echo "sdcard dev not found!!!"
	exit 0
fi
mount -t ext4 $sdcard"2" $OPI_SDCARD_ROOT

cd ${OPI_WORK_DIR}
echo "cp -a  ${OPI_SYSTEM_OUTPUT_DIR}/*  ${OPI_SDCARD_ROOT}/"
cp -a  ${OPI_SYSTEM_OUTPUT_DIR}/*  ${OPI_SDCARD_ROOT}/

echo ""
echo "^_^"
