require("config.local")
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

-- Truncate diagnostic messages to the first line
vim.diagnostic.config({
  virtual_text = {
    source = "always",
    format = function(diagnostic)
      local new_line_location = diagnostic.message:find("\n")

      if new_line_location ~= nil then
        return diagnostic.message:sub(1, new_line_location)
      else
        return diagnostic.message
      end
    end,
  },
})

-- Disable LazyVim's default clipboard.
opt.clipboard = ""
