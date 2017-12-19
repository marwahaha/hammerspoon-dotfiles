dofile('window_tiling.lua')

-- Keybinding for JetBrains: Code > Comment with Line Comment
hs.hotkey.bind({"alt", "ctrl"}, "7", nil, function() 
    hs.eventtap.keyStroke({"cmd"}, "pad/")
  end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", nil, hs.reload)
hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send()
