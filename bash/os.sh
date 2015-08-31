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
