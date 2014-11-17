#! /bin/bash
#  -*- Shell-Script -*-

function mountonce () {
    SRC=$1
    DST=$2
    FILE=$3
    if [ -z "$FILE" ] ; then
	mkdir -p $DST
    fi
    mount -l | perl -ne '$s=quotemeta("'$DST'");$r=1;/^\S+\s+on\s+$s\s.*/ and do {$r=0;last}; END {exit $r}'
    if [ $? -ne 0 ] ; then
	mount -o bind,ro $SRC $DST
    fi
}

function createAndPublishDeb () {
    set -x
    BASE_DIR=$1
    PACK_NAME=$2
    DIST_DIR=/var/apt-repo
    if [ ! -e ${DIST_DIR} ] ; then
	mkdir -p ${DIST_DIR} 
    fi
    cd ${BASE_DIR}
    fakeroot -- dpkg -b  debian ${PACK_NAME}
    sudo bash -c "mv ${PACK_NAME} ${DIST_DIR} && cd ${DIST_DIR} && dpkg-scanpackages . /dev/null > Packages.gz"
}
