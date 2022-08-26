# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source user definitions
if [ -d /usr/share/fzf ]; then
	. /usr/share/fzf/key-bindings.bash
	. /usr/share/fzf/completion.bash
fi

# User specific environment and startup programs
export PYENV_ROOT="$HOME/.pyenv"
export GTK_USE_PORTAL=1
export EDITOR="nvim"

# Aliases
alias code="code-insiders"
alias codeext="code-insiders --list-extensions"
alias ll="ls -alh"

# User specific environment and startup programs
eval "$(pyenv init -)"
eval "$(starship init bash)"
