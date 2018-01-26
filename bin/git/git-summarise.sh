set -o pipefail
source ~/.fah/bash/colours.sh

function get_repo_branches() {
	BRANCHES=$( git branch  -vv | sed 's/[\* \t]//')
	if [[ $? != 0 ]]; then
		echo "FUCKING HELL"
		exit 2
	fi
	echo "${BRANCHES}"
}

function get_branch_tag() {
	BRANCH=$1
	if [[ $BRANCH = *"["*":"*"]"* ]]; then
		if [[ $BRANCH = *"ahead"*"behind"* ]]; then
			echo "DIVERGED"
		else
			if [[ $BRANCH = *"ahead"* ]]; then
				echo "AHEAD"
			else
				if [[ $BRANCH = *"behind"* ]]; then
					echo "BEHIND"
				else
					if [[ $BRANCH = *"gone"* ]]; then
						echo "UPSTREAM DELETED"
					else
						echo "SPECIAL"
					fi
				fi
			fi
		fi
	else
		if [[ $BRANCH = *"["*"/"*"]"* ]]; then
			echo "OK"
		else
			echo "NO TRACKING BRANCH"
		fi
	fi
}

function annotate_branch_info() {
	BRANCH=$1
	TAG=$( get_branch_tag $BRANCH )

	if [[ $TAG != *"OK"* ]]; then
		echo "  [BRANCH] [$TAG] ${BRANCH:0:90}"
	fi
}

function get_repo_data() {
	DIR_NAME=$1
	cd ${DIR_NAME}
	pwd
	BRANCHES="$( get_repo_branches )"
	if [[ $? != 0 ]]; then
		echo "FUCKING HELL"
		exit 2
	fi
	IFS=$'\n'
	for BRANCH in ${BRANCHES}; do
		annotate_branch_info "$BRANCH"
	done;
}

#get_repo_data "/Users/frank/Development/angular-google-gapi_example"
#exit 2

CUR=`echo $1`
echo $CUR
CD_PFX=${CUR}/
if [[ ${CUR:0:1} == "/" ]]; then
	CD_PFX=
fi

find ${CUR} -name ".git" -type d -print0 | 
while IFS= read -r -d '' dir; do
	DIR=$( dirname "$dir" )
	get_repo_data ${CD_PFX}${DIR}
done
