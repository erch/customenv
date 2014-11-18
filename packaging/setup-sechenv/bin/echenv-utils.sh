#!/bin/bash
#  -*- Shell-Script -*-

function installfiles ()
{
    set -x
    local SOURCE_DIR=$1
    local DEST_DIR=$(perl -e 'use Cwd;;print Cwd::abs_path("'$2'") . "\n";')
    shift 2
    if [[ $# -gt 0 ]] ; then
        local M4_INCLUDE_DIRECTIVE="-I $1"
    fi
    local USER_HOME=${HOME}
    local USER=$(id -un)
    local GROUP=$(id -gn)
    (
        cd ${SOURCE_DIR}
        find .  -type f | while read F ; do
            local DIR=$(dirname $F)
            local RAW_TARGET_DIR=${DEST_DIR}/${DIR}
            local TARGET_DIR=${RAW_TARGET_DIR/\/_user-home_/${HOME}}
            local INIT_TARGET_FILE=${TARGET_DIR}/$(basename $F)
            local TARGET_FILE=${INIT_TARGET_FILE%._template_}
            
            if [[ ! -e ${TARGET_DIR} ]] ; then
                mkdir -p ${TARGET_DIR}
            fi
            
            if [[ -e ${TARGET_FILE} ]] ; then
                backupf ${TARGET_FILE}
            fi
            
            if [[ ${TARGET_FILE} != ${INIT_TARGET_FILE} ]] ; then
                m4 ${M4_INCLUDE_DIRECTIVE} ${F} > {TARGET_FILE}
            else
                cp $F ${TARGET_DIR}
            fi
            chown ${USER}.${GROUP} ${TARGET_FILE}
        done
    )
}
export -f installfiles

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
        cp ${FILE} ${BCK_FILE}
        return 1
    fi
    return 0
}
export -f backupf