IP=$(hostname -I)
CMD="add-apt-repository \"deb http://${IP}:8090/ /\""
echo $CMD
sudo chroot /var/chroot $CMD