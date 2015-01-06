
searchLib=$1

echo $searchLib

FCWD=`pwd`
IFS='
'
for lib in `find . -name "*.dylib" -o -name "*.so"`
do
  for path in `/usr/bin/otool -L ${FCWD}/${lib} | tail -n +2 | grep "${searchLib}"`
  do
    echo -e "\t${lib} : ${path}"
  done
done

