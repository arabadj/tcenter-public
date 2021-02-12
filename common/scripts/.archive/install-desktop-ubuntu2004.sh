#/bin/sh

#===========================================================================================================================
# [ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================

# sudo apt clean
sudo apt update
sudo apt upgrade -y 

sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

sudo apt install -y gdm3
sudo apt install -y ubuntu-desktop
# sudo apt install -y kde-full
sudo apt install -y kde-plasma-desktop

if [ ! -f "/usr/bin/google-chrome" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt --fix-broken install ./google-chrome-stable_current_amd64.deb
    rm -f google-chrome-stable_current_amd64.deb
fi

sudo apt install -y xrdp 
sudo systemctl enable xrdp
sudo adduser xrdp ssl-cert
sudo systemctl restart xrdp
# echo "startplasma-x11"  > ~/.xsession

#===========================================================================================================================
