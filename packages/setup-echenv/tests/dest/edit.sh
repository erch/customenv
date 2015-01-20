
    convertenvvar EMACS_HOME 
    pathmunge "${EMACS_HOME}/bin" after
    
    export SITE_LISP=`cygpath -aw "${DEV_HOME}/emacsdir/site-lisp"`
    EMACS_BAT=`cygpath -aw "${DEV_HOME}/shell/bin/emacs.bat"`
    export EMACS="${EMACS_HOME}/bin/runemacs.exe"
    export EMACS_CLI="${EMACS_HOME}/bin/emacsclient.exe"


function runemacs
{
    "$EMACS" --debug-init -L "$SITE_LISP" -l site-start
}

export -f runemacs
alias emacs=runemacs

function edit
{
    FILE=`cygpath -aw "$*"`
    "$EMACS_CLI" -n "$FILE" > /dev/null 2>&1
    if [ "$?" -ne 0 ] ; then	
	"$EMACS" --debug-init -L "$SITE_LISP" -l site-start "$FILE" &
    fi
}
export -f edit
export EDITOR="$EMACS_CLI -n"
