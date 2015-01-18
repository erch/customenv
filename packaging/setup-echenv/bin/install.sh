#! /bin/bash
#  -*- Shell-Script -*-

set -x
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

# need to do that for cheetah
export OS_TYPE=$OSTYPE

#get helper functions
. ${MY_DIR}/echenv-utils.sh

SOURCE_ROOT_DIR=${MY_DIR}/../root
installfromdir ${SOURCE_ROOT_DIR} /

#apt-add-repository ppa:jtaylor/keepass
#apt-get update 
#apt-get install keeepass2

