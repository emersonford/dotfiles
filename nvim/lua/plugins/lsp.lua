return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          cmd = { "rustup", "run", "stable", "rust-analyzer" },
        },
      },
      diagnostics = {
        virtual_text = {
          -- Truncate diagnostic messages to the first line
          format = function(diagnostic)
            local new_line_location = diagnostic.message:find("\n")

            if new_line_location ~= nil then
              return diagnostic.message:sub(1, new_line_location)
            else
              return diagnostic.message
            end
          end,
        },
      },
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
