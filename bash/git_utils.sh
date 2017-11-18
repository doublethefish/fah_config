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
  BREW_GIT_DIR=$(brew --prefix bash-git-prompt)/share

  __GIT_PROMPT_DIR=${BREW_GIT_DIR}
  export __GIT_PROMPT_DIR

  GIT_SEARCH_DIRS="$GIT_SEARCH_DIRS ${BREW_GIT_DIR}"
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
done;

if [[ ! -z ${GIT_PROMPT} ]] || [[ -f  ${GIT_PROMPT} ]]; then
  source ${GIT_PROMPT}
else
  echo "Git-prompt script not found: ${GIT_COMPLETION_FILES}"
fi
