require('globals')
dofile('window_tiling.lua')
dofile('space_manipulation.lua')
dofile('battery.lua')

-- Keybinding for JetBrains: Code > Comment with Line Comment
hs.hotkey.bind({"alt", "ctrl"}, "7", nil, function() 
    hs.eventtap.keyStroke({"cmd"}, "pad/")
  end)

-- Hotkey for quick config reload
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", nil, function()
  hs.console.clearConsole()
  print("Reloading configuration...")
  hs.reload()
end)
hs.notify.new({title="Hammerspoon", subTitle="Config reloaded"}):send()
