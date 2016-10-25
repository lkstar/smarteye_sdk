#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
message "check uboot soucre ...."
if [ ! -d ${OPI_U_source} ]
then
	message "soucre not foud !"
	exit 0
fi

message "entry u-boot source dir " && cd ${OPI_U_source}

if [ ! -f .config ]
then 
	message "clear   u-boot " && make distclean
	message "config  u-boot " && make ${OPI_U_config}
fi

#configuboot
message "config u-boot" && make menuconfig
echo ""
message "config u-boot finish,Please run 'make uboot'" 
echo "^_^"

