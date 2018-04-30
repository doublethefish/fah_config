#FILES=$( find . -iname "*.ini" -o -iname "*.h" -o -iname "*.cpp" ) #
FILES=$( git status -uno | ag "modified" | sed 's/modified://' )
for file in ${FILES}; do
	dos2unix $file
	DIFF_COUNT_UNIX=$(git diff ${file} | wc -l)
	unix2dos $file
	DIFF_COUNT_WIN=$(git diff ${file} | wc -l)
	if [[ ${DIFF_COUNT_UNIX} < ${DIFF_COUNT_WIN} ]]; then
		dos2unix $file
	fi
done
