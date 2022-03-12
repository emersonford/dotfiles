local opt = vim.opt

opt.number = true           -- show line numbers
opt.relativenumber = true   -- show relative numbers by default

-- show absolute numbers in insert mode, relative in normal mode
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END
]])

opt.showmatch = true        -- show matching brackets

opt.smartindent = true      -- use c-like indents when no indentexpr is used
opt.expandtab = true        -- use spaces instead of tabs
opt.shiftwidth = 2          -- use 2 spaces when inserting tabs
opt.tabstop = 2             -- show tabs as 2 spaces

opt.splitright = true       -- vsplit to right of current window
opt.splitbelow = true       -- hsplit to bottom of current window

opt.hidden = true           -- allow background buffers

opt.scrolloff = 2           -- include 2 rows of context above/below current line
opt.sidescrolloff = 5       -- include 5 colums of context to the left/right of current column

opt.ignorecase = true       -- ignore case in searches...
opt.smartcase = true        -- ...unless we use mixed case

opt.joinspaces = false      -- join lines without two spaces

opt.termguicolors = true    -- allow true colors

opt.inccommand = 'nosplit'  -- show effects of substitute incrementally

opt.mouse = 'a'             -- enable mouse mode

opt.updatetime = 400        -- decrease time for cursorhold event
