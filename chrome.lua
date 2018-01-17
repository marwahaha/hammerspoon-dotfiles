local function translateLabels(locale)
  local label = {}

  if locale == 'de_DE' then
    label.people = 'Personen'
    label.incognito = {'Datei', 'Neues Inkognitofenster'}
  else
    label.people = 'People'
    label.incognito = {'File', 'New Incognito Window'}
  end

  return label
end
local menu_label = translateLabels(hs.host.locale.current())

local function chrome_switch_to(profile)
    return function()
        hs.application.launchOrFocus("Google Chrome")

        local chrome = nil
        while chrome == nil do
          chrome = hs.application.find("Google Chrome")
        end

        local str_menu_item
        if profile == "Incognito" then
            str_menu_item = menu_label.incognito
        else
            str_menu_item = {menu_label.people, profile}
        end
        if chrome:selectMenuItem(str_menu_item) then
          -- found and selected
        end
    end
end

-- TODO maybe: cycle through all users (get available profiles: see console)

--- open different Chrome users
local chrome_profile_mod = 'ctrl'
local profiles = {
  'Manage',
  'Projekt',
  'Docs',
  'Incognito'
}
for key, profile in ipairs(profiles) do
    hs.hotkey.bind({chrome_profile_mod}, string.format('%d', key), chrome_switch_to(profile))
end
