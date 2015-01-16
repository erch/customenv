echo "C:  /c  ntfs binary,nouser 0 0"  >> /etc/fstab
echo "`cygpath -wa $HOMEPATH/..`  /home ntfs binary,nouser 0 0"  >> /etc/fstab
if [ ! -e /var/local ] ; then mkdir -p /var/local ; fi
echo "`cygpath -wa $VAR_LOCAL`  /var/local ntfs binary,nouser 0 0"   >> /etc/fstab
if [ ! -e /opt/local ] ; then mkdir -p /opt/local ; fi
echo "`cygpath -wa $OPT_LOCAL`  /opt/local ntfs binary,nouser 0 0"  >> /etc/fstab
echo "`cygpath -wa $VAR_LOCAL/tmp`  /tmp ntfs binary,nouser 0 0"  >> /etc/fstab
if [ ! -e $HOME/bin ] ; then mkdir -p $HOMEPATH/bin ; fi
echo "`cygpath -wa $DEV_HOME/shell/bin`  $HOME/bin ntfs binary,nouser 0 0"  >> /etc/fstab
if [ ! -e $HOME/.profile.d ] ; then mkdir -p $HOMEPATH/.profile.d ; fi
echo "`cygpath -wa $DEV_HOME/shell/profile.d`  $HOME/.profile.d ntfs binary,nouser 0 0"  >> /etc/fstab
if [ ! -e /var/www ] ; then mkdir -p /var/www ; fi
echo "`cygpath -wa $WEB_HOME`  /var/www ntfs binary,nouser 0 0"  >> /etc/fstab
