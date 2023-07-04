local colors = require("tokyonight.colors").setup({})

return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    keys = function()
      return {
        { "<leader>bq", "<Cmd>BufferLinePickClose<CR>" },
        { "<leader>bn", "<Cmd>BufferLineCycleNext<CR>" },
        { "<leader>bp", "<Cmd>BufferLineCyclePrev<CR>" },
      }
    end,
    opts = {
      options = {
        separator_style = "slant",
        always_show_bufferline = true,
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
    },
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>uh",
        function()
          require("telescope").load_extension("notify")
          require("telescope").extensions.notify.notify()
        end,
        desc = "View messages history",
      },
    },
    opts = {
      timeout = 5000,
    },
  },
}
