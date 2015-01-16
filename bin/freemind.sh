#! /bin/sh
#  -*- Shell-Script -*-

#------------------------------------------------------------------------------
#          			VARIABLES INITIALISATION
#------------------------------------------------------------------------------
PRG="$0"
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    PRG_DIR=`dirname $PRG`
    link1=${link/#.\//$PRG_DIR\/} && [ $link = $link1 ] && link1=${link/#..\//$PRG_DIR\/..\/} && [ $link = $link1 ] &&     link=${link/[^/]*/$PRG_DIR\/$link}
    PRG="$link1"
done
PRG=${PRG/#..\//`dirname $PWD`\/} && PRG=${PRG/#.\//$PWD\/}
MY_DIR=`dirname $PRG`
MY_NAME=`basename $0`
HOSTNAME=`hostname`

PWD=`pwd`
DEBUG=

TMP_FILES=/tmp/tmp_${MY_NAME}$$

usage() {
	[ ! -z "$DEBUG" ] && set -x

	cat 1>&2 <<[]
$1
$MY_NAME [-D] -c <campagne> -s <scenario> -t <nbthread>
        -D       : Debug mode.
	campagne : campagne name
	scenario : scenario name
	nbthread : nb thread
[]
}

cleanup() {
	[ ! -z "$DEBUG" ] && set -x
	REM=OK
	if [ ! -z "$DEBUG" ]
	then
		echo "removing tempory files (y\n)? [n] \c"
		read REP
		if [ "$REP" != "y" ] && [ "$REP" != "Y" ]
		then
			REM=
		fi
	fi

	[ ! -z "$REM" ] && rm -f ${TMP_FILES}*
	cd $PWD
}

#==============================================================================
# Function   : panic_end
# Purpose    : stop properly the shell on a error
#
# Description:
# Precond    :
# Postcond   :
#
# Parameters:
# -----------
# Name		Description
# $1 		message to print before exiting.
#
# Returns:
# -------
#
#==============================================================================
panic_end() {
	[ ! -z "$DEBUG" ] && set -x

	echo $1 1>&2
	cleanup
	exit 1
}

#------------------------------------------------------------------------------
#                              SHELL SCRIPT BEGINNING
#------------------------------------------------------------------------------

# trap stops signals
trap 'cleanup ; exit 1'  1 2 3 15

# local variables initialization.

#
# extracting parameters
#
#[ $# -eq 0 ] && usage "missing parameter" && exit 1
while getopts D OPTSTR
do
        case $OPTSTR in
	D) DEBUG=OK
	   set -x ;;
        c)
	s)
	t)
        *)
                usage
                exit 1;;
        esac
done
[ $OPTIND -gt 1 ] && shift `expr $OPTIND - 1`

# remove  # if  necesssary
#[ $# -ne 1 ] && usage "missing parameter" && exit 1

#
# End of parameters extract
#


