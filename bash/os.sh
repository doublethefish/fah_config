# A place to configure OS
FAH_PLATFORM='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  FAH_PLATFORM='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  FAH_PLATFORM='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  FAH_PLATFORM='mac'
fi
echo $unamestr
