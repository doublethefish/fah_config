CUR=`echo $PWD`
for dir in $( find ${CUR} -name ".git" )
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  pwd
  git lfs pull | sed -E 's#^# ['${FULLDIR}'] #g'
done
