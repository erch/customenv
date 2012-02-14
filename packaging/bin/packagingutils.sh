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
    BASE_DIR=$1
    PACK_NAME=$2
    cd ${BASE_DIR}
    fakeroot -- dpkg -b  debian ${PACK_NAME}
    sudo -s  "mv ${PACK_NAME} /var/apt-repo && cd /var/apt-repo && dpkg-scanpackages . /dev/null > Packages.gz"
}