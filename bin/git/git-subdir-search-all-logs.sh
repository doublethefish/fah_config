CUR=$(echo $PWD)
for dir in $(find ${CUR} -name ".git"); do
	DIR=$(dirname $dir)
	FULLDIR=$CUR/${DIR}
	FULLDIR=${DIR}
	cd $FULLDIR
	echo -e "${TXTBoldCyan}${FULLDIR}${TXTNoColour}"
	echo $@
	git log --all -i --grep="${@}" | sed -E 's#^# ['${FULLDIR}'] #g'
done
