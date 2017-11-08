#!/bin/sh
# Enables using kdiff3 as the diff-tool for git

PWD=`pwd`
FILE_2=${PWD}/${5}
if [ ! -f ${FILE_2} ]
then
	FILE_2="${5}"
fi

/Developer/Applications/Utilities/kdiff3.app/Contents/MacOS/kdiff3 "$2" "${FILE_2}" > /dev/null 2>&1
exit 0
