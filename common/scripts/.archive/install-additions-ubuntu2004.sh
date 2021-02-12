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
#sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

#===========================================================================================================================

echo "----> Clean"
sudo apt autoremove -y
sudo apt clean

#===========================================================================================================================
