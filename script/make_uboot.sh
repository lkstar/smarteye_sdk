#!/bin/bash
source $OPI_WORK_DIR/script/common.sh
message "check uboot soucre ...."
if [ ! -d $OPI_U_source ]
then
	message "soucre not foud !"
	exit 0
fi

message "entry u-boot source dir " && cd $OPI_U_source

if [ ! -f .config ]
then 
	message "clear   u-boot " && make distclean
	message "config  u-boot " && make $OPI_U_config
fi

#build uboot
date
message "build u-boot , Please wait some time." && make -j8
date
if [ -f u-boot-sunxi-with-spl.bin  ]; then
	# Copy u-boot-sunxi-with-spl.bin to output
    cp u-boot-sunxi-with-spl.bin  $OPI_UBOOT_OUTPUT_DIR 
	cp arch/arm/dts/*sun8i-h3*  $OPI_DTB_OUTPUT_DIR	
fi 
echo ""


message "build u-boot boot.scr" && rm $OPI_UBOOT_OUTPUT_DIR/boot.scr
mkimage -C none -A arm -T script -d $OPI_source/u-boot-script/orangepi.cmd $OPI_UBOOT_OUTPUT_DIR/boot.scr 


message "build sunxi script.bin" && rm $OPI_UBOOT_OUTPUT_DIR/script.bin
fex2bin $OPI_source/sunxi-script/orangepi.fex  $OPI_UBOOT_OUTPUT_DIR/script.bin

echo ""
echo ""
message "build u-boot finish,Please to see $OPI_UBOOT_OUTPUT_DIR directories" 
echo "^_^"
