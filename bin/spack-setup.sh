#!/bin/bash
set -eux -o pipefail

cd ~ || exit
stat spack &> /dev/null || git clone https://github.com/spack/spack.git
cd spack && git fetch && git checkout releases/v0.16
cd ~ || exit

spack/bin/spack external find
spack/bin/spack install tmux@3.1b
spack/bin/spack install vim@8.2.1201 +huge +python
spack/bin/spack install zsh@5.8
spack/bin/spack install git@2.29.0

ln -sf "$(spack/bin/spack location --install-dir tmux@3.1b)/bin/tmux" ~/bin/tmux
ln -sf "$(spack/bin/spack location --install-dir vim@8.2.1201)/bin/vim" ~/bin/vim
ln -sf "$(spack/bin/spack location --install-dir vim@8.2.1201)/bin/vimdiff" ~/bin/vimdiff
ln -sf "$(spack/bin/spack location --install-dir zsh@5.8)/bin/zsh" ~/bin/zsh
ln -sf "$(spack/bin/spack location --install-dir git@2.29.0)/bin/git" ~/bin/git
