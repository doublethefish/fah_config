# ~/.bashrc: executed by bash(1) for non-login shells.
# This file needs some love

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -z ${FAH_HOME} ]; then
  eval FAH_HOME=~
  echo $FAH_HOME
fi
source ${FAH_HOME}/.fah/bash/bash.sh # shared bashrc-like config

unamestr=`uname`
echo "bash is on ${unamestr}" 

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


# TODO: this is being done in my colour.sh
# PROMPT_COMMAND is executed just before displaying $PS1
# FIXME
#PROMPT_COMMAND='echo -ne "\033[0;37m${SHORT_HOST_NAME}\033]0;${SHORT_PATH}\007"'
#PROMPT_COMMAND='echo -ne "${SHORT_PATH}\007"'
#if [ "$color_prompt" = yes ]; then
#    PS1="${TXTBoldWhite}${SHORT_HOST_NAME} ${TXTCyan}$\w${TXTBrown}\$ ${TXTGreen}${TXTGrey}" # "${TXTCyan}\w ${TXTBrown}\$ ${TXTGreen}${TXTGrey}"
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# FIXME: this is probably meant to be PROMPT_COMMAND, not PS1 /fh
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

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
PATH=$PATH:${FAH_HOME}/bin/user_frank_svn/
PYTHON_PATH=$PYTHON_PATH:/workspace/FnSCons/2.1.0/engine


hostname

