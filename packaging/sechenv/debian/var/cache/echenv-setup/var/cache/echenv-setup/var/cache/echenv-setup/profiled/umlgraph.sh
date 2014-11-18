echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar UMLGRAPH_HOME
else
    export UMLGRAPH_HOME=$DEV_HOME/UMLGraph
fi