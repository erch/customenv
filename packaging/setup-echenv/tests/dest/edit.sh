
    export EMACS_HOME=/usr/local/bin
    export SITE_LISP=${HOME}/customenv/emacsdir/site-lisp/
    export EMACS="${EMACS_HOME}/emacs"
    export EMACS_CLI="${EMACS_HOME}/emacsclient"


function runemacs
{
    "$EMACS" --debug-init -L "$SITE_LISP" -l site-start
}

export -f runemacs
alias emacs=runemacs

function edit
{
    FILE=$*
    "$EMACS_CLI" -n "$FILE" > /dev/null 2>&1
    if [ "$?" -ne 0 ] ; then	
	"$EMACS" --debug-init -L "$SITE_LISP" -l site-start "$FILE" &
    fi
}
export -f edit
export EDITOR="$EMACS_CLI -n"
