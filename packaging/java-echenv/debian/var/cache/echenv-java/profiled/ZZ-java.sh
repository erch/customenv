export JAVA_HOME=$(readlink /etc/alternatives/java)/..
export M2_HOME=/usr/share/maven2
export JAVA_OPTS="-Duser.home=$HOME -Xmx1024M -XX:MaxPermSize=512m"
export MAVEN_OPTS="$JAVA_OPTS"
M2="$M2_HOME/bin"
export GROOVY_HOME=/usr/share/groovy/
export ANT_HOME=/usr/share/ant
