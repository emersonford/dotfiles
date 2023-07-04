return {
  {
    "liuchengxu/vista.vim",
    lazy = true,
    cmd = "Vista",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          cmd = { "rustup", "run", "stable", "rust-analyzer" },
        },
      },
    },
  },
}
