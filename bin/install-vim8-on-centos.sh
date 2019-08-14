yum -y groupinstall "Development Tools"
yum -y install ncurses-devel git-core

git clone https://github.com/vim/vim && cd vim

./configure --prefix=/usr --with-features=huge --enable-multibyte --with-python-config-dir=/usr/lib/python2.7/config --enable-pythoninterp=yes

make && sudo make install
