#!/bin/bash

hosts=(home fm-test miyako notchpeak.chpc.utah.edu cade hacktheu-main hacktheu-bigboi)

for i in ${hosts[@]}; do
  echo "updating $i"
  ssh -o ConnectTimeout=5 $i 'bash -s' < ~/.dotfiles/bin/dotfile-install
done
