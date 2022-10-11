local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Bootstrap Packer
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Run PackerCompile whenever we edit this file with `nvim`.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Colorscheme
  use({
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    after = "tokyonight.nvim",
    config = function()
      local colors = require("tokyonight.colors").setup({})

      require("bufferline").setup({
        options = {
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
        highlights = {
          fill = {
            bg = colors.bg_statusline,
          },
          separator = {
            fg = colors.bg_statusline,
          },
          separator_selected = {
            fg = colors.bg_statusline,
          },
          separator_visible = {
            fg = colors.bg_statusline,
          },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "gn",
        ":BufferLineCycleNext<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gp",
        ":BufferLineCyclePrev<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gq",
        ":BufferLinePickClose<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gh",
        ":BufferLinePick<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "gb",
        ":b#<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "g]",
        ":BufferLineMoveNext<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "g[",
        ":BufferLineMovePrev<CR>",
        { noremap = true, silent = true }
      )
    end,
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
        },
      })
    end,
  })

  use("neovim/nvim-lspconfig")
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "phpdoc" },
        highlight = {
          enable = true,
          disable = { "latex" },
        },
        indent = {
          enable = true,
          disable = { "python", "lua", "latex" },
        },
      })
    end,
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.cmd(
        [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      )
    end,
  })

  use("L3MON4D3/LuaSnip")

  use({
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" },
    after = "LuaSnip",
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
          }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        },
      })
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup({})

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
      )
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Allow multi select https://github.com/nvim-telescope/telescope.nvim/issues/1048
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local custom_actions = {}

      function custom_actions._multiopen(prompt_bufnr, open_cmd)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local num_selections = #picker:get_multi_selection()
        if num_selections > 1 then
          local cwd = picker.cwd
          if cwd == nil then
            cwd = ""
          else
            cwd = string.format("%s/", cwd)
          end
          vim.cmd("bw!") -- wipe the prompt buffer
          for _, entry in ipairs(picker:get_multi_selection()) do
            vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
          end
          vim.cmd("stopinsert")
        else
          if open_cmd == "vsplit" then
            actions.file_vsplit(prompt_bufnr)
          elseif open_cmd == "split" then
            actions.file_split(prompt_bufnr)
          elseif open_cmd == "tabe" then
            actions.file_tab(prompt_bufnr)
          else
            actions.select_default(prompt_bufnr)
          end
        end
      end
      function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "vsplit")
      end
      function custom_actions.multi_selection_open_split(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "split")
      end
      function custom_actions.multi_selection_open_tab(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "tabe")
      end
      function custom_actions.multi_selection_open(prompt_bufnr)
        custom_actions._multiopen(prompt_bufnr, "edit")
      end

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<tab>"] = actions.toggle_selection
                + actions.move_selection_next,
              ["<s-tab>"] = actions.toggle_selection
                + actions.move_selection_previous,
              ["<cr>"] = custom_actions.multi_selection_open,
              ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
              ["<c-s>"] = custom_actions.multi_selection_open_split,
              ["<c-t>"] = custom_actions.multi_selection_open_tab,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<tab>"] = actions.toggle_selection
                + actions.move_selection_next,
              ["<s-tab>"] = actions.toggle_selection
                + actions.move_selection_previous,
              ["<cr>"] = custom_actions.multi_selection_open,
              ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
              ["<c-s>"] = custom_actions.multi_selection_open_split,
              ["<c-t>"] = custom_actions.multi_selection_open_tab,
            },
          },
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader><space>",
        [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sf",
        [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sb",
        [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
        { noremap = true, silent = true }
      )
    end,
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  use("folke/trouble.nvim")

  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({})

      vim.api.nvim_set_keymap(
        "n",
        "<C-n>",
        ":NvimTreeToggle<CR>",
        { noremap = true, silent = true }
      )
    end,
  })

  use("ggandor/lightspeed.nvim")

  use("tpope/vim-commentary")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")

  use({
    "mhinz/vim-signify",
    after = "tokyonight.nvim",
    config = function()
      local colors = require("tokyonight.colors").setup({})
      local util = require("tokyonight.util")

      util.highlight("SignifySignAdd", { link = "GitSignsAdd" })
      util.highlight("SignifySignChange", { link = "GitSignsChange" })
      util.highlight("SignifySignChangeDelete", { link = "GitSignsChange" })
      util.highlight("SignifySignDelete", { link = "GitSignsDelete" })
      util.highlight("SignifySignDeleteFirstLine", { link = "GitSignsDelete" })

      vim.g.signify_sign_add = "▊"
      vim.g.signify_sign_change = "▊"
      vim.g.signify_sign_change_delete = "~"
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "┊",
        filetype_exclude = { "help", "packer" },
        buftype_exclude = { "terminal", "nofile" },
        char_highlight = "LineNr",
        show_trailing_blankline_indent = false,
      })
    end,
  })

  use({
    "lervag/vimtex",
    config = function()
      vim.o.conceallevel = 2
      vim.g.vimtex_complete_enabled = 0
      vim.g.vimtex_format_enabled = 0
      vim.g.vimtex_compiler_enabled = 0
      vim.g.vimtex_quickfix_enabled = 0
      vim.g.vimtex_view_enabled = 0
    end,
  })

  -- use 'mfussenegger/nvim-dap'
  -- use 'williamboman/nvim-lsp-installer'

  if packer_bootstrap then
    require("packer").sync()
  end
end)
