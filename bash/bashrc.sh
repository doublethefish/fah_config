source ~/.fah/bash/bash.sh # shared bashrc-like config

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

unamestr=`uname`
echo "bash is on ${unamestr}" 

#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


# some more ls aliases
if [[ ${unamestr} == "Darwin" ]]; then
  alias ll="ls -GlFhk"
  alias la='ll -A'
  alias l='ls -CF'
else
  #alias ll='ls -alF'
  alias ll="ls -GlFhkX --color=always"
  alias la="ll -A" 
  alias l='ls -CF'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [[ ${unamestr} == "MINGW32_NT-6.1" ]]; then
  NUM_CORES=0
  for i in `WMIC CPU Get NumberOfCores,NumberOfLogicalProcessors /Format:List | grep NumberOfLogicalProcessors | sed 's/[^0-9]//g'`
  do
   NUM_CORES=$((${NUM_CORES}+${i}))
  done
else
  if [[ ${unamestr} == "Darwin" ]]; then
    #sys_log=/tmp/system_profiler.log
    #echo "Calling system_profiler for num cores ...."
    #system_profiler > ${sys_log}
    #NUM_PROCS=`grep Processors ${sys_log} | sed 's/[^0-9]//g'`
    #NUM_CORES=`grep "Cores"    ${sys_log} | sed 's/[^0-9]//g'`
    #NUM_CORES=$((${NUM_CORES}*${NUM_PROCS}))

    # Faster version from Bob, thanks Bob.
    NUM_CORES=`sysctl -n hw.ncpu`
  else
    NUM_CORES=`nproc`
  fi
fi
echo "Num Cores : ${NUM_CORES}"

alias gd='git difftool -g --no-prompt'
alias dg='gd'
alias gf='~/bin/git-commit-info.bash'
alias sg='sd'
alias gdiff='dg'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
for filename in /etc/bash_completion /etc/bash_completion.d/git /etc/bash_completion.d/subversion /etc/bash_completion.d/yum.bash
do
  if [ -f $filename ] && ! shopt -oq posix; then
    . $filename
  fi
done



PATH=$PATH:/workspace/FnSCons/2.1.0/bin:/workspace/FnSCons/2.1.0/lib:/workspace/FnSCons/lib/scons-2.1.0/SCons/
PATH=$PATH:/opt/qtcreator-2.3.1/bin/
PATH=$PATH:/usr/local/smartgithg-5_0_3/bin/
PATH=$PATH:~/bin/user_frank_svn/
PYTHON_PATH=$PYTHON_PATH:/workspace/FnSCons/2.1.0/engine

. ~/.bashrc_lonefish

if [ -f /home/frank/.bashrc ]; then
	. /home/frank/.bashrc
else
  computer=`hostname`
  echo "no local bashrc for frank on ${computer}"
fi

if [ -f ~/bin/foundry_svn_user_frank/configs/bash/.foundry ]; then
  source ~/.fah/fah_bin/foundry_svn_user_frank/configs/bash/.foundry
else
  computer=`hostname`
  echo "no Foundry specific config on ${computer}"
fi

echo "I love the smell of napalm in the morning"

hostname

