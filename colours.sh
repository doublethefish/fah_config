####################################
###         Colours             ####
####################################

# Currently these are mac-specific
TXTNoColour="\[\033[0m\]"
TXTBlack="\[\033[0;30m\]"
TXTRed="\[\033[0;31m\]"
TXTGreen="\[\033[0;32m\]"
TXTBrown="\[\033[0;33m\]"
TXTBlue="\[\033[0;34m\]"
TXTPurple="\[\033[0;35m\]"
TXTCyan="\[\033[0;36m\]"
TXTGrey="\[\033[0;37m\]"
TXTUnknown1="\[\033[0;38m\]"
TXTUnknown2="\[\033[0;39m\]"
TXTDarkGray="\[\033[1;30m\]"
TXTBoldRed="\[\033[1;31m\]"
TXTBoldGreen="\[\033[1;32m\]"
TXTBoldYellow="\[\033[1;33m\]"
TXTBoldBlue="\[\033[1;34m\]"
TXTBoldPurple="\[\033[1;35m\]"
TXTBoldCyan="\[\033[1;36m\]"
TXTBoldWhite="\[\033[1;37m\]"
##Reset="\[$(tput sgr0)\]"
##echo -e "${TXTUnknown1}TXTUnknown1, \n${TXTUnknown2}TXTUnknown2, \n${TXTBlack}TXTBlack, \n${TXTRed}TXTRed, \n${TXTGreen}TXTGreen, \n${TXTBrown}TXTBrown, \n${TXTBlue}TXTBlue, \n${TXTPurple}TXTPurple, \n${TXTCyan}TXTCyan, \n${TXTDarkGray}TXTDarkGray, \n${TXTBoldRed}TXTBoldRed, \n${TXTBoldGreen}TXTBoldGreen, \n${TXTBold}TXTBold, \n${TXTBoldBlue}TXTBoldBlue, \n${TXTBoldPurple}TXTBoldPurple, \n${TXTBoldCyan}TXTBoldCyan, \n${TXTBoldWhite}TXTBoldWhite, \n${TXTGrey}TXTGrey"
## Set prompt
##PS1="${TXTCyan}\w ${TXTBrown}$ ${TXTGreen}${Reset}"
export PS1="${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTNoColour}"

# LSCOLORS     "abcdabcdabcdabcdabcdab"
#               1.2.3.4.5.6.7.8.9.1011
export LSCOLORS="dxfxcxdxCeegedabagacDa"
#LS_COLORS="ow=01;31:di=04;93:fi=36:ln=target:ex=01;35"


CLICOLOR="yes"
####################################
###         ~Colours            ####
####################################
