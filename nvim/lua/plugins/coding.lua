return {
  {
    "L3MON4D3/LuaSnip",
    keys = function() end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- Require at least one tab before tab completing.
      opts.completion = {
        completeopt = "menu,menuone,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      })
    end,
  },
}
