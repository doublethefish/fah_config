# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
for filename in /etc/bash_completion /etc/bash_completion.d/git /etc/bash_completion.d/subversion /etc/bash_completion.d/yum.bash /usr/local/etc/bash_completion /usr/local/etc/profile.d/bash_completion.sh; do
	if [ -f $filename ] && ! shopt -oq posix; then
		. $filename
	fi
done
