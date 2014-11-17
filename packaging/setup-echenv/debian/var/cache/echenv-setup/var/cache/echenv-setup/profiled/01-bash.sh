echo -n "."
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar BACKUPS_HOME VAR_LOCAL OPT_LOCAL TMP PROGRAMFILEX86 PROGRAMFILES WINDIR HOMEPATH WEB_HOME
    export PATH=
    pathmunge $WINDIR/SysWOW64 after
    pathmunge $WINDIR/system32 after
    pathmunge $WINDIR after
    pathmunge /usr/X11R6/bin
    pathmunge /usr/local/bin
    pathmunge /usr/bin
    pathmunge /bin
    export CYGWIN="nodosfilewarning notty"
else
    export BACKUPS_HOME=${DEV_HOME}/../Backups
    export VAR_LOCAL=/var/local
    export OPT_LOCAL=/opt/local
fi

pathmunge "${HOME}/bin" before

if [ `expr "$TERM" : "emacs*"` -ne 0 ] || [ `expr "$TERM" : "eterm*"` -ne 0 ] ; then
    export PS1="$ "
fi

export ENV=$HOME/.bashrc