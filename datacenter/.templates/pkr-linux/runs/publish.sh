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

function image_publish () {

  export PACKER_BUILD_SOURCE="$VAGRANT_DISTRO_PROVIDER/$VAGRANT_DISTRO_NAME"
  export PACKER_DISTRO_NAME="$VAGRANT_DISTRO_NAME$DASH$PACKER_BUILD_SUFFIX"
  export PACKER_BUILD_NAME="$VAGRANT_DEPLOYER/$PACKER_DISTRO_NAME"
  export PACKER_BUILD_OUTPUT="$PACKER_BUILD_PATH/output/$PACKER_DISTRO_NAME/$PACKER_BUILD_VERSION"
  export PACKER_BUILD_BOX="$PACKER_BUILD_OUTPUT/package.box"

  export PACKER_BUILD_BOX_SIZE="$(ls -lah $PACKER_BUILD_BOX | awk '{print $5}')"
  export PACKER_BUILD_BOX_MD5="$(md5sum $PACKER_BUILD_BOX | awk '{print $1}')"

  echo ""
  echo " Box Name:     $PACKER_BUILD_NAME"
  echo " Box Version:  $PACKER_BUILD_VERSION"
  echo " Box Size:     $PACKER_BUILD_BOX_SIZE"
  echo " Box Checksum: $PACKER_BUILD_BOX_MD5"
  echo ""

  vagrant cloud publish --force --release --checksum-type md5 --checksum $PACKER_BUILD_BOX_MD5 \
      $PACKER_BUILD_NAME $PACKER_BUILD_VERSION virtualbox $PACKER_BUILD_BOX

}

#===========================================================================================================================

vagrant cloud auth login
vagrant cloud auth whoami

if [ ! -z "$VAGRANT_DISTRO_CENTOS" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_CENTOS"
  image_publish $VAGRANT_DISTRO_NAME
fi

if [ ! -z "$VAGRANT_DISTRO_ORACLE" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_ORACLE"
  image_publish $VAGRANT_DISTRO_NAME
fi

if [ ! -z "$VAGRANT_DISTRO_UBUNTU" ]; then
  VAGRANT_DISTRO_NAME="$VAGRANT_DISTRO_UBUNTU"
  image_publish $VAGRANT_DISTRO_NAME
fi

#===========================================================================================================================
