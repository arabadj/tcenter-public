#/bin/sh

#===========================================================================================================================
[ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================


# sudo yum --enablerepo=epel,powertools group install -y "base-x" "Workstation" "KDE Plasma Workspaces"
sudo yum --enablerepo=epel,powertools group install -y "base-x" "KDE Plasma Workspaces"

# sudo yum install -y gdm
# sudo systemctl enable gdm
# sudo systemctl start gdm

# sudo systemctl set-default multi-user.target
# sudo systemctl set-default graphical.target

if [ ! -f "/etc/yum.repos.d/google-chrome.repo" ]; then
    sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    sudo yum localinstall -y google-chrome-stable_current_x86_64.rpm
    sudo rm -f google-chrome-stable_current_x86_64.rpm
fi

#===========================================================================================================================
