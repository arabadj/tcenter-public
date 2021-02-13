#!/bin/bash

#===========================================================================================================================
while [ -z "$GLOBAL_ROOT" ]; do
    [ -f ./global.env ] && export GLOBAL_ROOT=$(pwd) && source ./global.env
    [ "$(pwd)" == "/" ] && echo "Unknown \$GLOBAL_ROOT, terminating..." && exit 0; cd ..; done
for FUNCTION in $(cat $GLOBAL_ROOT/global.env | grep "^function" | awk '{print $2}'); do 
    export -f $FUNCTION; done
#===========================================================================================================================

if [ -z "$(echo $GLOBAL_ROOT | grep tcenter)" ]; then echo "Wrong directory, terminating..."; exit 0; fi

#===========================================================================================================================

cd $GLOBAL_ROOT

#---------------------------------------------------------------------------------------------------------------------------

git config --unset core.filemode
git config --unset core.autocrlf
git config --unset core.ignorecase

#---------------------------------------------------------------------------------------------------------------------------

find "$GLOBAL_ROOT/" -type d -exec chmod 0755 {} \;
find "$GLOBAL_ROOT/" -type f -exec chmod 0644 {} \;
find "$GLOBAL_ROOT/" -type f -name '*.sh' -exec chmod 0755 {} \;

chmod +x $GLOBAL_ROOT/tcenter

#===========================================================================================================================
