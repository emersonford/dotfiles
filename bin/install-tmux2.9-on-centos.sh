# yum install libevent-devel ncurses-devel glibc-static
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xzvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure && make
sudo make install

wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
tar xzf tmux-2.9.tar.gz
cd tmux-2.9
./configure && make
sudo make install
