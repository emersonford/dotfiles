local Util = require("lazyvim.util")

return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  },
  {
    "mhinz/vim-signify",
    config = function(_, _)
      local util = require("tokyonight.util")

      util.highlight("SignifySignAdd", { link = "GitSignsAdd" })
      util.highlight("SignifySignChange", { link = "GitSignsChange" })
      util.highlight("SignifySignChangeDelete", { link = "GitSignsChange" })
      util.highlight("SignifySignDelete", { link = "GitSignsDelete" })
      util.highlight("SignifySignDeleteFirstLine", { link = "GitSignsDelete" })

      vim.g.signify_sign_add = "▎"
      vim.g.signify_sign_change = "▎"
      vim.g.signify_sign_delete = ""
      vim.g.signify_sign_delete_first_line = ""
      vim.g.signify_sign_change_delete = ""
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function()
      return {
        {
          "<C-n>",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<C-N>",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>,", false },
      { "<leader><space>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      {
        "<leader>p",
        function()
          Util.telescope("files", { cwd = vim.fn.expand("%:p:h") })()
        end,
        desc = "Find Files (cwd)",
      },
      { "<leader>P", Util.telescope("files"), desc = "Find Files (root)" },
    },
    opts = {
      defaults = {
        initial_mode = "normal",
      },
    },
  },
}
