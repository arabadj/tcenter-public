#!/bin/bash

exit 0

#===WARNING=================================================================================================================

# !!! DO NOT RUN THIS BLINDLY !!! 
# !!! THESE ARE HINTS ONLY !!! 

#===Fork====================================================================================================================

# !!! FORK THIS REPO WITH THE SAME NAME !!!

#===Chocolatey==============================================================================================================

# Install Choco
#
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#

#===OpenSSH=================================================================================================================

# Install OpenSSH
#
choco install openssh -y
#

# Refresh Environment
#
$env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
#

# Setup SSH
#
Set-Location "C:\Program Files\OpenSSH-Win64\"
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
Set-Service -Name sshd -StartupType 'Disabled'
Set-Service -Name ssh-agent -StartupType 'Automatic'
Set-Service -Name ssh-agent -Status 'Running'
Set-Location $HOME
#

#===VirtualBox==============================================================================================================

# Install Packages
#
choco install virtualbox -y
#

# Set your "Default Machine Folder" with gui to:
#
VBoxManage.exe setproperty machinefolder "$HOME\VirtualBox"
#

# Set your "VirtualBox Host-Only Ethernet Adapter" IPv4 Address with gui to:
#
VBoxManage.exe hostonlyif ipconfig "VirtualBox Host-Only Ethernet Adapter" --ip 192.168.73.1 --netmask 255.255.255.0
#

#===Packages================================================================================================================

# Change Directory
#
Set-Location $HOME
#

# Install Packages
#
choco install git -y
choco install sysinternals -y --params "/InstallDir:C:\Sysinternals"
#choco install winbox -y
choco install fiddler -y
choco install winmtr-redux -y
choco install nmap -y
choco install wireshark -y
#

# Refresh Environment
#
$env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
#

#===WSL=====================================================================================================================

# Enable WSL
#
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
#

# Change Directory
#
Set-Location $HOME
#

# Set WSL Defaults
#
wsl.exe --set-default-version 1

# Install WSL Distribution
#
Set-Variable PACKAGE_WSL "wslubuntu2004"
#
Invoke-WebRequest -Uri "https://aka.ms/$PACKAGE_WSL" -OutFile ".\$PACKAGE_WSL.zip" -UseBasicParsing
#
Add-AppxPackage ".\$PACKAGE_WSL.zip"
#
Remove-Item ".\$PACKAGE_WSL.appx"
#

# Set Default Distribution
#
wsl.exe --set-default Ubuntu-20.04
#

#===========================================================================================================================
