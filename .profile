####################################
###         Colours             ####
####################################
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

####################################
###        Include Paths        ####
####################################
C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/X11/include/
LIBRARY_PATH=${LIBRARY_PATH}:/usr/X11/lib/
CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:$C_INCLUDE_PATH
####################################
###       ~Include Paths        ####
####################################

####################################
###    Environment Settings     ####
####################################
# should already be on the PATH - PATH=/usr/local/bin:${PATH} # custom installs, also where brew (from homebrew) puts its stuff)
PATH=:~/bin:~/bin/deprocrastinator:${PATH} # my stuff
echo "Using custom bash"
alias ll="ls -GlFhkO"
alias la="ls -GAlFhkO"
alias gvim="mvim"
alias ffind="find . -name "
alias ffindi="find . -iname "
alias mvcstatus="mvc status | grep ^[MCAD] | grep -v ^CVS "
alias hgrep="ffind \"*.h\" | xargs grep -n"

BROWSER=${BROWSER}:open

#bind '"<Up>":history-search-backward'
#bind '"<Down>":history-search-forward'
####################################
###    ~Environment Settings    ####
####################################

####################################
###           Installs          ####
####################################

#----------------------------
# MacPorts Installer addition on 2009-12-18_at_18:26:41: adding an appropriate PATH variable for use with MacPorts.
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=${PATH}:/usr/local/mysql-5.5.2-m2-osx10.6-x86_64/bin/
# Finished adapting your PATH environment variable for use with MacPorts.

####################################
###          ~Installs          ####
####################################

####################################
###          Python 3.1         ####
####################################

#----------------------------
# Setting PATH for Python 3.1
# The orginal version is saved in .profile.pysave
# I want the default system python not 3.1 - PATH=/Library/Frameworks/Python.framework/Versions/3.1/bin:${PATH}
#echo $PATH

####################################
###         ~Python 3.1         ####
####################################


####################################
###            Django           ####
####################################

# I'm not using django for anything now - PATH=${PATH}:/Users/frankharrison/local/lib/python2.6/site-packages/django-trunk/django/bin
#echo $PATH

#----------------------------
# Setting PYTHONPATH 
# I'm not using django for anything now - PYTHONPATH=${PYTHONPATH}:/Users/frankharrison/local/lib/python2.6/site-packages:/Users/frankharrison/local/lib/python2.6/site-packages/django-trunk

####################################
###           ~Django           ####
####################################


####################################
###           Android           ####
####################################

# I'm not doing any android dev right now - ANDROID=/Developer/SDKs/Android
# I'm not doing any android dev right now - PATH=${ANDROID}/android-sdk-mac_x86/tools/:${ANDROID}/bin/:${PATH}
# 
# I'm not doing any android dev right now - #Cross Compiler setup
# I'm not doing any android dev right now - CCOMPILER=${ANDROID}/src/system/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0/bin/arm-eabi-

####################################
###          ~Android           ####
####################################

####################################
###        Line wrapping        ####
####################################
#
# \e (escape)
# [  (open square bracket)
# ?  (question mark)
# 7  (seven)
# l  (el - lowercase L)
# \c (tells echo to suppress the newline; this is optional)
#
#echo -e "\e[?7l\c"
# turn line wrapping back on
# echo -e "\e[?7h\c"
####################################
###       ~Line Wrapping        ####
####################################

# svn diff
alias kdiff3="/Developer/Applications/Utilities/kdiff3.app/Contents/MacOS/kdiff3"
alias sd="svn diff --diff-cmd=/Users/frankharrison/bin/svn_diff_vim.sh"
alias gd="git difftool -y"
alias dg="gd"

source /usr/local/git/contrib/completion/git-completion.bash

#include Foundry specific stuff
source ~/bin/foundry_svn_user_frank/configs/bash/.foundry

export FN_FBUILD_USER=frank

