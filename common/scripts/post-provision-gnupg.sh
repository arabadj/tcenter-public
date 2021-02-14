#!/bin/bash

#===========================================================================================================================

gpg --import ~/.gnupg/gpg_arabadj.key
for fpr in $(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}' | sort -u); do  
        echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key $fpr trust
done
gpg --list-secret-keys

#===========================================================================================================================
