require("vman")

local opt = vim.opt

opt.number = true -- show line numbers
opt.relativenumber = true -- show relative numbers by default

-- show absolute numbers in insert mode, relative in normal mode
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END
]])

opt.hidden = true -- allow background buffers
opt.joinspaces = false -- join lines without two spaces

-- Disable LazyVim's default clipboard.
opt.clipboard = ""

-- Require this at the end so local settings take highest precedence.
require("config.local")
