echo "$FAH_PLATFORM"

if [[ -z $FAH_PLATFORM ]]; then
  echo "FAH_PLATFORM not set!"
  exit 2
fi

if [[ "$FAH_PLATFORM" == 'mac' ]]; then
  LIB_DEPS_CMD="/usr/bin/otool -L "
elif [[ "$FAH_PLATFORM" == 'linux' ]]; then
  LIB_DEPS_CMD="readelf -d | grep NEEDED | sed 's/.*\[\(.*\)\]/\1/g'"
else
  echo "Unsupported platform! ${FAH_PLATFORM}"
fi

searchLib=$1

echo $searchLib

FCWD=`pwd`
IFS='
'
for lib in `find . -name "*.dylib" -o -name "*.so"`
do
  for path in `echo ${FCWD}/${lib} | xargs ${LIB_DEPS_CMD} | tail -n +2 | grep "${searchLib}"`
  do
    echo -e "\t${lib} : ${path}"
  done
done

