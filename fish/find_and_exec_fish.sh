#!/usr/bin/env bash

find_and_exec_fish() {
  fish_paths=(
    "$HOME/bin"
    "$HOME/.dotfiles/bin"
    "/usr/local/bin"
    "/opt/homebrew/bin"
  )

  fish_found=false

  for p in "${fish_paths[@]}"; do
    if [ -f "$p/fish" ] && [ -x "$p/fish" ]; then
      export SHELL="$p/fish"
      fish_found=true
      break
    fi
  done

  if [ "$fish_found" = false ] && which fish &> /dev/null && [ -x "$(which zsh)" ]; then
    export SHELL="$(which zsh)"
    fish_found=true
  fi

  if [ "$fish_found" = true ]; then
    exec $SHELL
  fi
}
