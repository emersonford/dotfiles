local colors = require("tokyonight.colors").setup({})

return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    keys = function()
      return {
        { "gb", "<Cmd>b#<CR>" },
        { "gq", "<Cmd>BufferLinePickClose<CR>" },
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
}
