# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

# Source user definitions
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env"
[ -d /opt/homebrew ] && export PATH="/opt/homebrew/bin:$PATH"

# User specific environment and startup programs
export EDITOR="nvim"
export GTK_USE_PORTAL=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

# Aliases
alias code="code-insiders"
alias codeext="code-insiders --list-extensions"
alias ll="ls -alh"

# User specific environment and startup programs
eval "$(pyenv init -)"
eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"