#!/bin/bash

#---------------------------------------------------------------
CPPFLAGS="-Iinclude/ -Iinclude/fah/ -Wall -Werror"
MD5TOOL="md5sum"
if [ 0 -eq `which ${MD5TOOL} | wc -l` ]
then
	MD5TOOL="md5"
	if [ 0 -eq `which ${MD5TOOL} | wc -l` ]
	then
		echo "Error! no MD5 checksum util found, exiting"
		exit 1
	fi
fi

#---------------------------------------------------------------
function tryBuild
{
	echo -e "\tcompiling $1"
	cat <<EOF >tmp.cc 
#include "${1}"
class X
{
public:
	virtual ~X(){};
};
class Y : public X
{
public:
	virtual ~Y(){};
};
int main() 
{ 
	X x;
	Y y;
	return 0; 
}
EOF
	g++ --pass-exit-codes ${CPPFLAGS} tmp.cc
	exitcode=$?
	if [ ${exitcode} -ne 0 ]
	then
		echo -e "\t\t{$1} FAILED width exitcode {$exitcode} - stopping!"
		cat -n tmp.cc
		exit $exitcode
	fi
	#echo "done $i, exit code was {$#}"
}

#---------------------------------------------------------------
function checkFile()
{
	md5line=`$MD5TOOL $1`
	
	md5num=`echo $md5line | sed 's/.* = \([a-fA-F0-9]\)/\1/'`

	if [ "$3" != "$md5num" ]
	then
		tryBuild $1
	fi
	echo "$1,$md5num" >> $2
}

#---------------------------------------------------------------
#---------------------------------------------------------------

if [ -n "$1" ]
then
	echo "changing to directory '$1'"
	cd $1
fi

crcfile=crcchecks
crcfiletmp=/tmp/crcchecks
if [ -f $crcfile ]
then
	echo "found $crcfile"
else
	echo "${crcfile} not found, creating!"
	echo "" > $crcfile
fi

echo "" > $crcfiletmp
for i in `ls include/fah/*.h`
do
	#echo "about to check $i"
	existingCrc=`grep "$i" $crcfile | sed 's/.*,\(.*\)/\1/'`
	checkFile "$i" "$crcfiletmp" "$existingCrc"
done

cp $crcfiletmp $crcfile

echo "done checking headers"


