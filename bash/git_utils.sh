GIT_PROMPT_THEME=Default
export GIT_PROMPT_THEME

if [ -z $FAH_BIN ]; then
	echo "WARNING: FAH_BIN hasn't been set!"
fi

# aliases for git that don't fit intp any of the git configs
alias gd="git difftool -y"
alias dg="gd"
