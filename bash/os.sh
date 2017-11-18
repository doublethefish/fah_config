# A place to configure OS
FAH_PLATFORM='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  FAH_PLATFORM='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  FAH_PLATFORM='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  FAH_PLATFORM='mac'
elif [[ "$unamestr" == 'MINGW32_NT-6.1' ]]; then
  FAH_PLATFORM='win'
fi
export FAH_PLATFORM
echo "Setting FAH_PLATFORM to ${FAH_PLATFORM} from ${unamestr}"

FAH_SYSTEM_CONFIG=${FAH_HOME}/.bash_fah_system
if [ ! -f "${FAH_SYSTEM_CONFIG}" ]; then
  cp ${FAH_HOME}/.fah/bash/bash_fah_system.template ${FAH_SYSTEM_CONFIG}
  echo "WARNING! : Copied the system-specific to ${FAH_SYSTEM_CONFIG}, you will"
  echo "         : need to update it"
fi

source ${FAH_SYSTEM_CONFIG} # pull in the system configuration

if [[ -z ${FAH_DEV_DIR} ]] || [[ ! -d  ${FAH_DEV_DIR} ]]; then
  echo "WARNING! : You have not set or created the 'FAH_DEV_DIR' env variable"
  echo "         : on this machine, yet. Check ${FAH_SYSTEM_CONFIG}"
  if [[ ! -d ${FAH_DEV_DIR} ]]; then
    echo "         : Not found ${FAH_DEV_DIR}"
  fi
fi
