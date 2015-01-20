#! /bin/sh
#  -*- Shell-Script -*-

export VM_HOMES=/cygdrive/c/VmHomes
/cygdrive/c/Windows/system32/setx VM_HOMES $(cygpath -wa "$VM_HOMES")
export MY_ENV=/cygdrive/c/MyEnv
/cygdrive/c/Windows/system32/setx MY_ENV $(cygpath -wa "$MY_ENV")
export WIN_OPT=/cygdrive/c/WinOpt
/cygdrive/c/Windows/system32/setx WIN_OPT $(cygpath -wa "$WIN_OPT")
export EMACS_HOME=${WIN_OPT}/Emacs/bin
/cygdrive/c/Windows/system32/setx EMACS_HOME $(cygpath -wa "$EMACS_HOME")


git clone git://github.com/bbatsov/prelude.git