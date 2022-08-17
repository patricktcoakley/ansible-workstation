# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source user definitions
if [ -f /usr/share/fzf ]; then
	. /usr/share/fzf/key-bindings.bash
	. /usr/share/fzf/completion.bash
fi

# User specific environment and startup programs
eval "$(pyenv init -)"
eval "$(starship init bash)"