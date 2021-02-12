#/bin/sh

#===========================================================================================================================
[ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================

echo "----> Update"
sudo yum clean all
sudo yum update -y

[ ! -z "$(needs-restarting -r | grep 'Reboot is required')" ] && echo "Core Updated. Halting..." &&  sudo shutdown -h now 

#===========================================================================================================================

echo "----> Install VBoxGuestAdditions"
export VERSION="6.1.16"
sudo yum install -y dkms
sudo yum install -y kernel-devel
if [ "$(/usr/sbin/VBoxService --version 2> /dev/null | cut -d "r" -f 1)" != "$VERSION" ]; then
    sudo curl -C - -O http://download.virtualbox.org/virtualbox/$VERSION/VBoxGuestAdditions_$VERSION.iso
    sudo mkdir /media/VBoxGuestAdditions
    sudo mount -o loop,ro VBoxGuestAdditions_$VERSION.iso /media/VBoxGuestAdditions
    sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
    sudo rm VBoxGuestAdditions_$VERSION.iso
    sudo umount /media/VBoxGuestAdditions
    sudo rmdir /media/VBoxGuestAdditions
fi

#===========================================================================================================================
