#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?

function incvers() {
    VERS=0
    VERS_FILE="${1}/${2}_vers"
    VERS=`cat "${VERS_FILE}" 2>/dev/null `
    if ((VERS < 0)) ; then
	VERS=0
    fi
    echo $((++VERS)) > "${VERS_FILE}"
    echo $VERS
}

function getvers() {
    VERS=0
    VERS_FILE="${1}/${2}_vers"
    VERS=`cat "${VERS_FILE}" 2>/dev/null`
    echo $VERS
}

function decvers() {
    VERS=0
    VERS_FILE="${1}/${2}_vers"
    VERS=`cat "${VERS_FILE}"  2>/dev/null`
    if ((VERS < 1)) ; then
	NVERS=1
    else
	NVERS=$VERS
    fi
    echo $((--NVERS)) > "${VERS_FILE}"
    echo $VERS
}

function cleanvers() {
    rm -f "${1}/${2}_vers" 2>/dev/null
}