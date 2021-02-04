export PATH=$HOME/bin:/usr/local/bin:$PATH:/usr/bin:$HOME/.dotfiles/bin
typeset -U path

export VISUAL=vim
export EDITOR=$VISUAL

if [[ "$TERM_PROGRAM" == 'iTerm.app' || "$TERM" == 'iTerm2.app' ]] && infocmp iTerm2.app &> /dev/null; then
    export TERM='iTerm2.app'
elif [[ "$TERM" != 'tmux-256color' ]]; then
    export TERM='xterm-256color'
fi

# LS Colors
if ! ls --color > /dev/null 2>&1; then # GNU `ls`
    export LSCOLORS='exfxcxdxbxegedabagacad'
fi
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Locale
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# Default Pager
export PAGER='less'

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"

export STARSHIP_CONFIG=$HOME/.dotfiles/starship.toml
