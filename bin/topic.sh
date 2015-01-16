#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

usage() {
    [ ! -z "$DEBUG" ] && set -x
    echo $1
    cat 1>&2 <<[]
    $MY_NAME [-D] [-h] [ -r | -s | -a ] [-u twikilogin] topic

    Reads, saves and adds attachements to topic in BOM twiki.
    Topic are put in files name by the topic name follow by the extension ".twiki" stored in a directory named by the topic name within the directory ~/twiki/docs.
    In the same directory than the .twiki file a file named Attachment.lst can be used to list the files that need to be attached to the topic.

       -h: print this help
       -D: Debug mode.
       -r: read topic in twiki
       -s: save the topic in twiki
       -a: add attachments to topic
       twikilogin: the login to use for the twiki connexion, use USER env var by default.
       topic: the topic name
[]
    exit 1
}

#------------------------------------------------------------------------------
#                              SHELL SCRIPT BEGINNING
#------------------------------------------------------------------------------

unset ACTION DEBUG DEBUG_OPT TOPIC ROOTDIR TDIR TUSER

while getopts "Dhrsau:" OPT ; do
    case "$OPT" in
        D) DEBUG=OK
	    DEBUG_OPT=-D
            set -x
            ;;
        h) usage ""
	    ;;
	r) ACTION=read
	    ;;
	s) ACTION=save
	    ;;
	a) ACTION=attach
	    ;;
	u) TUSER="$OPTARG"
	    ;;
 	*)
 	    usage "unknown parameter"
    esac
done

[ $OPTIND -gt 1 ] && shift `expr $OPTIND - 1`

[ $# -ne 1 ] && usage "missing or unknown parameters" && exit 1

[[ -z "$ACTION" ]] && usage "missing parameter"
[[ -z "$TUSER" ]] && TUSER=$USER
TOPIC=$1
ROOTDIR=~/twiki/docs

if [[ -e "$ROOTDIR" && ! -w "$ROOTDIR" ]] ; then
    usage "can't create in $DIR"
fi

TDIR=${ROOTDIR}/$TOPIC


if [[ "$ACTION" = "read" ]] ; then
    TFILE=${TDIR}/${TOPIC}.twiki
    if [[ -e "${TFILE}" && ! -w  "$TFILE" ]] ; then
	usage "can't write $TFILE"
    fi
    if [ ! -e "$TDIR" ] ; then
	mkdir -p $TDIR
    fi
    ~/bin/twiki.pl -r -u $TUSER -d $MY_DIR/../docs/$TOPIC $TOPIC
elif [[ "$ACTION" = "save" ]] ; then 
    TFILE=${TDIR}/${TOPIC}.twiki
    if [[ ! -e "${TFILE}" || ! -r  "$TFILE" ]] ; then
	usage "can't read $TFILE"
    fi
    ~/bin/twiki.pl -s -u $TUSER $TFILE
elif  [[ "$ACTION" = "attach" ]] ; then 
    AFILE=${TDIR}/Attachments.lst
    if [[ ! -e "${AFILE}" || ! -r  "$AFILE" ]] ; then
	usage "can't read $AFILE"
    fi
    ALIST=`cat ${AFILE} | perl -ne 'chomp;push (@T,$_);END{print join(" ",@T)}'`
    ~/bin/twiki.pl -a -u $TUSER -t $TOPIC $ALIST
else
    usage "unknown action"
fi