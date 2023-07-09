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
          bg = {
            attribute = "bg",
            highlight = "StatusLine",
          },
        },
        separator = {
          fg = {
            attribute = "bg",
            highlight = "StatusLine",
          },
        },
        separator_selected = {
          fg = {
            attribute = "bg",
            highlight = "StatusLine",
          },
        },
        separator_visible = {
          fg = {
            attribute = "bg",
            highlight = "StatusLine",
          },
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
  },
}
