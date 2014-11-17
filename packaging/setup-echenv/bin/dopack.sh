#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`


. ${MY_DIR}/../../bin/packagingutils.sh
createAndPublishDeb  "${MY_DIR}/.." echenv-setup_1.0.2_all.deb

