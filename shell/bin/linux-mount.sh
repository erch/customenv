if [ ! -e $HOME/bin ] ; then 
    echo "you must create the $HOME/bin in the Home shared folder" 1>&2
    exit 1
fi
if [ ! -e $HOME/.profile.d ] ; then 
    echo "you must create the $HOME/.profile.d in the Home shared folder" 1>&2
    exit 1
fi

echo "Home /home vboxsf defaults 0 0"  >> /etc/fstab
echo "HomeBin  $HOME/bin  vboxsf defaults 0 0"  >> /etc/fstab
echo "HomeProfiled  $HOME/.profile.d vboxsf defaults 0 0"  >> /etc/fstab
if [ ! -e /var/local ] ; then mkdir -p /var/local ; fi
echo "VarLocal  /var/local vboxsf defaults 0 0"   >> /etc/fstab
if [ ! -e /opt/local ] ; then mkdir -p /opt/local ; fi
if [ ! -e /var/www ] ; then mkdir -p /var/www ; fi
echo "WebHome  /var/www vboxsf defaults 0 0"  >> /etc/fstab
if [ ! -e /opt/MyHome ] ; then mkdir -p /opt/MyHome ; fi
echo "MyHome  /opt/MyHome vboxsf defaults 0 0"  >> /etc/fstab

