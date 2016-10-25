#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
sdcard=$1
create=1
if [ "$(id -u)" != "0" ]; then
   echo "Script must be run as root !"
   exit 0
fi

if [  "$(fdisk -l $sdcard)" == "" ]
then
	echo "sdcard dev not found!!!"
	exit 0
fi
boot_size=${OPI_SDCARD_BOOT_SIZE}
boot_start=${OPI_SDCARD_BOOT_START}
sdcard_sectors=`fdisk -l $sdcard | grep "Disk $sdcard" | awk '{print $7}'`
sdcard_bytes=`fdisk -l $sdcard | grep "Disk $sdcard" | awk '{print $5}'`
sdcard_block=$(expr $sdcard_bytes / $sdcard_sectors )
block_size=$(expr 1024 \* 1024 / $sdcard_block )
sdcard_size=$(expr $sdcard_bytes / 1024 / 1024 )
root_size=$(expr  $sdcard_size - $boot_size - $(expr $boot_start / $block_size ) )
boot_end=$(expr $boot_start + $(expr $boot_size \* $block_size ) - 1)
root_start=$(expr $boot_end + 1)
root_end=$(expr $(expr $root_size \* $block_size ) + $root_start - 1 )


echo ""
echo " sdcard dev :   $sdcard"
echo " sdcard total size   :  $sdcard_size	M"
echo " boot partition size :  $boot_size	M"
echo " root partition size :  $root_size	M"
echo " boot start : $boot_start"
echo " boot end   : $boot_end"
echo " root start : $root_start"
echo " root end   : $root_end"
echo ""



read -p "Will clear the SD card data, whether or not to continue ?[y/n]"  continue
if [ "$continue" == "y" ];then
	mount_dev=`mount | grep $sdcard | awk '{print $3}'`
	umount -f $mount_dev
	echo ""
	echo -e "d\n\nd\n\nd\n\nd\n\nw\n" | fdisk $sdcard > /dev/null 
	#echo " dd sdcard........"
	#dd if=/dev/zero of=$sdcard  count=1

	echo "fdisk sdcard..........."
	echo -e "n\np\n1\n${boot_start}\n${boot_end}\nt\nb\nw\n" | fdisk $sdcard 
	echo -e "n\np\n2\n${root_start}\n${root_end}\nw\n" | fdisk $sdcard  
	fdisk -l $sdcard
	echo ""

	check_boot=`fdisk -l $sdcard | grep $sdcard"1" | awk '{print $2}'`
	check_root=`fdisk -l $sdcard | grep $sdcard"2" | awk '{print $2}'`

	if [[ $check_boot == $boot_start  && $check_root == $root_start ]];then
		echo "mkfs image............"
		mkfs.vfat $sdcard"1"
		dosfslabel $sdcard"1" "BOOT"
		mkfs.ext4 $sdcard"2"
		e2label $sdcard"2" "ROOTFS"
		echo ""
	fi
else 
	echo "exit"
	exit 0
fi


#mount partition
mkdir -p $OPI_SDCARD_BOOT $OPI_SDCARD_ROOT

echo "mount -t vfat $sdcard"1" $OPI_SDCARD_BOOT"
mount -t vfat $sdcard"1" $OPI_SDCARD_BOOT

echo "mount -t ext4 $sdcard"2" $OPI_SDCARD_ROOT"
mount -t ext4 $sdcard"2" $OPI_SDCARD_ROOT

#read -p "Enter any key, close to mount :"
#fuser -ck $OPI_SDCARD_BOOT
#fuser -ck $OPI_SDCARD_ROOT
#umount -f $OPI_SDCARD_BOOT
#umount -f $OPI_SDCARD_ROOT
#echo "umount :$OPI_SDCARD_BOOT"
#echo "umount :$OPI_SDCARD_ROOT"

echo ""
echo "^_^"
