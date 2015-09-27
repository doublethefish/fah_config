# A place to store useful aliases
alias ll="ls -GlFhkO"
alias la="ls -GAlFhkO"
alias ffind="find . -name "
alias ffindi="find . -iname "
alias hgrep="ffind \"*.h\" | xargs grep -n"
alias dev="cd ~/Development"
alias fah="dev && cd fah_products"
alias fn="dev && cd Foundry"

# Mac OS specific aliases
if [[ "$FAH_PLATFORM" == 'mac' ]]; then
  alias gvim="mvim"
fi


function vffind {
  gvim `ffind $@`
}

function vffindi {
  gvim `ffindi $@`
}
