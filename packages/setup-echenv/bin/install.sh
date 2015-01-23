#! /bin/bash
#  -*- Shell-Script -*-

#set -x
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

export BIN_DIR=${MY_DIR}/../../bin

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

. ${BIN_DIR}/osprofile
setOsProfile

installfromdir ${SOURCE_ROOT_DIR} /
#installfromdir ${MY_DIR}/../tests/source ${MY_DIR}/../tests/dest

OLD_HOST_ENV_FILE=~/.hostname.env
export HOST_ENV_FILE=~/.$(hostname).env
if [[ -e ${OLD_HOST_ENV_FILE} ]] ; then
    echo >> ${OLD_HOST_ENV_FILE}
    echo "# helper var for other installers" >> ${OLD_HOST_ENV_FILE}
    echo "HOST_ENV_FILE=${NEW_HOST_ENV_FILE}" >> ${OLD_HOST_ENV_FILE}
    mv ${OLD_HOST_ENV_FILE} ${HOST_ENV_FILE}
fi

${BIN_DIR}/insertfif  ~/.bashrc "ech_env" '#'  ~/bashrc-extension
chmod a+x ~/.bashrc

${BIN_DIR}/insertfif ~/.bash_profile  "ech_env" '#' ~/.bash_profile-extension
chmod a+x ~/.bash_profile

if [[ ${OS_TYPE} = 'cygwin' ]] ; then
    # suppress the sleep line
    ${BIN_DIR}/insertfif ~/.startxwinrc  "sleep" '#'

    ${BIN_DIR}/insertfif ~/.startxwinrc  "ech_env" '#' ~/.startxwinrc-extension
    chmod a+x ~/.startxwinrc
fi

#apt-add-repository ppa:jtaylor/keepass
#apt-get update
#apt-get install keeepass2
