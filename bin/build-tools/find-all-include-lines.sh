#!/bin/bash
#echo "---FILES---"
#find ./src \( -not -ipath "*gtest*" \) -and \( -iname "*.cpp" -or -iname "*.h" \)
#echo "---INLCUDES---"
#find ./src \( -not -ipath "*gtest*" \) -and \( -iname "*.cpp" -or -iname "*.h" \) -exec grep -Hn "#include" '{}' \;
echo "---FILES---"
find ./src \( -not -ipath "*gtest*" \) -and \( -iname "*.h" \)
echo "---INLCUDES---"
find ./src \( -not -ipath "*gtest*" \) -and \( -iname "*.h" \) -exec grep -Hn "#include" '{}' \;
