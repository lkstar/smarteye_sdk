#!/bin/bash
mount -t proc proc /proc 
ROOTPASS="12345678"
USER="orangepi"
USERPASS="12345678"

set_system(){
echo "set_system..."

#SET hostname
cat > /etc/hostname << _EOF_
OrangePi 
_EOF_

#SET hostname
cat > /etc/motd << _EOF_

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Welcome to use OrangePi !


_EOF_

#cat > /etc/apt/source.list << _EOF_
#deb http://ftp.cn.debian.org/debian/ jessie main contrib non-free
#deb-src http://ftp.cn.debian.org/debian/ jessie main contrib non-free

#deb http://ftp.cn.debian.org/debian/ jessie-updates main contrib non-free
#deb-src http://ftp.cn.debian.org/debian/ jessie-updates main contrib non-free

#deb http://ftp.cn.debian.org/debian/ jessie-backports main contrib non-free
#deb-src http://ftp.cn.debian.org/debian/ jessie-backports main contrib non-free
#_EOF_

echo "/dev/mmcblk0p1  /boot  vfat  defaults  0 0" >> /etc/fstab
echo "tmpfs /tmp  tmpfs nodev,nosuid,mode=1777  0 0" >> /etc/fstab
# ** SET interfaces
mkdir -p /etc/network
cat >> /etc/network/interfaces << _EOF_
# Local loopback
auto lo
iface lo inet loopback

# Wired adapter #1
allow-hotplug eth0
iface eth0 inet dhcp
#	hwaddress ether # if you want to set MAC manually
#	pre-up /sbin/ifconfig eth0 mtu 3838 # setting MTU for DHCP, static just: mtu 3838

# Wireless adapter #1
allow-hotplug wlan0
iface wlan0 inet dhcp
#	wpa-ssid ssid 
#	wpa-psk ********
# to generate proper encrypted key: wpa_passphrase yourSSID yourpassword
_EOF_
# ** SET 8189fs mac address
mkdir -p /etc/modprobe.d
cat > /etc/modprobe.d/8189fs.conf << _EOF_
options 8189fs rtw_initmac=00:e0:4c:88:88:88
_EOF_
# ** SET modules
cat > /etc/modules << _EOF_
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.
## Display and GPU
#ump
#mali
##mali_drm
## WiFi
8189fs
#8192cu
#8188eu
## GPIO
#gpio-sunxi
#w1-sunxi 
#w1-gpio 
#w1-therm 
#gc2035 
#vfe_v4l2 
#sunxi-cir
_EOF_

# ** SET bashrc
cat >> /root/.bashrc << _EOF_
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
_EOF_


# ENABLE SSH ROOT LOOGIN WITH PASSWORD
    if [ -f /etc/ssh/sshd_config ]; then
	cat /etc/ssh/sshd_config | sed s/"PermitRootLogin without-password"/"PermitRootLogin yes"/g > /tmp/sshd_config
	mv /tmp/sshd_config /etc/ssh/sshd_config
    fi
# ENABLE ttyS0 console
systemctl set-default multi-user.target
systemctl enable serial-getty@ttyS0.service
#passwd
echo root:$ROOTPASS | chpasswd

# set default shell to /bin/bash
useradd -m -s "/bin/bash" $USER 
echo $USER:$USERPASS | chpasswd
usermod -c $USER $USER 
adduser $USER sudo 


}

install_software(){

cat > /etc/apt/source.list << _EOF_
deb http://ftp.cn.debian.org/debian/ jessie main
_EOF_
echo "apt-get update..."
apt-get update
echo "Installing base packages..."
apt-get install -y sudo ntp vim man-db dbus bash-completion openssh-server net-tools wpasupplicant build-essential lsb libncurses5-dev
echo ""
echo "Installing more packages..."
apt-get install -y dosfstools console-setup ifupdown iproute ethtool iw lshw usbutils keyboard-configuration

}
install_software
set_system
umount -t proc proc /proc
rm -rf /init.sh
exit 0
