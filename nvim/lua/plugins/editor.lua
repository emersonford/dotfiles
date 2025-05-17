return {
  {
    "mhinz/vim-signify",
    init = function(_)
      vim.g.signify_skip = { vcs = { deny = { "git" } } }
    end,
    config = function(_, _)
      vim.api.nvim_set_hl(0, "SignifySignAdd", { link = "GitSignsAdd" })
      vim.api.nvim_set_hl(0, "SignifySignChange", { link = "GitSignsChange" })
      vim.api.nvim_set_hl(0, "SignifySignChangeDelete", { link = "GitSignsChange" })
      vim.api.nvim_set_hl(0, "SignifySignDelete", { link = "GitSignsDelete" })
      vim.api.nvim_set_hl(0, "SignifySignDeleteFirstLine", { link = "GitSignsDelete" })

      vim.g.signify_sign_add = "▎"
      vim.g.signify_sign_change = "▎"
      vim.g.signify_sign_delete = ""
      vim.g.signify_sign_delete_first_line = ""
      vim.g.signify_sign_change_delete = ""
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = function(_, keys)
      -- Insert at the start => if these keymaps already exist, don't override.
      table.insert(keys, 1, {
        "<leader>p",
        LazyVim.pick("files"),
        desc = "Find Files (root)",
      })

      -- Insert at the end => override these keymaps even if they exist.
      return vim.list_extend(keys, {
        { "<leader>,", false },
        { "<leader><space>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>" },
        {
          "<leader>P",
          LazyVim.pick("files", { root = false }),
          desc = "Find Files (cwd)",
        },
      })
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
  },
}
