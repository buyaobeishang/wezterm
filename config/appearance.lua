local wezterm = require("wezterm")
local colors = require("colors.custom")
local fonts = require('config.fonts')

return {
	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	cursor_blink_rate = 800,
	cursor_blink_ease_in = "Linear",
	default_cursor_style = 'SteadyBlock',

	-- color scheme
	colors = colors,

	-- background
	background = {
		{
			source = { File = wezterm.config_dir .. "/backdrops/astro-jelly.jpg" },
		},
		{
			source = { Color = colors.background },
			height = "100%",
			width = "100%",
			opacity = 0.70,
		},
	},

	quick_select_patterns = {
		'[0-9a-f]{7,40}',
	},

	-- scrollbar
	-- enable_scroll_bar = false,

	-- tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_max_width = 15,
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,
	native_macos_fullscreen_mode = true,

	-- window
	window_padding = {
		left = 5,
		right = 10,
		top = 12,
		bottom = 7,
	},
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
		-- font = fonts.font,
		-- font_size = fonts.font_size,
	},
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
}
