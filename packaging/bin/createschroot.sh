#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

PACKAGING_ROOT=`perl -e 'use Cwd;print Cwd::abs_path("'$MY_DIR'");'`
cat > /etc/schroot/chroot.d/packaging.conf <<-EOF 
	[packaging]
	type=directory
	description=packaging chroot
	directory=/srv/packaging
	root-users=$USER
	users=$USER
	script-config=packaging/config
	preserve-environment=false
EOF

mkdir -p /etc/schroot/packaging/

cat > /etc/schroot/packaging/config <<-EOF 
	# Filesystems to mount inside the chroot.
	FSTAB="/etc/schroot/packaging/fstab"
	# Files to copy from the host system into the chroot.
	COPYFILES="/etc/schroot/packaging/copyfiles"
	# System NSS databases to copy into the chroot.
	NSSDATABASES="/etc/schroot/default/nssdatabases"
EOF

cat > /etc/schroot/packaging/copyfiles <<-EOF 
	/etc/resolv.conf
	/etc/gshadow
EOF

cat > /etc/schroot/packaging/fstab <<-EOF 
	/proc		/proc		none    rw,bind        0       0
	/sys		/sys		none    rw,bind        0       0
	/dev            /dev            none    rw,bind         0       0
	/dev/pts	/dev/pts	none	rw,bind		0	0
	/tmp		/tmp		none	rw,bind		0	0
EOF

cp ${MY_DIR}/90packagingchroot /etc/schroot/setup.d/