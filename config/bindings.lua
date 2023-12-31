local wezterm = require('wezterm')
local platform = require('utils.platform')()
local act = wezterm.action

local mod = {}

if platform.is_mac then
   mod.SUPER = 'CMD'
   mod.SUPER_REV = 'CMD|CTRL'
elseif platform.is_win then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end


local keys = {
   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowTabNavigator },
   { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },
   { key = 'f', mods = mod.SUPER_REV, action = act.Search({ CaseInSensitiveString = '' }) },

   -- copy/paste --
   { key = 'c', mods = 'CMD', action = act.CopyTo('Clipboard') },
   { key = 'v', mods = 'CMD', action = act.PasteFrom('Clipboard') },

   -- tabs --
   -- tabs: spawn+close
   { key = 't', mods = mod.SUPER, action = act.SpawnTab('DefaultDomain') },
   { key = 't', mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = 'WSL:Ubuntu' }) },
   { key = 'w', mods = mod.SUPER, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation
   { key = 'h', mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
   { key = 'l', mods = mod.SUPER, action = act.ActivateTabRelative(1) },
   { key = 'j', mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
   { key = 'k', mods = mod.SUPER, action = act.ActivateTabRelative(1) },
   -- { key = 'h', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   -- { key = 'l', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   -- window --
   -- spawn windows
   { key = 'n', mods = mod.SUPER, action = act.SpawnWindow },

   { key = "s", mods = mod.SUPER_REV, action = act.QuickSelect },
   { key = 'n', mods = mod.SUPER_REV, action = wezterm.action.ToggleFullScreen },

   -- panes --
   -- panes: split panes
   {
      key = '-',
      mods = mod.SUPER,
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = [[\]],
      mods = mod.SUPER,
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },

   -- panes: zoom+close pane
   { key = 'z', mods = mod.SUPER, action = act.TogglePaneZoomState },
   -- { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentPane({ confirm = true }) },
   -- { key = "q", mods = "CTRL", action = act({ CloseCurrentPane = { confirm = true } }) },
   

   -- panes: navigation
   { key = '[', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
   { key = ']', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
   { key = '[', mods = mod.SUPER, action = act.ActivatePaneDirection('Left') },
   { key = ']', mods = mod.SUPER, action = act.ActivatePaneDirection('Right') },

   -- key-tables --
   -- resizes fonts
   {
      key = 'f',
      mods = 'CMD',
      action = act.ActivateKeyTable({
         name = 'resize_font',
         one_shot = false,
         timemout_miliseconds = 1000,
      }),
   },
   -- resize panes
   {
      key = 'p',
      mods = 'CMD',
      action = act.ActivateKeyTable({
         name = 'resize_pane',
         one_shot = false,
         timemout_miliseconds = 1000,
      }),
   },
}

local key_tables = {
   resize_font = {
      { key = 'k', action = act.IncreaseFontSize },
      { key = 'j', action = act.DecreaseFontSize },
      { key = 'r', action = act.ResetFontSize },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
   },
   resize_pane = {
      { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
      { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
      { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
      { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q', action = 'PopKeyTable' },
   },
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

return {
   disable_default_key_bindings = true,
   leader = { key = 'Space', mods = 'CTRL' },
   keys = keys,
   key_tables = key_tables,
   mouse_bindings = mouse_bindings,
}

