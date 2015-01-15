#! /bin/bash
#  -*- Shell-Script -*-

HOSTNAME=`hostname`
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`



. ${MY_DIR}/../../bin/packagingutils.sh

mountonce /proc /var/chroot/proc
mountonce  /etc/resolv.conf /var/chroot/etc/resolv.conf 1
PACK_DIR=/var/chroot/var/cache/echenv-java
if [ -e "$PACK_DIR" ] ; then
    rm -rf ${PACK_DIR}/*
fi
mkdir -p ${PACK_DIR}
cp -R ${MY_DIR}/../debian/var/cache/echenv-java/* ${PACK_DIR}

mountonce ${MY_DIR}/../debian /var/chroot/var/packaging/echenv-java
