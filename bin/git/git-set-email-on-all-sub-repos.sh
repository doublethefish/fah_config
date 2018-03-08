CUR=`echo $PWD`
for dir in `find ${CUR} -name ".git"`
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  pwd
  git config --list --show-origin | grep email
  git config user.email $1
  git config --list --show-origin | grep email
done
