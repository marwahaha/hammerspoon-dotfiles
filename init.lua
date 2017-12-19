-- Keybinding for JetBrains: Code > Comment with line comment (toggle)
hs.hotkey.bind({"alt", "ctrl"}, "7", nil, function() 
    hs.eventtap.keyStroke({"cmd"}, "pad/")
  end)
