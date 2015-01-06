# aliases for svn tools that can't be represented in svn's .config

if [ -z $FAH_BIN ]; then
  echo "WARNING: FAH_BIN hasn't been set!"
fi

# svn diff
alias kdiff3="/Developer/Applications/Utilities/kdiff3.app/Contents/MacOS/kdiff3"
alias sd='svn diff --diff-cmd=${FAH_BIN}/svn-diff-beyondcompare.sh'
#alias sd="svn diff --diff-cmd ~/bin/svn_diff_mac.bash"

