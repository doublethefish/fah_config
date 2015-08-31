# Configurations for compilers

####################################
###        Include Paths        ####
####################################
if [[ "$FAH_PLATFORM" == 'mac' ]]; then
  C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/X11/include/
  LIBRARY_PATH=${LIBRARY_PATH}:/usr/X11/lib/
  CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}:$C_INCLUDE_PATH
fi
####################################
###       ~Include Paths        ####
####################################


