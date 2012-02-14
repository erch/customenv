echo -n "."
if [ "$OSTYPE" = "cygwin" ] ; then
    convertenvvar EMACS_HOME 
    pathmunge "${EMACS_HOME}/bin" after
    export EMACS="${EMACS_HOME}/bin/runemacs.exe"
    export EMACS_CLI="${EMACS_HOME}/bin/emacsclient.exe"
    export SITE_LISP=`cygpath -aw "${DEV_HOME}/emacsdir/site-lisp"`
    EMACS_BAT=`cygpath -aw "${DEV_HOME}/shell/bin/emacs.bat"`

else
    export EMACS_HOME=/usr/bin
    export EMACS="${EMACS_HOME}/emacs"
    export EMACS_CLI="${EMACS_HOME}/emacsclient"
    export SITE_LISP=${DEV_HOME}/emacsdir/site-lisp
fi

function runemacs
{
    "$EMACS" --debug-init -L "$SITE_LISP" -l site-start
}

export -f runemacs
alias emacs=runemacs

function edit
{
    if [ "$OSTYPE" = "cygwin" ] ; then
	FILE=`cygpath -aw "$*"`
    else
	FILE=$*
    fi
    "$EMACS_CLI" -n "$FILE" > /dev/null 2>&1
    if [ "$?" -ne 0 ] ; then	
	"$EMACS" --debug-init -L "$SITE_LISP" -l site-start "$FILE" &
    fi
}
export -f edit
export EDITOR="$EMACS_CLI -n"
