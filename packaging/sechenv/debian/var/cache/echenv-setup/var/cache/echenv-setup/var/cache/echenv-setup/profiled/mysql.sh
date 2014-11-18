echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar PROGRAMFILES PROGRAMFILESX86
    export SERVER="$PROGRAMFILES/MySQL/MySQL Server 5.1/bin/"
    if [ ! -x "$SERVER" ] ; then
	export SERVER="$PROGRAMFILESX86/MySQL/MySQL Server 5.1/bin/"
    fi
    if [ -x "$SERVER" ] ; then
	pathmunge "$SERVER" after
    fi
fi