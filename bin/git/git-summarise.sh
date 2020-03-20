set -o pipefail
source ~/.fah/bash/colours.sh

function get_repo_branch_infos() {
	BRANCH_INFOS=$(git branch -vv | sed 's/[\* \t]//')
	if [[ $? != 0 ]]; then
		printf "get_repo_branch_infos failed\\n"
		exit 2
	fi
	echo "${BRANCH_INFOS}"
}

function git_branch_name() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
	if [[ $? != 0 ]]; then
		printf "git_branch_name failed\\n"
		exit 2
	fi
}

function count_edited_files() {
	EDITED_FILES=$(git status 2>&1 | grep "modified:" | wc -l | tr -d -c 0-9)
	#EXIT_CODE=$?
	#if [[ $EXIT_CODE != 0 ]]; then
	#	printf "count_edited_files failed with exit $EXIT_CODE and message: %s\\n" "$EDITED_FILES"
	#	exit $EXIT_CODE
	#fi
	printf "%s\\n"  "$EDITED_FILES"
}

function upstream_candidate_branches() {
	CUR_BRANCH=${1}
	git branch -r | grep "${CUR_BRANCH}"
	if [[ $? != 0 ]]; then
		printf "upstream_candidate_branches failed\\n"
		exit 2
	fi
}

function get_branch_tag() {
	BRANCH=$1
	if [[ $BRANCH == *"["*":"*"]"* ]]; then
		if [[ $BRANCH == *"ahead"*"behind"* ]]; then
			echo "${TXTRed}DIVERGED${TXTNoColour}"
		else
			if [[ $BRANCH == *"ahead"* || $BRANCH == *"delante"* ]]; then
				echo "${TXTRed}AHEAD${TXTNoColour}"
			else
				if [[ $BRANCH == *"behind"* || $BRANCH == *"detrás"* ]]; then
					echo "${TXTGreen}BEHIND${TXTNoColour}"
				else
					if [[ $BRANCH == *"gone"* ]]; then
						echo "${TXTRed}UPSTREAM DELETED${TXTNoColour}"
					else
						echo "${TXTYellow}CHECK ME${TXTNoColour}"
					fi
				fi
			fi
		fi
	else
		if [[ $BRANCH == *"["*"/"*"]"* || $BRANCH == *"HEAD detached"* || $BRANCH == *"HEAD desacoplada"* ]]; then
			echo "OK"
		#else
		#	echo "${TXTRed}NO UPSTREM BRANCH${TXTNoColour} $(echo ${BRANCH} | awk '{print $1}')"
		#	for CAND in $(upstream_candidate_branches);
		#	do
		#		echo "\t\t$CAND"
		#	done
		else
			echo "${TXTRed}NO UPSTREAM!${TXTNoColour}"
		fi
	fi
}

function annotate_branch_info() {
	BRANCH_INFO=$1
	TAG=$(get_branch_tag $BRANCH_INFO)

	if [[ $TAG != *"OK"* ]]; then
		printf "    %s: %s\\n" "$TAG" "${BRANCH_INFO:0:120}"
	fi
}

function get_repo_data() {
	DIR_NAME=$1
	cd "${DIR_NAME}"

	REPO_OK=$(git status 2>&1)
	EXIT_CODE=$?
	if [[ $EXIT_CODE != 0 ]]; then
		printf "   ${TXTRed}REPOSITORY IS CORRUPT${TXTNoColour} (exit from git-statue was %s)\\n" "$EXIT_CODE"
		return
	fi

	CUR_BRANCH=$(git_branch_name)

	EDITED_FILES=$(count_edited_files)
	EXIT_CODE=$?
	if [[ $EXIT_CODE != 0 ]]; then
		printf "get_repo_data (1) failed with %s and %s\\n" "$EXIT_CODE" "$EDITED_FILES"
		return
	fi

	if [[ ${EDITED_FILES} != 0 ]]; then
		EDITED_FILES=", has ${TXTRed}${EDITED_FILES}${TXTNoColour} edits"
		echo "${TXTYellow}${CUR_BRANCH}${TXTNoColour} ${EDITED_FILES}"
	else
		EDITED_FILES=$(annotate_branch_info ${CUR_BRANCH})
	fi

	BRANCH_INFOS="$(get_repo_branch_infos)"
	if [[ $? != 0 ]]; then
		printf "get_repo_data (2) failed\\n"
		exit 2
	fi
	IFS=$'\n'
	for BRANCH_INFO in ${BRANCH_INFOS}; do
		annotate_branch_info "$BRANCH_INFO"
	done
}

#get_repo_data "/Users/frank/Development/angular-google-gapi_example"
#exit 2

if [ -z $1 ]; then
	CUR="."
else
	CUR=$(echo $1)
fi
echo "Search from: $CUR"
CD_PFX=${CUR}/
if [[ ${CUR:0:1} == "/" ]]; then
	CD_PFX=
fi
if [[ ${CD_PFX} == "./" ]]; then
	CD_PFX=
fi

find ${CUR} -name ".git" -type d -print0 |
	while IFS= read -r -d '' dir; do
		DIR=$(dirname "$dir")
		if [[ $? != 0 ]]; then
			echo "FUCKED 1"
		fi
		printf "${TXTCyan}$DIR${TXTNoColour}:\\n"
		CUR_DIR=$(pwd)
		get_repo_data "${CD_PFX}${DIR}"
		if [[ $? != 0 ]]; then
			echo "FUCKED"
		fi
		cd $CUR_DIR
	done
