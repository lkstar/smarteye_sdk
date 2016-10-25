#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
message "check kernel soucre ...."
if [ ! -d ${OPI_K_source} ]
then
	message "soucre not foud !"
	exit 0
fi

message "entry kernel source dir " && cd ${OPI_K_source}

if [ ! -f .config ]
then 
	message "clear   kernel " && make distclean
	message "config  kernel " && make ${OPI_K_config}
fi

##build kernel
message "config kernel..." && make menuconfig
echo ""
message "config kernel finish,Please run 'make kernel'" 
echo "^_^"

