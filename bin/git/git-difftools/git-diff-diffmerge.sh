#!/bin/sh
# Use diffmerge as the tool for git-diff

PWD=$(pwd)
FILE_2=${PWD}/${5}
if [ ! -f ${FILE_2} ]; then
	FILE_2="${5}"
fi

#diffmerge --merge --result=\$MERGED \$LOCAL \$BASE \$REMOTE"
/usr/bin/diffmerge

exit 0
