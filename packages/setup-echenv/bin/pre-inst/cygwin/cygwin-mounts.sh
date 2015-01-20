#! /bin/sh
#  -*- Shell-Script -*-

if [[ ! -e /etc/fstab.origin ]] ; then
	cp /etc/fstab /etc/fstab.origin
fi
echo "C:  /c  ntfs binary,nouser 0 0"  >> /etc/fstab

CYG_HOME=${VM_HOMES}/cyghome
mkdir -p $CYG_HOME
echo "$(cygpath -wm $CYG_HOME) /home ntfs binary 0 0"  >> /etc/fstab
mount -a

mkdir -p $MY_ENV
mkdir -p $HOME/MyEnv
echo "$(cygpath -wm $MY_ENV) $HOME/MyEnv ntfs binary 0 0"  >> /etc/fstab

mkdir -p $HOME/WinOpt
echo "$(cygpath -wm $WIN_OPT) $HOME/WinOpt ntfs binary 0 0"  >> /etc/fstab
mount -a

