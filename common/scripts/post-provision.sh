#!/bin/bash

#===========================================================================================================================

# function get_repository () {
#     [ ! -d $REPO_BASE/$REPO_NAME ] && git -C $REPO_BASE clone git@github.com:arabadj/$REPO_NAME.git
#     [ -d $REPO_BASE/$REPO_NAME ] && git -C $REPO_BASE/$REPO_NAME pull 
# }

#---------------------------------------------------------------------------------------------------------------------------

# export REPO_BASE="$HOME/.local"     && mkdir -p $REPO_BASE
# export REPO_NAME="gbin"             && get_repository

#===========================================================================================================================

gpg --import ~/.gnupg/gpg_arabadj.key
for fpr in $(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}' | sort -u); do  
        echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key $fpr trust
done
gpg --list-secret-keys

#===========================================================================================================================
