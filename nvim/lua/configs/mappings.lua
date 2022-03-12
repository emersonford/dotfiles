local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- I bind Ctrl+HJKL to arrow keys, so map arrow keys to pane shifts.
map("n", "<Up>", "<C-w><C-k>", { noremap = true })
map("n", "<Down>", "<C-w><C-j>", { noremap = true })
map("n", "<Left>", "<C-w><C-h>", { noremap = true })
map("n", "<Right>", "<C-w><C-l>", { noremap = true })

-- avoid mistyping write/quit
cmd("command WQ wq")
cmd("command Wq wq")
cmd("command W w")
cmd("command Q q")

-- set leader to <Space>
vim.api.nvim_set_keymap(
  "",
  "<Space>",
  "<Nop>",
  { noremap = true, silent = true }
)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
