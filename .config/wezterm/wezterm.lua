local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { '/usr/bin/zsh', '-c', 'tmux' }

config.font = wezterm.font_with_fallback {
  { family = 'Iosevka Nerd Font', weight = 'Regular' },
}
config.font_size = 17.0
--config.color_scheme = 'Google (dark) (terminal.sexy)'
config.color_scheme = "Gruber Dark"

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 5000

config.keys = {
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = wezterm.action.SendString '\x17',
  },
}

config.enable_tab_bar = false
config.audible_bell = 'Disabled'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.enable_kitty_keyboard = true
config.warn_about_missing_glyphs = false
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
}

return config
