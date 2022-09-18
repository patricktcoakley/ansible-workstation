# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

# Source user definitions
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
[ -f $HOME/.cargo/env ] && source "$HOME/.cargo/env"
[ -d /opt/homebrew ] && export PATH="/opt/homebrew/bin:$PATH"

# User specific environment and startup programs
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export EDITOR="nvim"
export GTK_USE_PORTAL=1
export JAVA_HOME="/usr/lib/jvm/java"
export JAVA_INCLUDE_DIR="$JAVA_HOME/include"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# Aliases
alias code="code-insiders"
alias codeext="code-insiders --list-extensions"
alias ll="ls -alh"

# User specific environment and startup programs
eval "$(pyenv init -)"
eval "$(starship init bash)"
eval "$(zellij setup --generate-auto-start bash)"