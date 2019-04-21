#!/bin/bash

hosts=(home raspberrypi.local ford1 ford2 ford3 miyako notchpeak.chpc.utah.edu cade hacktheu-main)

for i in ${hosts[@]}; do
  ssh $i 'bash -s' < ~/.dotfiles/bin/dotfile-install
done
