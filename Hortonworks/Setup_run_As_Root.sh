# !/bin/bash
if [ $(id -u) -eq 0 ]; then echo " "; else  echo "Please run as root" ; exit 1 ; fi

yum update -y
if [ $? -gt 0 ] ; then echo "There is an error update ...."; fi
sleep 10
systemctl set-default multi-user.target
if [ $? -gt 0 ] ; then echo "There is an error in systemctl multi-user.target ...."; fi

sudo systemctl get-default
sleep 10
echo "vm.swappiness = 10" >> /etc/sysctl.conf
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag " >> /etc/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled " >> /etc/rc.local
echo umask 0022 >> /etc/profile
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
grep "SELINUX" /etc/selinux/config
echo "============================================================================================"
sleep 10

yum install wget ntp firewalld  -y
if [ $? -gt 0 ] ; then echo "There is an error in installing wget ntp firewalld  ...."; fi
systemctl enable ntpd
systemctl start  ntpd
systemctl status  ntpd

systemctl enable firewalld
systemctl status firewalld
systemctl disable firewalld
systemctl status firewalld
systemctl status  ntpd
echo "============================================================================================"
hostnamectl status
sleep 10
cd /etc/yum.repos.d
wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.7.3.0/ambari.repo