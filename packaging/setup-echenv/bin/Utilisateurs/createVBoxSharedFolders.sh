convertenvvar VBOX_INSTALL_PATH HOMEPATH

if [ $# -ne 1 ] ; then
    echo "parameter vm name mandatory" 1>&2
    exit 1
fi

VM=$1
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "MyHome" --hostpath "`cygpath -wa \"$DEV_HOME/..\"`"
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "Home" --hostpath "`cygpath -wa \"$HOMEPATH/..\"`"
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "VarLocal" --hostpath "`cygpath -wa \"$VAR_LOCAL\"`"
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "HomeBin" --hostpath "`cygpath -wa \"$DEV_HOME/shell/bin\"`"
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "HomeProfiled" --hostpath "`cygpath -wa \"$DEV_HOME/shell/profile.d\"`"
"$VBOX_INSTALL_PATH"/VBoxManage.exe sharedfolder add "$VM" --name "WebHome" --hostpath "`cygpath -wa \"$WEB_HOME\"`"
