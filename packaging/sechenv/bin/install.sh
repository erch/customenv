#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`





T_USER=ech
ENV_GROUP=ech

ROOT_DIR=${MY_DIR}/../debian
CACHE_DIR={ROOT_DIR}/var/cache/echenv-setup

. ${ROOT_DIR}/usr/local/sbin/echenv-utils.sh

addtoprofiled /home/${T_USER} ${CACHE_DIR}/profiled/*.sh

SHORT_HOSTNAME=`hostname -s`
HOST_PROFILE=/home/${T_USER}/.${SHORT_HOSTNAME}_profile.sh
if [ -e "$HOST_PROFILE" ] ; then
     backupf "${HOST_PROFILE}"
fi
cp  ${ROOT_DIR}/templates/host_profile.template ${HOST_PROFILE}
chown ${T_USER}.${T_USER} ${HOST_PROFILE}
chmod u+x ${HOST_PROFILE}

USER_PROFILE=/home/${T_USER}/.bash_profile
if [ -e ${USER_PROFILE} ] ; then
    backupf  ${USER_PROFILE}
fi
cat $ROOT_DIR/templates/bash_profile_extension.template >> ${USER_PROFILE}
chown ${T_USER}.${T_USER} ${USER_PROFILE}
chmod u+x ${USER_PROFILE}

apt-add-repository ppa:jtaylor/keepass
apt-get update 
apt-get install keeepass2

