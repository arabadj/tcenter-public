#!/bin/bash

exit 0

#===WARNING=================================================================================================================

# !!! DO NOT RUN THIS BLINDLY !!! 
# !!! THESE ARE HINTS ONLY !!! 

#===Fork====================================================================================================================

# !!! FORK THIS REPO WITH THE SAME NAME !!!

#===Files===================================================================================================================

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#

#===WSL=====================================================================================================================

# Enable SUDO with NOPASSWD 
#
sudo vi /etc/sudoers
# Edit Lines:
#
# %sudo   ALL=(ALL:ALL) NOPASSWD: ALL
#

# Configure WSL Options:
#
sudo su -

cat > /etc/wsl.conf <<-EOT
[automount]
enabled = true
options = "metadata,umask=22,fmask=11"
mountFsTab = false

[network]
generateHosts = true
generateResolvConf = true
EOT
exit
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#---------------------------------------------------------------------------------------------------------------------------

# Update and Install Prerequisites
#
sudo apt update
sudo apt upgrade -y
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#---------------------------------------------------------------------------------------------------------------------------

# !!! SKIP SECTION IF HAVE ARTIFACTS !!!

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#

# Create Artifact Directories
#
mkdir -p $ARTIFACTS/home
mkdir -p $ARTIFACTS/home/user/.ssh
#

# Create Encrypted User SSH Key (!!! IF DO NOT HAVE !!!)
#
ssh-keygen -t rsa -b 2048 -f $ARTIFACTS/home/user/.ssh/id_rsa_$USER_WSL -C "$USER_WSL@company.com"
#
mv $ARTIFACTS/home/user/.ssh/id_rsa_$USER_WSL $ARTIFACTS/home/user/.ssh/id_rsa_$USER_WSL.key
#

# Create Decrypted Vagrant SSH Key (!!! IF DO NOT HAVE !!!)
#
ssh-keygen -t rsa -b 2048 -f $ARTIFACTS/home/user/.ssh/id_rsa_vagrant -C "$USER_WSL@company.com"
#
mv $ARTIFACTS/home/user/.ssh/id_rsa_vagrant $ARTIFACTS/home/user/.ssh/id_rsa_vagrant.key
#

#---------------------------------------------------------------------------------------------------------------------------

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#

# Configure SSH Client
#
mkdir -p $HOME_WSL/.ssh && chmod 700 $HOME_WSL/.ssh
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.pub $HOME_WSL/.ssh/ && chmod 644 $HOME_WSL/.ssh/id_rsa_*.pub
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.key $HOME_WSL/.ssh/ && chmod 600 $HOME_WSL/.ssh/id_rsa_*.key
cat $HOME_WSL/.ssh/id_rsa_$USER_WSL.pub > $HOME_WSL/.ssh/authorized_keys
#

# Configure SSH Server
#
sudo vi /etc/ssh/sshd_config
#
# Edit and uncomment line:
#
# Port 2233
#

# Enable SSH Server
#
sudo ssh-keygen -A
sudo service ssh --full-restart
#

# Modify Bashrc
#
echo "# Add Paths" >> $HOME/.bashrc
echo "export PATH=\"\$HOME/.local/gbin:\$PATH\"" >> $HOME/.bashrc
echo "" >> $HOME/.bashrc
echo "# Modify Prompt" >> $HOME/.bashrc
echo "export PS1='\[\033[01;32m\]\u@\$WSL_DISTRO_NAME:\[\033[34m\]\w\$\[\033[00m\] '" >> $HOME/.bashrc
echo "" >> $HOME/.bashrc
#

# Install SSH Keys loader
#
mkdir -p $HOME_WSL/.local/gbin
wget -P $HOME_WSL/.local/gbin/ https://raw.githubusercontent.com/arabadj/public-scripts/main/ssh-load-linux
wget -P $HOME_WSL/.local/gbin/ https://raw.githubusercontent.com/arabadj/public-scripts/main/ssh-load-windows
chmod +x $HOME_WSL/.local/gbin/ssh-load-*
#
$HOME_WSL/.local/gbin/ssh-load-linux install
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#===Git=====================================================================================================================

# !!! SKIP SECTION IF HAVE REPO LOCALY !!!

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#
# Load SSH Keys
#
ssh-load-linux
#

# Clone Repo
#
mkdir -p $HOME_WIN/tcenter
rm -rf $HOME_WIN/tcenter/tcenter-$DEPLOYMENT
#
git -C $HOME_WIN/tcenter clone https://github.com/$USER_GIT/tcenter-$DEPLOYMENT.git
#

# Fix Repo
#
cd $HOME_WIN/tcenter/tcenter-$DEPLOYMENT/
#
./fixrepo.sh
#

#===Ansible=================================================================================================================

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#
# Load SSH Keys
#
ssh-load-linux
#

# Install ANSIBLE
#
sudo apt install -y ansible
#

#===Configure-Localhost=====================================================================================================

# Export Variables
#
export DEPLOYMENT="public"
export USER_GIT="$USER"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$DEPLOYMENT"
#
# Load SSH Keys
#
ssh-load-linux
#

# Fake Artifacts
#
$HOME_WIN/tcenter/tcenter-$DEPLOYMENT/tcenter Artifacts localhost
#

# Configure WSL
#
$HOME_WIN/tcenter/tcenter-$DEPLOYMENT/tcenter provision localhost
#

# Configure Windows
#
$HOME_WIN/tcenter/tcenter-$DEPLOYMENT/tcenter winstrap localhost
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#===Tcenter=================================================================================================================

# Load SSH Keys
#
ssh-load-linux
#

# Run Tcenter
#
tcenter-public
#

#===========================================================================================================================
