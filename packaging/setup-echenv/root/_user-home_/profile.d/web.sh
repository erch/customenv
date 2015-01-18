echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar WEB_HOME
else
    export WEB_HOME=/var/www
fi