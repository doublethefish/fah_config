source ~/.fah/bash/colours.sh
CUR=`echo $PWD`
for dir in `find ${CUR} -name ".git" -type d`
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  pwd

  OUTPUT=$( git fetch --all --prune )
  IFS=$'\n'
  read -r -a array <<< "${OUTPUT}"
  for i in "${array[@]}"; do
      echo -e "${TXTNoColour} [${TXTYellow}${FULLDIR}${TXTNoColour}] $i"
  done
done
