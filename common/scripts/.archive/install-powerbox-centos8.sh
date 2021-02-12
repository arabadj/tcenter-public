#/bin/sh

#===========================================================================================================================
[ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================

echo "----> Update"
sudo yum clean all
sudo yum update -y

[ ! -z "$(needs-restarting -r | grep 'Reboot is required')" ] && echo "Core Updated. Halting..." &&  sudo shutdown -h now 

#===========================================================================================================================

# echo "----> Install VBoxGuestAdditions"
# export VERSION="6.1.16"
# sudo yum install -y dkms
# sudo yum install -y kernel-devel
# if [ "$(/usr/sbin/VBoxService --version 2> /dev/null | cut -d "r" -f 1)" != "$VERSION" ]; then
#     sudo curl -C - -O http://download.virtualbox.org/virtualbox/$VERSION/VBoxGuestAdditions_$VERSION.iso
#     sudo mkdir /media/VBoxGuestAdditions
#     sudo mount -o loop,ro VBoxGuestAdditions_$VERSION.iso /media/VBoxGuestAdditions
#     sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
#     sudo rm VBoxGuestAdditions_$VERSION.iso
#     sudo umount /media/VBoxGuestAdditions
#     sudo rmdir /media/VBoxGuestAdditions
# fi

#---------------------------------------------------------------------------------------------------------------------------

echo "----> Install Packages"
sudo yum install -y wget
sudo yum install -y vim
sudo yum install -y figlet
sudo yum install -y mc
sudo yum install -y net-tools
sudo yum install -y bind-utils
sudo yum install -y traceroute
sudo yum install -y telnet
sudo yum install -y psmisc
sudo yum install -y tree
sudo yum install -y htop
sudo yum install -y tcpdump
sudo yum install -y nmap
sudo yum install -y mtr

echo "----> Install Development Tools"
sudo yum groups install -y "Development Tools"
sudo yum install -y python3
sudo yum install -y python3-devel
sudo yum install -y python3-pip
sudo yum install -y python2
sudo yum install -y python2-devel
sudo yum install -y python2-pip
sudo yum install -y json
sudo yum install -y jq

echo "----> Install Deployment Tools"
sudo yum install -y ansible 
sudo pip3 install --upgrade awscli
sudo pip3 install --upgrade azure-cli

sudo pip3 install --upgrade jinja2-cli j2cli
sudo pip3 install --upgrade botocore boto boto3
sudo pip2 install --upgrade botocore boto boto3

echo "----> Install Docker"
# sudo yum -y install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
# sudo yum -y install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.2.el7.x86_64.rpm
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo yum install -y docker-ce docker-ce-cli 
sudo yum install -y yum-utils zip unzip
sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce --nobest

sudo pip3 install --upgrade docker-compose

#===========================================================================================================================

echo "----> Clean"
# sudo yum clean all

#===========================================================================================================================
