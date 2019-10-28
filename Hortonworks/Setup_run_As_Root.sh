
yum update -y
sleep 10
systemctl set-default multi-user.target
sudo systemctl get-default
sleep 10
echo "vm.swappiness = 10" >> /etc/sysctl.conf
echo "HOSTNAME=master1.hadoop.com" >> /etc/sysconfig/network
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag " >> /etc/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled " >> /etc/rc.local
echo umask 0022 >> /etc/profile
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
grep "SELINUX" /etc/selinux/config
echo "============================================================================================"
sleep 10

yum install wget ntp firewalld  -y

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