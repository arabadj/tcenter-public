#!/bin/bash

#===========================================================================================================================

function get_repository () {
    [ ! -d $REPO_BASE/$REPO_NAME ] && git -C $REPO_BASE clone git@github.com:arabadj/$REPO_NAME.git
    [ -d $REPO_BASE/$REPO_NAME ] && git -C $REPO_BASE/$REPO_NAME pull 
}

#---------------------------------------------------------------------------------------------------------------------------

export REPO_BASE="$HOME/work/cloud"     && mkdir -p $REPO_BASE
export REPO_NAME="arabadj-aws"          && get_repository
export REPO_NAME="arabadj-tfstate-aws"  && get_repository
export REPO_NAME="aws-arabadj"          && get_repository
export REPO_NAME="docker-devel"         && get_repository
export REPO_NAME="docker-hub"           && get_repository
export REPO_NAME="public-scripts"       && get_repository

#===========================================================================================================================
