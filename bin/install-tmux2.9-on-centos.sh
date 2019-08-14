yum install libevent-devel ncurses-devel glibc-static

wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
tar xzf tmux-2.9.tar.gz
cd tmux-2.9
./configure && make
sudo make install
