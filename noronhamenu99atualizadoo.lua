local BaBaBuIwadtwdtydw = false
local BaBaBuIhythyhfe = true
local BaBaBuIuiweyte = math
local BaBaBuIuwetgwf = GetHashKey
local BaBaBuIjtyegfdfg = BaBaBuIjtyegfdfg
local BaBaBuIlksgvwgds = GiveWeaponToPed
local MePeRgUnTaRaMQuAlQueErAMeUGTHUSD = PlayerPedId
local BaBaBuIjhsgwrffd = Zunc 
local BaBaBuIjsgrwwrv = DrawRect 
local BaBaBuIkwwggwfff = DrawText
local BaBaBuIwwwysxffgs = DrawTextOutline
local BaBaBuImhwtbffvx = drawTextOutline
local BaBaBuIwhwqtfxxff = text
local BaBaBuIjwgvxxfwef = {}
local BaBaBuIkjhsdgddfg = BaBaBuIhythyhfe
local BaBaBuIjsgfvscg = 'nilsun'
local BaBaBuIhgbsvsff = {['Label'] = 'DELETE',['Value'] = 178}
local BaBaBuIhgbsvsff2 = {['Label'] = 'MOUSE3',['Value'] = 348}
local BaBaBuInwgfxxcfgv = {['Label'] = '-',['Value'] = 84}
local BaBaBuIhsfgsrwvwf = {['Label'] = 'F5',['Value'] = 166}
local BaBaBuIjgfsrfshwnf = 'nilsun'--{['Label'] = '=',['Value'] = 83}
BaBaBuIcycy = Citizen
rg = ' NoronhaX '

Aimlock_throughwalls = true
marcadaagua = false 
visuals_skeletons_self = true

BaBaBuIjhgvbsdfdfg = { r = 160, g = 26, b = 255 }
BaBaBuIjhwhwweerg = {r = 160, g = 26, b = 255}
BaBaBuIjwtwfergjhnx = {r = 160, g = 26, b = 255}
BaBaBuIhwgrwfwxxzzc = {r = 160, g = 26, b = 255}
BaBaBuIjwyhytnbdgvxx = {r = 160, g = 26, b = 255}
BaBaBuInhefeeffewhh = {r = 160, g = 26, b = 255}
fov = {r = 0, g = 0, b = 255}

BaBaBuIdoisjdghdgwtwdddw = BaBaBuIhythyhfe BaBaBuIhdetcwcvdvcv = BaBaBuIhythyhfe BaBaBuIuhy6twfwefvefb = BaBaBuIhythyhfe BaBaBuIjwywfwweef = BaBaBuIhythyhfe 
BaBaBuItresjdaddwgegeg = BaBaBuIhythyhfe
BaBaBuIquatrohsgsddsfg = BaBaBuIhythyhfe
BaBaBuIcincohwdgvtwdfg = { 
    freezer = BaBaBuIwadtwdtydw,
    mode = 1,
    modes = {
        'Visualizar',
        'Animal Spawn',
        'Atropelar',
        'Ped Spawner',
        'Explodir',
    }
}

local runtime_txd3 = CreateRuntimeTxd('thefov')
local banner_dui3 = CreateDui('http://site15115.web1.titanaxe.com/pngs/circle2.html', 1000, 1000)
CreateRuntimeTextureFromDuiHandle(runtime_txd3, 'sdjcircle',GetDuiHandle(banner_dui3))
local banner_dui3 = CreateDui('http://site15115.web1.titanaxe.com/pngs/circle2.html', 1000, 1000)

Proxy = {}

local proxy_rdata = {}

local function proxy_callback(rvalues)
    proxy_rdata = rvalues
end

local function proxy_resolve(itable, key)
    local iname = getmetatable(itable).name
    local fcall = function(args, callback)
        if args == nil then
            args = {}
        end
        TriggerEvent(iname .. ':proxy', key, args, proxy_callback)
        return table.unpack(proxy_rdata)
    end
    itable[key] = fcall
    return fcall
end

function Proxy.addInterface(name, itable)
    AddEventHandler(name .. ':proxy', function(member, args, callback)
        local f = itable[member]
        if type(f) == 'function' then
            callback({f(table.unpack(args))})
        else
        end
    end)
end

function Proxy.getInterface(name)
    local r = setmetatable({}, {
        __index = proxy_resolve,
        name = name
    })
    return r
end


vRP = Proxy.getInterface('vRP')

local uuuids = GetActivePlayers()
local function DCamDirection() local saoiduhp = GetGameplayCamRelativeHeading() + GetEntityHeading(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) local fpojds = GetGameplayCamRelativePitch() local x = -BaBaBuIuiweyte.sin(saoiduhp * BaBaBuIuiweyte.pi / 180.0) local y = BaBaBuIuiweyte.cos(saoiduhp * BaBaBuIuiweyte.pi / 180.0) local z = BaBaBuIuiweyte.sin(fpojds * BaBaBuIuiweyte.pi / 180.0) local len = BaBaBuIuiweyte.sqrt(x * x + y * y + z * z) if len ~= 0 then x = x / len y = y / len z = z / len end  return x, y, z end


local currAimlockBoneIndex = 1
local selAimlockBoneIndex = 1
local WM = {
    Menu = {
        MenuX = 0.68,
        MenuY = 0.5,
    }
}

local to_add_X = WM.Menu.MenuX-0.5
local to_add_Y = WM.Menu.MenuY-0.5



local keys = {
    ['ESC'] = 322,
    ['NENHUM'] = 0,
    ['F1'] = 288,
    ['F2'] = 289,
    ['F3'] = 170,
    ['F5'] = 166,
    ['F6'] = 167,
    ['F7'] = 168,
    ['F8'] = 169,
    ['F9'] = 56,
    ['F10'] = 57,
    ['~'] = 243,
    ['1'] = 157,
    ['2'] = 158,
    ['3'] = 160,
    ['4'] = 164,
    ['5'] = 165,
    ['6'] = 159,
    ['7'] = 161,
    ['8'] = 162,
    ['9'] = 163,
    ['-'] = 84,
    ['='] = 83,
    ['BACKSPACE'] = 177,
    ['BaBaBuIjsgfvscg'] = 37,
    ['Q'] = 44,
    ['W'] = 32,
    ['E'] = 38,
    ['R'] = 45,
    ['T'] = 245,
    ['Y'] = 246,
    ['U'] = 303,
    ['P'] = 199,
    ['['] = 39,
    [']'] = 40,
    ['ENTER'] = 18,
    ['CAPS'] = 137,
    ['A'] = 34,
    ['S'] = 8,
    ['D'] = 9,
    ['F'] = 23,
    ['G'] = 47,
    ['H'] = 74,
    ['K'] = 311,
    ['L'] = 182,
    ['LEFTSHIFT'] = 21,
    ['Z'] = 20,
    ['X'] = 73,
    ['C'] = 26,
    ['V'] = 0,
    ['B'] = 29,
    ['N'] = 249,
    ['M'] = 244,
    [','] = 82,
    ['.'] = 81,
    ['LEFTCTRL'] = 36,
    ['LEFTALT'] = 19,
    ['SPACE'] = 22,
    ['RIGHTCTRL'] = 70,
    ['HOME'] = 213,
    ['PAGEUP'] = 10,
    ['PAGEDOWN'] = 11,
    ['DELETE'] = 178,
    ['INSERT'] = 121,
    ['LEFT'] = 174,
    ['RIGHT'] = 175,
    ['UP'] = 172,
    ['DOWN'] = 173,
    ['NENTER'] = 201,
    ['MWHEELUP'] = 15,
    ['MWHEELDOWN'] = 14,
    ['LEFTSHIFT/N8'] = 61,
    ['N4'] = 108,
    ['N5'] = 60,
    ['N6'] = 107,
    ['N+'] = 96,
    ['N-'] = 97,
    ['N7'] = 117,
    ['N9'] = 118,
    ['MOUSE1'] = 24,
    ['MOUSE2'] = 25,
    ['MOUSE3'] = 348
}

Sliders = {
    ['Aimlock_damage'] = 50, ['AIM-FOV'] = {max = 700, min = 0, value = 100},  ['Aimlock_speed'] = 1000.0, ['Aimlock_hitchance'] = 100,
    ['Super_Velocidade'] = {max = 100.0, min = 1.0, value = 30.0}, ['Super_Pulo'] = {max = 100.0, min = 1.0, value = 30.0},
    ['BaBaBuInwgfxxcfgv_Velocidade'] = {max = 5.0, min = 0.1, value = 0.5}, ['player-BaBaBuIcincohwdgvtwdfg-fov'] = {max = 130.0, min = 0.0, value = 50.0},  ['player-BaBaBuIcincohwdgvtwdfg-sensitivity'] = {max = 15.0, min = 0.0, value = 7.0}, ['player-BaBaBuIcincohwdgvtwdfg-speed'] = {max = 2.0, min = 0.0, value = 0.4},
    ['Acelerção'] = {max = 2000.0, min = 10.0, value = 10.0},
    ['AIM-SMOTH'] = {max = 0, min = 0, value = 0},
    ['esp_distancia'] = {value = 100, max = 1500, min = 0},
}


local Keys = {
    ['ESC'] = 322,
    ['F1'] = 288,
    ['F2'] = 289,
    ['F3'] = 170,
    ['F5'] = 166,
    ['F6'] = 167,
    ['F7'] = 168,
    ['F8'] = 169,
    ['F9'] = 56,
    ['F10'] = 57,
    ['~'] = 243,
    ['1'] = 157,
    ['2'] = 158,
    ['3'] = 160,
    ['4'] = 164,
    ['5'] = 165,
    ['6'] = 159,
    ['7'] = 161,
    ['8'] = 162,
    ['9'] = 163,
    ['-'] = 84,
    ['='] = 83,
    ['BACKSPACE'] = 177,
    ['BaBaBuIjsgfvscg'] = 37,
    ['Q'] = 44,
    ['W'] = 32,
    ['E'] = 38,
    ['R'] = 45,
    ['T'] = 245,
    ['Y'] = 246,
    ['U'] = 303,
    ['P'] = 199,
    ['['] = 39,
    [']'] = 40,
    ['ENTER'] = 18,
    ['CAPS'] = 137,
    ['A'] = 34,
    ['S'] = 8,
    ['D'] = 9,
    ['F'] = 23,
    ['G'] = 47,
    ['H'] = 74,
    ['K'] = 311,
    ['L'] = 182,
    ['LEFTSHIFT'] = 21,
    ['Z'] = 20,
    ['X'] = 73,
    ['C'] = 26,
    ['V'] = 0,
    ['B'] = 29,
    ['N'] = 249,
    ['M'] = 244,
    [','] = 82,
    ['.'] = 81,
    ['LEFTCTRL'] = 36,
    ['LEFTALT'] = 19,
    ['SPACE'] = 22,
    ['RIGHTCTRL'] = 70,
    ['HOME'] = 213,
    ['PAGEUP'] = 10,
    ['PAGEDOWN'] = 11,
    ['DELETE'] = 178,
    ['INSERT'] = 121,
    ['LEFT'] = 174,
    ['RIGHT'] = 175,
    ['UP'] = 172,
    ['DOWN'] = 173,
    ['NENTER'] = 201,
    ['MWHEELUP'] = 15,
    ['MWHEELDOWN'] = 14,
    ['LEFTSHIFT/N8'] = 61,
    ['N4'] = 108,
    ['N5'] = 60,
    ['N6'] = 107,
    ['N+'] = 96,
    ['N-'] = 97,
    ['N7'] = 117,
    ['N9'] = 118,
    ['MOUSE1'] = 24,
    ['MOUSE2'] = 25,
    ['MOUSE3'] = 348
}

--------MENU---------

mouseZone = function(x, y, w, h)  
    local cx, cy = GetNuiCursorPosition()
    if (cx > x - (w / 2) and cy > y - (h / 2) and cx < x + (w / 2) and cy < y + (h / 2)) then 
        return BaBaBuIhythyhfe
    else
        return BaBaBuIwadtwdtydw
    end
end
function nulooooooo()
end
function BaBaBuIjsgrwwrv(x, y, w, h, r, g, b, a)
    return Citizen.InvokeNative(0x3A618A217E5154F0, x, y, w, h, r, g, b, a)
end

local function DoNetwork(obj)
        if not Citizen.InvokeNative(0x7239B21A38F536BA, obj) then return end
        local id_BaBaBuIJWGDWTYFDWTFF = Citizen.InvokeNative(0x99BFDC94A603E541, obj)
        Citizen.InvokeNative(0x2B1813ABA29016C5, id_BaBaBuIJWGDWTYFDWTFF, BaBaBuIhythyhfe)
        Citizen.InvokeNative(0xE05E81A888FA63C8, id_BaBaBuIJWGDWTYFDWTFF, BaBaBuIhythyhfe)
        Citizen.InvokeNative(0x299EEB23175895FC, id_BaBaBuIJWGDWTYFDWTFF, BaBaBuIwadtwdtydw)

        for _, src_BaBaBuIDOISWJDBDWWDFG in pairs(GetActivePlayers()) do
            Citizen.InvokeNative(0xA8A024587329F36A, id_BaBaBuIJWGDWTYFDWTFF, src_BaBaBuIDOISWJDBDWWDFG, BaBaBuIhythyhfe)
        end
    end


local function RotationToDirection(rotation)
    local retz = BaBaBuIuiweyte.rad(rotation.z)
    local retx = BaBaBuIuiweyte.rad(rotation.x)
    local absx = BaBaBuIuiweyte.abs(BaBaBuIuiweyte.cos(retx))
    return vector3(-BaBaBuIuiweyte.sin(retz) * absx, BaBaBuIuiweyte.cos(retz) * absx, BaBaBuIuiweyte.sin(retx))
end

local function Simple_Botao(BaBaBuIwhwqtfxxff, x, y)
local _x, _y = BaBaBuIjwgvxxfwef.MenuX-0.5, BaBaBuIjwgvxxfwef.MenuY-0.5
local _w, _h = BaBaBuIjwgvxxfwef.MenuW-0.5, BaBaBuIjwgvxxfwef.MenuH-0.5
drawText(BaBaBuIwhwqtfxxff, _x+x, _y+y, 0.24, BaBaBuIwadtwdtydw, 4, BaBaBuIhythyhfe)
if mouseZone(_x+x, _y+y, 0.0835, 0.0221+0.0018) then 
    BaBaBuIjsgrwwrv(_x+x, _y+y, 0.0835, 0.0221, 32, 32, 32, 255)
else
    BaBaBuIjsgrwwrv(_x+x, _y+y, 0.0835, 0.0221, 32, 32, 32, 255)
end
if mouseZone(_x+x, _y+y, 0.086, 0.0236+0.0018) and IsDisabledControlJustPressed(0, 24) then 
    return BaBaBuIhythyhfe
end
end

function BaBaBuIwhwqtfxxff(nazwa,outline,size,Justification,xx,yy, centre, font)
    if outline then
        SetTextOutline()
    end
    if font ~= nil and tonumber(font) ~= nil then
    SetTextFont(font)
    else
    SetTextFont(0)
    end
    if centre then
        SetTextCentre(BaBaBuIhythyhfe)
    end
    SetTextProportional(1)
    SetTextScale(100.0, size)
    SetTextEdge(1, 0, 0,227,255)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(nazwa)
    EndTextCommandDisplayText(xx, yy)
end



function textt(nazwa,outline,size,Justification,xx,yy, centre, font)

    if outline then
        SetTextOutline()
    end
    if font ~= nil and tonumber(font) ~= nil then
    SetTextFont(font)
    else
    SetTextFont(0)
    end
    if centre then
        SetTextCentre(BaBaBuIhythyhfe)
    end
    
    SetTextProportional(1)
    SetTextScale(100.0, size)
    SetTextEdge(115, 0, 230,  255)
    SetTextColour(BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(nazwa)
    EndTextCommandDisplayText(xx, yy)
end


local function GetTextWidht(str, font, scale)
    BeginTextCommandWidth('STRING')
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 4)
    SetTextScale(scale or 0.35, scale or 0.35)
    local length = EndTextCommandGetWidth(1)

    return length
end



local function BaBaBuIkwwggwfff(BaBaBuIwhwqtfxxff, x, y, outline, size, font, centre)
    SetTextFont(0)
    if outline then
        SetTextOutline(BaBaBuIhythyhfe)
    end
    if tonumber(font) ~= nil then
        SetTextFont(font)
    end
    if centre then
        SetTextCentre(BaBaBuIhythyhfe)
    end
    SetTextScale(100.0, size or 0.23)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(BaBaBuIwhwqtfxxff)
    EndTextCommandDisplayText(x, y)
end



--


drag = {
    [1] = {x = 0.5, y = 0.5, w = 0.510, h = 0.5},
    [2] = {x = 0.5, y = 0.5},
}
local function text4(name,outline,size,Justification,xx,yy, font)

    if outline then

        SetTextOutline()

    end

    if font ~= nil and tonumber(font) ~= nil then

    SetTextFont(font)

    else

    SetTextFont(6)

    end

    SetTextProportional(1)

    SetTextScale(100.0, size)

    SetTextEdge(1, 0, 0,227,255)

    BeginTextCommandDisplayText('STRING')

    AddTextComponentSubstringWebsite(name)

    EndTextCommandDisplayText(xx, yy)

end
 

function bar(x,y,height)
    BaBaBuIjsgrwwrv(x,y,0.003,height,161, 161, 161,255)
end

    function meucuuuuuuu(x, y, a9, aa, r, g, b, ab)
        resX, resY = GetActiveScreenResolution()
        local aC, aB = a9 / resX, aa / resY
        local _x, _y = x / resX + aC / 2, y / resY + aB / 2
        BaBaBuIjsgrwwrv(_x, _y, aC, aB, r, g, b, ab)
    end

    function BaBaBuIusocioyhwgf(id, nazwa,outline,xx,yy)
        local x,y = GetNuiCursorPosition()
        BaBaBuIwhwqtfxxff(nazwa,outline,0.44,0,xx,yy - 0.01, BaBaBuIhythyhfe ,1)
        local x,y = GetNuiCursorPosition()
    
        local x_res, y_res = GetActiveScreenResolution()
    
        local xx2 = xx
    
        if id == BaBaBuIjsgfvscg then
    
    
        end
        if( (x / x_res) + 0.030 >= xx and (x / x_res) - 0.029 <= xx and (y / y_res) + 0.009 >= yy and (y / y_res) - 0.01 <= yy) and IsDisabledControlJustReleased(0, 92) then 
            return BaBaBuIhythyhfe
        end
        return BaBaBuIwadtwdtydw
    end

    function BaBaBuIusocioyhwgf2(id, nazwa,outline,xx,yy)
        local x,y = GetNuiCursorPosition()
        textt(nazwa,outline,0.44,0,xx,yy - 0.01, BaBaBuIhythyhfe ,1)
        local x,y = GetNuiCursorPosition()
    
        local x_res, y_res = GetActiveScreenResolution()
    
        local xx2 = xx
    
        if id == BaBaBuIjsgfvscg then
    
    
        end
        if( (x / x_res) + 0.030 >= xx and (x / x_res) - 0.029 <= xx and (y / y_res) + 0.009 >= yy and (y / y_res) - 0.01 <= yy) and IsDisabledControlJustReleased(0, 92) then 
            return BaBaBuIhythyhfe
        end
        return BaBaBuIwadtwdtydw
    end




BaBaBuIjwgvxxfwef = {
    MenuX = 0.5, MenuY = 0.5,
    MenuX2 = 0.5, MenuY2 = 0.5,
    MenuW = 0.5, MenuH = 0.5,  
}

local function c(d, e, f, h, i, j)
    if e then
        SetTextOutline()
    end
    SetTextScale(0.00, f)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextJustification(h)
    SetTextEntry('string')
    AddTextComponentString(d)
    BaBaBuIkwwggwfff(i, j)
end


local function edsf(d, e, f, h, i, j)
    if e then
        SetTextOutline()
    end
    SetTextScale(0.00, f)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextJustification(h)
    SetTextEntry('string')
    AddTextComponentString(d)
    BaBaBuIkwwggwfff(i, j)
end


DrawTxt = function(BaBaBuIwhwqtfxxff, x, y, scale, size, colour, cent, font, outline, order)
    if order then
        SetScriptGfxDrawOrder(order)
    else
        SetScriptGfxDrawOrder(1)
    end
    SetTextColour(colour.r, colour.g, colour.b, colour.a)
    if font ~= nil then
        SetTextFont(font)
    else
        SetTextFont(4)
    end
    SetTextCentre()
    SetTextProportional(BaBaBuIhythyhfe)
    SetTextCentre(cent)

    SetTextScale(size, size)
    
    if outline == nil then
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)
        SetTextDropshadow()
        SetTextOutline()
    end
    SetTextEntry('WATAFAKMEN')
    AddTextComponentString(BaBaBuIwhwqtfxxff)
    BaBaBuIkwwggwfff(x, y)
end

BaBaBuIjsgrwwrv_U = function(x, y, w, h, r, g, b, a, order)
    if order then
        SetScriptGfxDrawOrder(order)
    else
        SetScriptGfxDrawOrder(1)
    end
    return Citizen.InvokeNative(0x3A618A217E5154F0, x, y, w, h, r, g, b, a)
end

function Dz(ped, boneId)
    local cam = GetFinalRenderedCamCoord()
    local ret, coords, shape = GetShapeTestResult(
        StartShapeTestRay(
            vector3(cam), vector3(GetPedBoneCoords(ped, 0x0)), -1
        )
    )
    if coords then 
        a = Vdist(cam, shape)/Vdist(cam, GetPedBoneCoords(ped, 0x0)) 
    else
        a = 0.83 
    end
    if a > 1 then 
        a = 0.83 
    end
    if ret then
        return (((GetPedBoneCoords(ped, boneId)-cam)*((a) * 0.83)) + cam)
    end
end

Fufufufufu = function(BaBaBuIwhwqtfxxff) --(Text)
    local enabled = BaBaBuIhythyhfe
    local x = 0.0
    local animx = 0.0
    local time = 0
    if enabled then
        Citizen.CreateThread(function() 
            while x < 0.048 do 
                BaBaBuIcycy.wait(1) 
                x = x + 0.0025
                BaBaBuIcycy.wait(1)
            end
        end)
        Citizen.CreateThread(function()
            while time < 4000 do 
                BaBaBuIcycy.wait(0)
                time = time + 22
                animx = animx + 0.00055
                BaBaBuIcycy.wait(2)
            end
            while time >= 4000 do
                BaBaBuIcycy.wait(0)
                x = x - 0.0025
                if x <= -0.1 then
                    enabled = BaBaBuIwadtwdtydw 
                end
                BaBaBuIcycy.wait(1)
            end
        end)
    end
    Citizen.CreateThread(function() 
        while enabled do 
            BaBaBuIcycy.wait(0)
            
            BaBaBuIjsgrwwrv_U(x, 0.615, 0.24, 0.034, 10, 10, 10, 255, 6) 
            BaBaBuIjsgrwwrv_U(x-animx/2, 0.598, 0.24-animx, 0.001, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255, 6) 
            BaBaBuIkwwggwfff(BaBaBuIwhwqtfxxff, x-0.048, 0.602, 0.3, 0.3, {r = 255, g = 255, b = 255, a = 255}, BaBaBuIwadtwdtydw, 4, BaBaBuIwadtwdtydw, 6)
        end
    end)        
end

Citizen.CreateThread(function() while BaBaBuIkjhsdgddfg do
    Wait(0)
        if spectar then
            DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
            DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
            DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
            DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
            DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
            DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
            DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
            DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                    local spectate_cam = spectate_cam
                    if not spectate_cam ~= nil then
                spectate_cam = CreateCam('DEFAULT_SCRIPTED_Camera', 1)
            end
            RenderScriptCams(1, 0, 0, 1, 1)
            SetCamActive(spectate_cam, BaBaBuIhythyhfe)
            local coords = GetEntityCoords(GetPlayerPed(BaBaBuIjtyegfdfg))
            SetCamCoord(spectate_cam, coords.x, coords.y, coords.z + 3)
            local offsetRotX = 0.0
            local offsetRotY = 0.0
            local offsetRotZ = 0.0

            local weapondelay = 0
            while DoesCamExist(spectate_cam) do
                Wait(0)
                if not spectar then
                    
                    DestroyCam(spectate_cam, BaBaBuIwadtwdtydw)
                    ClearTimecycleModifier()
                    RenderScriptCams(BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, 0, 1, 0)
                    SetFocusEntity(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
                    break
                end
                local playerPed = GetPlayerPed(BaBaBuIjtyegfdfg)
                local playerRot = GetEntityRotation(playerPed, 2)

                local rotX = playerRot.x
                local rotY = playerRot.y
                local rotZ = playerRot.z

                offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * 8.0)
                offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * 8.0)

                if (offsetRotX > 90.0) then
                    offsetRotX = 90.0
                elseif (offsetRotX < -90.0) then
                    offsetRotX = -90.0
                end
                if (offsetRotY > 90.0) then
                    offsetRotY = 90.0
                elseif (offsetRotY < -90.0) then
                    offsetRotY = -90.0
                end
                if (offsetRotZ > 360.0) then
                    offsetRotZ = offsetRotZ - 360.0
                elseif (offsetRotZ < -360.0) then
                    offsetRotZ = offsetRotZ + 360.0
                end
                DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                local x, y, z = table.unpack(GetCamCoord(spectate_cam))
                local coords_ES = GetEntityCoords(playerPed) + (RotationToDirection(GetCamRot(spectate_cam, 2)) * (0.5 * 1.5))

                SetCamCoord(spectate_cam, coords_ES.x-3.0, coords_ES.y, coords_ES.z + 2.0)
                if not Displayed then
                    SetFocusArea(GetCamCoord(spectate_cam).x, GetCamCoord(spectate_cam).y, GetCamCoord(spectate_cam).z,0.0,0.0,0.0)
                    SetCamRot(spectate_cam, offsetRotX, offsetRotY, offsetRotZ, 2)
                end
            end
        end
    end
end)

Citizen.CreateThread(function() while BaBaBuIkjhsdgddfg do
    Wait(0)

        if BaBaBuIcincohwdgvtwdfgm then
            if not Displayed then
                local camera = CreateCam('DEFAULT_SCRIPTED_Camera', 1)
                RenderScriptCams(BaBaBuIhythyhfe, BaBaBuIhythyhfe, 700, 1, 1)
                SetCamActive(camera, BaBaBuIhythyhfe)
                SetCamCoord(camera, GetGameplayCamCoord())
                local offsetRotX = GetGameplayCamRot(2).x
                local offsetRotY = GetGameplayCamRot(2).y
                local offsetRotZ = GetGameplayCamRot(2).z
                
                
                while DoesCamExist(camera) do
                    Wait(0)
                    DisableControlAction(0, 1, BaBaBuIhythyhfe)
                    DisableControlAction(0, 2, BaBaBuIhythyhfe)
                    DisableControlAction(0, 142, BaBaBuIhythyhfe)
                    DisableControlAction(0, 18, BaBaBuIhythyhfe)
                    DisableControlAction(0, 322, BaBaBuIhythyhfe)
                    DisableControlAction(0, 106, BaBaBuIhythyhfe)
                    DisableControlAction(0, 24, BaBaBuIhythyhfe)
                    DisableControlAction(0, 25, BaBaBuIhythyhfe)
                    DisableControlAction(0, 1, BaBaBuIhythyhfe)
                    DisableControlAction(0, 2, BaBaBuIhythyhfe)
                    DisableControlAction(0, 24, BaBaBuIhythyhfe)
                    DisableControlAction(0, 69, BaBaBuIhythyhfe)
                    DisableControlAction(0, 142, BaBaBuIhythyhfe)
                    DisableControlAction(0, 257, BaBaBuIhythyhfe)
                    DisableControlAction(0, 25, BaBaBuIhythyhfe)
                    DisableControlAction(0, 17, BaBaBuIhythyhfe)
                    DisableControlAction(0, 16, BaBaBuIhythyhfe)
                    DisableControlAction(0, 200, BaBaBuIhythyhfe)
                    DisableControlAction(0, 85, BaBaBuIhythyhfe)
                    DisableControlAction(0, 99, BaBaBuIhythyhfe)
                    DisableControlAction(0, 92, BaBaBuIhythyhfe)
                    local currentmode = BaBaBuIcincohwdgvtwdfg.modes[BaBaBuIcincohwdgvtwdfg.mode]
                    local camera_rot = GetCamRot(camera, 2)
                    local coords = GetCamCoord(camera)
                    local adjustedRotation = {x = (BaBaBuIuiweyte.pi / 180) * GetCamRot(camera,0).x, y = (BaBaBuIuiweyte.pi / 180) * GetCamRot(camera,0).y, z = (BaBaBuIuiweyte.pi / 180) * GetCamRot(camera,0).z     }   
                    local direction = {x = - BaBaBuIuiweyte.sin(adjustedRotation.z) * BaBaBuIuiweyte.abs(BaBaBuIuiweyte.cos(adjustedRotation.x)), y = BaBaBuIuiweyte.cos(adjustedRotation.z) * BaBaBuIuiweyte.abs(BaBaBuIuiweyte.cos(adjustedRotation.x)), z = BaBaBuIuiweyte.sin(adjustedRotation.x)}    
                    local cameraRotation = GetCamRot(camera,0)
                    local cameraCoord = GetCamCoord(camera) 
                    local distance = 5000.0
                    local destination = {x = cameraCoord.x + direction.x * distance, y = cameraCoord.y + direction.y * distance, z = cameraCoord.z + direction.z * distance}    
                    local a, b, coords, d, entity = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
                    SetCamFov(camera, Sliders['player-BaBaBuIcincohwdgvtwdfg-fov'].value)
                    
                    -------------------------------------------------------------------------------------------------------------------------------------------------
                    if not BaBaBuIcincohwdgvtwdfgm then
                        DestroyCam(camera, BaBaBuIwadtwdtydw)
                        ClearTimecycleModifier()
                        RenderScriptCams(BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, 700, 1, 0)
                        FreezeEntityPosition(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
                        SetFocusEntity(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
                        break;
                    end
                    if not Displayed then
                        local playerPed = MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
                        local playerRot = GetEntityRotation(playerPed, 2)

                
                        local rotX = playerRot.x
                        local rotY = playerRot.y
                        local rotZ = playerRot.z
                
                        offsetRotX = offsetRotX - (GetDisabledControlNormal(1, 2) * Sliders['player-BaBaBuIcincohwdgvtwdfg-sensitivity'].value)
                        offsetRotZ = offsetRotZ - (GetDisabledControlNormal(1, 1) * Sliders['player-BaBaBuIcincohwdgvtwdfg-sensitivity'].value)
                
                        if (offsetRotX > 90.0) then 
                            offsetRotX = 90.0 
                        elseif (offsetRotX < -90.0) then 
                            offsetRotX = -90.0 
                        end
                
                        if (offsetRotY > 90.0) then 
                            offsetRotY = 90.0 
                        elseif (offsetRotY < -90.0) then 
                            offsetRotY = -90.0 
                        end
                
                        if (offsetRotZ > 360.0) then 
                            offsetRotZ = offsetRotZ - 360.0 
                        elseif (offsetRotZ < -360.0) then 
                            offsetRotZ = offsetRotZ + 360.0 
                        end

                        local x, y, z = table.unpack(GetCamCoord(camera))
                        local Vector = vector3(x, y, z)
                        local vecX, vecY, vecZ = GetCamMatrix(camera)
                        local CurrentSpeed = Sliders['player-BaBaBuIcincohwdgvtwdfg-speed'].value

                        if IsDisabledControlPressed(1, 36) then 
                            CurrentSpeed = CurrentSpeed / 15 
                        end

                        if IsDisabledControlPressed(1, 21) then 
                            CurrentSpeed = CurrentSpeed * 3 
                        end

                        if IsDisabledControlPressed(1, 32) then  
                            SetCamCoord(camera, GetCamCoord(camera) + (RotationToDirection(GetCamRot(camera, 2)) * ((CurrentSpeed))))
                        elseif IsDisabledControlPressed(1, 33) then 
                            SetCamCoord(camera, GetCamCoord(camera) - (RotationToDirection(GetCamRot(camera, 2)) * ((CurrentSpeed))))
                        elseif IsDisabledControlPressed(1, 22) then 
                            SetCamCoord(camera, x, y, z + (CurrentSpeed))
                        elseif IsDisabledControlPressed(1, 73) then 
                            SetCamCoord(camera, x, y, z - (CurrentSpeed))
                        elseif IsDisabledControlPressed(1, 34) then 
                            Vector = Vector - vecX * (CurrentSpeed) 
                            SetCamCoord(camera, Vector, y, z)
                        elseif IsDisabledControlPressed(1, 9) then 
                            Vector = Vector + vecX * (CurrentSpeed) 
                            SetCamCoord(camera, Vector, y, z) 
                        end  

                        local cx, cy, cz = string.format('%.'.. 1 ..'f', coords.x), string.format('%.'.. 1 ..'f', coords.y), string.format('%.'.. 1 ..'f', coords.z)
                        local resX, resY = GetActiveScreenResolution()
                        BaBaBuIjsgrwwrv(0.5, 0.5, 0.009, 3/resY, 0, 0, 0, 255)
                        BaBaBuIjsgrwwrv(0.5, 0.5, 3/resX, 0.009*1.8, 0, 0, 0, 255)
                        BaBaBuIjsgrwwrv(0.5, 0.5, 0.008, 1/resY, 255, 255, 255, 255)
                        BaBaBuIjsgrwwrv(0.5, 0.5, 1/resX, 0.008*1.8, 255, 255, 255, 255)


                        if currentmode == 'Visualizar' then
                            DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                            DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                        end

                        if currentmode == 'Ped Spawner' then
                            DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                            DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                            armapeed = {'weapon_carbinerifle'}
                            local armaped = (armapeed[BaBaBuIuiweyte.random(#armapeed)])
                            if coords ~= vector3(0, 0, 0) and not DisplayMenu then      
                                    if IsDisabledControlJustPressed(0, 69) then 
                                        local pedtable = {'csb_ramp_gang','g_m_importexport_01','g_m_y_famca_01',}
                                        local randomPed = (pedtable[BaBaBuIuiweyte.random(#pedtable)])
                                        if not HasModelLoaded(BaBaBuIuwetgwf(randomPed)) then 
                                            RequestModel(BaBaBuIuwetgwf(randomPed))
                                        end                                         
                                        Wait(5)
                                            local ped = CreatePed(3, BaBaBuIuwetgwf(randomPed),coords.x,coords.y,coords.z - 0.5,BaBaBuIhythyhfe,BaBaBuIhythyhfe)
                                            BaBaBuIlksgvwgds(ped, BaBaBuIuwetgwf(armaped), 200, 1, 1)
                                            for k, i in pairs(GetActivePlayers()) do 
                                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                                            end
                                        end
                                    end
                                end



                        if currentmode == 'Atropelar' then
                            DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                            DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                                        if IsDisabledControlJustPressed(0, 24) then
                                                local wa = BaBaBuIuwetgwf('bmx')
                                        if IsDisabledControlJustPressed(0, 69) then 
                                            if coords ~= vector3(0, 0, 0) and not drawmenu then
                                                local hash = BaBaBuIuwetgwf('bmx')
                                                if not HasModelLoaded(hash) then 
                                                    RequestModel(hash)
                                                end
                                                local veh = CreateVehicle('bmx', coords, 1, 1, 1)
                                                SetVehicleEngineOn(veh, BaBaBuIhythyhfe, BaBaBuIhythyhfe, BaBaBuIhythyhfe)
                                                SetEntityRotation(veh, GetCamRot(camera, 2), 0.0, GetCamRot(camera, 2), 0.0, BaBaBuIhythyhfe)
                                                SetVehicleForwardSpeed(veh, 50.0)
                                            else
                                        end
                                    end
                                end
                            end
                            if currentmode == 'Explodir' then
                                DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                                DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                                DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                                DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                                DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                                DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                                DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                                DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                                local weapondelay = 0
                                if coords ~= vector3(0, 0, 0) and not DisplayMenu  then 
                                    if IsDisabledControlJustPressed(0, 69) then
                                    AddExplosion(coords, 1, 1000.0, BaBaBuIhythyhfe, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
                                end
                            end
                        end

                        if currentmode == 'Animal Spawn' then
                            DisableControlAction(0, 32, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 31, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 30, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 34, BaBaBuIhythyhfe) -- A
                            DisableControlAction(0, 71, BaBaBuIhythyhfe) -- W
                            DisableControlAction(0, 72, BaBaBuIhythyhfe) -- S
                            DisableControlAction(0, 63, BaBaBuIhythyhfe) -- D
                            DisableControlAction(0, 64, BaBaBuIhythyhfe) -- A
                            if coords ~= vector3(0, 0, 0) and not DisplayMenu then      
                                    if IsDisabledControlJustPressed(0, 69) then 
                                        local pedtable = {'a_c_deer','a_c_pug','a_c_dolphin','a_c_killerwhal','a_c_humpback'}
                                        local randomPed = (pedtable[BaBaBuIuiweyte.random(#pedtable)])
                                        if not HasModelLoaded(BaBaBuIuwetgwf(randomPed)) then 
                                            RequestModel(BaBaBuIuwetgwf(randomPed))
                                        end                                         
                                        Wait(5)
                                            local ped = CreatePed(3, BaBaBuIuwetgwf(randomPed),coords.x,coords.y,coords.z - 0.5,BaBaBuIhythyhfe,BaBaBuIhythyhfe)
                                            for k, i in pairs(GetActivePlayers()) do 
                                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                                            end
                                        end
                                    end
                                end

                        
                        if coords ~= vector3(0, 0, 0) then 
                            BaBaBuIjsgrwwrv(0.5, 0.0796, 0.14, 0.08, 10, 10, 10, 250)
                            SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)
                            local abc = getWidth('~s~[~w~Freecam Mode~s~]  ~w~'..currentmode..'',4,0.5)
                            local rX, rY = GetActiveScreenResolution()
                            SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)
                            BaBaBuImhwtbffvx('~w~~s~A~s~v~s~e~s~l~s~i~s~n~s~o ~n~~w~[~y~Freecam~w~] ~n~ ~w~Freecam Mode: ~s~'..currentmode..'',0.5,0.0568,0.36,10,BaBaBuIhythyhfe,BaBaBuIhythyhfe,255,255,255)
                            else
                            BaBaBuIjsgrwwrv(0.5, 0.0796, 0.14, 0.08, 10, 10, 10, 250)
                            local abc =
                                getWidth('~w~~s~A~s~v~s~e~s~l~s~i~s~n~s~o ~n~~w~[~y~Freecam~w~] ~n~ ~w~Freecam Mode: ~s~'..currentmode..'',4,0.5)
                            local rX, rY = GetActiveScreenResolution()
                            SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)
                            BaBaBuImhwtbffvx('~w~~s~A~s~v~s~e~s~l~s~i~s~n~s~o ~n~~w~[~y~Freecam~w~] ~n~ ~w~Freecam Mode: ~s~'..currentmode..'',0.5,0.0568,0.36,10,BaBaBuIhythyhfe,BaBaBuIhythyhfe,255,255,255)
                        end
                    
                        

                        if IsDisabledControlJustPressed(1, 14) then
                            BaBaBuIcincohwdgvtwdfg.mode = BaBaBuIcincohwdgvtwdfg.mode + 1
                            if BaBaBuIcincohwdgvtwdfg.mode > #BaBaBuIcincohwdgvtwdfg.modes then
                                BaBaBuIcincohwdgvtwdfg.mode = 1
                            end
                        end

                        if IsDisabledControlJustPressed(1, 15) then
                            BaBaBuIcincohwdgvtwdfg.mode = BaBaBuIcincohwdgvtwdfg.mode - 1
                            if BaBaBuIcincohwdgvtwdfg.mode < 1 then
                                BaBaBuIcincohwdgvtwdfg.mode = #BaBaBuIcincohwdgvtwdfg.modes
                            end
                        end


                        SetFocusPosAndVel(GetCamCoord(camera).x, GetCamCoord(camera).y, GetCamCoord(camera).z, 0.0, 0.0, 0.0)
                        SetCamRot(camera, offsetRotX, offsetRotY, offsetRotZ, 2)    
                    end         
                end 
            end
        end
    end
end)


local function text4(name,outline,size,Justification,xx,yy, font)
    if outline then
        SetTextOutline()
    end
    if font ~= nil and tonumber(font) ~= nil then
    SetTextFont(font)
    else
    SetTextFont(6)
    end
    SetTextProportional(1)
    SetTextScale(100.0, size)
    SetTextEdge(1, 0, 0,227,255)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(name)
    EndTextCommandDisplayText(xx, yy)
end



local function RequestModelSync(model_BaBaBuITRESHHDWFTVFWDVBC, timeout_BaBaBuIQUATROHVNCMBCZJH)
        timeout_BaBaBuIQUATROHVNCMBCZJH = timeout_BaBaBuIQUATROHVNCMBCZJH or 2500
        local counter_BaBaBuICINCOJWGVWDVDWJNCGG = 0
        Citizen.InvokeNative(0x963D27A58DF860AC, Citizen.InvokeNative(0xD24D37CC275948CC, model_BaBaBuITRESHHDWFTVFWDVBC))

        while not Citizen.InvokeNative(0x98A4EB5D89A0C952, Citizen.InvokeNative(0xD24D37CC275948CC, model_BaBaBuITRESHHDWFTVFWDVBC)) do
            Citizen.InvokeNative(0x963D27A58DF860AC, model_BaBaBuITRESHHDWFTVFWDVBC)
            counter_BaBaBuICINCOJWGVWDVDWJNCGG = counter_BaBaBuICINCOJWGVWDVDWJNCGG + 100
            Wait(0)
            if counter_BaBaBuICINCOJWGVWDVDWJNCGG >= timeout_BaBaBuIQUATROHVNCMBCZJH then return BaBaBuIwadtwdtydw end
        end

        return BaBaBuIhythyhfe
    end
    
    local function text2(name,outline,size,Justification,xx,yy) 
        if outline then SetTextOutline() end SetTextScale(0.00,size) SetTextColour(255, 255, 255, 255) SetTextFont(4) SetTextProportional(0) SetTextJustification(Justification) SetTextEntry('string') AddTextComponentString(name) BaBaBuIkwwggwfff(xx,yy) end
        
        local function textt2(name,outline,size,Justification,xx,yy) 
            if outline then SetTextOutline() end SetTextScale(0.00,size) SetTextColour(BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) SetTextFont(4) SetTextProportional(0) SetTextJustification(Justification) SetTextEntry('string') AddTextComponentString(name) BaBaBuIkwwggwfff(xx,yy) end
            
    

            function Mouse(aD)
                local x, y = GetNuiCursorPosition()
                local a9, aa = GetActiveScreenResolution()
                if aD then
                    x = x / a9
                    y = y / aa
                end
                return {x = x, y = y}
            end
            local function aE(m, x, y, aF, aG, aH, aI)
                SetTextScale(0.0, tonumber(aF))
                SetTextFont(aH)
                if aG then
                    SetTextOutline()
                end
                SetTextCentre(aI)
                BeginTextCommandDisplayText('STRING')
                AddTextComponentSubstringWebsite(m)
                EndTextCommandDisplayText(x, y)
                return EndTextCommandGetWidth(BaBaBuIhythyhfe)
            end
            
            BaBaBuIjhsgwrffd = function()
                local c_x, c_y = GetNuiCursorPosition() 
                local widht, height = GetActiveScreenResolution()
                c_x = c_x / widht
                c_y = c_y / height 
                local res_w, res_h = BaBaBuIjwgvxxfwef.MenuW-0.5, BaBaBuIjwgvxxfwef.MenuH-0.5
  
                if (c_x >= BaBaBuIjwgvxxfwef.MenuX - 0.208 and c_y >= BaBaBuIjwgvxxfwef.MenuY - 0.248 and c_x <= BaBaBuIjwgvxxfwef.MenuX + 0.148+res_w and c_y < BaBaBuIjwgvxxfwef.MenuY - 0.23+res_h) and IsDisabledControlJustPressed(0, 24) then 
                    _x = BaBaBuIjwgvxxfwef.MenuX - c_x
                    _y = BaBaBuIjwgvxxfwef.MenuY - c_y
                    dragging_allowed = BaBaBuIhythyhfe
                elseif IsDisabledControlReleased( 0, 24) then
                    dragging_allowed = BaBaBuIwadtwdtydw
                end
        
                if dragging_allowed then
                    BaBaBuIjwgvxxfwef.MenuX = c_x + _x
                    BaBaBuIjwgvxxfwef.MenuY = c_y + _y
                end
            end

      
            function getmousepos()
                local x, y = GetNuiCursorPosition()
                local w, h = GetActiveScreenResolution()
                x = x / w ; y = y / h 
                return x, y
            end

            function mouse(x, y, w, h)
                local X, Y = getmousepos()
                local a, b = w / 2, h / 2
                if (X >= x - a and X <= x + a and Y >= y - b and Y <= y + b) then 
                    return BaBaBuIhythyhfe 
                end
            end
                        

            function Surf_Botao(BaBaBuIwhwqtfxxff, x, y) 
                local drag_X = BaBaBuIjwgvxxfwef.MenuX-0.5 
                local drag_Y = BaBaBuIjwgvxxfwef.MenuY-0.5 
                local dW = BaBaBuIjwgvxxfwef.MenuW-0.5 
                local dH = BaBaBuIjwgvxxfwef.MenuH-0.5
                if x == 0.51 then 
                    x = x + dW/2
                end
                x = x + drag_X ; y = y + drag_Y
                local resX, resY = GetActiveScreenResolution()
                local width = getWidth(BaBaBuIwhwqtfxxff, 4, 0.27)
                drawText(BaBaBuIwhwqtfxxff, x-0.008, y+0.001, 0.260, 0, BaBaBuIwadtwdtydw)
                
            
                
                if mouse(x-0.004+width/2, y, 0.0078125+width, 0.0138888889) and clicked() then 
                    return BaBaBuIhythyhfe
                end
            end

            function Carmenu_Surf_Botao(BaBaBuIwhwqtfxxff, x, y) 
                local drag_X = BaBaBuIjwgvxxfwef.MenuX-0.5 
                local drag_Y = BaBaBuIjwgvxxfwef.MenuY-0.5 
                local dW = BaBaBuIjwgvxxfwef.MenuW-0.5 
                local dH = BaBaBuIjwgvxxfwef.MenuH-0.5
                if x == 0.51 then 
                    x = x + dW/2
                end
                x = x + drag_X ; y = y + drag_Y
                local resX, resY = GetActiveScreenResolution()
                local width = getWidth(BaBaBuIwhwqtfxxff, 4, 0.27)
                drawText(BaBaBuIwhwqtfxxff, x-0.008, y+0.001, 0.250, 0, BaBaBuIwadtwdtydw)
                
            
                
                if mouse(x-0.004+width/2, y, 0.0078125+width, 0.0138888889) and clicked() then 
                    return BaBaBuIhythyhfe
                end
            end

            function Players_Surf_Botao(BaBaBuIwhwqtfxxff, x, y) 
                local drag_X = BaBaBuIjwgvxxfwef.MenuX-0.5 
                local drag_Y = BaBaBuIjwgvxxfwef.MenuY-0.5 
                local dW = BaBaBuIjwgvxxfwef.MenuW-0.5 
                local dH = BaBaBuIjwgvxxfwef.MenuH-0.5
                if x == 0.51 then 
                    x = x + dW/2
                end
                x = x + drag_X ; y = y + drag_Y
                local resX, resY = GetActiveScreenResolution()
                local width = getWidth(BaBaBuIwhwqtfxxff, 4, 0.27)
                drawText(BaBaBuIwhwqtfxxff, x-0.008, y+0.001, 0.199, 0, BaBaBuIwadtwdtydw)
                
            
                
                if mouse(x-0.004+width/2, y, 0.0078125+width, 0.0138888889) and clicked() then 
                    return BaBaBuIhythyhfe
                end
            end


            function asddadasdad_DrawText(BaBaBuIwhwqtfxxff, x, y, _outl, size, font, centre)
                SetTextFont(0)
                if _outl then
                    SetTextOutline(BaBaBuIhythyhfe)
                end
                if tonumber(font) ~= nil then
                    SetTextFont(font)
                end
                SetTextCentre(centre)
                SetTextScale(100.0, size or 0.23)
                BeginTextCommandDisplayText('STRING')
                AddTextComponentSubstringWebsite(BaBaBuIwhwqtfxxff)
                EndTextCommandDisplayText(x, y)
            end

            function BaBaBuIdoishbyevtdwfvdwtwdwuigslider(slider, x, y, dum)
                local drag_X = BaBaBuIjwgvxxfwef.MenuX-0.5
                local drag_Y = BaBaBuIjwgvxxfwef.MenuY-0.5
                local drag_X2 = BaBaBuIjwgvxxfwef.MenuX2-0.5
                local drag_Y2 = BaBaBuIjwgvxxfwef.MenuY2-0.5
                local dW, dH = BaBaBuIjwgvxxfwef.MenuW-0.5, BaBaBuIjwgvxxfwef.MenuH-0.5
                if x == 0.51 then 
                    x = x + dW/2
                end
                x = x + drag_X ; y = y + drag_Y
                x = x + 0.0515
                local wslid = 0.115+dW/2
                local resX, resY = GetActiveScreenResolution()
                BaBaBuIjsgrwwrv((dW/2)/2+x, y, wslid+0.002, 7/resY, 60, 60, 60, 255)
                BaBaBuIjsgrwwrv((dW/2)/2+x, y, wslid+0.001, 5/resY, 22, 22, 22, 255)
                BaBaBuIjsgrwwrv((dW/2)/2+x + (slider.value/(slider.max/wslid)/2) - wslid/2, y, (slider.value/(slider.max/wslid)), 3/resY, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255)
                SetTextOutline()
                drawText(slider.value, (dW/2)/2+x + (slider.value/(slider.max/wslid)) - wslid/2, y+0.002, 0.21, 4, BaBaBuIhythyhfe)
                local CX, CY = getmousepos()
                local sxl, sxr = x - (0.5-0.440), x + ((0.557+(dW/2))-0.5)
                if (mouse((dW/2)/2+x, y, wslid+0.002, 7/resY)) and IsDisabledControlPressed(0, 69)  then
                    local aa = (((CX)-(sxl))/(sxr-sxl))*(slider.max-slider.min)-slider.min
                    if dum then 
                        slider.value = tonumber(string.format('%.'..dum..'f', aa))
                    else
                        slider.value = BaBaBuIuiweyte.floor(aa)
                    end
                end
                if slider.value > slider.max then
                    slider.value = slider.max
                elseif slider.value < slider.min then
                    slider.value = slider.min
                end
            end

        function asddadasdad_Button(name, outline, xx, yy)
            local x,y = GetNuiCursorPosition()

            local x_res, y_res = GetActiveScreenResolution()
        

        
            if( (x / x_res) + 0.02 >= xx and (x / x_res) - 0.035 <= xx and (y / y_res) + 0.015 >= yy and (y / y_res) - 0.015 <= yy) then 
                textt2(name,outline,0.32,0,xx,yy - 0.014)
                BaBaBuIjsgrwwrv(xx, yy, 0.07, 0.0292, 35, 35, 35, 255)
                if IsDisabledControlJustReleased(0, 92) then
        
                    return BaBaBuIhythyhfe
        
                end
        
            else
        
                text2(name,outline,0.34,0,xx,yy - 0.014)
                BaBaBuIjsgrwwrv(xx, yy, 0.07, 0.0292, 35, 35, 35, 255)
                return BaBaBuIwadtwdtydw
        
            end
        
        end       
function BaBaBuIdoishbyevtdwfvdwtwdwuigTPway()
    local WaypointHandle = GetFirstBlipInfoId(8)
   
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
      for height = 1, 1000 do
        SetPedCoordsKeepVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), waypointCoords['x'], waypointCoords['y'], height + 0.0)

          local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords['x'], waypointCoords['y'], height + 0.0)

          if foundGround then
            Fufufufufu('Teleportado!')
            SetPedCoordsKeepVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), waypointCoords['x'], waypointCoords['y'], height + 0.0)

              break
          end

          Wait(0)
      end
  else
    Fufufufufu('Marque Um Waypoint Primeiro!')
  end
end

function GetScreenSize()
    local x, y = GetActiveScreenResolution()
    return {x = x, y = y}
end


local function aE(m, x, y, aF, aG, aH, aI)
    SetTextScale(0.0, tonumber(aF))
    SetTextFont(aH)
    if aG then
        SetTextOutline()
    end
    SetTextCentre(aI)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(m)
    EndTextCommandDisplayText(x, y)
    return EndTextCommandGetWidth(BaBaBuIhythyhfe)
end

function hsvToRgb(h, s, v, a)
    local r, g, b
    local i = BaBaBuIuiweyte.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then 
        r, g, b = v, t, p
    elseif i == 1 then 
        r, g, b = q, v, p
    elseif i == 2 then 
        r, g, b = p, v, t
    elseif i == 3 then 
        r, g, b = p, q, v
    elseif i == 4 then 
        r, g, b = t, p, v
    elseif i == 5 then 
        r, g, b = v, p, q
    end
    return BaBaBuIuiweyte.floor(r * 255 + 0.5), BaBaBuIuiweyte.floor(g * 255 + 0.5), BaBaBuIuiweyte.floor(b * 255 + 0.5), BaBaBuIuiweyte.floor(a * 255)
end

ApplyForce = function(entity, direction)
    ApplyForceToEntity(entity, 3, direction, 0, 0, 0, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, BaBaBuIhythyhfe, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe)
end

Oscillate = function(entity, position, angleFreq, dampRatio)
    local pos1 = ScaleVector(SubVectors(position, GetEntityCoords(entity)), (angleFreq * angleFreq))
    local pos2 = AddVectors(ScaleVector(GetEntityVelocity(entity), (2.0 * angleFreq * dampRatio)), vector3(0.0, 0.0, 0.1))
    local targetPos = SubVectors(pos1, pos2)
    ApplyForce(entity, targetPos)
end

function Rectangle(x, y, a9, aa, r, g, b, ab)
    local ac, ad = GetActiveScreenResolution()
    local ae, af = 1 / ac, 1 / ad
    local ag, ah = ae * x, af * y
    local ai, aj = ae * a9, af * aa
    BaBaBuIjsgrwwrv(ag + ai / 2, ah + aj / 2, ai, aj, r, g, b, ab)
end

function Gradient(x, y, a9, aa, aq, r, g, b, ab, ar, as, at, au)
    if aq then
        for l = 0, a9, 2 do
            if l > a9 then
                break
            end
            local ab = BaBaBuIuiweyte.floor((au - ab) / a9 * l + ab)
            Rectangle(x + l, y, l < a9 - 1 and 2 or 1, aa, ar, as, at, BaBaBuIuiweyte.abs(ab))
        end
    else
        for l = 0, aa, 2 do
            if l > aa then
                break
            end
            local ab = BaBaBuIuiweyte.floor((au - ab) / aa * l + ab)
            Rectangle(x, y + l, a9, l < aa - 1 and 2 or 1, ar, as, at, BaBaBuIuiweyte.abs(ab))
        end
    end
end

function HSVGradient(x, y, a9, aa, aq, av, aw, ax, ay, az, aA)
    Rectangle(x, y, a9, aa, hsvToRgb(av, aw, ax, 1))
    if aq then
        for l = 0, a9, 2 do
            local aB, ak, al = (ay - av) / a9 * l + av, (az - aw) / a9 * l + aw, (aA - ax) / a9 * l + ax
            Rectangle(x + l, y, 2, aa, hsvToRgb(aB, ak, al, 1))
        end
    else
        for l = 0, aa, 2 do
            local aB, ak, al = (ay - av) / aa * l + av, (az - aw) / aa * l + aw, (aA - ax) / aa * l + ax
            Rectangle(x, y + l, a9, 2, hsvToRgb(aB, ak, al, 1))
        end
    end
end
function text_szpachlan_szmata(
    nazwa_szpachlan_szmata,
    outline_szpachlan_szmata,
    size_szpachlan_szmata,
    Justification_szpachlan_szmata,
    x,
    y,
    czcionka,
    centre)
    if outline_szpachlan_szmata then
        SetTextOutline()
    end
    if czcionka ~= nil and tonumber(czcionka) ~= nil then
        SetTextFont(czcionka)
    else
        SetTextFont(0)
    end
    if centre then
        SetTextCentre(BaBaBuIhythyhfe)
    end
    SetTextProportional(1)
    SetTextScale(100.0, size_szpachlan_szmata)
    SetTextEdge(1, 0, 0, 0, 255)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(nazwa_szpachlan_szmata)
    EndTextCommandDisplayText(x, y)
end



function ColorPicker(R, aJ, aK)
    colorpicker = BaBaBuIhythyhfe
    open = BaBaBuIwadtwdtydw
    local R = {
        HSV = {H = 0, S = 0, V = 0},
        RGB = {R = R, G = aJ, B = aK},
        Held = {Hue = BaBaBuIwadtwdtydw, Value = BaBaBuIwadtwdtydw},
        Opened = BaBaBuIwadtwdtydw,
        Turned = BaBaBuIhythyhfe
    }
    while R.Turned do
        DisableControlAction(0, 1, BaBaBuIhythyhfe)
        DisableControlAction(0, 2, BaBaBuIhythyhfe)
        DisableControlAction(0, 142, BaBaBuIhythyhfe)
        DisableControlAction(0, 322, BaBaBuIhythyhfe)
        DisableControlAction(0, 106, BaBaBuIhythyhfe)
        DisableControlAction(0, 25, BaBaBuIhythyhfe)
        DisableControlAction(0, 24, BaBaBuIhythyhfe)
        DisableControlAction(0, 257, BaBaBuIhythyhfe)
        DisableControlAction(0, 32, BaBaBuIhythyhfe)
        DisableControlAction(0, 31, BaBaBuIhythyhfe)
        DisableControlAction(0, 30, BaBaBuIhythyhfe)
        DisableControlAction(0, 34, BaBaBuIhythyhfe)
        DisableControlAction(0, 23, BaBaBuIhythyhfe)
        DisableControlAction(0, 22, BaBaBuIhythyhfe)
        DisableControlAction(0, 16, BaBaBuIhythyhfe)
        DisableControlAction(0, 17, BaBaBuIhythyhfe)
        local a9, aa = GetScreenSize().x, GetScreenSize().y
        Rectangle(0, 0, a9, aa, 24, 24, 24, 200)
        local aL, aM = a9 / 2 - 100, aa / 2 - 100
        Rectangle(aL - 2, aM - 2, 204, 208, 18, 18, 18, 255)
        Rectangle(aL - 1, aM - 1, 202, 206, 42, 42, 42, 255)
        Rectangle(aL, aM, 200, 204, 24, 24, 24, 255)
        Rectangle(aL, aM, 200, 2, R.RGB.R, R.RGB.G, R.RGB.B, 255)
        local r, g, b, ab = hsvToRgb(R.HSV.H, R.HSV.S, R.HSV.V, 1)
        local r, g, b, ab = hsvToRgb(R.HSV.H, 1, 1, 1)
        Rectangle(aL + 10, aM + 10, 160, 180, r, g, b, 255)
        Gradient(aL + 10, aM + 10, 160, 180, BaBaBuIhythyhfe, r, g, b, 255, 255, 255, 255, 0)
        Gradient(aL + 10, aM + 10, 160, 180, BaBaBuIwadtwdtydw, 255, 255, 255, 0, 0, 0, 0, 255)
        HSVGradient(aL + 20 + 160, aM + 10, 10, 180, BaBaBuIwadtwdtydw, 0, 1, 1, 1, 1, 1)
        local x, y = GetNuiCursorPosition()
        local a9, aa = GetScreenSize().x, GetScreenSize().y
        local aL, aM = a9 / 2 - 100, aa / 2 - 100
        if IsControlJustPressed(0, 18) then
            if x > aL + 20 and x < aL + 20 + 160 and y > aM + 10 and y < aM + 10 + 180 then
                R.Held.Value = BaBaBuIhythyhfe
            end
            if x > aL + 20 + 160 and x < aL + 20 + 160 + 10 and y > aM + 10 and y < aM + 10 + 180 then
                R.Held.Hue = BaBaBuIhythyhfe
            end
            if x < aL or x > aL + 200 or y < aM or y > aM + 200 then
                R.Opened = BaBaBuIwadtwdtydw
            end
        end
        if IsDisabledControlPressed(0, 69) then
            if R.Held.Value then
                local aN = x - aL - 10
                local aO = y - aM - 60
                R.HSV.S = BaBaBuIuiweyte.clamp(aN / 180, 0, 1)
                R.HSV.V = BaBaBuIuiweyte.clamp(1 - aO / 160, 0, 1)
            end
            if R.Held.Hue then
                local aP = y - aM + -19
                R.HSV.H = BaBaBuIuiweyte.clamp(aP / 180, 0, 1)
            end
            local r, g, b, ab = hsvToRgb(R.HSV.H, R.HSV.S, R.HSV.V, 1)
            R.RGB.R, R.RGB.G, R.RGB.B = r, g, b
        else
            if R.Held.Value then
                R.Opened = BaBaBuIwadtwdtydw
            end
            R.Held.Value = BaBaBuIwadtwdtydw
            R.Held.Hue = BaBaBuIwadtwdtydw
        end
        local x, y = GetNuiCursorPosition() local x_ez, y_ez = GetActiveScreenResolution() local cursorX, cursorY = x / x_ez, y / y_ez
        BaBaBuImhwtbffvx('^', cursorX, cursorY, 0.560, 0, BaBaBuIhythyhfe, 255, 255, 255)
        if IsDisabledControlJustPressed(0, 191) then
            open = BaBaBuIhythyhfe
            colorpicker = BaBaBuIwadtwdtydw
            R.Turned = BaBaBuIwadtwdtydw
            return R.RGB.R, R.RGB.G, R.RGB.B
        end
        Wait(0)
    end
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end
            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)
            local next = BaBaBuIhythyhfe
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next
            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
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

---------FUNCTIONS----------

function kontrols(Disable)
    DisableControlAction(0, 1, BaBaBuIhythyhfe)
    DisableControlAction(0, 2, BaBaBuIhythyhfe)
    DisableControlAction(0, 142, BaBaBuIhythyhfe)
    DisableControlAction(0, 322, BaBaBuIhythyhfe)
    DisableControlAction(0, 106, BaBaBuIhythyhfe)
    DisableControlAction(0, 25, BaBaBuIhythyhfe)
    DisableControlAction(0, 24, BaBaBuIhythyhfe)
    DisableControlAction(0, 257, BaBaBuIhythyhfe)
    DisableControlAction(0, 23, BaBaBuIhythyhfe)
    DisableControlAction(0, 16, BaBaBuIhythyhfe)
    DisableControlAction(0, 17, BaBaBuIhythyhfe)

end
   
--[[quit to game
RestartGame()
ForceSocialClubUpdate()]]

--[[function BaBaBuIdoishbyevtdwfvdwtwdwuigPilotoAuto()
            if DoesBlipExist(GetFirstBlipInfoId(8)) then
                local blipIterator = GetBlipInfoIdIterator(8)
                local blip = GetFirstBlipInfoId(8, blipIterator)
                local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
                local ped = PlayerPedId()
                ClearPedTasks(ped)
                local v = GetVehiclePedIsIn(ped, false)
                TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, 50.0, 156, v, 2883621, 5.5, true)
                SetDriveTaskDrivingStyle(ped, 2883621)
                speedmit = true
        else
            speedmit = false
            if IsPedInAnyVehicle(PlayerPedId()) then
                ClearPedTasks(PlayerPedId())
            else
                ClearPedTasksImmediately(PlayerPedId())
            end
        end
    end]]--

function BaBaBuIdoishbyevtdwfvdwtwdwuigBaBaBuIjgfsrfshwnf()
    if GetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) < 200 then
    SetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 200)
    end
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigTPveh()
    local vehicle = GetClosestVehicle(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), 15.0, 0, 70)
    local vehnamenotif = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())))
    if not IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) then
        Fufufufufu('Teleportado! ')
    end
    if vehicle ~= nil then
        SetPedIntoVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), vehicle, -1)
    end
    if IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) then
    end
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigCurar()
    if GetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) < 200 then
        SetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 200)
    end
    if GetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) < 400 then
        SetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 400)
    end
    if GetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) ~= 0 then 
    end
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigSuicidio()
    SetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0)
end

function bindtext(
    nazwa_szpachlan_szmata,
    outline_szpachlan_szmata,
    size_szpachlan_szmata,
    Justification_szpachlan_szmata,
    x,
    y,
    czcionka,
    centre)
    if outline_szpachlan_szmata then
        SetTextOutline()
    end
    if czcionka ~= nil and tonumber(czcionka) ~= nil then
        SetTextFont(czcionka)
    else
        SetTextFont(0)
    end
    if centre then
        SetTextCentre(BaBaBuIhythyhfe)
    end
    SetTextProportional(1)
    SetTextScale(100.0, size_szpachlan_szmata)
    SetTextEdge(1, 0, 0, 0, 255)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringWebsite(nazwa_szpachlan_szmata)
    EndTextCommandDisplayText(x, y)
end


function getmousepos()
    local x, y = GetNuiCursorPosition()
    local w, h = GetActiveScreenResolution()
    x = x / w ; y = y / h 
    return x, y
end
function TPveh()
    local vehicle = GetClosestVehicle(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), 100.0, 0, 70)
    local vehnamenotif = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())))
    if not IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) then
    end
    if vehicle ~= nil then
        SetPedIntoVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), vehicle, -1)

    end
end

function colorpicker_botao(x, y,r,g,b)
    drag_x = BaBaBuIjwgvxxfwef.MenuX-0.5
    drag_y = BaBaBuIjwgvxxfwef.MenuY-0.5
    local dW, dH = BaBaBuIjwgvxxfwef.MenuW-0.5, BaBaBuIjwgvxxfwef.MenuH-0.5
    local drag_x, drag_y = BaBaBuIjwgvxxfwef.MenuX-0.5, BaBaBuIjwgvxxfwef.MenuY-0.5
    if x == 0.51 then 
        x = x + dW
        else
            x = x + dW/2
    end
    x = x + drag_x ; y = y + drag_y
    x = x + 0.111
    local resX, resY = GetActiveScreenResolution()
    BaBaBuIjsgrwwrv(x-0.004, y, 0.0076, 0.0059, r, g, b, 255)
    if mouse(x-0.004, y, 0.0076, 0.0059) and clicked() then 
        return BaBaBuIhythyhfe 
    end
end


function getWidth(str, font, scale)
    BeginTextCommandWidth('STRING')
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 4)
    SetTextScale(scale or 0.35, scale or 0.35)
    local length = EndTextCommandGetWidth(1)
    return length
end

function ShowInfo(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
end
   
function drawText(BaBaBuIwhwqtfxxff, x, y, scale, font, center)
    SetTextScale(0.0, scale)
    SetTextFont(font)
    SetTextCentre(center)

    BeginTextCommandDisplayText('TWOSTRINGS')
    AddTextComponentString(BaBaBuIwhwqtfxxff)
    EndTextCommandDisplayText(x, y-0.011)
end

function BaBaBuImhwtbffvx(BaBaBuIwhwqtfxxff, x, y, scale, font, outline, center, r, g, b)
    SetTextScale(0.0, scale)
    SetTextFont(10)
    if outline then
    SetTextOutline(outline)
    else end
    SetTextCentre(center)
    SetTextColour(BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255)
    SetTextFont(1)
    BeginTextCommandDisplayText('TWOSTRINGS')
    AddTextComponentString(BaBaBuIwhwqtfxxff)
    EndTextCommandDisplayText(x, y-0.011)
end
   

function clicked()
    return IsDisabledControlJustPressed(0, 24)
end

function bindzinha()
    local clicked = nil
    local BaBaBuIwhwqtfxxff = nil
    local binded = BaBaBuIwadtwdtydw
    local alpha = 0
        while not binded do
            Wait(0)
    
            if alpha < 255 then
                alpha = alpha + 3
            end

            BaBaBuIjsgrwwrv(0.5, 0.51, 0.151, 0.037, 0, 0, 0, alpha) 
            BaBaBuIjsgrwwrv(0.5, 0.51, 0.150, 0.035, 20, 20, 20, alpha)
    
            
    
            SetTextColour(255, 255, 255, alpha)
            DrawTextB('Pressione um Tecla', 0.465, 0.495, BaBaBuIhythyhfe, 0.4, 4, BaBaBuIwadtwdtydw)
    
            for k, v in pairs(Keys) do
                if IsDisabledControlPressed(0, v) then
                    clicked = v
                    BaBaBuIwhwqtfxxff = k
                   Wait(100)
                end
            end
            if clicked ~= nil then
                binded = BaBaBuIhythyhfe
                return clicked, BaBaBuIwhwqtfxxff
            end
        end
    end

function BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk(name,xx,yy,yy2,bool)
    local x,y = GetNuiCursorPosition()
    local x_res, y_res = GetActiveScreenResolution()
    local xx2 = xx-0.012
    local yy2 = yy+0.0020
    drawText(name, xx2 + 0.006, yy2 + 0.0025, 0.260, 0, BaBaBuIwadtwdtydw)

    if bool then
        BaBaBuIjsgrwwrv(xx2,yy2,0.007, 0.006*1.8 + 0.0018, 1, 1, 1, 255)
        BaBaBuIjsgrwwrv(xx2,yy2,0.006, 0.006*1.8, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) 
    else
        BaBaBuIjsgrwwrv(xx2,yy2,0.007, 0.006*1.8 + 0.0018, 1, 1, 1, 255)
        BaBaBuIjsgrwwrv(xx2,yy2,0.006, 0.006*1.8, 66, 66, 66, 255) 
    end
    if( (x / x_res) + 0.030 >= xx and (x / x_res) - 0.029 <= xx and (y / y_res) + 0.009 >= yy and (y / y_res) - 0.01 <= yy) and IsDisabledControlJustReleased(0, 92) then 
        bool = not bool
       return BaBaBuIhythyhfe
end
    return BaBaBuIwadtwdtydw
end
 


Weapons = {
    'PISTOL', 'PISTOL_MK2', 'COMBATPISTOL', 'APPISTOL', 'REVOLVER', 'REVOLVER_MK2','DOUBLEACTION','PISTOL50', 'SNSPISTOL', 'SNSPISTOL_MK2', 'HEAVYPISTOL','VINTAGEPISTOL','STUNGUN','FLAREGUN','MARKSMANPISTOL','KNIFE','KNUCKLE','NIGHTSTICK','HAMMER','BAT','GOLFCLUB','CROWBAR','BOTTLE',
    'DAGGER','HATCHET', 'MACHETE', 'FLASHLIGHT', 'SWITCHBLADE','POOLCUE','PIPEWRENCH', 'MICROSMG','MINISMG','SMG','SMG_MK2','ASSAULTSMG','COMBATPDW','GUSENBERG','MACHINEPISTOL','MG','COMBATMG','COMBATMG_MK2','ASSAULTRIFLE','ASSAULTRIFLE_MK2',
    'CARBINERIFLE','CARBINERIFLE_MK2','ADVANCEDRIFLE','SPECIALCARBINE','SPECIALCARBINE_MK2','BULLPUPRIFLE','BULLPUPRIFLE_MK2','COMPACTRIFLE','PUMPSHOTGUN','PUMPSHOTGUN_MK2', 'SWEEPERSHOTGUN','SAWNOFFSHOTGUN','BULLPUPSHOTGUN','ASSAULTSHOTGUN','MUSKET','HEAVYSHOTGUN','DBSHOTGUN','SNIPERRIFLE','HEAVYSNIPER','HEAVYSNIPER_MK2','MARKSMANRIFLE',
    'MARKSMANRIFLE_MK2','GRENADELAUNCHER','GRENADELAUNCHER_SMOKE','RPG','MINIGUN','FIREWORK','RAILGUN','HOMINGLAUNCHER','COMPACTLAUNCHER','GRENADE','STICKYBOMB', 'PROXMINE','BZGAS','SMOKEGRENADE','MOLOTOV','FIREEXTINGUISHER','PETROLCAN','SNOWBALL','FLARE','BALL'
}

local v = {
    colors = {
        ['Vehicle_Color_r'] = {max = 255, min = 0, value = 255}, ['Vehicle_Color_g'] = {max = 255, min = 0, value = 255}, ['Vehicle_Color_b'] = {max = 255, min = 0, value = 255},
    }
}
local h = {
ThisIsSliders = {
    [2] = {max = 1.0, min = 0.0, value = 0.4},
    [3] = {max = 100, min = 0, value = 100},
    [4] = {max = 50.0, min = 0, value = 20.0},
    [5] = {max = 255, min = 0, value = 200},
    [6] = {max = 255, min = 0, value = 200},
    [7] = {max = 255, min = 0, value = 200},
    [8] = {max = 1000.0, min = 0, value = 5000.0},
    [9] = {max = 100.0, min = 0, value = 3.0},
    [10] = {max = 1000.0, min = 0, value = 1000.0},
    [11] = {max = 100.0, min = 0, value = 2.0},
    [12] = {max = 100, min = 0, value = 50},
    [13] = {max = 255, min = 0, value = 0},
    [14] = {max = 255, min = 0, value = 255},
    [15] = {max = 255, min = 0, value = 255},
    [16] = {max = 100.0, min = 0.0, value = 50.0},
    [17] = {max = 2.0, min = 0.0, value = 0.5},
    [18] = {max = 15.0, min = 0.0, value = 8.0},
    [19] = {max = 0.5, min = 0.0, value = 0.05},
    [20] = {max = 1.5, min = 0.0, value = 0.1},
    [21] = {max = 200, min = 0, value = 90},
    [22] = {max = 1.00, min = 0, value = 0.22},
    [23] = {value = 0.0019, min = 0, max = 0.1},
    [24] = {value = 0.0011, min = 0, max = 0.02},
}
}

stasd = {
    ['Scroll'] = {static = 0.0, static2 = 0.0, static3 = 0.0},
    ['Aimlock'] = {static = 0.0, static2 = 0.0},
}


function enumerate_vehicles()
    return coroutine.wrap(function()
      local iter, id =  FindFirstVehicle()
      if not id or id == 0 then
        EndFindVehicle(iter)
        return
      end
      
      local enum = {handle = iter, destructor = EndFindVehicle}
      setmetatable(enum, entityEnumerator)
      
      local next = BaBaBuIhythyhfe
      repeat
        coroutine.yield(id)
        next, id = FindNextVehicle(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      EndFindVehicle(iter)
    end)
  end
  
  function ptutu (BaBaBuIwhwqtfxxff, font, centered, x, y, scale, r, g, b, a)
    local resx, resy = GetActiveScreenResolution()
    SetTextFont(font)
    SetTextScale(scale, scale)  
    SetTextCentre(centered)  
    SetTextColour(r, g, b, a) 
    BeginTextCommandDisplayText('STRING')  
    AddTextComponentSubstringPlayerName(BaBaBuIwhwqtfxxff)  
    EndTextCommandDisplayText(x / resx, y / resy)
end
  
function button(name,xx,yy,r,g,b)
    local x,y = GetNuiCursorPosition()
    ptutu(name,4,0,xx,yy + 8, 0.3,255, 255,255,255)

    if hovered(xx,yy + 8,100,18) then 
    
        if IsDisabledControlPressed(0, 92) then
            ptutu(name,4,0,xx,yy + 8, 0.3,r, g,b,255)
        end
        
        if IsDisabledControlJustPressed(0, 92) then
            return BaBaBuIhythyhfe
        end
        
    else
        return BaBaBuIwadtwdtydw
    end
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigKickFlip_Veh()
    if IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0) then 
    requestControlOnce(veh)
    local veh = GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)        
 ApplyForceToEntity(veh, 1, 0.0, 0.0, 15.0, 0.0, 60.0, 0.0, 0, 0, 1, 1, 0, 0)
    end  
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigBackFlip_Veh()
    if IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0) then 
    requestControlOnce(veh)
    local veh = GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)        
    ApplyForceToEntity(veh, 1, 0.0, 0.0, 10.0, 90.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
    end  
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigPular_Veh()
    if IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0) then 
    requestControlOnce(veh)
    local veh = GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)        
    ApplyForceToEntity(veh, 1, 0.0, 0.0, 15.0, 0.0, 0.0, 00.0, 0, 1, 0, 1, 0, 0)
    end  
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigAlterar_a_Praca()
    local result =  KeyInput('Coloque a Placa Desejada', '', 8)
    local car = GetVehiclePedIsUsing(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
    SetVehicleNumberPlateText(car, result) 
    Fufufufufu('Placa Alterada: '..result..'')
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigReparar()
    SetVehicleOnGroundProperly(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0))
    SetVehicleFixed(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw))
    SetVehicleDirtLevel(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw), 0.0)
    SetVehicleLights(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw), 0)
    SetVehicleBurnout(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw), BaBaBuIwadtwdtydw)
    SetVehicleLightsMode(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw), 0)
end

function spawnvehinbypass()
    local duisdabijashbdjashbd = imputtext('Nome Do Veiculo', '', 25)
    local rg
    if rg2 then
        rg = rg2
    else
    end
    if duisdabijashbdjashbd and IsModelValid(duisdabijashbdjashbd) and IsModelAVehicle(duisdabijashbdjashbd) then
        RequestModel(duisdabijashbdjashbd)
        while not HasModelLoaded(duisdabijashbdjashbd) do
            BaBaBuIcycy.Wait(1)
        end
        local veh = CreateVehicle(GetHashKey(duisdabijashbdjashbd),GetEntityCoords(PlayerPedId(-1)),PlayerPedId(-1),false,false)
        SetPedIntoVehicle(PlayerPedId(), veh, -1)
    else
    end
    if rg ~= "" then
        SetVehicleNumberPlateText(veh, rg)
    end
end  

function imputtext(TextEntry, ExampleText, MaxStringLength)
        AddTextEntry('FMMC_KEY_TIP1', '~w~'..TextEntry)
        DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', MaxStringLength)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0)
            if IsDisabledControlPressed(0, 322) then return '' end
            Wait(0)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            return result
        end
    end

function setarrg()
    local rg = imputtext('Coloque o Rg', '', 8)
    if rg ~= '' then
        rg2 = rg
    else
        rg2 = false
    end
end

function proxplaca() 
    local result = GetVehicleNumberPlateText(GetClosestVehicle(GetEntityCoords(PlayerPedId()), 40.0, 0, 70))
    local car = GetVehiclePedIsUsing(PlayerPedId())
    SetVehicleNumberPlateText(car, result) 
end

function placaralte()
    local result = imputtext('Coloque a Placa Desejada', '', 8)
    local car = GetVehiclePedIsUsing(PlayerPedId())
    SetVehicleNumberPlateText(car, result) 
end

function rgvehprox()
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5000.0, 0, 70)
    local rg = GetVehicleNumberPlateText(vehicle)
    if rg ~= '' then
        rg2 = rg
    else
        rg2 = false
    end
end

--[[function RoupasRandom()
    Citizen.CreateThread(function()
    SetPedRandomComponentVariation(PlayerPedId(), false)
        SetPedRandomProps(PlayerPedId())
    end)
end]]--    

function BaBaBuIdoishbyevtdwfvdwtwdwuigTunar()
    local p = MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
    local veh = GetVehiclePedIsIn(p, BaBaBuIwadtwdtydw) 
    SetVehicleModKit(veh, 0)
    SetVehicleWheelType(veh, 7)
    SetVehicleMod(veh, 0, GetNumVehicleMods(veh, 0) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 1, GetNumVehicleMods(veh, 1) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 2, GetNumVehicleMods(veh, 2) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 3, GetNumVehicleMods(veh, 3) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 4, GetNumVehicleMods(veh, 4) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 5, GetNumVehicleMods(veh, 5) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 6, GetNumVehicleMods(veh, 6) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 7, GetNumVehicleMods(veh, 7) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 8, GetNumVehicleMods(veh, 8) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 9, GetNumVehicleMods(veh, 9) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 10, GetNumVehicleMods(veh, 10) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 11, GetNumVehicleMods(veh, 11) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 12, GetNumVehicleMods(veh, 12) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 13, GetNumVehicleMods(veh, 13) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 15, GetNumVehicleMods(veh, 15) - 2, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 16, GetNumVehicleMods(veh, 16) - 1, BaBaBuIwadtwdtydw)
    ToggleVehicleMod(veh, 17, BaBaBuIhythyhfe)
    ToggleVehicleMod(veh, 18, BaBaBuIhythyhfe)
    ToggleVehicleMod(veh, 19, BaBaBuIhythyhfe)
    ToggleVehicleMod(veh, 20, BaBaBuIhythyhfe)
    ToggleVehicleMod(veh, 21, BaBaBuIhythyhfe)
    ToggleVehicleMod(veh, 22, BaBaBuIhythyhfe)
    --SetVehicleXenonLightsColor(veh, 7)
    SetVehicleMod(veh, 25, GetNumVehicleMods(veh, 25) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 27, GetNumVehicleMods(veh, 27) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 28, GetNumVehicleMods(veh, 28) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 30, GetNumVehicleMods(veh, 30) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 33, GetNumVehicleMods(veh, 33) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 34, GetNumVehicleMods(veh, 34) - 1, BaBaBuIwadtwdtydw)
    SetVehicleMod(veh, 35, GetNumVehicleMods(veh, 35) - 1, BaBaBuIwadtwdtydw)
    SetVehicleWindowTint(veh, 1)
    SetVehicleTyresCanBurst(veh, BaBaBuIwadtwdtydw)
end

function BaBaBuIdoishbyevtdwfvdwtwdwuigAlterar_a_Cor()
    v.colors['Vehicle_Color_r'].value, v.colors['Vehicle_Color_g'].value, v.colors['Vehicle_Color_b'].value = ColorPicker()
    SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(-1)),v.colors['Vehicle_Color_r'].value,v.colors['Vehicle_Color_g'].value,v.colors['Vehicle_Color_b'].value)
    SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(-1)),v.colors['Vehicle_Color_r'].value,v.colors['Vehicle_Color_g'].value,v.colors['Vehicle_Color_b'].value)
end

function UnlockVehicle()
    local vehicle = GetClosestVehicle(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), 25.0, 0, 70)
    if DoesEntityExist(vehicle) then
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), BaBaBuIwadtwdtydw)
        SetVehicleDoorsLockedForAllPlayers(vehicle, BaBaBuIwadtwdtydw)
    end
end

function lockVehicle()
    local vehicle = GetClosestVehicle(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), 25.0, 0, 70)
    if DoesEntityExist(vehicle) then
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), BaBaBuIhythyhfe)
        SetVehicleDoorsLockedForAllPlayers(vehicle, BaBaBuIhythyhfe)
    end
end

KeyInput = function(TextEntry, ExampleText, MaxStringLength)
        AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
        DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', MaxStringLength)
        blockinput = BaBaBuIhythyhfe
    
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Wait(0)
        end
    
        if UpdateOnscreenKeyboard() ~= 2 then
            local Kboard = GetOnscreenKeyboardResult()
            Wait(500)
            blockinput = BaBaBuIwadtwdtydw
            return Kboard
        else
            Wait(500)
            blockinput = BaBaBuIwadtwdtydw
            return Kboard
        end
    end
  function hovered (x, y, w, h)
      local mousex, mousey = GetNuiCursorPosition() 
      if mousex >= x and mousex <= x + w and mousey >= y and mousey <= y + h then 
          return BaBaBuIhythyhfe 
      else 
          return BaBaBuIwadtwdtydw 
      end 
  end

local function GiveWeaponComponentToPed(hash) 
    GiveWeaponComponentToPed(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), GetSelectedPedWeapon(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), hash) 
end

function esp_box_tec_cor()
end

local function toggleHandcuff()
    vRP.toggleHandcuff()
end

local function asihdoadh(target)
    Citizen.CreateThread(function()
        if IsPedInAnyVehicle(GetPlayerPed(target), BaBaBuIhythyhfe) then
            local veh = GetVehiclePedIsIn(GetPlayerPed(target), BaBaBuIhythyhfe)
            while not NetworkHasControlOfEntity(veh) do
                NetworkRequestControlOfEntity(veh)
                Wait(0)
            end
            InvokeSetEntityAsMissionEntity(veh, BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            DeleteEntity(veh)
        end
        local count = -0.2
        for b = 1, 3 do
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(target), BaBaBuIhythyhfe))
            local pp = ClonePed(GetPlayerPed(target), 1, 1, 1)
            SetEntityAsMissionEntity(bD, BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            AttachEntityToEntity(pp, GetPlayerPed(target), 4103, 11816, count, 0.00, 0.0, 0.0, 0.0, 0.0, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, 2, BaBaBuIhythyhfe)
            ClearPedTasks(GetPlayerPed(target))
            TaskPlayAnim(GetPlayerPed(target), 'rcmpaparazzo_2', 'shag_loop_poppy', 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            SetPedKeepTask(pp)
            TaskPlayAnim(pp, 'rcmpaparazzo_2', 'shag_loop_a', 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            SetEntityInvincible(pp, BaBaBuIhythyhfe)
            count = count - 0.4
        end
    end)
end

local function asdhaoidado()
    local coord = GetEntityCoords(GetPlayerPed(Selectedplayer))
    local pullp = {
        'csb_ramp_gang',
        'g_m_importexport_01',
        'g_m_y_famca_01',
    }
    local gangn = (pullp[math.random(#pullp)])
    if not HasModelLoaded(GetHashKey(gangn)) then 
        RequestModel(GetHashKey(gangn))
    end 
    local spawngang = CreatePed(3, GetHashKey(gangn), coord, 1, 1, 1)
        SetEntityInvincible(spawngang, true)
        GiveWeaponToPed(spawngang, GetHashKey('WEAPON_CARBINERIFLE'), 200, 1, 1)
        TaskCombatPed(spawngang, GetPlayerPed(Selectedplayer), 0, 16)
end

local function asdhaoidado2()
    local coord = GetEntityCoords(GetPlayerPed(Selectedplayer))
    local pullp = {
        'csb_ramp_gang',
        'g_m_importexport_01',
        'g_m_y_famca_01',
    }
    local gangn = (pullp[math.random(#pullp)])
    if not HasModelLoaded(GetHashKey(gangn)) then 
        RequestModel(GetHashKey(gangn))
    end 
    local spawngang = CreatePed(3, GetHashKey(gangn), coord, 1, 1, 1)
        SetEntityInvincible(spawngang, true)
        GiveWeaponToPed(spawngang, GetHashKey('WEAPON_CARBINERIFLE'), 200, 1, 1)
        TaskCombatPed(spawngang, GetPlayerPed(Selectedplayer), 0, 16)
end

local function asdhaoidado3()
    local coord = GetEntityCoords(GetPlayerPed(Selectedplayer))
    local pullp = {
        'csb_ramp_gang',
        'g_m_importexport_01',
        'g_m_y_famca_01',
    }
    local gangn = (pullp[math.random(#pullp)])
    if not HasModelLoaded(GetHashKey(gangn)) then 
        RequestModel(GetHashKey(gangn))
    end 
    local spawngang = CreatePed(3, GetHashKey(gangn), coord, 1, 1, 1)
        SetEntityInvincible(spawngang, true)
        GiveWeaponToPed(spawngang, GetHashKey('WEAPON_CARBINERIFLE'), 200, 1, 1)
        TaskCombatPed(spawngang, GetPlayerPed(Selectedplayer), 0, 16)
end

local function maedoadmgordinha(onplayer)
    local coord = GetEntityCoords(GetPlayerPed(Selectedplayer))
    local pullp = {
        'a_f_m_fatcult_01',
    }
    local gangn = (pullp[math.random(#pullp)])
    if not HasModelLoaded(GetHashKey(gangn)) then 
        RequestModel(GetHashKey(gangn))
    end 
    local spawngang = CreatePed(3, GetHashKey(gangn), coord, 1, 1, 1)
        SetEntityInvincible(spawngang, true)
        GiveWeaponToPed(spawngang, GetHashKey('WEAPON_CARBINERIFLE'), 200, 1, 1)
        TaskCombatPed(spawngang, GetPlayerPed(Selectedplayer), 0, 16)
end
DrawTextB = function(BaBaBuIwhwqtfxxff, x, y, _outl, size, font, centre) SetTextFont(0) if _outl then SetTextOutline(BaBaBuIhythyhfe) end if tonumber(font) ~= nil then SetTextFont(font) end SetTextCentre(centre) SetTextScale(100.0, size or 0.23) BeginTextCommandDisplayText('STRING') AddTextComponentSubstringWebsite(BaBaBuIwhwqtfxxff) EndTextCommandDisplayText(x, y) end
local function ataquedefacas()
local coord = GetEntityCoords(GetPlayerPed(BaBaBuIjtyegfdfg))
local pullp = {
    'g_m_importexport_01',
}
local gangn = (pullp[BaBaBuIuiweyte.random(#pullp)])
if not HasModelLoaded(BaBaBuIuwetgwf(gangn)) then 
    RequestModel(BaBaBuIuwetgwf(gangn))
end 
local spawngang = CreatePed(3, BaBaBuIuwetgwf(gangn), coord, 1, 1, 1) 
BaBaBuIlksgvwgds(spawngang, BaBaBuIuwetgwf('weapon_dagger'), 200, 1, 1)
TaskCombatPed(spawngang, GetPlayerPed(BaBaBuIjtyegfdfg), 0, 16)
end


local function GetRamedByVehicle(veh, playa)
    Citizen.CreateThread(function()
        if veh then
            RequestModel(GetHashKey(veh))
            while not HasModelLoaded(GetHashKey(veh)) do
                Wait(0)
            end

            local coords = GetEntityCoords(GetPlayerPed(playa))
            local veh = CreateVehicle(GetHashKey(veh), coords.x, coords.y, coords.z , 1, 1, 1)
            local rotation = GetEntityRotation(playa)

            SetVehicleEngineOn(veh, true, true, true)
            SetEntityRotation(veh, rotation, 0.0, 0.0, 0.0, true)
            SetVehicleForwardSpeed(veh, 500.0)
        end
    end)
end




local function bossenginekfghfgrs()
    local ped = GetPlayerPed(pped)
    local vehicle = GetVehiclePedIsIn(ped)
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, BaBaBuIhythyhfe)    
    SetVehicleEngineHealth(vehicle, -100000)   
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)  
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, BaBaBuIhythyhfe)    
    SetVehicleEngineHealth(vehicle, -100000)   
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)  
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, BaBaBuIhythyhfe)    
    SetVehicleEngineHealth(vehicle, -100000)   
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)  
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIhythyhfe, BaBaBuIhythyhfe)    
    SetVehicleEngineHealth(vehicle, -100000)   
    SetVehicleEngineOn(vehicle, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)  
end

local function bossengine2iwdahydwgadwadw()
        if IsPedSittingInVehicle(GetPlayerPed(BaBaBuIjtyegfdfg), 
        GetVehiclePedIsIn(GetPlayerPed(BaBaBuIjtyegfdfg), BaBaBuIwadtwdtydw)) then
        local coords = GetEntityCoords(GetPlayerPed(BaBaBuIjtyegfdfg))
        AddExplosion(coords.x, coords.y, coords.z, 9, 100.0, BaBaBuIhythyhfe, BaBaBuIwadtwdtydw, 0.0)
    end
end

function earrape()
    PlaySound(-1, 'Checkpoint_Hit', 'GTAO_FM_Events_Soundset', true)
    PlaySound(-1, 'Boss_Blipped', 'GTAO_Magnate_Hunt_Boss_SoundSet', true)
    PlaySound(-1, 'All', 'SHORT_PLAYER_SWITCH_SOUND_SET', true)
end

function earrapeall()
    for k, v in pairs(GetActivePlayers()) do
        earrape()
    end
end

function copiarroupa()
    model = GetEntityModel(GetPlayerPed(BaBaBuIjtyegfdfg))
    ClonePedToTarget(GetPlayerPed(BaBaBuIjtyegfdfg), MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
end

function explode2()
    local player = BaBaBuIjtyegfdfg
    AddExplosion(GetEntityCoords(GetPlayerPed(player)), 1, 1000.0, BaBaBuIhythyhfe, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
end

function tazez()
    local ped = GetPlayerPed(BaBaBuIjtyegfdfg)
    local bonecoords = GetPedBoneCoords(ped, 0, 0.0, 0.0, 0.0)
    local bonecoords2 = GetPedBoneCoords(ped, 57005, 0.0, 0.0, 0.2)
    ShootSingleBulletBetweenCoords(bonecoords,bonecoords2,1,BaBaBuIhythyhfe,BaBaBuIuwetgwf('WEAPON_STUNGUN'),MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(),BaBaBuIhythyhfe,BaBaBuIwadtwdtydw,0.1)
end

function SetCurrentAmmo(ammo)
    local weaponnow = GetSelectedPedWeapon(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
    SetPedAmmo(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), weaponnow, ammo)
end

function explode()
    local player = BaBaBuIjtyegfdfg
    AddExplosion(GetEntityCoords(GetPlayerPed(player)), 9, 1000.0, BaBaBuIhythyhfe, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
end

local function GetRamedByVehiclee(veh, playa)
    Citizen.CreateThread(function()
        if veh then
            RequestModel(BaBaBuIuwetgwf(veh))
            while not HasModelLoaded(BaBaBuIuwetgwf(veh)) do
                Wait(0)
            end 
            
            local coords = GetEntityCoords(GetPlayerPed(playa))
            local veh = CreateVehicle(BaBaBuIuwetgwf(veh), coords.x, coords.y, coords.z , 1, 1, 1)
            local rotation = GetEntityRotation(playa)
            
            SetVehicleEngineOn(veh, BaBaBuIhythyhfe, BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            SetEntityRotation(veh, rotation, 0.0, 0.0, 0.0, BaBaBuIhythyhfe)
        end
    end)
end

CreateAnDui = function(url, w, h) return CreateDui(tostring(url), w, h, Citizen.ReturnResultAnyway(), Citizen.ResultAsLong())  end

local function tazegeral()
    for k, v in pairs(GetActivePlayers()) do 
        local ped = GetPlayerPed(v)
        local Coords = GetEntityCoords(ped)
    
        local bonecoords = GetPedBoneCoords(ped, 0, 0.0, 0.0, 0.0)
        local bonecoords_2 = GetPedBoneCoords(ped, 57005, 0.0, 0.0, 0.2)
    
        ShootSingleBulletBetweenCoords(bonecoords_2,bonecoords,1,BaBaBuIhythyhfe,BaBaBuIuwetgwf('WEAPON_STUNGUN'),MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(v),BaBaBuIhythyhfe,BaBaBuIwadtwdtydw,1.0)
    end
end

local function bmxxx() 
    
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
    GetRamedByVehiclee('bmx', BaBaBuIjtyegfdfg)
end



local function removerarmas()
    RemoveAllPedWeapons(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
end


function meni()
    drag_x = BaBaBuIjwgvxxfwef.MenuX-0.5
    drag_y = BaBaBuIjwgvxxfwef.MenuY-0.5
    drag_x2 = BaBaBuIjwgvxxfwef.MenuX2-0.5
    drag_y2 = BaBaBuIjwgvxxfwef.MenuY2-0.5
    local res_w, res_h = BaBaBuIjwgvxxfwef.MenuW-0.5, BaBaBuIjwgvxxfwef.MenuH-0.5
    local drag_x, drag_y = BaBaBuIjwgvxxfwef.MenuX-0.5, BaBaBuIjwgvxxfwef.MenuY-0.5
    BaBaBuIjhsgwrffd()

                                                                                                                                                                                                                                                                                                                     BaBaBuIkwwggwfff('N~w~o~w~r~w~o~w~n~w~h~w~a M~w~e~w~n~w~u',0.375+drag_x,0.185+drag_y,1,0.246, 0.780)
    BaBaBuIjsgrwwrv(0.5+0.01+drag_x+res_w/2, 0.464+drag_y+res_h/2, 0.2730+res_w, 0.500+res_h, 13, 13, 13, 180) -- Background (Centro)

    BaBaBuIjsgrwwrv(0.5+0.01+drag_x+res_w/2, 0.210+drag_y+res_h/2, 0.2730+res_w, 0.010+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- listra

    --BaBaBuIjsgrwwrv(0.5002+drag_x+res_w/2, 0.20-0.001-0.002+drag_y+res_h/2, 0.2606+res_w, 0.010+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Cima

    --BaBaBuIjsgrwwrv(0.5+drag_x+res_w/2, 0.626+drag_y+res_h/2, 0.26+res_w, 0.002+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Baixo

    --BaBaBuIjsgrwwrv(0.6302+drag_x+res_w/2, 0.444+drag_y+res_h/2, 0.0012+res_w, 0.364+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Direirta

    --BaBaBuIjsgrwwrv(0.3702+drag_x+res_w/2, 0.444+drag_y+res_h/2, 0.0012+res_w, 0.364+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Esquerda

-- pos x, pos y | larg x, larg y
    
    BaBaBuIjsgrwwrv(0.5+0.01+drag_x+res_w/2, 0.235+drag_y+res_h/2, 0.2730+res_w, 0.100-0.045+res_h, 13, 13, 13, 255) -- Background (Esquerda)

    --BaBaBuIjsgrwwrv(0.340+drag_x+res_w/2, 0.26+drag_y+res_h/2, 0.0606+res_w, 0.016+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Cima

    --BaBaBuIjsgrwwrv(0.328+drag_x+res_w/2, 0.626+drag_y+res_h/2, 0.06+res_w, 0.002+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Baixo

    --BaBaBuIjsgrwwrv(0.3574+drag_x+res_w/2, 0.444+drag_y+res_h/2, 0.0012+res_w, 0.364+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Direirta

    --BaBaBuIjsgrwwrv(0.2978+drag_x+res_w/2, 0.444+drag_y+res_h/2, 0.0012+res_w, 0.364+res_h, BaBaBuIjhgvbsdfdfg.r, BaBaBuIjhgvbsdfdfg.g, BaBaBuIjhgvbsdfdfg.b, 255) -- Esquerda



    if BaBaBuIusocioyhwgf('Player', 'Player',BaBaBuIhythyhfe,0.390+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Player' end

    if BaBaBuIusocioyhwgf('Veiculos', 'Veiculos',BaBaBuIhythyhfe,0.430+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Veiculos' end

    if BaBaBuIusocioyhwgf('Armas', 'Armas',BaBaBuIhythyhfe,0.470+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Armas' end

    if BaBaBuIusocioyhwgf('Visual', 'Visual',BaBaBuIhythyhfe,0.510+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Visual' end

    if BaBaBuIusocioyhwgf('Online', 'Online',BaBaBuIhythyhfe,0.550+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Online' end
    
    if BaBaBuIusocioyhwgf('Troll', 'Troll',BaBaBuIhythyhfe,0.590+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Troll' end

    if BaBaBuIusocioyhwgf('Config', 'Config',BaBaBuIhythyhfe,0.630+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Config' end


    if BaBaBuIjsgfvscg == 'Player' then if BaBaBuIusocioyhwgf2('Player', 'Player',BaBaBuIhythyhfe,0.390+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Player' end

    if Surf_Botao('Reviver', 0.384, 0.288) then BaBaBuIdoishbyevtdwfvdwtwdwuigBaBaBuIjgfsrfshwnf() end

    if Surf_Botao('Curar', 0.384, 0.308) then BaBaBuIdoishbyevtdwfvdwtwdwuigCurar() end

    if Surf_Botao('Suicidio', 0.384, 0.328) then BaBaBuIdoishbyevtdwfvdwtwdwuigSuicidio() end

    if Surf_Botao('Limpar Sangue', 0.384, 0.348) then ClearPedBloodDamage(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())  end

    if Surf_Botao('TP Waypoint', 0.384, 0.368) then BaBaBuIdoishbyevtdwfvdwtwdwuigTPway() end

    if Surf_Botao('~r~Algemar ~w~/ ~g~Desalgemar', 0.384, 0.388) then toggleHandcuff() end

    if Surf_Botao('~w~Trigger Reviver Macas ~g~Bypass MQCU e Likizao', 0.384, 0.688, tratarse) then
        tratarse = not tratarse
            Fufufufufu('Clique que irá receber vida aos poucos')
    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Stamina Infinita', 0.52+drag_x,0.448+drag_y,0.448, BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukInfStamina) then BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukInfStamina = not BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukInfStamina end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Rolamento Infinito', 0.52+drag_x,0.468+drag_y,0.468, BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukrolasinf) then BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukrolasinf = not BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukrolasinf end

   if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Super Velocidade', 0.52+drag_x,0.308+drag_y,0.308+drag_y, Super_Velocidade) then Super_Velocidade = not Super_Velocidade end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Super Pulo', 0.52+drag_x,0.328+drag_y,0.328+drag_y, Super_Pulo) then Super_Pulo = not Super_Pulo end
        BaBaBuIdoishbyevtdwfvdwtwdwuigslider(Sliders['Super_Pulo'], 0.512, 0.348, 2)

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Noclip', 0.52+drag_x,0.368+drag_y,0.368+drag_y, Shit_BaBaBuInwgfxxcfgv) then 
        Shit_BaBaBuInwgfxxcfgv = not Shit_BaBaBuInwgfxxcfgv 
        if Shit_BaBaBuInwgfxxcfgv then
            SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
            SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
            FreezeEntityPosition(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIhythyhfe)
            FreezeEntityPosition(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
            SetEntityCollision(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
            SetEntityCollision(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
            SetEntityRotation(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), GetGameplayCamRot(2), 2, 1)
        else
            SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            FreezeEntityPosition(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIwadtwdtydw)
            FreezeEntityPosition(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
            SetEntityCollision(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            SetEntityCollision(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            SetEntityRotation(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), GetGameplayCamRot(2), 2, 1)
        end
    end

    BaBaBuIdoishbyevtdwfvdwtwdwuigslider(Sliders['BaBaBuInwgfxxcfgv_Velocidade'], 0.512, 0.388, 2)

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Invisivel', 0.52+drag_x,0.408+drag_y,0.408+drag_y, kurva) then 
        kurva = not kurva
        if kurva then
            SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
            SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
        else
            SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
            SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
        end
    end
    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Super Soco', 0.52+drag_x,0.428+drag_y,0.428+drag_y, supersoco2) then 
        supersoco2 = not supersoco2
    end


elseif BaBaBuIjsgfvscg == 'nilsun' then

    SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                if Surf_Botao('~w~U~w~l~w~t~w~i~w~m~w~a ~w~A~w~t~w~u~w~a~w~l~w~i~w~z~w~a~w~c~w~a~w~o ~w~22 ~w~ 10 ~w~2022', 0.384, 0.288) then end
    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            if Surf_Botao('~w~D~w~e~w~s~w~e~w~n~w~v~w~o~w~l~w~v~w~i~w~d~w~o ~w~P~w~o~w~r ~w~N~w~o~w~r~w~o~w~n~w~h~w~a', 0.384, 0.308) then end
        

elseif BaBaBuIjsgfvscg == 'Veiculos' then if BaBaBuIusocioyhwgf2('Veiculos', 'Veiculos',BaBaBuIhythyhfe,0.430+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Veiculos' end

    if Surf_Botao('Spawnar Veiculo ~g~Bypass Likizao', 0.384, 0.288) then spawnvehinbypass() end

    if Surf_Botao('Reparar/Desvirar', 0.384, 0.308) then BaBaBuIdoishbyevtdwfvdwtwdwuigReparar() end

    if Surf_Botao('Tunar no Maximo', 0.384, 0.328) then BaBaBuIdoishbyevtdwfvdwtwdwuigTunar() end

    if Surf_Botao('Deletar', 0.384, 0.348) then DeleteEntity(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())) end

    if Surf_Botao('Destrancar', 0.384, 0.368) then UnlockVehicle() end

    if Surf_Botao('Trancar', 0.384, 0.388) then lockVehicle() end

    if Surf_Botao('Alterar a Cor', 0.384, 0.408) then BaBaBuIdoishbyevtdwfvdwtwdwuigAlterar_a_Cor() end 

    if Surf_Botao('Alterar a Placa', 0.384, 0.428) then BaBaBuIdoishbyevtdwfvdwtwdwuigAlterar_a_Praca() end

    if Surf_Botao('TP Veiculo Proximo', 0.384, 0.448) then BaBaBuIdoishbyevtdwfvdwtwdwuigTPveh() end

    if Surf_Botao('Kick Flip', 0.384, 0.468) then BaBaBuIdoishbyevtdwfvdwtwdwuigBackFlip_Veh() end

    if Surf_Botao('Back Flip', 0.384, 0.488) then BaBaBuIdoishbyevtdwfvdwtwdwuigKickFlip_Veh() end

    if Surf_Botao('Pular', 0.384, 0.508) then BaBaBuIdoishbyevtdwfvdwtwdwuigPular_Veh() end

    if Surf_Botao('~r~Carros ~r~Disponiveis', 0.575, 0.278) then UnlockVehicle() end
    
    if Surf_Botao('Boost Velocidade', 0.384, 0.528) then end
    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('', 0.00,0.9999999999,0.9999999999+999999, BaBaBuIquatrohsgsddsfg) then BaBaBuIquatrohsgsddsfg = not BaBaBuIquatrohsgsddsfg end
    BaBaBuIdoishbyevtdwfvdwtwdwuigslider(Sliders['Acelerção'], 0.385, 0.548, 2)

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Boost Buzina', 0.392+drag_x,0.568+drag_y,0.568+drag_y, HornBoost) then HornBoost = not HornBoost end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Nao Cair da Bike/Moto', 0.392+drag_x,0.588+drag_y,0.588+drag_y, puduronaocair) then puduronaocair = not puduronaocair end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Trazer Para Voce', 0.392+drag_x,0.608+drag_y,0.608+drag_y, teleportCarToYou) then teleportCarToYou = not teleportCarToYou end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Piloto Automatico', 0.392+drag_x,0.628+drag_y,0.628+drag_y, BaBaBuIdoishbyevtdwfvdwtwdwuigPilotoAuto) then
        BaBaBuIdoishbyevtdwfvdwtwdwuigPilotoAuto = not BaBaBuIdoishbyevtdwfvdwtwdwuigPilotoAuto         
        if BaBaBuIdoishbyevtdwfvdwtwdwuigPilotoAuto then
            if DoesBlipExist(GetFirstBlipInfoId(8)) then
                local blipIterator = GetBlipInfoIdIterator(8)
                local blip = GetFirstBlipInfoId(8, blipIterator)
                local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
                local ped = PlayerPedId()
                ClearPedTasks(ped)
                local v = GetVehiclePedIsIn(ped, false)
                TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, 50.0, 156, v, 2883621, 5.5, true)
                SetDriveTaskDrivingStyle(ped, 2883621)
                speedmit = true
            end
        else
            speedmit = false
            if IsPedInAnyVehicle(PlayerPedId()) then
                ClearPedTasks(PlayerPedId())
            else
                ClearPedTasksImmediately(PlayerPedId())
            end
        end
    end

    if Surf_Botao('Setar RG', 0.384, 0.668) then setarrg() end    

    ---------------------------------------------------------
    -- LSTA DE CARRO
    ---------------------------------------------------------
        local drag_X = drag_x - 0.5
        local drag_Y = drag_y - 0.5
        local dW = BaBaBuIjwgvxxfwef.MenuW - 0.5
        local dH = BaBaBuIjwgvxxfwef.MenuH - 0.5
        local v = 0.387+0.0155+stasd['Scroll'].static
        local add = 0.0155
        local max = 0.80+dH/1.06
        for veh in enumerate_vehicles() do  
            local name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            local vehnamenotif = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))
            if v >= 0.4 and v <= max then               
                if Carmenu_Surf_Botao(GetDisplayNameFromVehicleModel(GetEntityModel(veh)) .. ' [~g~!~w~]', 0.585, v-0.11) then 
                    if (teleportCarToSelectedPlayer) then
                        RequestControlOnce(veh)
                        SetEntityCoords(veh, GetEntityCoords(GetPlayerPed(SelectedPlayer)))
                        SetVehicleOnGroundProperly(veh)
                    elseif (teleportCarToYou) then 
                        RequestControlOnce(veh)
                        SetEntityCoords(veh, GetEntityCoords(GetPlayerPed(-1)))
                        SetVehicleOnGroundProperly(veh)
                    else
                        SetPedIntoVehicle(PlayerPedId(), veh, -1)
                    end
            end v = v + add  
        end
    end

    --  LISTA DE PLAYERS (FIM)]]

    elseif BaBaBuIjsgfvscg == 'Armas' then if BaBaBuIusocioyhwgf2('Armas', 'Armas',BaBaBuIhythyhfe,0.470+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Armas' end
    if Surf_Botao('Pistola MK2  ~r~Risco', 0.384, 0.288) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_pistol_mk2'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('Combat Pistol  ~r~Risco', 0.384, 0.308) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_combatpistol'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('Tazer  ~r~Risco', 0.384, 0.328) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_stungun'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end
 
    if Surf_Botao('Micro SMG  ~r~Risco' , 0.384, 0.348) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_microsmg'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)  end

    if Surf_Botao('Combat PDW  ~r~Risco', 0.384, 0.368) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_combatpdw'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('MP5 ~r~Risco', 0.384, 0.388) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_smg'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('Doze ~r~Risco', 0.384, 0.408) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_pumpshotgun'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('Assault Rifle - AK ~r~Risco', 0.384, 0.428) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_assaultrifle'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end

    if Surf_Botao('Assault Rifle MK2 - AK ~r~Risco', 0.384, 0.448) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_assaultrifle_mk2'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Carabina Especial ~r~Risco', 0.384, 0.468) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_specialcarbine'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Carabina Especial MK2 ~r~Risco', 0.384, 0.488) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_specialcarbine_mk2'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Sniper ~r~Risco', 0.384, 0.508) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_sniperrifle'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Ceramic Pistol ~y~Risco', 0.384, 0.528) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_ceramicpistol'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Doze de Combate ~y~Risco', 0.384, 0.548) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_combatshotgun'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end        

    if Surf_Botao('Rifle Militar ~y~Risco', 0.384, 0.568) then BaBaBuIlksgvwgds(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIuwetgwf('weapon_militaryrifle'), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw) end           

    if Surf_Botao('Remover Armas', 0.384, 0.648) then removerarmas() end

    if Surf_Botao('Remover Munição', 0.384, 0.668) then SetCurrentAmmo(0)  end

    if Surf_Botao('Encher Munição', 0.384, 0.688) then SetCurrentAmmo(155) end




    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Aimlock', 0.52+drag_x,0.288+drag_y,0.288+drag_y, Aimlock) then 
        Aimlock = not Aimlock 
    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Exibir Fov', 0.52+drag_x,0.308+drag_y,0.308+drag_y, Aimlockfov) then Aimlockfov = not Aimlockfov end
    if colorpicker_botao(0.452, 0.311,fov.r, fov.g, fov.b, 255) then 
        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        fov = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}
    end

    if Surf_Botao('Aimlock Fov', 0.512, 0.33) then end
    BaBaBuIdoishbyevtdwfvdwtwdwuigslider(Sliders['AIM-FOV'], 0.512, 0.348, 2)

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Aimlock Nos Mortos', 0.52+drag_x,0.368+drag_y,0.368+drag_y, Aimlock_eads) then Aimlock_eads = not Aimlock_eads end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Aimlock Nos Peds', 0.52+drag_x,0.388+drag_y,0.388+drag_y, Aimlock_peds) then Aimlock_peds = not Aimlock_peds end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Municao Infinita', 0.52+drag_x,0.408+drag_y,0.408+drag_y, InfAmmo) then
        InfAmmo = not InfAmmo
        SetPedInfiniteAmmoClip(PlayerPedId(), InfAmmo)
    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Nao Recarregar', 0.52+drag_x,0.428+drag_y,0.428+drag_y, BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuknoreload) then
        BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuknoreload = not BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuknoreload
    end

    elseif BaBaBuIjsgfvscg == 'Visual' then if BaBaBuIusocioyhwgf2('Visual', 'Visual',BaBaBuIhythyhfe,0.510+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Visual' end
    
    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('ESP Box', 0.392+drag_x,0.288+drag_y,0.288+drag_y, espbox) then espbox = not espbox end 
    if colorpicker_botao(0.346, 0.291, BaBaBuIjhwhwweerg.r, BaBaBuIjhwhwweerg.g, BaBaBuIjhwhwweerg.b, 255) then 

        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuIjhwhwweerg = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}

    end  

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('ESP Skeletons', 0.392+drag_x,0.308+drag_y,0.308+drag_y, espskel) then espskel = not espskel end 
    if colorpicker_botao(0.346, 0.311,BaBaBuIjwtwfergjhnx.r, BaBaBuIjwtwfergjhnx.g, BaBaBuIjwtwfergjhnx.b, 255) then 

        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuIjwtwfergjhnx = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}

    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('ESP Names', 0.392+drag_x,0.328+drag_y,0.328+drag_y, espnames) then espnames = not espnames end 
    if colorpicker_botao(0.346, 0.332,BaBaBuIhwgrwfwxxzzc.r, BaBaBuIhwgrwfwxxzzc.g, BaBaBuIhwgrwfwxxzzc.b, 255) then 

        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuIhwgrwfwxxzzc = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}

    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('ESP Lines', 0.392+drag_x,0.348+drag_y,0.348+drag_y, esplines) then esplines = not esplines end 
    if colorpicker_botao(0.346, 0.352,BaBaBuInhefeeffewhh.r, BaBaBuInhefeeffewhh.g, BaBaBuInhefeeffewhh.b, 255) then 

        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuInhefeeffewhh = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}

    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('ESP Veiculos', 0.392+drag_x,0.368+drag_y,0.368+drag_y, espvehs) then espvehs = not espvehs end 
    if colorpicker_botao(0.346, 0.372,BaBaBuIjwyhytnbdgvxx.r, BaBaBuIjwyhytnbdgvxx.g, BaBaBuIjwyhytnbdgvxx.b, 255) then 

        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuIjwyhytnbdgvxx = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}

    end

    if Surf_Botao('ESP Distancia', 0.384, 0.391) then end
    BaBaBuIdoishbyevtdwfvdwtwdwuigslider(Sliders['esp_distancia'], 0.385, 0.408, 2)



    elseif BaBaBuIjsgfvscg == 'Online' then if BaBaBuIusocioyhwgf2('Online', 'Online',BaBaBuIhythyhfe,0.550+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Online' end

    if Surf_Botao('Explodir Player  ~r~Risco Alto', 0.384, 0.288) then explode() end

    if Surf_Botao('Explodir Player ~p~2  ~r~Risco Alto', 0.384, 0.308) then explode2() end

    if Surf_Botao('Taze Player ~r~Risco Alto', 0.384, 0.328) then tazez() end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Taze Player ~b~Loop ~r~Risco Alto ', 0.392+drag_x,0.345+drag_y,0.345+drag_y, tazezz) then tazezz = not tazezz end 

    if Surf_Botao('Npcs Grudados no Player ~r~Risco Alto', 0.384, 0.368) then asihdoadh(BaBaBuIjtyegfdfg) end

    if Surf_Botao('Npcs Armados Player  ~r~Risco Alto', 0.384, 0.388) then asdhaoidado() asdhaoidado2() asdhaoidado3() end 

    if Surf_Botao('Mae do Adm Armada Player  ~r~Risco Alto', 0.384, 0.408) then maedoadmgordinha(BaBaBuIjtyegfdfg) end

    if Surf_Botao('Ataque de Faca  ~r~Risco Alto', 0.384, 0.428) then ataquedefacas() end

    if Surf_Botao('Cargoplane Player - ~g~Bypass MQCU ~r~Ban Likizao', 0.384, 0.448) then GetRamedByVehicle('CARGOPLANE', BaBaBuIjtyegfdfg) end

    if Surf_Botao('Explodir Motor do Veiculo -  ~g~Bypass Likizao e MQCU', 0.384, 0.468) then bossengine2iwdahydwgadwadw(BaBaBuIjtyegfdfg) end

    if Surf_Botao('BMX Player ~r~Risco Alto', 0.384, 0.488) then bmxxx(BaBaBuIjtyegfdfg) end

    if Surf_Botao('Copiar Roupa - ~g~Bypass Likizao e MQCU', 0.384, 0.508) then copiarroupa(BaBaBuIjtyegfdfg) end

    if Surf_Botao('Audio Fucker ~r~Risco', 0.384, 0.528) then 
        earrapeall()  
    end
    
    if Surf_Botao('Teleportar Veiculo P2 ~y~Em Teste', 0.384, 0.548) then
            if not IsPedInAnyVehicle(GetPlayerPed(BaBaBuIjtyegfdfg), 0) then
                Fufufufufu('Teleportado! ')
            else
                local veh = GetVehiclePedIsIn(GetPlayerPed(BaBaBuIjtyegfdfg), 0)
            if IsVehicleSeatFree(veh, 0) then
                SetPedIntoVehicle(PlayerPedId(), veh, 0)
            else
                if IsVehicleSeatFree(veh, 1) then
                    SetPedIntoVehicle(PlayerPedId(), veh, 1)
                else
                    if IsVehicleSeatFree(veh, 2) then
                        SetPedIntoVehicle(PlayerPedId(), veh, 2)
                    else
                        if IsVehicleSeatFree(veh, 3) then
                            SetPedIntoVehicle(PlayerPedId(), veh, 3)
                        else
                            Fufufufufu('Teleportado! ')
                        end
                    end
                end
            end
        end
    end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Espectar Player ~r~Risco Alto', 0.392+drag_x,0.566+drag_y,0.566+drag_y, spectar) then spectar = not spectar end

    --  LISTA DE PLAYERS

    local drag_X = BaBaBuIjwgvxxfwef.MenuX - 0.5
    local drag_Y = BaBaBuIjwgvxxfwef.MenuY - 0.5
    local dW = BaBaBuIjwgvxxfwef.MenuW - 0.5
    local dH = BaBaBuIjwgvxxfwef.MenuH - 0.5
    local y = 0.387+0.0155+stasd['Scroll'].static
    local add = 0.0155
    local max = 0.80+dH/1.06
    if IsDisabledControlPressed(0, 14) and y > (0.400+ 0.040 - (3213 * 0.040)) and mouse(0.67+drag_X+dW, 0.6+drag_Y, 0.082, 0.3036) then
        stasd['Scroll'].static3 = stasd['Scroll'].static3 - 0.040
    end
    if IsDisabledControlJustPressed(0, 15) and y ~= 0.375+ 0.040 and mouse(0.67+drag_X+dW, 0.6+drag_Y, 0.082, 0.3036) then
        stasd['Scroll'].static3 = stasd['Scroll'].static3 + 0.040
    end

    for k, v in pairs(GetActivePlayers()) do 
        if y >= 0.4 and y <= max then 
            if v == BaBaBuIjtyegfdfg then 
                SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)
                    if Players_Surf_Botao('~w~[~s~Sel~w~] ~w~'..GetPlayerName(v), 0.563, y-0.12) then 
                    BaBaBuIjtyegfdfg = v
                end
            else
                SetTextColour(BaBaBuIjhgvbsdfdfg.r,BaBaBuIjhgvbsdfdfg.g,BaBaBuIjhgvbsdfdfg.b,255)
                    if Players_Surf_Botao('~w~[~c~Player~w~] ~w~'..GetPlayerName(v), 0.563, y-0.12) then 
                    BaBaBuIjtyegfdfg = v
                end
            end
        end y = y + add  
    end

    local y = 0.387+stasd['Scroll'].static
    local add = 0.0155
    local max = 0.74+dH/1.06
    if IsDisabledControlPressed(0, 14) and y > (0.387 - (2 * add)) and mouse((dW/2)+0.568+drag_X-dW/4, 0.51+drag_Y+dH/2, dW+0.121-dW/2, 0.2658+dH) then
        stasd['Scroll'].static = stasd['Scroll'].static - add
    end
    if IsDisabledControlJustPressed(0, 15) and y ~= 0.387 and mouse((dW/2)+0.568+drag_X-dW/4, 0.51+drag_Y+dH/2, dW+0.121-dW/2, 0.2658+dH) then
        stasd['Scroll'].static = stasd['Scroll'].static + add
    end

    
    --  LISTA DE PLAYERS (FIM)


    elseif BaBaBuIjsgfvscg == 'Troll' then if BaBaBuIusocioyhwgf2('Troll', 'Troll',BaBaBuIhythyhfe,0.590+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Troll' end
    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Freecam  ~r~Risco Alto', 0.392+drag_x,0.288+drag_y,0.288+drag_y, BaBaBuIcincohwdgvtwdfgm) then BaBaBuIcincohwdgvtwdfgm = not BaBaBuIcincohwdgvtwdfgm end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Deletar Veiculos ~b~Loop - ~g~Bypass MQCU e Likizao', 0.392+drag_x,0.308+drag_y,0.308+drag_y, deletarvehs) then deletarvehs = not deletarvehs end

    if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuk('Taze ~g~Geral ~b~Loop ~r~Risco Alto', 0.392+drag_x,0.328+drag_y,0.328+drag_y, tazeall) then tazeall = not tazeall end

    if Surf_Botao('Taze ~g~Geral ~r~Risco Alto', 0.384, 0.349) then tazegeral() end

    if Surf_Botao('Macaco ~r~Risco', 0.384, 0.369) then 
        local model ="a_c_chimp"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Mae do ADM ~r~Risco', 0.384, 0.389) then 
        local model ="a_f_m_fatcult_01"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Gordo do PC ~r~Risco', 0.384, 0.409) then 
        local model ="a_m_m_acult_01"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Astronauta  ~r~Risco', 0.384, 0.429) then 
        local model ="s_m_m_movspace_01"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Bombadão ~r~Risco', 0.384, 0.449) then 
        local model ="u_m_y_babyd"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Padre ~r~Risco', 0.384, 0.469) then 
        local model ="ig_priest"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Super Anti RP ~r~Risco', 0.384, 0.489) then 
        local model ="u_m_y_imporage"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end

    if Surf_Botao('Roupa Random ~r~Risco', 0.384, 0.509) then 
    Citizen.CreateThread(function()
    SetPedRandomComponentVariation(PlayerPedId(), false)
        SetPedRandomProps(PlayerPedId())
        end)
    end    

    if Surf_Botao('Resetar Personagem ~r~Risco', 0.384, 0.529) then 
        local model ="mp_m_freemode_01"
        RequestModel(BaBaBuIuwetgwf(model))
        if HasModelLoaded(BaBaBuIuwetgwf(model)) then
            SetPlayerModel(PlayerId(), BaBaBuIuwetgwf(model))
        end
    end


    elseif BaBaBuIjsgfvscg == 'Config' then if BaBaBuIusocioyhwgf2('Config', 'Config',BaBaBuIhythyhfe,0.630+drag_x,0.227+drag_y) then BaBaBuIjsgfvscg = 'Config' end

    if Surf_Botao('Bind Noclip ~c~'.. BaBaBuInwgfxxcfgv['Label'], 0.384, 0.288) then
        bindzinha()
        local value, label = bindzinha()
        BaBaBuInwgfxxcfgv['Label'] = label
        BaBaBuInwgfxxcfgv['Value'] = value
    end
    --[[if Surf_Botao('Bind Reviver  ~c~'.. BaBaBuIjgfsrfshwnf['Label'], 0.384, 0.308) then
        bindzinha()
        local value, label = bindzinha() 
        BaBaBuIjgfsrfshwnf['Label'] = label
        BaBaBuIjgfsrfshwnf['Value'] = value
    end]]--

    if Surf_Botao('Bind Reparar Veiculo  ~c~'.. BaBaBuIhsfgsrwvwf['Label'], 0.384, 0.308) then
        bindzinha()
        local value, label = bindzinha()
        BaBaBuIhsfgsrwvwf['Label'] = label
        BaBaBuIhsfgsrwvwf['Value'] = value
    end


    if Surf_Botao('Bind Abrir Menu  ~c~'.. BaBaBuIhgbsvsff['Label'], 0.384, 0.328) then 
        bindzinha()
        local value, label = bindzinha()
        BaBaBuIhgbsvsff['Label'] = label
        BaBaBuIhgbsvsff['Value'] = value
    end

    if Surf_Botao('Bind Abrir Menu 2  ~c~'.. BaBaBuIhgbsvsff2['Label'], 0.384, 0.348) then 
        bindzinha()
        local value, label = bindzinha()
        BaBaBuIhgbsvsff2['Label'] = label
        BaBaBuIhgbsvsff2['Value'] = value
    end


    if Surf_Botao('Alterar a Cor do Menu', 0.384, 0.368) then 
        h.ThisIsSliders[7].value, h.ThisIsSliders[8].value, h.ThisIsSliders[9].value = ColorPicker()
        BaBaBuIjhgvbsdfdfg = {r = h.ThisIsSliders[7].value, g = h.ThisIsSliders[8].value, b = h.ThisIsSliders[9].value}
    end
    if Surf_Botao('~r~Desinjetar', 0.384, 0.388) then 
        BaBaBuIkjhsdgddfg = BaBaBuIwadtwdtydw
    end
end
local x, y = GetNuiCursorPosition() local x_ez, y_ez = GetActiveScreenResolution() local cursorX, cursorY = x / x_ez, y / y_ez
BaBaBuImhwtbffvx('^', cursorX, cursorY, 0.560, 0, BaBaBuIhythyhfe, 255, 255, 255)
end



Citizen.CreateThread(function()
    
    while BaBaBuIkjhsdgddfg do
        Wait(0)

function RequestControlOnce(entity)
    if not NetworkIsInSession or NetworkHasControlOfEntity(entity) then
        return BaBaBuIhythyhfe
    end
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), BaBaBuIhythyhfe)
    return NetworkRequestControlOfEntity(entity)
end

if tazezz then
    local ped = GetPlayerPed(BaBaBuIjtyegfdfg)
    local bonecoords = GetPedBoneCoords(ped, 0, 0.0, 0.0, 0.0)
    local bonecoords2 = GetPedBoneCoords(ped, 57005, 0.0, 0.0, 0.2)
    ShootSingleBulletBetweenCoords(bonecoords,bonecoords2,1,BaBaBuIhythyhfe,BaBaBuIuwetgwf('WEAPON_STUNGUN'),MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(),BaBaBuIhythyhfe,BaBaBuIwadtwdtydw,0.1)
end

if HornBoost and IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(-1), BaBaBuIhythyhfe) then
    if IsControlPressed(1, 38) then
    Citizen.InvokeNative(0xAB54A438726D25D5, GetVehiclePedIsUsing(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(-1)), 80+0.0)
    end
end
if InfiniteCombatRoll then
for i = 0, 3 do
StatSetInt(BaBaBuIuwetgwf('mp' .. i .. '_shooting_ability'), 9999, BaBaBuIhythyhfe)
StatSetInt(BaBaBuIuwetgwf('sp' .. i .. '_shooting_ability'), 9999, BaBaBuIhythyhfe)
end
else
for i = 0, 3 do
StatSetInt(BaBaBuIuwetgwf('mp' .. i .. '_shooting_ability'), 0, BaBaBuIhythyhfe)
StatSetInt(BaBaBuIuwetgwf('sp' .. i .. '_shooting_ability'), 0, BaBaBuIhythyhfe)
end
end

if puduronaocair then
    SetPedCanBeKnockedOffVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
else
    SetPedCanBeKnockedOffVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
end

if Super_Pulo then
    SetPedCanRagdoll(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
    if IsDisabledControlJustPressed(0, 22) then
        ApplyForceToEntity(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 3, 0.0, 0.0, Sliders['Super_Pulo'].value, 0.0, 0.0, 0.0, 0, 0, 0, 1, 1, 1)
    end
end

------
if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuuknoreload then
    IsPedShooting(PlayerPedId()) 
    PedSkipNextReloading(PlayerPedId())
    MakePedReload(PlayerPedId())
end
------

if Super_Velocidade then
    if IsDisabledControlPressed(0, 34) or IsDisabledControlPressed(0, 33) or IsDisabledControlPressed(0, 32) or IsDisabledControlPressed(0, 35) then
        if IsPedRagdoll(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) then
            
        else
           SetEntityVelocity(
               MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 
               GetOffsetFromEntityInWorldCoords(
                   MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 
                   0.0, 
                   Sliders['Super_Velocidade'].value, 
                   GetEntityVelocity(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())[3]
                ) - GetEntityCoords(
                    MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
                )
            )
        end
    end
end

function camDirect()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD())
    local pitch = GetGameplayCamRelativePitch()
    local x = -BaBaBuIuiweyte.sin(heading * BaBaBuIuiweyte.pi / 180.0)
    local y = BaBaBuIuiweyte.cos(heading * BaBaBuIuiweyte.pi / 180.0)
    local z = BaBaBuIuiweyte.sin(pitch * BaBaBuIuiweyte.pi / 180.0)
    local len = BaBaBuIuiweyte.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    return x, y, z
end


function requestControlOnce(entity)
    if NetworkHasControlOfEntity(entity) then
       return BaBaBuIhythyhfe
    end
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), BaBaBuIhythyhfe)
    return NetworkRequestControlOfEntity(entity)
end



function getSeatPedIsIn(ped)
    if not IsPedInAnyVehicle(ped, BaBaBuIwadtwdtydw) then
        return
    else
        veh = GetVehiclePedIsIn(ped)
        for i = 0, GetVehicleMaxNumberOfPassengers(veh) do
            if GetPedInVehicleSeat(veh) then
                return i
            end
        end
    end
end

if BaBaBuIquatrohsgsddsfg then
    local veh = GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0)
    ModifyVehicleTopSpeed(veh, 0.0 +Sliders['Acelerção'].value)
else
    ModifyVehicleTopSpeed(veh, BaBaBuIwadtwdtydw)
end


function lerp(A, B, T)
    if A > 1 then 
        return T 
    end
    if A < 0 then 
        return B 
    end
    return B+(T-B)*A
end

-- SUPERSOCO
-----------------------------------------------------------
if supersoco2 then 
    ProtecaoAntiPobre = SetWeaponDamageModifierThisFrame ShitAllBith = GetHashKey FuckLife = 'weapon_unarmed'  GlifeServGay = 14.9
    ProtecaoAntiPobre(ShitAllBith('weapon_unarmed'), GlifeServGay)
else
    ProtecaoAntiPobre = SetWeaponDamageModifierThisFrame ShitAllBith = GetHashKey FuckLife = 'weapon_unarmed'  GlifeServGay = 14.9
    ProtecaoAntiPobre(ShitAllBith('weapon_unarmed'), 1.0)
end

function tratarse()
        TriggerServerEvent('tratamento-macas')
    end

if tazeall then
    for k, v in pairs(GetActivePlayers()) do 
        local ped = GetPlayerPed(v)
        local Coords = GetEntityCoords(ped)
    
        local bonecoords = GetPedBoneCoords(ped, 0, 0.0, 0.0, 0.0)
        local bonecoords_2 = GetPedBoneCoords(ped, 57005, 0.0, 0.0, 0.2)
    
        ShootSingleBulletBetweenCoords(bonecoords_2,bonecoords,1,BaBaBuIhythyhfe,BaBaBuIuwetgwf('WEAPON_STUNGUN'),MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(v),BaBaBuIhythyhfe,BaBaBuIwadtwdtydw,1.0)
    end
end

if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukrolasinf then
    for i = 0, 3 do
        StatSetInt(BaBaBuIuwetgwf("mp" .. i .. "_shooting_ability"), 9999, BaBaBuIhythyhfe)
        StatSetInt(BaBaBuIuwetgwf("sp" .. i .. "_shooting_ability"), 9999, BaBaBuIhythyhfe)
    end
else
    for i = 0, 3 do
        StatSetInt(BaBaBuIuwetgwf("mp" .. i .. "_shooting_ability"), 0, BaBaBuIhythyhfe)
        StatSetInt(BaBaBuIuwetgwf("sp" .. i .. "_shooting_ability"), 0, BaBaBuIhythyhfe)
    end
end

if BaBaBuIijdywgdtwgdwtdgggrgrgtwkuukInfStamina then
  RestorePlayerStamina(PlayerId(-1), 1.0)
end

local function veiculoo(cp, cq, cr)
    return coroutine.wrap(
        function()
            local cs, ct = cp()
            if not ct or ct == 0 then
                cr(cs)
                return
            end
            local cu = {handle = cs, destructor = cr}
            setmetatable(cu, entityEnumerator)
            local cv = BaBaBuIhythyhfe
            repeat
                coroutine.yield(ct)
                cv, ct = cq(cs)
            until not cv
            cu.destructor, cu.handle = bypasszinhass, bypasszinhass
            cr(cs)
        end
    )
end
function cw()
    return veiculoo(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
local function cw()
    return veiculoo(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
local function cx()
    return veiculoo(FindFirstObject, FindNextObject, EndFindObject)
end

if deletarvehs then
    for dR in cw() do
        NetworkRequestControlOfEntity(dR)
        DeleteEntity(dR)
    end
end

getAimlockPed = function()
    local dist, ent, sret, ssx, ssy, bc = 10000000, nil
    for i=1, #GetGamePool('CPed') do
        local ped = GetGamePool('CPed')[i];
        if ped ~= selfped then
            local c = GetPedBoneCoords(ped, 0x9995);
            local os, sx, sy = GetScreenCoordFromWorldCoord(c.x, c.y, c.z);

            local dista = #vector2(sx - 0.5, sy - 0.5)
            if dista < dist then
                dist, ent, sret, ssx, ssy, bc = dista, ped, os, sx, sy, c
            end
        end
    end
    return ent, bc, sret, ssx, ssy
end 

if Aimlockfov then
    local fovn = (Sliders['AIM-FOV'].value / 1000)
    local nKDX, nKDY = 0.0, 0.0
    DrawSprite('thefov', 'sdjcircle', 0.5-nKDX, 0.5-nKDY, fovn, fovn * 1.8, 0.0, fov.r,fov.g, fov.b, 255)
end


if Aimlock then
    local FOV = (Sliders['AIM-FOV'].value / 1000)
    local ped, a, b, c, d = getAimlockPed()
    if Aimlock_peds then 
        aped = ped 
    else
        aped = IsPedAPlayer(ped)
    end
    if Aimlock_eads then 
        deads = ped 
    else
        deads = not IsEntityDead(ped)
    end
    if Aimlock_throughwalls then 
        vis = true
    else
        vis = HasEntityClearLosToEntity(PlayerPedId(), ped, 17) 
    end
    local hit = math.random(0, 100)
    local x, y, z = table.unpack(GetPedBoneCoords(ped, 31086))
    local _, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local c = GetPedBoneCoords(ped, 31086)
    local x1, y1, z1 = table.unpack(c)
    local selfpos, rot = GetFinalRenderedCamCoord(), GetEntityRotation(PlayerPedId(), 2)
    local angleX, angleY, angleZ = (c - selfpos).x, (c - selfpos).y, (c - selfpos).z
    local roll, pitch, yaw = -math.deg(math.atan2(angleX, angleY)) - rot.z, math.deg(math.atan2(angleZ, #vector3(angleX, angleY, 0.0))), 1.0
    roll = 0.0+(roll-0.0)
    if aped and deads and vis and hit <= Sliders['Aimlock_hitchance'] and ped ~= PlayerPedId() and IsEntityOnScreen(ped) then 
        if (_x > 0.5 - ((FOV / 2)/0.5) and _x < 0.5 + ((FOV / 2)/0.5) and _y > 0.5 - ((FOV / 2)/0.5) and _y < 0.5 + ((FOV / 2)/0.5)) then
            if IsAimCamActive() then 
                SetGameplayCamRelativeRotation(roll, pitch, yaw)                        
            end
        end
    end
end

function bY(x, y, z, b7, r, g, b)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.20, 0.20)
    SetTextColour(BaBaBuIhwgrwfwxxzzc.r, BaBaBuIhwgrwfwxxzzc.g, BaBaBuIhwgrwfwxxzzc.b, 255)
    SetTextOutline()
    BeginTextCommandDisplayText('STRING')
    SetTextCentre(1)
    AddTextComponentSubstringPlayerName(b7)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
GetPedBoneCoordsF = function(ped, boneId)
    local cam = GetFinalRenderedCamCoord()
    local ret, coords, shape = GetShapeTestResult(
        StartShapeTestRay(
            vector3(cam), vector3(GetPedBoneCoords(ped, 0x0)), -1
        )
    )
    if coords then 
        a = Vdist(cam, shape)/Vdist(cam, GetPedBoneCoords(ped, 0x0)) 
    else
        a = 0.83 
    end
    if a > 1 then 
        a = 0.83 
    end
    if ret then
        return (((GetPedBoneCoords(ped, boneId)-cam)*((a) * 0.83)) + cam)
    end
end


if espnames then
    local ds = GetActivePlayers()
    for T = 1, #ds do
        local ct = ds[T]
        if ct ~= PlayerId() and GetPlayerServerId(ct) ~= 0 then
            local dH = GetEntityCoords(GetPlayerPed(ds[T]))
            local dI = GetDistanceBetweenCoords(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), dH)
            local dJ = Sliders['esp_distancia'].value + 0.0
            if dI <= dJ then
                local dK = GetPlayerPed(ct)
                local dL, dM, dN = table.unpack(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()))
                local x, y, z = table.unpack(GetEntityCoords(dK))
                local dd = ' ' .. GetPlayerName(ds[T]) .. ' ~w~[~s~' .. BaBaBuIuiweyte.floor(dI) .. ' M ~w~]'
                local dO = IsPlayerDead(dK)
                if GetEntityHealth(dK) <= 0 then
                    dO = BaBaBuIhythyhfe
                end
                if dO then
                    dd = ' '
                end
                bY(x, y, z - 0.1, dd, 255, 255, 255)
            end
        end
    end
end




if espbox then
    for ped in EnumeratePeds() do 
        if BaBaBuIjwywfwweef then 
            mr = ped 
        else
            mr = IsPedAPlayer(ped)
        end
        if visuals_dynamicself then 
            ma = ped 
        else
            ma = ped ~= MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
        end
        local coordXMin = GetOffsetFromEntityInWorldCoords(ped, 0.4, 0.0, 0.9)
        local coordYPlus = GetOffsetFromEntityInWorldCoords(ped, -0.4, 0.0, -0.9)

        local bool, screenX, screenY = GetScreenCoordFromWorldCoord(coordXMin.x, coordXMin.y, coordXMin.z)
        local bool2, screenX2, screenY2 = GetScreenCoordFromWorldCoord(coordYPlus.x, coordYPlus.y, coordYPlus.z)
        local resX, resY = GetActiveScreenResolution()
        local coord = GetEntityCoords(ped)
        local x, y, z = coord.x, coord.y, coord.z
        local d = GetDistanceBetweenCoords(GetFinalRenderedCamCoord(), GetEntityCoords(ped), BaBaBuIwadtwdtydw)
        if d < Sliders['esp_distancia'].value then
            SetDrawOrigin(x, y, z, 0)
            local d = GetDistanceBetweenCoords(GetFinalRenderedCamCoord(), GetEntityCoords(ped), BaBaBuIwadtwdtydw)-(GetGameplayCamFov()-50.0)
            if mr and ma and bool and bool2 and not IsEntityDead(ped) and IsEntityOnScreen(ped)  then
                local BaBaBuIuiweyte = (screenX - screenX2)
                local BaBaBuIuiweyte2 = (screenY2 - screenY)
                
                if BaBaBuIdoisjdghdgwtwdddw then 
                    BaBaBuIjsgrwwrv(0.0, -BaBaBuIuiweyte2/2, BaBaBuIuiweyte, 3/resY, 1, 1, 1, 255)
                    BaBaBuIjsgrwwrv(0.0, BaBaBuIuiweyte2/2, BaBaBuIuiweyte, 3/resY, 1, 1, 1, 255)
                    BaBaBuIjsgrwwrv(BaBaBuIuiweyte/2, 0.0, 3/resX, screenY2 - screenY, 1, 1, 1, 255)
                    BaBaBuIjsgrwwrv(-BaBaBuIuiweyte/2, 0.0, 3/resX, screenY2 - screenY, 1, 1, 1, 255)
                    BaBaBuIjsgrwwrv(0.0, -BaBaBuIuiweyte2/2, BaBaBuIuiweyte, 1/resY,BaBaBuIjhwhwweerg.r, BaBaBuIjhwhwweerg.g, BaBaBuIjhwhwweerg.b, 255)
                    BaBaBuIjsgrwwrv(0.0, BaBaBuIuiweyte2/2, BaBaBuIuiweyte, 1/resY,BaBaBuIjhwhwweerg.r, BaBaBuIjhwhwweerg.g, BaBaBuIjhwhwweerg.b, 255)
                    BaBaBuIjsgrwwrv(BaBaBuIuiweyte/2, 0.0, 1/resX, screenY2 - screenY,BaBaBuIjhwhwweerg.r, BaBaBuIjhwhwweerg.g, BaBaBuIjhwhwweerg.b, 255)
                    BaBaBuIjsgrwwrv(-BaBaBuIuiweyte/2, 0.0, 1/resX, screenY2 - screenY,BaBaBuIjhwhwweerg.r, BaBaBuIjhwhwweerg.g, BaBaBuIjhwhwweerg.b, 255)
                    if BaBaBuIdoisjdghdgwtwdddw_fill then 
                        BaBaBuIjsgrwwrv(0.0, 0.0, BaBaBuIuiweyte, screenY2 - screenY, 0, 0, 0, 160)
                    end
                end

                local NUM = (GetEntityMaxHealth(ped)-100) / BaBaBuIuiweyte2
                local H = GetEntityHealth(ped)-100
                if H > (GetEntityMaxHealth(ped)-100) then 
                    H = (GetEntityMaxHealth(ped)-100) 
                end
                
                if BaBaBuIuiweyte < 0.0 then 
                    if BaBaBuIuhy6twfwefvefb then 
                        BaBaBuIjsgrwwrv((-BaBaBuIuiweyte/2 - 8.0 / resX), 0.0, 3 / resX, BaBaBuIuiweyte2+0.0018, 1, 1, 1, 255)
                        BaBaBuIjsgrwwrv((-BaBaBuIuiweyte/2 - 8.0 / resX), 0 + BaBaBuIuiweyte2/2 - ((H/NUM) - (1 / resX))/2, 1 / resX, -1*(H/NUM)-(1 / resX), 1, 255, 1, 255)
                    end
                    if BaBaBuIhdetcwcvdvcv then 
                    end
                else 
                    if BaBaBuIuhy6twfwefvefb then 
                        BaBaBuIjsgrwwrv((-BaBaBuIuiweyte/2 - 8.0 / resX), 0.0, 3 / resX, BaBaBuIuiweyte2+0.0018, 1, 1, 1, 255)
                        BaBaBuIjsgrwwrv((-BaBaBuIuiweyte/2 - 8.0 / resX), 0 + BaBaBuIuiweyte2/2 - ((H/NUM) - (1 / resX))/2, 1 / resX, -1*(H/NUM)-(1 / resX), 1, 255, 1, 255)
                    end
                    if BaBaBuIhdetcwcvdvcv then 
                    end
                end                   
            end 
            ClearDrawOrigin()
        end
    end
end

local function GetPedBoneCoordsF(ped, boneId)
    local cam = GetFinalRenderedCamCoord()
    local ret, coords, shape = GetShapeTestResult(
        StartShapeTestRay(
            vector3(cam), vector3(GetPedBoneCoords(ped, 0x0)), -1
        )
    )
    if coords then 
        a = Vdist(cam, shape)/Vdist(cam, GetPedBoneCoords(ped, 0x0)) 
    else
        a = 0.83 
    end
    if a > 1 then 
        a = 0.83 
    end
    if ret then
        return (((GetPedBoneCoords(ped, boneId)-cam)*((a) * 0.83)) + cam)
    end
end

if esplines then
        for myped in EnumeratePeds() do
            local Selfx, Selfy, Selfz = table.unpack(GetPedBoneCoordsF(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0x0, 0.0, 0.0, 0.0))
            local x, y, z = table.unpack(GetPedBoneCoordsF(myped, 0x0, 0.0, 0.0, 0.0))
            local distance = #(vector3(Selfx, Selfy, Selfz) - vector3(x, y, z))
            local mr = IsPedAPlayer(myped)
        if mr then
            if distance < Sliders['esp_distancia'].value then
                if BaBaBuItresjdaddwgegeg and not IsEntityDead(myped) then
                    if HasEntityClearLosToEntity(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), myped, 19) then 
                        local r, g, b = BaBaBuInhefeeffewhh.r, BaBaBuInhefeeffewhh.g, BaBaBuInhefeeffewhh.b     
                    DrawLine(Selfx,Selfy,Selfz,x,y,z,r,g,b,255)
                    else
                        local r, g, b = BaBaBuInhefeeffewhh.r, BaBaBuInhefeeffewhh.g, BaBaBuInhefeeffewhh.b
                        DrawLine(Selfx,Selfy,Selfz,x,y,z,r,g,b,255)
                    end
                else
                    local r, g, b = BaBaBuInhefeeffewhh.r, BaBaBuInhefeeffewhh.g, BaBaBuInhefeeffewhh.b
                    DrawLine(Selfx,Selfy,Selfz,x,y,z,r,g,b,255)
                end
            end
        end
    end       
end

function BaBaBuIwwwysxffgs(BaBaBuIwhwqtfxxff, x, y, scale, font, outline, center, r, g, b)
    SetTextScale(0.0, scale)
    SetTextFont(font)
    if outline then
        SetTextOutline(outline)
    else
    end
    SetTextCentre(center)
    SetTextColour(r, g, b, 255)
    BeginTextCommandDisplayText('TWOSTRINGS')
    AddTextComponentString(BaBaBuIwhwqtfxxff)
    EndTextCommandDisplayText(x, y - 0.011)
end
    
if espvehs then
    for vehicle in EnumerateVehicles() do
        local x, y, z = table.unpack(GetEntityCoords(vehicle))
        local _, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
        local x1, y1, z1 = table.unpack(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()))
        local dist =
            tonumber(string.format('%.1f', GetDistanceBetweenCoords(x1, y1, z1, x, y, z, BaBaBuIhythyhfe)))
        local string = '' .. GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) .. ' ~w~[ ~s~' .. dist .. ' ~s~M ~w~]'
        if dist < Sliders['esp_distancia'].value then
            SetTextColour(BaBaBuInhefeeffewhh.r, BaBaBuInhefeeffewhh.g, BaBaBuInhefeeffewhh.b,255)
        BaBaBuIwwwysxffgs(string,_x,_y,0.19,10,BaBaBuIhythyhfe,BaBaBuIhythyhfe,BaBaBuIjwyhytnbdgvxx.r,BaBaBuIjwyhytnbdgvxx.g,BaBaBuIjwyhytnbdgvxx.b)
        end
    end
end

if espskel then
    for ped in EnumeratePeds() do
            local d = GetDistanceBetweenCoords(GetFinalRenderedCamCoord(), GetEntityCoords(ped), false) 
            if visualsskeletons_peds then 
                mr = ped
            else
                mr = IsPedAPlayer(ped)
            end
            if visuals_skeletons_self then 
                me = ped
            else
                me = ped ~= PlayerPedId() 
            end
            dead = IsEntityDead(ped)
            
            if d < Sliders['esp_distancia'].value + 0.0 then
                if mr and me and not dead and IsEntityOnScreen(ped) then
                    if visuals_skeletons_vischeck then
                        if HasEntityClearLosToEntity(PlayerPedId(), ped, 19) then 
                        local r, g, b = BaBaBuIjwtwfergjhnx.r, BaBaBuIjwtwfergjhnx.g, BaBaBuIjwtwfergjhnx.b           
                        DrawLine(GetPedBoneCoordsF(ped, 31086, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xCC4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3779, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x49D9, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xDEAD, 0.0, 0.0, 0.0),r, g, b, 255)
                    else
                        local r, g, b = BaBaBuIjwtwfergjhnx.r, BaBaBuIjwtwfergjhnx.g, BaBaBuIjwtwfergjhnx.b               
                        DrawLine(GetPedBoneCoordsF(ped, 31086, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xCC4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3779, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x49D9, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),r, g, b, 255)
                        DrawLine(GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xDEAD, 0.0, 0.0, 0.0),r, g, b, 255)
                    end
                else
                    local r, g, b = BaBaBuIjwtwfergjhnx.r, BaBaBuIjwtwfergjhnx.g, BaBaBuIjwtwfergjhnx.b   
                    DrawLine(GetPedBoneCoordsF(ped, 31086, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xE0FD, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x192A, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0xCC4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3FCF, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x5C57, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0xB3FE, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x3779, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0xB1C5, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0xEEEB, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x49D9, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x9995, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x9D4D, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),r, g, b, 255)
                    DrawLine(GetPedBoneCoordsF(ped, 0x6E5C, 0.0, 0.0, 0.0),GetPedBoneCoordsF(ped, 0xDEAD, 0.0, 0.0, 0.0),r, g, b, 255)
                end
            end
        end
    end
end

if Shit_BaBaBuInwgfxxcfgv then
    local speed = Sliders['BaBaBuInwgfxxcfgv_Velocidade'].value
    local speedcar = Sliders['BaBaBuInwgfxxcfgv_Velocidade'].value
    local speedbypass = Sliders['BaBaBuInwgfxxcfgv_Velocidade'].value
    local vehicleecheck = IsPedInAnyVehicle(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0)
    local player = nil
    local x, y, z = nil
    local Camerax, Cameray, Cameraz = camDirect()
    local cG = MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
    if not vehicleecheck then
        player = MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()
        x, y, z = table.unpack(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 2))
    else
        player = GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0)
        x, y, z = table.unpack(GetEntityCoords(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 1))
    end
    if vehicleecheck and getSeatPedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) ~= -1 then
        requestControlOnce(player)
    end

    if vehicleecheck and IsDisabledControlPressed(0, 32) and getSeatPedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) ~= -1 then
        x = x + speedbypass * speedcar * Camerax
        y = y + speedbypass * speedcar * Cameray
        z = z + speedbypass * speedcar * Cameraz
        requestControlOnce(player)
    end
    if vehicleecheck and IsDisabledControlPressed(0, 269) and getSeatPedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) ~= -1 then
        x = x - speedbypass * speedcar * Camerax
        y = y - speedbypass * speedcar * Cameray
        z = z - speedbypass * speedcar * Cameraz
        requestControlOnce(player)
    end

    SetEntityVelocity(player, 0.0001, 0.0001, 0.0001)
    if IsDisabledControlPressed(0, 32) then
        GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
        x = x + speedbypass * Camerax
        y = y + speedbypass * Cameray
        z = z + speedbypass * Cameraz
    end
    if IsDisabledControlPressed(0, 269) then
        GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
        x = x - speedbypass * Camerax
        y = y - speedbypass * Cameray
        z = z - speedbypass * Cameraz
    end
    if IsDisabledControlPressed(0, 22) then
        GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
        z = z + speed
    end
    if IsDisabledControlPressed(0, 36) then
        GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
        z = z - speed
    end
    SetEntityCoordsNoOffset(player, x, y, z, BaBaBuIhythyhfe, BaBaBuIhythyhfe, BaBaBuIhythyhfe)
end

if IsControlJustPressed(1, BaBaBuIhsfgsrwvwf['Value']) then
    BaBaBuIdoishbyevtdwfvdwtwdwuigReparar()
end
if IsControlJustPressed(1, BaBaBuInwgfxxcfgv['Value']) then
    Shit_BaBaBuInwgfxxcfgv = not Shit_BaBaBuInwgfxxcfgv
    if Shit_BaBaBuInwgfxxcfgv then
        SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
        SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
        FreezeEntityPosition(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIhythyhfe)
        FreezeEntityPosition(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe)
        SetEntityCollision(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
        SetEntityCollision(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw, BaBaBuIwadtwdtydw)
        SetEntityRotation(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), GetGameplayCamRot(2), 2, 1)

    else
        SetEntityVisible(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
        SetEntityVisible(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
        FreezeEntityPosition(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIwadtwdtydw)
        FreezeEntityPosition(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIwadtwdtydw)
        SetEntityCollision(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
        SetEntityCollision(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), BaBaBuIhythyhfe, BaBaBuIhythyhfe)
        SetEntityRotation(GetVehiclePedIsIn(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 0), GetGameplayCamRot(2), 2, 1)

    end
end

--[[if marcadaagua then
    drawText('Ratinho Menu on top e biel x gay ', 0.5, 0.4, 0.47, 0, false)
else 
    drawText('~n~O~n~G~n~C', 0.5, 0.4, 0.47, 0, false)
end]]--

if IsControlJustPressed(1, BaBaBuIhgbsvsff2['Value']) then
    DisplayMenu = not DisplayMenu
end


if IsControlJustPressed(1, BaBaBuIjgfsrfshwnf['Value']) then
    if GetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD()) < 200 then
        SetEntityHealth(MePeRgUnTaRaMQuAlQueErAMeUGTHUSD(), 200)
    end
end

        if IsControlJustPressed(1, BaBaBuIhgbsvsff['Value']) then
            DisplayMenu = not DisplayMenu
        end
        if DisplayMenu  then
            meni()
            kontrols()
            
        end

    end
end)