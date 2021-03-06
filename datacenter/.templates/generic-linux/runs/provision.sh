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

vagrant provision --provision-with bootstrap
vagrant provision --provision-with firewall
vagrant provision --provision-with usrstrap
vagrant provision --provision-with localstrap
vagrant provision --provision-with homestrap

#===========================================================================================================================
