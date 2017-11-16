OS_SPECIFIC_LS_OPTION=""
# Mac OS specific aliases
if [[ "$FAH_PLATFORM" == 'mac' ]]; then
  alias gvim="mvim"
  OS_SPECIFIC_LS_OPTION="O"
fi

# A place to store useful aliases
alias ll="ls -GlFhk${OS_SPECIFIC_LS_OPTION}"
alias la="ls -GAlFhk${OS_SPECIFIC_LS_OPTION}"
alias ffind="find . -name "
alias ffindi="find . -iname "
alias hgrep="ffind \"*.h\" | xargs grep -n"
alias dev="cd ${FAH_DEV_DIR}"
alias fah="dev && cd fah_products"
alias dtf="dev && cd doublethefish"
alias double="dtf"
alias doublethefish="dtf"


function vffind {
  gvim `ffind $@`
}

function vffindi {
  gvim `ffindi $@`
}
