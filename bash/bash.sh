source ~/.fah/bash/colours.sh
source ~/.fah/bash/aliases.sh
source ~/.fah/bash/compiler.sh
source ~/.fah/bash/git_utils.sh
source ~/.fah/bash/svn_utils.sh
source ~/.fah/bash/django.sh
source ~/.fah/bash/android.sh
source ~/.fah/bash/python3.1.sh

####################################
###    Environment Settings     ####
####################################
# should already be on the PATH - PATH=/usr/local/bin:${PATH} # custom installs, also where brew (from homebrew) puts its stuff)
PATH=:~/.fah/fah_bin:~/.fah/fah_bin/deprocrastinator:${PATH} # my stuff
echo "Using custom bash"

BROWSER=${BROWSER}:open

#bind '"<Up>":history-search-backward'
#bind '"<Down>":history-search-forward'
####################################
###    ~Environment Settings    ####
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

#include Foundry specific stuff
source ~/.fah/fah_bin/foundry_svn_user_frank/configs/bash/.foundry

