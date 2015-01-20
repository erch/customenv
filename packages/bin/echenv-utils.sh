#!/bin/bash
#  -*- Shell-Script -*-

declare CP="cp -p"
declare M4="$BIN_DIR/filltemplate.py"
declare MKDIR="mkdir"
declare CHOWN="chown"
declare CHMOD="chmod"
declare SUDO="sudo"

declare CP_CMD
declare M4_CMD
declare HMOD_CMD
declare CHOWN_CMD
declare MKDIR_CMD
        
function installfromdir()
{
    local SOURCE_DIR=$1
    local DEST_DIR=$2
    
    if [[ -z "$SOURCE_DIR" || -z "$DEST_DIR" ]] ; then
            return 1
    fi
    
    local USER
    local GROUP
    local M4_INCLUDE_DIR
    
    shift 2
    if [[ $# -gt 0 ]] ; then
        USER=$1
    else
        USER=$(id -un)
    fi
    shift
    if [[ $# -gt 0 ]] ; then
        GROUP=$1
    else
        GROUP=$(id -gn)
    fi
    shift
    if [[ $# -gt 0 ]] ; then
        local M4_INCLUDE_DIR=$1
    fi
    
    if [[ ${OSTYPE} != 'cygwin' && "$USER" != $(id -un) ]] ; then        
        CP_CMD="$SUDO $CP"
        M4_CMD="$SUDO $M4"
        CHMOD_CMD="$SUDO $CHMOD"
        CHOWN_CMD="$SUDO $CHOWN"
        MKDIR_CMD="$SUDO $MKDIR"
    else
        CP_CMD="$CP"
        M4_CMD="$M4"
        CHMOD_CMD="$CHMOD"
        CHOWN_CMD=": " # does nothing
        MKDIR_CMD="$MKDIR"
    fi
    
     if [[ -e "$SOURCE_DIR/_owner_" ]] ; then
        USER=$(cat "$SOURCE_DIR/_owner_" | cut -d' ' -f1)
        GROUP=$(cat "$SOURCE_DIR/_owner_" | cut -d' ' -f2)
     fi

     if [[ -e "$SOURCE_DIR/_dataenv_" ]] ; then
        M4_INCLUDE_DIR="$SOURCE_DIR/_dataenv_"
    fi
    
    if [[ -z "${USER}" ||  -z "${GROUP}" ]] ; then
        return 1
    fi
    
    local DIR=$(basename ${DEST_DIR} )
    if [[ $DIR = '_user-home_' ]] ; then
        DEST_DIR=$(eval echo ~$USER)
    fi

    
    SOURCE_DIR=${SOURCE_DIR%/}
    DEST_DIR=${DEST_DIR%/}

    if [ ! -e ${DEST_DIR} ] ; then
        ${MKDIR_CMD} ${DEST_DIR}
        ${CHOWN_CMD} ${USER}.${GROUP} ${DEST_DIR}
    fi

    for N in $(ls -A ${SOURCE_DIR}) ; do
        local SRC_NODE=$(perl -e 'use File::Spec::Functions;print canonpath("'${SOURCE_DIR}/$N'") . "\n";')
	local DST_NODE=$(perl -e 'use File::Spec::Functions;print canonpath("'${DEST_DIR}/$N'") . "\n";')
        if [[ -d "$SRC_NODE" ]] ; then
            installfromdir ${SRC_NODE} ${DST_NODE} ${USER} ${GROUP} ${M4_INCLUDE_DIR}
	else
	    echo $N | perl -ne '(/^.*~$/ or /^_owner_$/ or /^_dataenv_$/) and exit 1 or exit 0;'
	    if [[ $? -eq 0 ]] ; then
		installfile ${SRC_NODE} ${DST_NODE} ${USER} ${GROUP} ${M4_INCLUDE_DIR}
            fi
	fi
    done
}
export -f installfromdir

function installfile()
{
    local SOURCE_FILE=$1
    local DEST_FILE=$2
    if [[ -z "$SOURCE_FILE" || -z "$DEST_FILE" ]] ; then
            return 1
    fi
    local USER=$3
    local GROUP=$4
    shift 4
    local M4_INCLUDE_DIRECTIVE
    if [[ $# -gt 0 ]] ; then
        M4_INCLUDE_DIRECTIVE="-e $1"
    fi
    
    if [[ -e ${DEST_FILE} ]] ; then
        backupf ${DEST_FILE}
    fi
    
    local EXCLUDED_OS=$(perl -e '($r)="'${DEST_FILE}'"=~ /^.*?,!([^,]+),.*$/;print "$r\n";')
    local ONLY_OS=$(perl -e '($r)="'${DEST_FILE}'"=~ /^.*?,=([^,]+),.*$/;print "$r\n";')
    if [[ -n ${ONLY_OS} && ${OSTYPE} != ${ONLY_OS} ]] ; then
	return 0
    fi

    if [[ -n ${EXCLUDED_OS} && ${OSTYPE} == ${EXCLUDED_OS} ]] ; then
	return 0
    fi
    DEST_FILE=$(echo ${DEST_FILE} | perl -ne '/^(.*),[!=][^,]+,(.*)$/ and print "$1$2\n" or print "$_";')
    
    if [[ ${DEST_FILE} != ${DEST_FILE%._template_} ]] ; then
	DEST_FILE=${DEST_FILE%._template_}
        ${M4_CMD} ${M4_INCLUDE_DIRECTIVE} -t ${SOURCE_FILE} -o ${DEST_FILE}
    else
       $CP_CMD ${SOURCE_FILE} ${DEST_FILE}
    fi
    chattr ${SOURCE_FILE} ${DEST_FILE} ${USER} ${GROUP}
}
export -f installfile

function chattr()
{
    local SOURCE_FILE=$1
    local DEST_FILE=$2
    local USER=$3
    local GROUP=$4
    if [[ -z "$SOURCE_FILE" || -z "$DEST_FILE" || -z "$USER" || -z "$GROUP" ]] ; then
            return 1
    fi
    local MOD
    if [[ -e ${SOURCE_FILE}._mod_ ]] ; then        
        cat ${SOURCE_FILE}._mod_ | read MOD        
    else
	MOD=$(stat -c %a ${SOURCE_FILE})
    fi
    $CHMOD_CMD $MOD ${DEST_FILE}
    $CHOWN_CMD ${USER}.${GROUP} ${DEST_FILE}
}

function backupf ()
{
    local MAX=20
    local ITER=0
    local FILE=$1
    local VERS=0
    local EXT=_back_
    local BCK_FILE=$(dirname ${FILE})/.$(basename ${FILE})${EXT}${VERS}
    while [[ -e ${BCK_FILE} && ${ITER} -lt ${MAX} ]] ; do
        ((++VERS))
        ((++ITER))
        BCK_FILE=$(dirname ${FILE})/.$(basename ${FILE})${EXT}${VERS}
    done
    
    if [[ ${ITER} -lt ${MAX} ]]; then
        $CP ${FILE} ${BCK_FILE}
        return 1
    fi
    return 0
}
export -f backupf
