#!/bin/bash
# common script

TTY_X=$(($(stty size | awk '{print $2}'))) # determine terminal width
TTY_Y=$(($(stty size | awk '{print $1}'))) # determine terminal height

message()
{
	echo ">>>  "$*
}
wait_proc() {
	echo $!
if [[ $2 == "" ]] ;then
	str="Please wait some time"
else
	str=$2
fi
echo $str
while kill -0 $1 2>/dev/null
do
	i=0
	b=''
	while [ $i -le  100 ]
	do
	    printf "[%-50s]%d%%  \r" $b $i
	    sleep 0.01
	    i=`expr 2 + $i`       
	    b=">"$b
	done
	
done
if [ $? -eq 0 ]
then	
  printf "OK.   %-50s \r\n" 
else
  printf "ERROR.%-50s \r\n" 
  exit 1
fi
}
# #############
# clear screen
# #############
clear_screen()
{
	printf "\33c"
}


#debian source list
#Debian 8 ("jessie") — current stable release
#Debian 7 ("wheezy") — obsolete stable release
#Debian 6.0 ("squeeze") — obsolete stable release
#Debian GNU/Linux 5.0 ("lenny") — obsolete stable release
#Debian GNU/Linux 4.0 ("etch") — obsolete stable release
#Debian GNU/Linux 3.1 ("sarge") — obsolete stable release
#Debian GNU/Linux 3.0 ("woody") — obsolete stable release
#Debian GNU/Linux 2.2 ("potato") — obsolete stable release
#Debian GNU/Linux 2.1 ("slink") — obsolete stable release
#Debian GNU/Linux 2.0 ("hamm") — obsolete stable release 

#http://ftp2.cn.debian.org/debian/
#http://ftp.cn.debian.org/debian/
#http://debian.bjtu.edu.cn/debian/
#http://mirrors.cug.edu.cn/debian/
#http://mirrors.hust.edu.cn/debian/
#http://mirrors.tuna.tsinghua.edu.cn/debian/
#http://mirrors.ustc.edu.cn/debian/







