#!/bin/bash

export VERSION="6.1.14"

sudo curl -C - -O http://download.virtualbox.org/virtualbox/$VERSION/VBoxGuestAdditions_$VERSION.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_$VERSION.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
sudo rm VBoxGuestAdditions_$VERSION.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
