local wezterm = require("wezterm")
local config = {}

-- helps with error detection
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- shell
config.default_prog = { "/bin/zsh", "-l" }

-- disable tabs
config.enable_tab_bar = false

-- NOTE: Appearance

-- window appearance
config.initial_rows = 60
config.initial_cols = 160
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Sakura"
-- config.color_scheme = "Catppuccin Macchiato"

-- terminal font
config.font = wezterm.font("MesloLGM Nerd Font Mono")
config.strikethrough_position = "0.5cell"
-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

return config
