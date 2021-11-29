local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap Packer
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Run PackerCompile whenever we edit this file with `nvim`.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use {
    'joshdick/onedark.vim',
    config = function()
      vim.g.onedark_terminal_italics = 1
      vim.cmd 'colorscheme onedark'

      vim.cmd 'highlight! link TSKeywordFunction Statement'
      vim.cmd 'highlight! link TSKeyword Statement'
      vim.cmd 'highlight! link TSVariableBuiltin Constant'
    end
  }

  use {
    'akinsho/bufferline.nvim', 
    requires = {'kyazdani42/nvim-web-devicons'},
    after = 'onedark.vim',
    config = function()
      require('bufferline').setup{
        options = {
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          }
        },
        highlights = {
          fill = {
            guibg = vim.fn['onedark#GetColors']()['background']['gui']
          },
          separator = {
            guifg = vim.fn['onedark#GetColors']()['background']['gui']
          },
          separator_selected = {
            guifg = vim.fn['onedark#GetColors']()['background']['gui'],
            guibg = vim.fn['onedark#GetColors']()['cursor_grey']['gui']
          },
          separator_visible = {
            guifg = vim.fn['onedark#GetColors']()['background']['gui']
          },
          buffer_selected = {
            guibg = vim.fn['onedark#GetColors']()['cursor_grey']['gui']
          },
          close_button_selected = {
            guibg = vim.fn['onedark#GetColors']()['cursor_grey']['gui']
          }
        }
      }

      vim.api.nvim_set_keymap('n', 'gn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gq', ':BufferLinePickClose<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'gb', ':BufferLinePick<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'g]', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'g[', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
    end
  }
  use {
    'nvim-lualine/lualine.nvim', 
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('lualine').setup{
        options = {
          theme = "onedark"
        }
      }
    end
  }

  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = {"python", "lua"}
        },
      }
    end
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 
    'jose-elias-alvarez/null-ls.nvim', 
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'liuchengxu/vista.vim' 
  use { 
    'kosayoda/nvim-lightbulb', 
    config = function() 
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end
  }

  use 'L3MON4D3/LuaSnip'

  use { 
    'hrsh7th/nvim-cmp',
    requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer'},
    after = 'LuaSnip',
    config = function()
      vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
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
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
      }
    end
  }

  use {
    'saadparwaiz1/cmp_luasnip',
    after = 'nvim-cmp'
  }

  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('nvim-autopairs').setup{}

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    end
  }

  use { 
    'nvim-telescope/telescope.nvim', 
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup{ }
    end
  }

  use 'folke/trouble.nvim' 

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() 
      require'nvim-tree'.setup {} 

      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  }

  use 'ggandor/lightspeed.nvim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use 'mhinz/vim-signify'

  use { 
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        char = '┊',
        filetype_exclude = { 'help', 'packer' },
        buftype_exclude = { 'terminal', 'nofile' },
        char_highlight = 'LineNr',
        show_trailing_blankline_indent = false
      }
    end
  }

  -- use 'mfussenegger/nvim-dap'
  -- use 'williamboman/nvim-lsp-installer'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
