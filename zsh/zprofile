#!/usr/bin/env zsh

# Reference: https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856

# ~/.zprofile is executed when zsh is started as a login shell.
# macOS Terminal, iTerm, Tmux, VSCode, and SSH all create login shells.
# Linux terminal emulators usually don't, so that setting will have to be changed manually to match macOS behavior.

# We want to use `fish` and `starship` only in login shells as if I manually exec zsh (which does not source ~/.zprofile),
# I want a zsh environment with no configurations.

# Do not do anything if this is a non-interactive shell (happens sometimes with SSH).
[[ ! -o interactive ]] && return

# If fish is found, exec fish.
if [ -f ~/.config/fish/find_and_exec_fish.sh ]; then
  source ~/.config/fish/find_and_exec_fish.sh
  find_and_exec_fish
fi

eval "$("$HOME/bin/starship" init zsh)"
