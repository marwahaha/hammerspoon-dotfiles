-- require traverses directories in your ~/.hammerspoon folder, with directory levels separated by dots
require('globals')
local spaces = require('hs._asm.undocumented.spaces')

local cache = {
  movingWindowToSpace = false
}

-- grabs screen with active window, unless it's Finder's desktop
-- then we use mouse position
local function activeScreen()
  local mousePoint = hs.geometry.point(hs.mouse.getAbsolutePosition())
  local activeWindow = hs.window.focusedWindow()

  if activeWindow and activeWindow:role() ~= 'AXScrollArea' then
    return activeWindow:screen()
  else
    return hs.fnutils.find(hs.screen.allScreens(), function(screen)
        return mousePoint:inside(screen:frame())
      end)
  end
end

local function screenSpaces(currentScreen)
  currentScreen = currentScreen or activeScreen()
  return spaces.layout()[currentScreen:spacesUUID()]
end

local function getScreenSpaceLayout()
  local orderedScreens = {}
  for screen,position in pairs(hs.screen.screenPositions()) do 
      local index = position.x + 1
      orderedScreens[index] = screen
  end 
  
  local layout = {}
  local i = 1
  -- old version: hs.screen.allScreens()
  hs.fnutils.each(orderedScreens, function(screen)  
    hs.fnutils.each(screenSpaces(screen), function(space)
      local o = {["screen"] = screen, ["space"] = space}
      layout[i] = o
      i = i + 1
    end)
  end)

  return layout
end

local function focusScreen(screen)
  local frame = screen:frame()

  -- if mouse is already on the given screen we can safely return
  if hs.geometry(hs.mouse.getAbsolutePosition()):inside(frame) then return false end

  -- "hide" cursor in the lower right side of screen
  -- it's invisible while we are changing spaces
  local mousePosition = {
    x = frame.x + frame.w - 1,
    y = frame.y + frame.h - 1
  }

  -- click in the lower right side of screen
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, mousePosition):post()
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp,   mousePosition):post()
  
  return true
end

local function activeSpaceIndex(screenSpaces)
  local as = spaces.activeSpace()
  local index = 0
  local result = hs.fnutils.find(getScreenSpaceLayout(), function(layout)
      index = index + 1
      return layout.space == as
    end)
  return index
end

local function calculateClickpoint(win)
  local clickPoint = win:zoomButtonRect()

  clickPoint.x = clickPoint.x + clickPoint.w + 5
  clickPoint.y = clickPoint.y + clickPoint.h / 2

  -- fix for Chrome UI
  if win:application():title() == 'Google Chrome' then
    clickPoint.y = clickPoint.y - clickPoint.h
  end
  
  return clickPoint
end

local function calculateRelativePosition(targetScreen)
  local currentScreen = activeScreen()

  local point = hs.mouse.getRelativePosition()
  if targetScreen == currentScreen then return point end  
  
  local currentScreenMode = currentScreen.currentMode(currentScreen)
  point.x = point.x / currentScreenMode.w
  point.y = point.y / currentScreenMode.h

  local targetScreenMode = targetScreen.currentMode(targetScreen)
  point.x = point.x * targetScreenMode.w
  point.y = point.y * targetScreenMode.h

  return point
end


--since hs.window:focus() doesn't properly focus the screen
local function focusWindow(win)
  local clickPoint = calculateClickpoint(win)

  local cachedMousePosition = hs.mouse.getAbsolutePosition()

  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint):post()
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, clickPoint):post()
  
  hs.mouse.setAbsolutePosition(cachedMousePosition)
end

local function moveToSpace(win, targetSpace, targetSpaceNumber, callbackFn)
    local clickPoint = calculateClickpoint(win)

    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint):post()
    hs.eventtap.keyStroke({ mod }, string.format("%d", targetSpaceNumber) )

    hs.timer.waitUntil(
      function()
        return spaces.activeSpace() == targetSpace
      end,
      function()
        hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, clickPoint):post()

        callbackFn()
        cache.movingWindowToSpace = false
      end,
      0.01 -- check every 10 ms
    )
end

local function moveToSpaceAndScreen(win, targetSpaceNumber)
  local layout = getScreenSpaceLayout()
  if layout[targetSpaceNumber] == nil then return end
  
  local targetSpace  = layout[targetSpaceNumber].space
  local targetScreen = layout[targetSpaceNumber].screen  
  local currentScreen = activeScreen()
  
  local screenSpaces = screenSpaces(currentScreen)
  local activeSpaceNumber = activeSpaceIndex(screenSpaces)

  -- check if all conditions are ok to move the window
  local shouldMoveWindow = hs.fnutils.every({
      targetSpace ~= nil,
      activeSpaceNumber ~= targetSpaceNumber,
      not cache.movingWindowToSpace
    }, function(test) return test end)

  if not shouldMoveWindow then return end

  cache.movingWindowToSpace = true

  if targetScreen == currentScreen then
    local cachedMousePosition = hs.mouse.getAbsolutePosition()
    moveToSpace(win, targetSpace, targetSpaceNumber, function() hs.mouse.setAbsolutePosition(cachedMousePosition) end)
  else
    local cachedMousePosition = calculateRelativePosition(targetScreen)
    win:moveToScreen(targetScreen, false, true, 0)
    hs.timer.doAfter(0.005, function() 
      focusWindow(win) 
      moveToSpace(win, targetSpace, targetSpaceNumber, function() hs.mouse.setRelativePosition(cachedMousePosition, targetScreen) end)
    end)
  end
end

local function moveMouseToScreenWithSpace(spaceNumber)
  if cache.movingWindowToSpace then return end

  local layout = getScreenSpaceLayout()
  if layout[spaceNumber] == nil then return end
  
  local targetScreen = layout[spaceNumber].screen  
  local currentScreen = activeScreen()
  if targetScreen == currentScreen then return end  

  local point = calculateRelativePosition(targetScreen)

  focusScreen(targetScreen)
  hs.mouse.setRelativePosition(point, targetScreen)
end


local supportedSpaces = {1, 2, 3, 4, 5, 6}

hs.fnutils.each(supportedSpaces, 
  function(number)
    hs.hotkey.bind({mod}, string.format("%d", number), nil, function() moveMouseToScreenWithSpace(number) end)
  end)

hs.fnutils.each(supportedSpaces, 
  function(number)
    hs.hotkey.bind({mod, "shift"}, string.format("%d", number), nil, function() moveToSpaceAndScreen(hs.window.frontmostWindow(), number) end)
  end)
