local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Font configuration
config.font = wezterm.font("BerkeleyMono Nerd Font")
config.font_size = 14.0 -- Adjust as needed

-- Nerd Fonts configuration
config.font_rules = {
	{
		italic = false,
		intensity = "Normal",
		font = wezterm.font({
			family = "BerkeleyMono Nerd Font",
			scale = 1.0,
		}),
	},
}

-- Window size and position
config.initial_cols = 226
config.initial_rows = 70
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Window opacity
config.window_background_opacity = 0.95

-- Disable tabs
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Color scheme (Rosé Pine Moon)
-- config.color_scheme = 'Rosé Pine Moon'
config.color_scheme = "Kanagawa (Gogh)"
-- config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.color_scheme = 'Rosé Pine Moon (Gogh)'

-- config.keys = { }

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- macOS specific settings
if wezterm.target_triple == "x86_64-apple-darwin" then
	config.native_macos_fullscreen_mode = true
	config.quit_when_all_windows_are_closed = true
end

return config
