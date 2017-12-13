require('globals')

local function printStatus()
  print('--battery--')
  for k,v in pairs(hs.battery.getAll()) do print(k,v) end
  print('-----------')
end

local powerSource = hs.battery.powerSource()
local currentPercentage = hs.battery.percentage()
local warningPercentage = 10

local function notifyUserOfStatusChange()
  local newSource = hs.battery.powerSource()
  local newPercentage = hs.battery.percentage()

  local msg = {}
  if powerSource ~= newSource then
    powerSource = newSource
    
    if newSource == 'AC Power' then
      msg.title = 'Power Supply plugged in'
      msg.subTitle = string.format('Charging... (%d%%)', newPercentage)
      msg.soundName = 'Pop'
      msg.icon = 'battery_charging.png'
    else 
      msg.title = 'Power Supply removed!'
      msg.subTitle = string.format('%d%% remaining', newPercentage)
      msg.soundName = 'Bottle'
      msg.icon = 'battery.png'
    end

  elseif powerSource == 'Battery Power' then
    if newPercentage <= warningPercentage and currentPercentage > warningPercentage then
      msg.title = 'Low Power!'
      msg.subTitle = string.format('Only %d%% remaining!', newPercentage)
      msg.soundName = 'Bottle'
      msg.icon = 'battery_caution.png'
    end
  end
  currentPercentage = newPercentage

  if msg.title ~= nil then
    local notification = hs.notify.new(msg)
    notification:setIdImage('resources/images/' .. msg.icon)
    notification:send() 
  end
end

hs.battery.watcher.new(notifyUserOfStatusChange):start()
