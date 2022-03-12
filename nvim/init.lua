require("configs.options")
require("configs.mappings")
require("configs.plugins")
require("configs.lsp")

pcall(require, "configs.local")
