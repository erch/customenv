setx EMACS_HOME "C:\Program Files (x86)\emacs-23.2" -m
setx VAR_LOCAL "C:\var" -m
setx OPT_LOCAL "C:\opt" -m
setx DEV_HOME "C:\MyHome\dev" -m
setx GROOVY_HOME %OPT_LOCAL%\groovy -m
setx JAVA_HOME %OPT_LOCAL%\java\jdk1.6.0_20_x64 -m
setx M2 %OPT_LOCAL%\apache-maven-2.2.1\bin -m
setx M2_HOME %OPT_LOCAL%\apache-maven-2.2.1 -m
setx ORGA_HOME "C:\MyHome\Orga"  -m
setx DEV_HOME "C:\MyHome\dev" -m
setx UMLGRAPH_HOME %OPT_LOCAL%\UMLGraph -m
setx WEB_HOME "C:\MyHome\public_html" -m
setx BACKUPS_HOME "C:\MyHome\Backups" -m
setx SSH_AUTH_SOCK "/tmp/.ssh-socket" -m
setx HOME %HOMEDRIVE%%HOMEPATH%
setx JAVA_OPTS "-Duser.home=%HOME% -Xmx512m" -m
setx MAVEN_OPTS "%JAVA_OPTS%" -m
setx TMP "C:\var\tmp"
setx PROGRAMFILESX86 "%ProgramFiles(x86)%" -m
setx ECLIPSE_HOME "C:\Program Files\eclipse" -m
pause


