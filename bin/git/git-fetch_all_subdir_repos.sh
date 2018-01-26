CUR=`echo $PWD`
for dir in `find ${CUR} -name ".git" -type d`
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  pwd
  git fetch --all --prune | sed -E 's#^# ['${FULLDIR}'] #g'
done
