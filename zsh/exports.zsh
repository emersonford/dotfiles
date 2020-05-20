export PATH=/usr/local/bin:$HOME/bin:$PATH:/usr/bin:$HOME/.dotfiles/bin
typeset -U path

export VISUAL=vim
export EDITOR=$VISUAL

export TERM='xterm-256color'

# Locale
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# Default Pager
export PAGER='less'

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

export STARSHIP_CONFIG=~/.dotfiles/starship.toml
