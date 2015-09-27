
if [ -z $FAH_BIN ]; then
  echo "WARNING: FAH_BIN hasn't been set!"
fi

# aliases for git that don't fit intp any of the git configs
alias gd="git difftool -y"
alias dg="gd"

GIT_SEARCH_DIRS="/Applications/Xcode.app/Contents/Developer/usr/share/git-core /usr/local/git/contrib/completion"

if [[ "${FAH_PLATFORM}" == "mac" ]]; then
  GIT_SEARCH_DIRS="$GIT_SEARCH_DIRS $(brew --prefix bash-git-prompt)"
fi

GIT_COMPLETION_FILES="git-completion.bash"
GIT_PROMPT_FILES="gitprompt.sh git-prompt.sh"
unset GIT_PROMPT
unset GIT_COMPLETE
for GIT_DIR in ${GIT_SEARCH_DIRS}; do
  if [ ! -e ${GIT_DIR} ]; then
    continue
  fi

  if [ -z ${GIT_PROMPT} ]; then
    for GIT_PROMPT_CAND in ${GIT_PROMPT_FILES}; do
      GIT_PROMPT=${GIT_DIR}/${GIT_PROMPT_CAND}
    done;
  fi

  if [ -z ${GIT_PROMPT} ]; then
    for GIT_COMPLETE_CAND in ${GIT_COMPLETION_FILES}; do
      GIT_COMPLETE=${GIT_DIR}/${GIT_COMPLETE_CAND}
    done;
  fi
done;

GIT_PROMPT_THEME=Default

if [ ! -z  ${GIT_PROMPT} ]; then
  source ${GIT_PROMPT}
else
  echo "Git-prompt script not found: ${GIT_PROMPT_FILES}"
fi

if [ ! -z  ${GIT_COMPLETE} ]; then
  source ${GIT_COMPLETE}
else
  echo "Git-complete script not found: ${GIT_COMPLETION_FILES}"
fi
