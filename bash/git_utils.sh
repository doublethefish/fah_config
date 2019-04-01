GIT_PROMPT_THEME=Default
export GIT_PROMPT_THEME

if [ -z $FAH_BIN ]; then
	echo "WARNING: FAH_BIN hasn't been set!"
fi

# aliases for git that don't fit intp any of the git configs
alias gd="git difftool -y"
alias dg="gd"

GIT_SEARCH_DIRS="/usr/local/git/contrib/completion"

if [[ "${FAH_PLATFORM}" == "mac" ]]; then

	# disable on mac until I can work out why my custom PS1 is being overwritten
	GIT_SEARCH_DIRS=""

	# Hardcode the search for the bash-completion. There might be a better way to
	# do this
	[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
fi

GIT_COMPLETION_FILES="git-completion.bash"
GIT_PROMPT_FILES="gitprompt.sh git-prompt.sh"
unset GIT_PROMPT
for GIT_DIR in ${GIT_SEARCH_DIRS}; do
	if [ ! -e ${GIT_DIR} ]; then
		continue
	fi

	if [ -z ${GIT_PROMPT} ]; then
		for GIT_PROMPT_CAND in ${GIT_PROMPT_FILES}; do
			CAND=${GIT_DIR}/${GIT_PROMPT_CAND}
			if [ -f ${CAND} ]; then
				GIT_PROMPT=${CAND}
			fi
		done
	fi
done

if [[ ! -z ${GIT_PROMPT} ]] && [[ -f ${GIT_PROMPT} ]]; then
	source ${GIT_PROMPT}
	echo ${GIT_PROMPT}
else
	echo "Git-prompt script not found: ${GIT_COMPLETION_FILES}"
fi
