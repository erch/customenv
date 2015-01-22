#! /bin/bash
#  -*- Shell-Script -*-

#set -x
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

export BIN_DIR=${MY_DIR}/../../bin

. ${BIN_DIR}/osprofile
setOsProfile
# need to do that for cheetah

#get helper functions
. ${BIN_DIR}/echenv-utils.sh

SOURCE_ROOT_DIR=${MY_DIR}/../root
installfromdir ${SOURCE_ROOT_DIR} /

HOST_ENV_FILE=${HOST_ENV_FILE:-${HOME}/.$(hostname).env}
${BIN_DIR}/insertfif  ${HOST_ENV_FILE} ~/host.env "ech_emacs" '#'

${BIN_DIR}/insertfif  ~/.bashrc ~/.bashrc-extension "ech_emacs" '#'
