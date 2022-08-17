# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PYENV_ROOT="$HOME/.pyenv"
export GTK_USE_PORTAL=1
export EDITOR="nvim"

# PATH
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Aliases
alias code="code-insiders"
alias ll="ls -alh"
