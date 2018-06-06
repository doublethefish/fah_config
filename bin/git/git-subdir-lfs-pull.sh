source ~/.fah/bash/colours.sh
CUR=`echo $PWD`
for dir in `find ${CUR} -name ".git"`
do
  DIR=`dirname $dir`
  FULLDIR=$CUR/${DIR}
  FULLDIR=${DIR}
  cd $FULLDIR
  echo -e "${TXTBoldCyan}${FULLDIR}${TXTNoColour}"

  OUTPUT=$( git lfs pull )
  IFS=$'\n'
  read -r -a array <<< "${OUTPUT}"
  for i in "${array[@]}"; do
      IFS=$'\r'
      read -r -a array_cr <<< "${OUTPUT}"
      for j in "${array_cr[@]}"; do
        echo -e "${TXTNoColour} [${TXTBrown}${FULLDIR}${TXTNoColour}] $j"
      done
  done
done
