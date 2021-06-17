"" line number settings ""
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


"" indent settings ""
set shiftwidth=4    " four spaces per indent
set tabstop=4       " number of spaces per tab in display
set softtabstop=4   " number of spaces per tab when inserting
set expandtab       " substitute spaces for tabs


"" split settings ""
set splitright      " Split vertical windows right to the current windows
set splitbelow      " Split horizontal windows below to the current windows
set autowrite       " Automatically save before :next, :make etc.
set hidden


"" text width settings ""
" set textwidth=80
set colorcolumn=81


"" keybind settings ""
" I bind Ctrl+HJKL to arrow keys, so map arrow keys for Vim Tmux Navigator.
nmap <Up> <C-k>
nmap <Down> <C-j>
nmap <Left> <C-h>
nmap <Right> <C-l>

" avoid mistyping write/quit
command WQ wq
command Wq wq
command W w
command Q q

" buffer shortcuts
nmap gn :bn<cr>
nmap gp :bp<cr>
nmap gb :b#<cr>
nmap gq :bp <BAR> bd #<CR>


"" status line settings ""
set ruler

" filename
set statusline=%<%f\
" options
set statusline+=%w%h%m%r
" current dir
set statusline+=\ [%{getcwd()}]
" right aligned file nav info
set statusline+=%=%-14.(%l,%c%V%)\ %p%%


"" fold settings ""
" keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END


"" tab completion settings ""
" will insert tab at beginning of line,
" will use completion if not at beginning
" set wildmode=list:longest,list:full
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<Tab>"
"     else
"         return "\<C-p>"
"     endif
" endfunction
" inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
" inoremap <S-Tab> <C-n>


"" colorscheme settings ""
syntax on
set t_Co=256
colorscheme onehalfdark
hi IncSearch guifg=#282c34 ctermfg=236 guibg=#dcdfe4 ctermbg=188
let g:airline_theme='onehalfdark'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


"" tagbar settings ""
map <F8> :TagbarToggle<CR>


"" airline settings ""
" enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


"" bufexplorer settings ""
let g:bufExplorerDisableDefaultKeyMapping=1
nnoremap <silent> <Leader>b :BufExplorer<CR>


"" vim-polyglot settings ""
let g:polyglot_disabled = ['latex']


"" ultisnips settings ""
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips']
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Local config
if filereadable($HOME . "/.config/nvim/local.vim")
  source ~/.config/nvim/local.vim
endif
