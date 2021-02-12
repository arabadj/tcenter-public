#!/bin/bash

#===========================================================================================================================

# cat > /etc/yum.repos.d/ol8-epel.repo <<-EOT
# [ol8_developer_EPEL]
# name=Oracle Linux \$releasever EPEL (\$basearch)
# baseurl=https://yum.oracle.com/repo/OracleLinux/OL8/developer/EPEL/\$basearch/
# gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
# gpgcheck=1
# enabled=1
# EOT

sudo rpm --import http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8
sudo yum install -y https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

#===========================================================================================================================
