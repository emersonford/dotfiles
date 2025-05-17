local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night Storm'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Fira Code")
config.font_size = 12
config.line_height = 1.05

return config
