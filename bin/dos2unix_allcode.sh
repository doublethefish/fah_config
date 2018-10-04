FILES=$( find .  -iname "*.py"  \
              -o -iname "*.cpp" \
              -o -iname "*.h"   \
              -o -iname "*.inl" \
              -o -iname "*.c"   \
              -o -iname "*.pro" \
              -o -iname "*.yml" \
              -o -iname "CmakeLists.txt" \
              -o -iname "*.cmake" \
              -o -iname "*.sh" \
              -o -iname ".gitignore" \
              -o -iname "*.pri" )
echo "Converting"
for file in $FILES; do
  printf "\t${file} :"
  dos2unix "$file"
done
echo "Done from '${PWD}'"
