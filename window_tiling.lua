require('globals')

local windowSize = {}

local function notUsed()
  local wf = hs.window.filter.new{'iTerm2'}
  
  local windows = wf:getWindows()
  print("windows:",windows)
  for k,v in pairs(windows) do print(k,v) end
  
  wf:subscribe(hs.window.filter.windowCreated, function(win, name, src)
    print("gotcha")
    tileWindow(win, hs.layout.right50)    
    wf:unsubscribeAll()
    wf:pause()
  end)
end

local function tileWindow(win, rect)
  if win == nil then return end

  winId = win:id()
  if windowSize[winId] == nil then
    windowSize[winId] = win:frame()
  end
  
  win:moveToUnit(rect)
end

local function resetWindowSize(win)
  if win == nil then return end

  winId = win:id()
  if windowSize[winId] == nil then return end

  win:move(windowSize[winId])
  windowSize[winId] = nil
end

local function openTerminal() 
  local cmd = "tell application \"iTerm2\"\ncreate window with default profile\nend tell"
  local success,output,description = hs.osascript.applescript(cmd)
end

hs.hotkey.bind({mod, "shift"}, "return", nil, openTerminal)

hs.fnutils.each({
    { key = 'left',  position = hs.layout.left50 },
    { key = 'right', position = hs.layout.right50 },
    { key = 'up',    position = {x=0, y=0, w=1, h=0.5} },
    { key = 'down',  position = {x=0, y=0.5, w=1, h=0.5} },
    { key = 'M',     position = hs.layout.maximized }
  }, function(binding)
    hs.hotkey.bind({mod, "shift"}, binding.key, nil, function() tileWindow(hs.window.frontmostWindow(), binding.position) end)
  end)
hs.hotkey.bind({mod, "shift"}, "delete", nil, function() resetWindowSize(hs.window.frontmostWindow()) end)
