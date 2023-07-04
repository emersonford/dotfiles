-- Adopted from https://github.com/jez/vim-superman/blob/master/plugin/superman.vim

function SuperMan(page)
  vim.cmd("Man " .. page)

  if vim.fn.line("$") == 1 then
    vim.cmd("cquit")
  end

  -- Remove the [No name] buffer.
  -- Effectively also performs `silent only`.
  vim.cmd("bw 1")

  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.bo.swapfile = false

  vim.bo.expandtab = false
  vim.bo.tabstop = 8
  vim.bo.softtabstop = 8
  vim.bo.shiftwidth = 8
  vim.wo.list = false

  vim.cmd("noremap q :q<CR>")
end

vim.cmd("command! -nargs=+ SuperMan lua SuperMan(<f-args>)")
