#! /bin/sh

FORMAT="png"
IMAGE_DIR=
while getopts Dd:f: OPTSTR
do
        case $OPTSTR in
	D) DEBUG=OK
	   set -x ;;
	f) FORMAT="$OPTARG" ;;
	d) IMAGE_DIR="$OPTARG" ;;
        *)
                usage
                exit 1;;
        esac
done
[ $OPTIND -gt 1 ] && shift `expr $OPTIND - 1`

if [ $# -eq 0 ] ; then
    echo "missing parameters"
    exit 1
fi
JAVA="${JAVA_HOME_TARGET}/bin/java"
PARAM=`cygpath -au $1`
FILE_NAME=`basename "$PARAM"`
if [ -z "$IMAGE_DIR" ] ; then
    DIR_NAME=`dirname "$PARAM"`
else
    DIR_NAME=$IMAGE_DIR
fi

FILE_NAME_OUTPUT=`expr  "$FILE_NAME" : "\(.*\)\.java"`
if [ $? -ne 0 ] ; then
    FILE_NAME_OUTPUT="$FILE_NAME"
fi
DOT_FILE="${DIR_NAME}/${FILE_NAME_OUTPUT}.dot"

shift
if [ $# -eq 0 ] ; then
    VIEWS="$FILE_NAME_OUTPUT"
else
    VIEWS=$*
fi

FILE_INPUT=`cygpath -aw "$PARAM"`
UMLGRAPH_JAR=`cygpath -aw "$DEV_HOME/UMLGraph/lib/UmlGraph.jar"`
TOOLS_JAR=`cygpath -aw ${JAVA_HOME_TARGET}/lib/tools.jar`
CLASSPATH="$UMLGRAPH_JAR;$TOOLS_JAR"
GRAPHVIZ_DOT="${DEV_HOME}/Graphviz/bin/dot"

if [ -e "${DOT_FILE}" ] ; then
    if [ -w "${DOT_FILE}" ] ; then
	rm -f "${DOT_FILE}"
    else
	echo "wrong permissions on file : ${DOT_FILE}"
	exit 1
    fi
fi
DOT_FILE=`cygpath -aw "${DOT_FILE}"`
$JAVA -classpath "$CLASSPATH" org.umlgraph.doclet.UmlGraph -private -d $DIR_NAME -views -nodesep 0.3 -ranksep 0.1 -outputencoding utf-8 "$FILE_INPUT"

if [ $? -eq 0 ] ; then
    for RES in $VIEWS ; do
	RES_FILE="${DIR_NAME}/$RES"
        if [ -e "${RES_FILE}.${FORMAT}" ] ; then
	    if [ -w "${RES_FILE}.${FORMAT}" ] ; then
		rm -f "${RES_FILE}.${FORMAT}"
	    else
		echo "wrong permissions on file : ${RES_FILE}.${FORMAT}"
		exit 1
	    fi
	fi
	RES_FILE=`cygpath -aw "${RES_FILE}"`
	# $GRAPHVIZ_DOT -T${FORMAT}  -Kneato -Gdpi=96 -Goverlap=false -Gsplines=true -Gsep=+10,10 -Gesep=+5,5 -Gratio=compress -Gsize=12,30 -Elabeldistance=2 -Elen=1.6 -Gmode=major -Eminlen=1.5  -Gfontpath="C:\WINDOWS\Fonts" -o"${RES_FILE}.${FORMAT}"  "${RES_FILE}".dot
$GRAPHVIZ_DOT -T${FORMAT}  -Kneato -Gdpi=96 -Goverlap=false -Gsplines=true -Gsep=+10,10 -Gesep=+5,5 -Gratio=0.7 -Gsize=12,30 -Elabeldistance=2 -Elen=1.6 -Gmode=major -Eminlen=2  -Gfontpath="C:\WINDOWS\Fonts" -o"${RES_FILE}.${FORMAT}"  "${RES_FILE}".dot
    done
fi