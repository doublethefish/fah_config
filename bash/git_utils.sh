GIT_PROMPT_THEME=Default
export GIT_PROMPT_THEME

if [ -z $FAH_BIN ]; then
	echo "WARNING: FAH_BIN hasn't been set!"
fi

# aliases for git that don't fit intp any of the git configs
alias gd="git difftool -y"
alias dg="gd"
alias gg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
