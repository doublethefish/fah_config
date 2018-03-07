CUR=`echo $PWD`
for dir in `find ${CUR} -name ".git" -type d`
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  pwd
	echo $@
  git log --all -i --grep="${@}" | sed -E 's#^# ['${FULLDIR}'] #g'
done
