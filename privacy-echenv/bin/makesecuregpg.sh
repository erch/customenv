#! /bin/bash
#  -*- Shell-Script -*-

PRG="$0"
# What's my name?
read MY_NAME MY_DIR <<< `perl -e 'use Cwd;use File::Basename;print File::Basename::basename("'$PRG'") . " " . Cwd::abs_path( File::Basename::dirname("'$PRG'") ) . "\n";'`



TMP_DIR=/tmp/temp-sec$$
mkdir ${TMP_DIR}
PWDBACK=`pwd`
cd ${TMP_DIR}
for F in github_dsa github_dsa.pub  id_dsa  id_dsa.pub github-apitoken.txt.pgp ; do
    cp ~/.ssh/$F .
done
gpg --export-secret-keys --armor -o gpgkeys.asc  eric@chastan-jeannin.fr 
tar cvzf keys.tgz *
gpg -c -o $PWDBACK/keys.tgz.pgp keys.tgz
cd ${TMP_DIR}
rm -rf ${TMP_DIR}