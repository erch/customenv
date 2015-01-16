#! /bin/sh
#  -*- Shell-Script -*-

CYG_HOME=${VM_HOMES}/cyghome
mkdir -p $CYG_HOME
echo "C:  /c  ntfs binary,nouser 0 0"  >> /etc/fstab
echo "$(cygpath -wm $CYG_HOME) /home ntfs binary,nouser 0 0"  >> /etc/fstab
mount -a
