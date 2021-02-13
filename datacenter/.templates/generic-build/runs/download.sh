#!/bin/bash

#===========================================================================================================================
CWD=$(pwd); BASE=$(dirname $0); cd $BASE
while [ -z "$LOCAL_ROOT" ]; do
    [ -f ./local.env ] && export LOCAL_ROOT=$(pwd) && source ./local.env
    [ "$(pwd)" == "/" ] && echo "Unknown \$LOCAL_ROOT, terminating..." && exit 0; cd ..; done; cd $CWD
for FUNCTION in $(cat $LOCAL_ROOT/local.env | grep "^function" | awk '{print $2}'); do 
    export -f $FUNCTION; done
#===========================================================================================================================
cd $LOCAL_ROOT
#===========================================================================================================================
set -e
#===========================================================================================================================

function image_download () {

  export PACKER_BUILD_SOURCE="$VAGRANT_DISTRO_PROVIDER/$VAGRANT_DISTRO_NAME"
  export PACKER_DISTRO_NAME="$VAGRANT_DISTRO_NAME$DASH$PACKER_BUILD_SUFFIX"
  export PACKER_BUILD_NAME="$VAGRANT_DEPLOYER/$PACKER_DISTRO_NAME"
  export PACKER_BUILD_OUTPUT="$PACKER_BUILD_PATH/output/$PACKER_DISTRO_NAME/$PACKER_BUILD_VERSION"
  export PACKER_BUILD_BOX="$PACKER_BUILD_OUTPUT/package.box"

  vagrant box add --force $PACKER_BUILD_NAME --box-version $PACKER_BUILD_VERSION --provider virtualbox

}

#===========================================================================================================================

if [ ! -z "$VAGRANT_DISTRO_CENTOS" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_CENTOS"
  image_download $VAGRANT_DISTRO_NAME
fi

if [ ! -z "$VAGRANT_DISTRO_ORACLE" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_ORACLE"
  image_download $VAGRANT_DISTRO_NAME
fi

if [ ! -z "$VAGRANT_DISTRO_UBUNTU" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_UBUNTU"
  image_download $VAGRANT_DISTRO_NAME
fi

#===========================================================================================================================
