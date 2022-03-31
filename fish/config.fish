# Colorscheme
source ~/.config/fish/tokyonight.fish

# Fix terminfo if iTerm2.app is not available.
if ! infocmp iTerm2.app &> /dev/null
  if [ "$TERM" = 'iTerm2.app' ]
    set -gx TERM 'xterm-256color'
  end
else
  if set -q LC_TERMINAL && [ "$LC_TERMINAL" = 'iTerm2' -a "$TERM" != 'iTerm2.app' -a "$TERM" != 'tmux-256color' -a "$TERM" != 'screen-256color' ]
    set -gx TERM 'iTerm2.app'
  end
end

# Exports
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx PAGER (which less)
set -gx MANPAGER (which less) -X

function vman --wraps man
  if test (count $argv) -eq 0
    man
  else if ! man -w $argv > /dev/null
    false
  else 
    nvim -c "SuperMan $argv"
  end
end
  

set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL $LANG
set -gx LANGUAGE $LANG

set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share

set -U fish_greeting

if ls --color &> /dev/null # GNU `ls`
  set -gx LS_COLORS 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
  set -g lscolorflag '--color'
else
  set -gx LSCOLORS 'exfxcxdxbxegedabagacad'
  set -g lscolorflag '-G'
end

# Aliases
alias ssh="TERM=xterm-256color command ssh"
alias sudo="TERM=xterm-256color command sudo"

alias grep="grep --color=auto"
alias ls="ls $lscolorflag"
alias la="ls -lahF $lscolorflag"

# Paths
set -Ux fish_user_paths
fish_add_path ~/bin
fish_add_path ~/.dotfiles/bin
fish_add_path /usr/local/bin

# Local config
[ -f ~/.config/fish/local.fish ] && source ~/.config/fish/local.fish

# Use starship prompt
starship init fish | source
