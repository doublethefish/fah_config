# a not-so-fast script to purge a file from the history of a repo

if [ -z $1 ]; then
	echo "Use:"
	echo "\t$0 <regex-of-files-in-history-to-remove>"
	exit 2
fi

# get all of the largest files in the repo
LARGEST_FILES=$(git-largest-files.sh)
LARGE_FILES_MATCHING_PARAMS=$(echo "$LARGEST_FILES" | sed 's/ /\n/g' | ag $1)
COUNT_OF_INPUT=$(echo "$LARGE_FILES_MATCHING_PARAMS" | wc -l)

echo "$1 matches $COUNT_OF_INPUT files"

if [[ "0" == "${COUNT_OF_INPUT}" ]]; then
	echo "no files to remove"
	echo "done"
	exit 2
fi

FILTER_STRING="git rm -rf --cached --ignore-unmatch $@"
echo ${FILTER_STRING}
CMD="git filter-branch --index-filter \"${FILTER_STRING}\" HEAD"
echo $CMD
$CMD
