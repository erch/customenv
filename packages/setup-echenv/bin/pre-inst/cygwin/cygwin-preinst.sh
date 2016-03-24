#! /bin/bash
#  -*- Shell-Script -*-

set -x
PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

. ${MY_DIR}/init-cygwin.sh
. ${MY_DIR}/cygwin-mounts.sh
