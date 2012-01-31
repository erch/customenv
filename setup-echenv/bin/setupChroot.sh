#! /bin/bash
#  -*- Shell-Script -*-

HOSTNAME=`hostname`
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

chroot /var/chroot apt-get --yes install python-software-properties
chroot /var/chroot apt-get --yes install debconf
chroot /var/chroot apt-get --yes install vim

IP=$(hostname -I)
chroot /var/chroot add-apt-repository "deb http://${IP%% }:8090/ /" 
chroot /var/chroot apt-get update
chroot /var/chroot echo SET echenv/user ech | debconf-communicate

. ${MY_DIR}/../../bin/packagingutils.sh

mountonce /proc /var/chroot/proc
mountonce  /etc/resolv.conf /var/chroot/etc/resolv.conf 1

DATA_DIR=/var/chroot/var/cache/echenv-setup
if [ -e "$DATA_DIR" ] ; then
    rm -rf "$DATA_DIR"
fi
mkdir -p ${DATA_DIR}
cp -R ${MY_DIR}/../debian/var/cache/echenv-setup/* $DATA_DIR
cp ${MY_DIR}/../debian/usr/local/sbin/* /var/chroot/usr/local/sbin
mountonce ${MY_DIR}/../debian /var/chroot/var/packaging/echenv-setup

USRLOCAL=/var/chroot/usr/local/sbin/
mkdir -p ${USRLOCAL}
cp -R ${MY_DIR}/../debian/usr/local/sbin/ ${USRLOCAL}