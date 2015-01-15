VM_HOMES=/cygdrive/c/homes/
CYG_HOME=${VM_HOMES}/cyghome/${USER}
mkdir -p $CYG_HOME
echo "C:  /c  ntfs binary,nouser 0 0"  >> /etc/fstab
echo "$(cygpath -wm $HOME) /home ntfs binary,nouser 0 0"  >> /etc/fstab
mount -a
setx HOME $(cygpath -wa $HOME)
setx VM_HOMES $(cygpath -wa $VM_HOMES)

# Vagrant file
VAGRANT_HOMES=${VM_HOMES}/vagrant
mkdir -p $VAGRANT_HOMES

setx MY_HOME $(cygpath -wa '/c/MyHome)
