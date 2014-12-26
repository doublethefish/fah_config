source ~/.fah/colours.sh
source ~/.fah/compiler.sh
source ~/.fah/svn_utils.sh

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

alias gd="git difftool -y"
alias dg="gd"

source /usr/local/git/contrib/completion/git-completion.bash

#include Foundry specific stuff
source ~/bin/foundry_svn_user_frank/configs/bash/.foundry

export FN_FBUILD_USER=frank

