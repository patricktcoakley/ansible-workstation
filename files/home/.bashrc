# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

# Source user definitions
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

# User specific environment and startup programs
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export GTK_USE_PORTAL=1
export EDITOR="nvim"
export PATH="$HOME/.cargo/bin:$PATH"

if [ -d /opt/homebrew ]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi

# Aliases
alias code="code-insiders"
alias codeext="code-insiders --list-extensions"
alias ll="ls -alh"

# User specific environment and startup programs
eval "$(pyenv init -)"
eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"
