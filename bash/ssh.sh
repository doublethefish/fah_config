# hmm does work at all times...
SSH_ENV="$HOME/.ssh/environment"

if [ -z "${FAH_SSH_KEYS}" ]; then
  echo "WARNING: FAH_SSH_KEYS env variable not set!"
fi

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    for KEY_PATH in ${FAH_SSH_KEYS}; do
      eval KEY_PATH=${KEY_PATH}
      if [[ ! -f  ${KEY_PATH} ]]; then
        echo "WARNING!: SSH Key: not found ${KEY_PATH}, you may need to update ${FAH_SYSTEM_CONFIG}"
      else
        echo "SSH Key: adding ${KEY_PATH}"
        /usr/bin/ssh-add ${KEY_PATH}
      fi
    done;
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
