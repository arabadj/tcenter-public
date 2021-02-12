#/bin/sh

#===========================================================================================================================
[ -z "$(cat /etc/*release* | grep 'Ubuntu 20.04')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================

sudo sed -i -e 's/us.archive/archive/' /etc/apt/sources.list

#---------------------------------------------------------------------------------------------------------------------------

echo "----> Update"
sudo apt clean
sudo apt update
sudo apt upgrade -y

#---------------------------------------------------------------------------------------------------------------------------

[ -f /var/run/reboot-required ] && echo "Core Updated. Halting..." &&  sudo shutdown -h now 

#===========================================================================================================================

echo "----> Isntall Linux Tools"
sudo apt install -y linux-cloud-tools-generic
sudo apt install -y linux-tools-generic
sudo apt install -y linux-headers-generic
sudo apt install -y dkms

#---------------------------------------------------------------------------------------------------------------------------

echo "----> Install VBoxGuestAdditions"
sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils
# sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

#---------------------------------------------------------------------------------------------------------------------------

echo "----> Install Packages"
sudo apt install -y wget
sudo apt install -y acl
sudo apt install -y bash-completion
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python2
sudo apt install -y python2-pip
sudo apt install -y mc
sudo apt install -y net-tools
sudo apt install -y traceroute
sudo apt install -y telnet
sudo apt install -y psmisc
sudo apt install -y htop
sudo apt install -y nmap
sudo apt install -y mtr
sudo apt install -y tree
sudo apt install -y tcpdump

sudo apt install -y build-essential
sudo apt install -y autoconf automake gdb libffi-dev

echo "----> Install Deployment Tools"
sudo apt install -y ansible 
# sudo apt install -y awscli
# sudo apt install -y azure-cli
sudo pip3 install --upgrade awscli
sudo pip3 install --upgrade azure-cli

echo "----> Install Development Tools"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo pip3 install docker-compose

#===========================================================================================================================

echo "----> Clean"
sudo apt autoremove -y
sudo apt clean

#===========================================================================================================================
