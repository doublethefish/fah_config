#!/bin/bash
# Enables using `bcompare` as the git-diff tool on supported platforms

##!/bin/sh
## diff is called by git with 7 parameters:
## path old-file old-hex old-mode new-file new-hex new-mode
bcompare "$2" "$5" -title1="$2 (Prev)" -title2="$5 (Working)" | cat
#echo "1 = $1"
#echo "2 = $2"
#echo "3 = $3"
#echo "4 = $4"
#echo "5 = $5"
#echo "6 = $6"
#echo -e "7 = $7\n\n"
exit 0
