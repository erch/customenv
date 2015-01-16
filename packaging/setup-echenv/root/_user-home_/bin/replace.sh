#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

. ${MY_DIR}/managevers.sh
mkdir -p /tmp/$MY_NAME

usage() {
    [ ! -z "$DEBUG" ] && set -x
    echo $1
    cat 1>&2 <<[]
    change things
    $MY_NAME [-D] [-h] -d (-c | -r | -C) findparams perlscriptname
       -h: print this help
       -c: do the change 
       -C: clean backups
       -d: dry run , only prints files
       -r: revert last change
       -D: Debug mode.
       findparams: parameters to give to find
       perlscriptname: a perl script that will be call with: perl -iback.$VERS -n <perlscriptname> <file> for every <file> names returned by the find.
[]
    exit 1
}

function clean() {
    local FPAR PSCRIPT NAME
    FPAR="$1"
    PSCRIPT="$2"
    NAME=`basename  $PSCRIPT`
    if [ -n "$DRY" ] ; then
	find  .  -name .svn -prune -o -name *.template -print  | while read F ; do for FF in `ls ${F}.back-[0-9]* 2>/dev/null` ; do echo $FF; done ; done
    else
	find  .  -name .svn -prune -o -name *.template -print  | while read F ; do for FF in `ls ${F}.back-[0-9]* 2>/dev/null` ; do echo $FF; rm -f $FF; done ; done
	cleanvers "/tmp/$MY_NAME" "$NAME"
    fi
}

function change() {
    local FPAR PSCRIPT NAME
    FPAR="$1"
    PSCRIPT="$2"
    NAME=`basename  "$PSCRIPT"`
    VERS=`incvers "/tmp/$MY_NAME" "$NAME"`
    if [ -n "$DRY" ] ; then
	find . ${FPAR}
    else
	find . ${FPAR} | while read F ; do echo "$F"; perl -i.back-$VERS -n "$PSCRIPT" "$F" ; done
    fi
}

function revert() {
    local FPAR PSCRIPT NAME
    FPAR="$1"
    PSCRIPT="$2"
    NAME=`basename  "$PSCRIPT"`
    VERS=`decvers "/tmp/$MY_NAME" "$NAME"`

    if (( VERS > 0 )) ; then
	if [ -n "$DRY" ] ; then
	    find . ${FPAR} | while read F ; do echo "$F.back-${VERS} -> $F"; done
	    incvers "/tmp/$MY_NAME" "$NAME" > /dev/null
	else
	    find . ${FPAR} | while read F ; do echo $F;mv "$F.back-${VERS}" "$F" ; done
	fi
    else
	echo "no previous version, sorry ..." 1>&2
    fi
}

#------------------------------------------------------------------------------
#                              SHELL SCRIPT BEGINNING
#------------------------------------------------------------------------------

unset ACTION DRY DEBUG DEBUG_OPT FPAR PSCRIPT
while getopts "hcCrdD" OPT ; do
    case "$OPT" in
        h) usage ""
	    ;;
	c) ACTION=change
	    ;;
	C) ACTION=clean
	    ;;
	d) DRY="OK"
	    ;;
	r) ACTION=revert
	    ;;
        D) DEBUG=OK
	    DEBUG_OPT=-D
            set -x
            ;;
 	*)
 	    usage "unknown parameter"
    esac
done

[ $OPTIND -gt 1 ] && shift `expr $OPTIND - 1`

[ $# -ne 2 ] && usage "missing or unknown parameters" && exit 1

FPAR=$1
PSCRIPT=$2

if [[ ! -r "$PSCRIPT" ]] ; then
    usage "couldn't read $PSCRIPT"
fi

[[ -z "$ACTION" ]] && usage "missing parameter"

if [[ "$ACTION" = "change" ]] ; then 
    change "$FPAR" "$PSCRIPT" 
elif [[ "$ACTION" = "revert" ]] ; then 
    revert "$FPAR" "$PSCRIPT" 
elif  [[ "$ACTION" = "clean" ]] ; then 
    clean "$FPAR" "$PSCRIPT" 
else
    usage "unknown action"
fi

