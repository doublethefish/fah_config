source ~/.fah/bash/os.sh             # setup Platform detection
source ~/.fah/bash/fah_bin_setup.sh  # setup bin-path
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
PATH=/usr/local/bin:${PATH} # custom installs, also where brew (from homebrew) puts its stuff)
PATH=:${FAH_BIN}:$FAH_BIN}/deprocrastinator:${PATH} # my stuff
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
source ~/.fah/fn_frank_config/bash/foundry.sh

####################################
###       Filter PATH           ####
####################################
splitPath=`echo ${PATH} | sed 's/:/ /g'`;
PATH=
for pathBit in ${splitPath}; do
  if [[ -e ${pathBit} ]]; then
    PATH=${PATH}:${pathBit}
  fi
done
####################################
###      ~Filter PATH           ####
####################################

