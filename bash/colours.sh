####################################
###         Colours             ####
####################################

## enable color support of ls and also add handy aliases
# FIXME: do I want this? /FH
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
# TODO: consolidate the `case` and the `if` below
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  echo "FIXME: Colour support not detected, I suspect it's a lie, is tput missing (e.g. it is in git-bash"
  # TODO: redo this when tput or alternative is found: color_prompt=
  color_prompt=yes
fi


# Currently these are mac-specific
if [ "$color_prompt" = yes ]; then
  TXTNoColour="\033[0m"
  TXTBlack="\033[0;30m"
  TXTRed="\033[0;31m"
  TXTGreen="\033[0;32m"
  TXTBrown="\033[0;33m"
  TXTBlue="\033[0;34m"
  TXTPurple="\033[0;35m"
  TXTCyan="\033[0;36m"
  TXTGrey="\033[0;37m"
  TXTUnknown1="\033[0;38m"
  TXTUnknown2="\033[0;39m"
  TXTDarkGray="\033[1;30m"
  TXTBoldRed="\033[1;31m"
  TXTBoldGreen="\033[1;32m"
  TXTBoldYellow="\033[1;33m"
  TXTBoldBlue="\033[1;34m"
  TXTBoldPurple="\033[1;35m"
  TXTBoldCyan="\033[1;36m"
  TXTBoldWhite="\033[1;37m"
  # PS1 colours require \[ and \] to denote non-printable characters
  PS1_TXTNoColour="\[${TXTNoColour}\]"
  PS1_TXTBlack="\[${TXTBlack}\]"
  PS1_TXTRed="\[${TXTRed}\]"
  PS1_TXTGreen="\[${TXTGreen}\]"
  PS1_TXTBrown="\[${TXTBrown}\]"
  PS1_TXTBlue="\[${TXTBlue}\]"
  PS1_TXTPurple="\[${TXTPurple}\]"
  PS1_TXTCyan="\[${TXTCyan}\]"
  PS1_TXTGrey="\[${TXTGrey}\]"
  PS1_TXTUnknown1="\[${TXTUnknown1}\]"
  PS1_TXTUnknown2="\[${TXTUnknown2}\]"
  PS1_TXTDarkGray="\[${TXTDarkGray}\]"
  PS1_TXTBoldRed="\[${TXTBoldRed}\]"
  PS1_TXTBoldGreen="\[${TXTBoldGreen}\]"
  PS1_TXTBoldYellow="\[${TXTBoldYellow}\]"
  PS1_TXTBoldBlue="\[${TXTBoldBlue}\]"
  PS1_TXTBoldPurple="\[${TXTBoldPurple}\]"
  PS1_TXTBoldCyan="\[${TXTBoldCyan}\]"
  PS1_TXTBoldWhite="\[${TXTBoldWhite}\]"
else
  echo "FIXME: Colour support not detected, I suspect it's a lie, is tput missing (e.g. it is in git-bash"
  # copies of the above for when colours aren't supported
  TXTNoColour=""
  TXTBlack=""
  TXTRed=""
  TXTGreen=""
  TXTBrown=""
  TXTBlue=""
  TXTPurple=""
  TXTCyan=""
  TXTGrey=""
  TXTUnknown1=""
  TXTUnknown2=""
  TXTDarkGray=""
  TXTBoldRed=""
  TXTBoldGreen=""
  TXTBoldYellow=""
  TXTBoldBlue=""
  TXTBoldPurple=""
  TXTBoldCyan=""
  TXTBoldWhite=""
  PS1_TXTNoColour=""
  PS1_TXTBlack=""
  PS1_TXTRed=""
  PS1_TXTGreen=""
  PS1_TXTBrown=""
  PS1_TXTBlue=""
  PS1_TXTPurple=""
  PS1_TXTCyan=""
  PS1_TXTGrey=""
  PS1_TXTUnknown1=""
  PS1_TXTUnknown2=""
  PS1_TXTDarkGray=""
  PS1_TXTBoldRed=""
  PS1_TXTBoldGreen=""
  PS1_TXTBoldYellow=""
  PS1_TXTBoldBlue=""
  PS1_TXTBoldPurple=""
  PS1_TXTBoldCyan=""
  PS1_TXTBoldWhite=""
fi

##Reset="\[$(tput sgr0)\]"
# DEBUG COLOURS: echo -e "${TXTUnknown1}TXTUnknown1, \n${TXTUnknown2}TXTUnknown2, \n${TXTBlack}TXTBlack, \n${TXTRed}TXTRed, \n${TXTGreen}TXTGreen, \n${TXTBrown}TXTBrown, \n${TXTBlue}TXTBlue, \n${TXTPurple}TXTPurple, \n${TXTCyan}TXTCyan, \n${TXTDarkGray}TXTDarkGray, \n${TXTBoldRed}TXTBoldRed, \n${TXTBoldGreen}TXTBoldGreen, \n${TXTBold}TXTBold, \n${TXTBoldBlue}TXTBoldBlue, \n${TXTBoldPurple}TXTBoldPurple, \n${TXTBoldCyan}TXTBoldCyan, \n${TXTBoldWhite}TXTBoldWhite, \n${TXTGrey}TXTGrey"
## Set prompt
##PS1="${TXTCyan}\w ${TXTBrown}$ ${TXTGreen}${Reset}"
#export PS1="${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTNoColour}"
# Set prompt
#PS1="${TXTCyan}\w ${TXTBrown}$ ${TXTGreen}${Reset}"
#PS1="${TXTCyan}$PROMPT_COMMAND${TXTBrown}\$ ${TXTGreen}${TXTGrey}" # "${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTGrey}"
#echo "Setting PS1"
SHORT_HOST_NAME=`echo ${HOSTNAME} | sed 's/\..*//'` # strip off everything after the first dot
SHORT_HOST_NAME=`echo ${SHORT_HOST_NAME} | sed 's/\(.\).*\(.\)$/\1\2/'` # strip off everything after the first dot
SHORT_HOST_NAME=`echo ${SHORT_HOST_NAME} | tr '[:upper:]' '[:lower:]'` # make lower case
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
PS1="${PS1_TXTBoldWhite}${SHORT_HOST_NAME} ${PS1_TXTCyan}\w${PS1_TXTBrown}\$(parse_git_branch)\\\$ ${PS1_TXTGreen}${PS1_TXTGrey}" # "${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTGrey}"
#PS1="\[${TXTBoldWhite}]]${SHORT_HOST_NAME}\{${TXTCyan}]]\w\[${TXTBrown}]]\$ \[${TXTGrey}]]" # "${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTGrey}"
export PS1

# LSCOLORS     "abcdabcdabcdabcdabcdab"
#               1.2.3.4.5.6.7.8.9.1011
export LSCOLORS="dxfxcxdxCeegedabagacDa"
#LS_COLORS="ow=01;31:di=04;93:fi=36:ln=target:ex=01;35"


CLICOLOR="yes"
####################################
###         ~Colours            ####
####################################
