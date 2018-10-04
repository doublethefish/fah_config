#!/bin/sh

if [ "$#" != "3" ]
then
	echo "${0} <OLD_EMAIL> <NEW_EMAIL> <NAME>"
	exit 1
fi

export OLD_EMAIL=$1
export CORRECT_EMAIL=$2
export CORRECT_NAME=$3

echo $OLD_EMAIL $CORRECT_EMAIL $CORRECT_NAME

git filter-branch --env-filter ' 
if [ "${GIT_COMMITTER_EMAIL}" = "${OLD_EMAIL}" ]
	then
			export GIT_COMMITTER_NAME="${CORRECT_NAME}"
			export GIT_COMMITTER_EMAIL="${CORRECT_EMAIL}"
	fi
	if [ "$GIT_AUTHOR_EMAIL" = "${OLD_EMAIL}" ]
	then
			export GIT_AUTHOR_NAME="${CORRECT_NAME}"
			export GIT_AUTHOR_EMAIL="${CORRECT_EMAIL}"
	fi' --tag-name-filter cat -- --branches --tags
