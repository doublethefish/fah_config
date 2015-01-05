# aliases for git that don't fit intp any of the git configs
alias gd="git difftool -y"
alias dg="gd"

GIT_SEARCH_DIRS="/Applications/Xcode.app/Contents/Developer/usr/share/git-core /usr/local/git/contrib/completion"
for GIT_DIR in ${GIT_SEARCH_DIRS}; do
  GIT_SH_FILES="git-completion.bash git-prompt.sh"
  for GIT_SH in ${GIT_SH_FILES}; do
    GIT_SCRIPT=${GIT_DIR}/${GIT_SH}
    if [ -f  ${GIT_SCRIPT} ]; then
      source ${GIT_SCRIPT}
    fi
  done;
done;

