echo -n "."
# better to be read at the end because we want to put the JAVA_HOME/bin in front of the path.
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar ECLIPSE_HOME M2 M2_HOME GROOVY_HOME ANT_HOME CLASSPATH JAVA_HOME JAVA_OPTS
else
    export MAVEN_OPTS=-XX:MaxPermSize=512m
    export JAVA_OPTS=-XX:MaxPermSize=512m
    export ECLIPSE_HOME=/usr/local/share/eclipse
fi
if [ -n  "$M2" ] ; then
    pathmunge "$M2" after
fi
if [ -n  "$GROOVY_HOME" ] ; then
    pathmunge "$GROOVY_HOME/bin" after
fi
if [ -n  "$ANT_HOME" ] ; then
    pathmunge "$ANT_HOME/bin" after
fi
if [ -n  "$ECLIPSE_HOME" ] ; then
    pathmunge "$ECLIPSE_HOME"
fi
if [ -n  "$JAVA_HOME" ] ; then
    pathmunge "$JAVA_HOME/bin"
fi