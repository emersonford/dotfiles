require("configs.plugins")
require("configs.options")
require("configs.mappings")
require("configs.cmds")
require("configs.lsp")

pcall(require, "configs.local")
