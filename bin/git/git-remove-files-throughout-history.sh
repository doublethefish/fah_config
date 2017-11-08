# a not-so-fast script to purge a file from the history of a repo
FILTER_STRING="git rm --cached --ignore-unmatch $@"
echo ${FILTER_STRING}
git filter-branch --index-filter '${FILTER_STRING}' HEAD
