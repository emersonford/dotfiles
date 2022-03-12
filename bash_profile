#!/usr/bin/env bash

# Reference: https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856

# ~/.bash_profile is executed when bash is started as a login shell.
# macOS Terminal, iTerm, Tmux, VSCode, and SSH all create login shells.
# Linux terminal emulators usually don't, so that setting will have to be changed manually to match macOS behavior.

# We want to use `fish` and `starship` only in login shells as if I manually exec bash (which executes ~/.bashrc instead),
# I want a bash environment with no configurations.

# Do not do anything if this is a non-interactive shell (happens sometimes with SSH).
[ -z "$PS1" ] && return

# If fish is found, exec fish.
if [ -f ~/.config/fish/find_and_exec_fish.sh ]; then
  source ~/.config/fish/find_and_exec_fish.sh
  find_and_exec_fish
fi

# If we didn't find fish, continue with bash.
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

eval "$("$HOME/bin/starship" init bash)"
