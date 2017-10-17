if [ -z ${FAH_HOME} ]; then
  eval FAH_HOME=~
  echo $FAH_HOME
fi
source ${FAH_HOME}/.fah/bash/os.sh             # setup Platform detection
source ${FAH_HOME}/.fah/bash/fah_bin_setup.sh  # setup bin-path
source ${FAH_HOME}/.fah/bash/colours.sh
source ${FAH_HOME}/.fah/bash/aliases.sh
source ${FAH_HOME}/.fah/bash/compiler.sh
source ${FAH_HOME}/.fah/bash/git_utils.sh
source ${FAH_HOME}/.fah/bash/svn_utils.sh
source ${FAH_HOME}/.fah/bash/django.sh
source ${FAH_HOME}/.fah/bash/android.sh
source ${FAH_HOME}/.fah/bash/python3.1.sh
source ${FAH_HOME}/.fah/bash/ssh.sh

####################################
###    Environment Settings     ####
####################################
if [ -z ${FAH_BIN} ]; then
  echo "FAH_BIN not set!!"
else
  PATH=${PATH}:${FAH_BIN} # my stuff
  echo "Using .fah bash ${FAH_BIN}"
fi

PATH=/usr/local/bin:${PATH} # custom installs, also where brew (from homebrew) puts its stuff)
PATH=:${FAH_BIN}:$FAH_BIN}/deprocrastinator:${PATH} # my stuff

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
#I no longer work at the foundry: source ${FAH_HOME}/.fah/fn_frank_config/bash/foundry.sh


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

