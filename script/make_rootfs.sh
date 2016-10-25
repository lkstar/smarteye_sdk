#!/bin/bash
source $PWD/script/orangepi.conf
source $PWD/script/common.sh
HOSTNAME="orangepi"
rootfs=$1
system=$2
version=$3
mirror=

	# $1 debian ubuntu  $2 version
if  [[ $2 == "debian" ]] ; then
	case  "$3"  in   
 	  jessie ) 
		mirror="http://ftp.cn.debian.org/debian/"		
		;;
  	   wheezy ) 
		mirror="http://ftp.cn.debian.org/debian/"				
		;;
	esac
elif [[ $2 == "ubuntu" ]] ; then
	case  "$3"  in
	  xenial )
		mirror=	
		;;
     vivid ) 
		mirror=	
		;;
	trusty ) 
		mirror=
		;;
	esac
fi

message "check installed software ....."
soft=`dpkg -l debootstrap`
if [ ! $? -eq 0 ]
then
	message "not found debootstrap!!!!"
	apt-get install -y -q binfmt-support qemu qemu-user-static debootstrap
else
    echo ""
fi
message " entry root file system dir " && cd $rootfs
echo ""

#debootstrap
message " run debootstrap...."
debootstrap --foreign --arch armhf $version $rootfs $mirror
echo ""
cp /usr/bin/qemu-arm-static $rootfs/usr/bin
cp $rootfs/../../script/make_rootfs_last_stage.sh  $rootfs/init.sh 
chmod 755 $rootfs/init.sh 

#set qemu
export LC_ALL=C 
export LANGUAGE=C 
export LANG=C
export DEBCONF_NONINTERACTIVE_SEEN=true 
export DEBIAN_FRONTEND=noninteractive

#debootstrap second-stage
chroot $rootfs  /debootstrap/debootstrap --second-stage
echo ""

chroot $rootfs  /init.sh	
cat >> $rootfs/OrangePi << _EOF_
system : $system
version : $version 
mirror : $mirror
_EOF_
echo ""
message "make rootfs finish,Please to see $rootfs directories" 
echo "^_^"
#https://wiki.debian.org/EmDebian/CrossDebootstrap

