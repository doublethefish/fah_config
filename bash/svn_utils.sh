# aliases for svn tools that can't be represented in svn's .config

if [ -z $FAH_BIN ]; then
	echo "WARNING: FAH_BIN hasn't been set!"
fi

# svn diff
alias kdiff3="/Developer/Applications/Utilities/kdiff3.app/Contents/MacOS/kdiff3"

if [[ "${FAH_PLATFORM}" == "mac" ]]; then
	# diffmerge is pretty good but opendiff (aka Filemerge) is better
	#eval DIFF_CMD=${FAH_BIN}/svn-diff-mac-diffmerge.sh
	eval DIFF_CMD=${FAH_BIN}/svn-diff-mac-opendiff.sh
elif [[ "${FAH_PLATFORM}" == "linux" ]]; then
	# TODO: check that beyond compare works
	eval DIFF_CMD=${FAH_BIN}/svn-diff-beyondcompare.sh
else
	# default to vimdiff for the mo
	# do - diff obtain
	# dp - diff put
	eval DIFF_CMD=${FAH_BIN}/svn-diff-vimdiff.sh
fi

# setup the sd command
alias sd="svn diff --diff-cmd=${DIFF_CMD}"

if [[ -e /opt/subversion/bin/ ]]; then
	PATH=${PATH}:/opt/subversion/bin/
fi
