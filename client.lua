local QBCore = exports['qb-core']:GetCoreObject()
local OnNotify = false
local CardridgesLeft = Config.max
local TaserModel = GetHashKey("WEAPON_STUNGUN")


-- Make a usable command
if Config.type == "command" then
    RegisterCommand(Config.command, function()
        RefillTaser()
    end)
    RegisterKeyMapping(Config.command, 'Taser nachladen', 'keyboard', 'r')
end

-- event for the item
RegisterNetEvent('qb-tasercart:server:refillTaser', function()
    RefillTaser()
end)

-- notify which is safe to spam
-- @param msg - message to display
-- @param time - time to display message
function SafeNotify(msg, time)
    CreateThread(function()
        -- if already displaying a message, don't display another
        if OnNotify then
            return
        end
        -- if no time is specified, default to 2 seconds
        if time == nil then
            time = 2000
        end
        print(OnNotify)
        QBCore.Functions.Notify(msg, 'primary', time - 1)
        OnNotify = true
        Wait(time - 1)
        OnNotify = false
    end)
end

-- refill taser function
function RefillTaser()
    if Config.progressbar then
        RefillProgressbar()
    else
        RefillNotify()
    end
end

function RefillProgressbar()
     -- progressbar
     if QBCore.Functions.HasItem('taser_cardridge') then
        if QBCore.Functions.HasItem('weapon_stungun') then
        QBCore.Functions.Progressbar("taser", "Lade taser...", Config.ReloadTime, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true
        }, {}, {}, {}, function() -- Done
            SafeNotify("Taser Nachgeladen.")
            CardridgesLeft = Config.max
            TriggerServerEvent("qb-tasercart:server:removeCardridge")
        end, function() -- Cancel
            SafeNotify("Abgebochen", 1000)
        end)
    else
        SafeNotify("Du hast keinen Taser", 1000)
    end
end
end

function RefillNotify()
    CreateThread(function()
        if QBCore.Functions.HasItem('taser_cardridge') then
            SafeNotify("Refilling taser...", Config.ReloadTime)
            Wait(Config.ReloadTime)
            SafeNotify("Taser Reloaded.")
            TriggerServerEvent("qb-tasercart:server:removeCardridge")
            CardridgesLeft = Config.max
        else
            SafeNotify("Du hast keine Kartuschen", 1000)
        end
    end)
end

-- loop
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        if weapon == TaserModel then

            if CardridgesLeft <= 0 then
                DisablePlayerFiring(ped, true)
            end

            if IsControlPressed(0, 106) and CardridgesLeft <= 0 then
                SafeNotify("Dein Taser ist Leer", 1000)
            end

            if IsPedShooting(ped) and CardridgesLeft > 0 then
                CardridgesLeft = CardridgesLeft - 1
            end
        end
    end
end)
