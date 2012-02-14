#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`

${MY_DIR}/../setup-echenv/bin/dopack.sh
${MY_DIR}/../emacs-echenv/bin/dopack.sh
${MY_DIR}/../java-echenv/bin/dopack.sh
${MY_DIR}/../privacy-echenv/bin/dopack.sh