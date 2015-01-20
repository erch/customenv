#! /bin/bash
#  -*- Shell-Script -*-

#set -x
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

export BIN_DIR=${MY_DIR}/../../bin

# need to do that for cheetah
export OS_TYPE=$OSTYPE

# to not be disturb by windows programs
export PATH=$BIN_DIR:/usr/local/bin:/usr/bin:/usr/bin:.:

# install pip
pip -v >/dev/null 2>&1
if [[  ! $? ]]  ; then
    wget -nd -P /tmp https://bootstrap.pypa.io/get-pip.py
    python /tmp/get-pip.py
fi

pip install Cheetah

#get helper functions
. ${BIN_DIR}/echenv-utils.sh

SOURCE_ROOT_DIR=${MY_DIR}/../root
installfromdir ${SOURCE_ROOT_DIR} /
#installfromdir ${MY_DIR}/../tests/source ${MY_DIR}/../tests/dest

#apt-add-repository ppa:jtaylor/keepass
#apt-get update 
#apt-get install keeepass2

