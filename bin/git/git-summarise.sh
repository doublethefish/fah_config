set -o pipefail
source ~/.fah/bash/colours.sh

function get_repo_branches() {
	BRANCHES=$(git branch -vv | sed 's/[\* \t]//')
	if [[ $? != 0 ]]; then
		echo "FUCKING HELL"
		exit 2
	fi
	echo "${BRANCHES}"
}

function git_branch_name() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function count_edited_files() {
	COUNT=$(git status | grep "modified:" | wc -l)
	echo ${COUNT}
}

function upstream_candidate_branches() {
	CUR_BRANCH=${1}
	CANDIDIATES=$(git branch -r | grep "${CUR_BRANCH}")
	echo ${CANDIDIATES}
}

function get_branch_tag() {
	BRANCH=$1
	if [[ $BRANCH == *"["*":"*"]"* ]]; then
		if [[ $BRANCH == *"ahead"*"behind"* ]]; then
			echo "DIVERGED"
		else
			if [[ $BRANCH == *"ahead"* ]]; then
				echo "AHEAD"
			else
				if [[ $BRANCH == *"behind"* ]]; then
					echo "BEHIND"
				else
					if [[ $BRANCH == *"gone"* ]]; then
						echo "UPSTREAM DELETED"
					else
						echo "SPECIAL"
					fi
				fi
			fi
		fi
	else
		if [[ $BRANCH == *"["*"/"*"]"* ]]; then
			echo "OK"
		else
			echo "NO UP BRANCH ($(upstream_candidate_branches $(echo ${BRANCH} | awk '{print $1}')))"
		fi
	fi
}

function annotate_branch_info() {
	BRANCH=$1
	TAG=$(get_branch_tag $BRANCH)

	if [[ $TAG != *"OK"* ]]; then
		echo "  [BRANCH] [$TAG] ${BRANCH:0:120}"
	fi
}

function get_repo_data() {
	DIR_NAME=$1
	cd ${DIR_NAME}

	EDITED_FILES=$(count_edited_files)
	if [[ ${EDITED_FILES} != 0 ]]; then
		EDITED_FILES="[WIP:${EDITED_FILES}] "
	fi

	echo "$(pwd): $(git_branch_name) ${EDITED_FILES}"

	BRANCHES="$(get_repo_branches)"
	if [[ $? != 0 ]]; then
		echo "FUCKING HELL"
		exit 2
	fi
	IFS=$'\n'
	for BRANCH in ${BRANCHES}; do
		annotate_branch_info "$BRANCH"
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
		echo $DIR
		CUR_DIR=$(pwd)
		get_repo_data ${CD_PFX}${DIR}
		cd $CUR_DIR
	done
