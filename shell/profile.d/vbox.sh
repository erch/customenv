echo -n "."

if [ "$OSTYPE" = "cygwin" ] ; then  
    convertenvvar VBOX_INSTALL_PATH  
    pathmunge "$VBOX_INSTALL_PATH" after
fi
