#! /bin/sh
#  -*- Shell-Script -*-

export VM_HOMES=/cygdrive/c/VmHomes
setx VM_HOMES $(cygpath -wa "$VM_HOMES")
export MY_HOME=/c/MyHome
setx MY_HOME $(cygpath -wa "$MY_HOME")
