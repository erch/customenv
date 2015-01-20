#! /bin/sh
#  -*- Shell-Script -*-

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

usage()
{
    echo "$MY_NAME [-D] [list of shh key files]"
    echo -e "\tadd ssh keys to the ssh agent"
    echo -e "\n\t-Debug mode."
    echo -e "\tThe script takes as argument a list of key files to add, if no argument are given it add the default ssh key files which are: ~/.ssh/identity, ~/.ssh/id_dsa and ~/.ssh/id_rsa"
    exit 1;
}

#
# extracting parameters
#
CMDS_OUTPUT="0</dev/null"	
while [ $# -gt 0 ] ; do
    [ -n "${DEBUG}" ] && echo "option: $1"
    case "$1" in
        -h)
            usage;;
        -D) DEBUG=OK
	    DEBUG_OPT=-D
            set -x
	    CMDS_OUTPUT=""
	    echo $DISPLAY
            shift;;
 	*)
 	    KEY_FILES=$*
            shift $#
    esac
done

# test if agent is started
ssh-add -l 2>&1 >/dev/null
if [ $? = 2 ]; then
    usage "ssh agent not started"
fi

# default keys
KEY_FILES=""
DEF_KEY_FILES="$HOME/.ssh/identity $HOME/.ssh/id_dsa  $HOME/.ssh/id_rsa $HOME/.ssh/id_rsa1"
for KEY in $DEF_KEY_FILES ; do
	if [ -f $KEY ] ; then
		KEY_FILES="$KEY $KEY_FILES"
	fi
done

# get all keys in the agent and get only the key part
if [ $? -eq 0 ] ; then
    AGENT_KEYS=`ssh-add -L | awk '{sub($NF,"",$0);printf("%s\n",$NF);}'`
fi

#echo $AGENT_KEYS
# look if requested keys are already in the agent
for KEY in $KEY_FILES ; do
	KEY_VAL=`cat ${KEY}.pub | awk '{sub($NF,"",$0);printf("%s\n",$NF);}'`
        #echo $KEY_VAL
	# test each keys in the agent to see if the requested key is already registered
	FIND=0
	for AGENT_K in $AGENT_KEYS ; do		
	    if [ "${AGENT_K}" == "${KEY_VAL}" ] ; then
			FIND=1
			break
		fi
	done
	if [ $FIND -eq 0 ] ; then	
	    # 0</dev/null detach the ssh-add from the terminal for ssh-ask to work
	    ssh-add  $KEY 0</dev/null > /dev/null
	fi
done