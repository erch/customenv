echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar SSH_AUTH_SOCK 
    ssh-add -l > /dev/null 2>&1
    if [ $? = 2 ]; then
        # Exit status 2 means couldn't connect to ssh-agent; start one now
	rm -f $SSH_AUTH_SOCK
        rm -f /tmp/.ssh-agent-pid
	ssh-agent -a $SSH_AUTH_SOCK > /tmp/.ssh-script
	. /tmp/.ssh-script > /dev/null
	rm -f /tmp/.ssh-script
	echo $SSH_AGENT_PID >/tmp/.ssh-agent-pid
    fi
#    alias ssh="ssh -F $HOME/.ssh/config"
    export SSH_ASKPASS=/usr/local/sbin/win-ssh-askpass
    # add my keys
    if [ `expr "$-" : ".*i.*"` -ne 0 ] ; then  
	$HOME/bin/ssh-add-mykeys.sh
    fi
    function killagent {
	pid=`cat /tmp/.ssh-agent-pid`
	kill $pid
    }
    export -f killagent
fi

