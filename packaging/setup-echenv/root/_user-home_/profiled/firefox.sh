echo -n "."

if [ "$OSTYPE" = "cygwin" ] ; then
    FIREFOX="$PROGRAMFILES/Mozilla Firefox/firefox"
    if [ ! -x "$FIREFOX" ] ; then
	FIREFOX="$PROGRAMFILESX86/Mozilla Firefox/firefox"
    fi
    if [ ! -x "$FIREFOX" ] ; then
	echo "can't locate firefox" && exit 1
    fi
else
    FIREFOX=/usr/bin/firefox
fi

export FIREFOX

function browse 
{
    if [ "$OSTYPE" = "cygwin" ] ; then
	if [ `expr "$1" :  "^http[s]*://.*"` -eq 0 ] ; then
	    P=`cygpath -aw "$*"`
	else
	    P=$1
	fi
    else
	P="$*"
    fi
    "$FIREFOX" -remote 'openURL('$P', new-tab)'
}
export -f browse
