yum-config-manager --add https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
# Remove vim-minimal if is installed
yum remove -y vim-minimal
yum install vim
# If you removed vim-minimal, sudo may be removed to, install it again
yum install sudo
