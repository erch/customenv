function svnfind
{
    DIR=$1
    shift
    find $DIR -name .svn -prune -o $* -print
}
export -f svnfind