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
fi

# fall-back
if [ "$color_prompt" != yes ]; then
	# check if stdout is a terminal...
	if test -t 1; then

		# see if it supports colors...
		ncolors=$(tput colors)

		if test -n "$ncolors" && test $ncolors -ge 8; then
			color_prompt=yes
		fi
	fi
fi

# Currently these are mac-specific
if [ "$color_prompt" != yes ]; then
	echo "FIXME: Colour support not detected."
	echo "\t: This is possibly a lie; is tput missing?"
else
	if [ -n "$ZSH_VERSION" ]; then
		printf "Using ZSH\\n"
		export TXTNoColour="%f"
		export TXTNoBold="%b"
		export TXTBlack="%F{black}"
		export TXTRed="%F{red}"
		export TXTGreen="%F{green}"
		export TXTYellow="%F{yellow}"
		export TXTBlue="%F{blue}"
		export TXTPurple="%F{purple}"
		export TXTCyan="%F{cyan}"
		export TXTGrey="%F{grey}"
		export TXTUnknown1="%F{unknown1}"
		export TXTUnknown2="%F{unknown2}"
		export TXTDarkGray="%F{darkGray}"
		export TXTBoldRed="%B%F{red}"
		export TXTBoldGreen="%B%F{green}"
		export TXTBoldYellow="%B%F{yellow}"
		export TXTBoldBlue="%B%F{blue}"
		export TXTBoldPurple="%B%F{purple}"
		export TXTBoldCyan="%B%F{cyan}"
		export TXTBoldWhite="%B%F{white}"

		# PS1 colours require \[ and \] to denote non-printable characters
		export PS1_TXTNoColour="${TXTNoColour}"
		export PS1_TXTNoBold="${TXTNoBold}"
		export PS1_TXTBlack="${TXTBlack}"
		export PS1_TXTRed="${TXTRed}"
		export PS1_TXTGreen="${TXTGreen}"
		export PS1_TXTYellow="${TXTYellow}"
		export PS1_TXTBlue="${TXTBlue}"
		export PS1_TXTPurple="${TXTPurple}"
		export PS1_TXTCyan="${TXTCyan}"
		export PS1_TXTGrey="${TXTGrey}"
		export PS1_TXTUnknown1="${TXTUnknown1}"
		export PS1_TXTUnknown2="${TXTUnknown2}"
		export PS1_TXTDarkGray="${TXTDarkGray}"
		export PS1_TXTBoldRed="${TXTBoldRed}"
		export PS1_TXTBoldGreen="${TXTBoldGreen}"
		export PS1_TXTBoldYellow="${TXTBoldYellow}"
		export PS1_TXTBoldBlue="${TXTBoldBlue}"
		export PS1_TXTBoldPurple="${TXTBoldPurple}"
		export PS1_TXTBoldCyan="${TXTBoldCyan}"
		export PS1_TXTBoldWhite="${TXTBoldWhite}"
	else
		export TXTNoColour="\033[0m"
		export TXTNoBold=""
		export TXTBlack="\033[0;30m"
		export TXTRed="\033[0;31m"
		export TXTGreen="\033[0;32m"
		export TXTYellow="\033[0;33m"
		export TXTBlue="\033[0;34m"
		export TXTPurple="\033[0;35m"
		export TXTCyan="\033[0;36m"
		export TXTGrey="\033[0;37m"
		export TXTUnknown1="\033[0;38m"
		export TXTUnknown2="\033[0;39m"
		export TXTDarkGray="\033[1;30m"
		export TXTBoldRed="\033[1;31m"
		export TXTBoldGreen="\033[1;32m"
		export TXTBoldYellow="\033[1;33m"
		export TXTBoldBlue="\033[1;34m"
		export TXTBoldPurple="\033[1;35m"
		export TXTBoldCyan="\033[1;36m"
		export TXTBoldWhite="\033[1;37m"

		# PS1 colours require \[ and \] to denote non-printable characters
		export PS1_TXTNoColour="\[${TXTNoColour}\]"
		export PS1_TXTNoBold=""
		export PS1_TXTBlack="\[${TXTBlack}\]"
		export PS1_TXTRed="\[${TXTRed}\]"
		export PS1_TXTGreen="\[${TXTGreen}\]"
		export PS1_TXTYellow="\[${TXTYellow}\]"
		export PS1_TXTBlue="\[${TXTBlue}\]"
		export PS1_TXTPurple="\[${TXTPurple}\]"
		export PS1_TXTCyan="\[${TXTCyan}\]"
		export PS1_TXTGrey="\[${TXTGrey}\]"
		export PS1_TXTUnknown1="\[${TXTUnknown1}\]"
		export PS1_TXTUnknown2="\[${TXTUnknown2}\]"
		export PS1_TXTDarkGray="\[${TXTDarkGray}\]"
		export PS1_TXTBoldRed="\[${TXTBoldRed}\]"
		export PS1_TXTBoldGreen="\[${TXTBoldGreen}\]"
		export PS1_TXTBoldYellow="\[${TXTBoldYellow}\]"
		export PS1_TXTBoldBlue="\[${TXTBoldBlue}\]"
		export PS1_TXTBoldPurple="\[${TXTBoldPurple}\]"
		export PS1_TXTBoldCyan="\[${TXTBoldCyan}\]"
		export PS1_TXTBoldWhite="\[${TXTBoldWhite}\]"
	fi
fi

##Reset="\[$(tput sgr0)\]"
# DEBUG COLOURS: echo -e "${TXTUnknown1}TXTUnknown1, \n${TXTUnknown2}TXTUnknown2, \n${TXTBlack}TXTBlack, \n${TXTRed}TXTRed, \n${TXTGreen}TXTGreen, \n${TXTYellow}TXTYellow, \n${TXTBlue}TXTBlue, \n${TXTPurple}TXTPurple, \n${TXTCyan}TXTCyan, \n${TXTDarkGray}TXTDarkGray, \n${TXTBoldRed}TXTBoldRed, \n${TXTBoldGreen}TXTBoldGreen, \n${TXTBold}TXTBold, \n${TXTBoldBlue}TXTBoldBlue, \n${TXTBoldPurple}TXTBoldPurple, \n${TXTBoldCyan}TXTBoldCyan, \n${TXTBoldWhite}TXTBoldWhite, \n${TXTGrey}TXTGrey"
## Set prompt
##PS1="${TXTCyan}\w ${TXTYellow}$ ${TXTGreen}${Reset}"
#export PS1="${TXTCyan}\w ${TXTYellow}\$ ${TXTGreen}${TXTNoColour}"
# Set prompt
#PS1="${TXTCyan}\w ${TXTYellow}$ ${TXTGreen}${Reset}"
#PS1="${TXTCyan}$PROMPT_COMMAND${TXTYellow}\$ ${TXTGreen}${TXTGrey}" # "${TXTCyan}\w ${TXTYellow}\$ ${TXTGreen}${TXTGrey}"
#echo "Setting PS1"
SHORT_HOST_NAME=$(hostname | sed 's/\..*//')                     # strip off everything after the first dot
SHORT_HOST_NAME=$(echo ${SHORT_HOST_NAME} | sed 's/\(.\).*\(.\)$/\1\2/') # strip off everything after the first dot
SHORT_HOST_NAME=$(echo ${SHORT_HOST_NAME} | tr '[:upper:]' '[:lower:]')  # make lower case
function parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function parse_path() {
	CMD="pwd | sed -e 's#\$NC_LIBRARIES_META_PATH#nclibs#' | sed -e 's#/mnt/d/NCam/#NC|#' | sed -e 's#/mnt/d/NCam/#NC|#' \
	         | sed -e \"s#"$FAH_DEV_DIR"/fah_products/loveclimbing.rocks/#lcr:#\" \
	         | sed -e \"s#"$FAH_DEV_DIR"/fah_products/learn_spanish#ls:#\" \
	         | sed -e \"s#"$FAH_DEV_DIR"/fah_products/doublethefish#dtf:#\" \
	         | sed -e \"s#"$FAH_DEV_DIR"/fah_products/#fah:#\" \
	         | sed -e \"s#"$FAH_DEV_DIR"/##\""
	#echo "$CMD"
	eval "$CMD"
}
function fah_prompt_cmd() {
	NCAM_PATH=$(pwd | sed -e 's#.*NCam.*/\(\(RTC\|Nc\)[^/]*\).*#\1#' | sed -e 's#.*NCam#NCam#' | sed -e 's#.*Development/*#dev:#g')
	echo -en "\033]0;${NCAM_PATH}\a"
}
export fah_prompt_cmd
PROMPT_COMMAND=fah_prompt_cmd
export PROMPT_COMMAND
#export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
PS1="${PS1_TXTBoldWhite}${SHORT_HOST_NAME} ${PS1_TXTCyan}\$(parse_path)${PS1_TXTYellow}\$(parse_git_branch)\\\$${PS1_TXTGreen}${PS1_TXTGrey}${PS1_TXTNoColour}${PS1_TXTNoBold} " # "${TXTCyan}\w ${TXTYellow}\$ ${TXTGreen}${TXTGrey}"
#PS1="\[${TXTBoldWhite}]]${SHORT_HOST_NAME}\{${TXTCyan}]]\w\[${TXTYellow}]]\$ \[${TXTGrey}]]" # "${TXTCyan}\w ${TXTYellow}\$ ${TXTGreen}${TXTGrey}"

# LSCOLORS     "abcdabcdabcdabcdabcdab"
#               1.2.3.4.5.6.7.8.9.1011
export LSCOLORS="dxfxcxdxCeegedabagacDa"
#LS_COLORS="ow=01;31:di=04;93:fi=36:ln=target:ex=01;35"

CLICOLOR="yes"
####################################
###         ~Colours            ####
####################################

PROMPT=$PS1
export PROMPT
export PS1
export SHORT_HOST_NAME
