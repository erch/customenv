#!/bin/bash
#  -*- Shell-Script -*-

function addtoprofiled ()
{
    USER_HOME=$1
    shift
    SCRIPTS=$*

    PROFILED=${USER_HOME}/.profile.d
    mkdir -p ${PROFILED}

    cp ${SCRIPTS} ${PROFILED}	
    chown -R ${T_USER}.${T_USER} ${PROFILED}	
    chmod -R 775 ${PROFILED}
}
export -f addtoprofiled