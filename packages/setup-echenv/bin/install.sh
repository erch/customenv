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
if [[ $? -ne 0 ]]  ; then
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

# should not be here : .ssh configuration
${BIN_DIR}/insertfif ~/.ssh/config  "ech_env" '#' ~/.ssh/config-extension

# chocolatey config to be move to a specific package
if [[ ${OS_TYPE} = 'cygwin' ]] ; then
    CHOCO="/c/ProgramData/chocolatey/bin/choco"
    $CHOCO feature > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
	"/c/WINDOWS/system32/WindowsPowerShell/v1.0/powershell" -NoProfile -ExecutionPolicy unrestricted -Command "& {iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))}"
    else
	echo '\n' | $CHOCO upgrade -y chocolatey
    fi
    # not used anymore , kept as reminders
    # CURPATH=`regtool get '/machine/SYSTEM/CurrentControlSet/Control/Session Manager/Environment/Path'`
    # SETX="/cygdrive/c/Windows/system32/setx"
    export PATH=$PATH:$ChocolateyInstall
fi

## java config , will be moved to java packaging
# install java and maven (cygwin only for now)
if [[ ${OS_TYPE} = 'cygwin' ]] ; then
    echo '\n' | $CHOCO install -y jdk8
    echo '\n' | $CHOCO install -y maven

    # Chocolatey set the following environment variables: JAVA_HOME, M2_HOME, we need to add JAVA_OPTS and MAVEN_OPTS
    OPTS="-Duser.home=$(cygpath -wa $HOME) -Xmx1024M -XX:MaxPermSize=512m"
    /cygdrive/c/Windows/system32/setx JAVA_OPTS "$OPTS"
    /cygdrive/c/Windows/system32/setx MAVEN_OPTS "$OPTS"
fi

#apt-add-repository ppa:jtaylor/keepass
#apt-get update
#apt-get install keeepass2
