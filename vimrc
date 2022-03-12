" VIM Settings
set noerrorbells
set nocompatible

" settings
" turn hybrid line numbers on
set number relativenumber

" relative numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set shiftwidth=4    " four spaces per indent
set tabstop=4       " number of spaces per tab in display
set softtabstop=4   " number of spaces per tab when inserting
set expandtab       " substitute spaces for tabs
set autoindent      " carry indent over to new lines
set modelines=0

set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set showmatch                   " Show me the matching delimiter

set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set ttyfast
set hidden

" Make it obvious where 80 characters is
" set textwidth=80
set colorcolumn=81

" Search settings
if has("extra_search")
    " Highlight searches [use :noh to clear]
    set hlsearch
    " Highlight dynamically as pattern is typed
    set incsearch
    " Ignore case of searches...
    set ignorecase
    " ...unless has mixed case
    set smartcase
endif

" PLUGINS
filetype off
filetype indent plugin on

" set color scheme to one dark
syntax on
set t_Co=256
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" I bind Ctrl+HJKL to arrow keys, so map arrow keys for Vim Tmux Navigator.
nmap <Up> <C-k>
nmap <Down> <C-j>
nmap <Left> <C-h>
nmap <Right> <C-l>

" Avoid mistyping write/quit
command WQ wq
command Wq wq
command W w
command Q q

" Buffer shortcuts
nmap gn :bn<cr>
nmap gp :bp<cr>
nmap gb :b#<cr>
nmap gq :bp <BAR> bd #<CR>

" Move to next displayed line instead of actual line
nnoremap j gj
nnoremap k gk

" Local config
if filereadable($HOME . "/.vim/vimrc_local")
  source ~/.vim/vimrc_local
endif
