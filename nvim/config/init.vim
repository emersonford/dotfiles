"" line number settings
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


"" show settings
set showmatch


"" indent settings
set smartindent
set shiftwidth=4    " four spaces per indent
set tabstop=4       " number of spaces per tab in display
set softtabstop=4   " number of spaces per tab when inserting
set expandtab       " substitute spaces for tabs


"" split settings
set splitright      " Split vertical windows right to the current windows
set splitbelow      " Split horizontal windows below to the current windows
set autowrite       " Automatically save before :next, :make etc.
set hidden


"" text width settings
" set textwidth=80
set colorcolumn=81


"" keybind settings
" I bind Ctrl+HJKL to arrow keys, so map arrow keys to pane shifts.
nmap <Up> <C-w><C-k>
nmap <Down> <C-w><C-j>
nmap <Left> <C-w><C-h>
nmap <Right> <C-w><C-l>

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


"" status line settings
set ruler


"" fold settings
" use treesitter for folds
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END


"" colorscheme settings
" For tmux true color support
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors
set t_Co=256
syntax on

let g:onedark_terminal_italics = 1

packadd! onedark
colorscheme onedark
let g:airline_theme='onedark'


"" NERDTree Settings
nmap <C-n> :NERDTreeToggle<CR>


"" airline settings
" enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" disable fancy unicode symbols in airline
let g:airline_symbols_ascii = 1
" enable ALE support
let g:airline#extensions#ale#enabled = 1


"" bufexplorer settings
let g:bufExplorerDisableDefaultKeyMapping=1
nnoremap <silent> <Leader>b :BufExplorer<CR>


"" vimtex settings
" let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'


"" ultisnips settings
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips']


"" nvim-treesitter settings
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
}
EOF


"" nvim-cmp settings
set completeopt=menuone,noselect
lua << EOF
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- lspconfig settings
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pylsp", "texlab", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end
EOF


"" ale settings
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}


"" local config
if filereadable($HOME . "/.config/nvim/local.vim")
  source ~/.config/nvim/local.vim
endif
