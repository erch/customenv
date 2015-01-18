echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar ORGA_HOME
else
    export ORGA_HOME=$DEV_HOME/../Orga
fi