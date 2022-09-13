--[[
Taser cardridge
by L1 & ItssJxstn
]]
local QBCore = exports['qb-core']:GetCoreObject()
    RegisterKeyMapping("taserreload", "Reload", 'keyboard', "R")


local maxTaserCarts = 2
local refillCommand = "taserreload"
local longerTazeTime = false
local longerTazeSecTime = 20
taserModel = GetHashKey("WEAPON_STUNGUN")
local taserCartsLeft = maxTaserCarts

--- Code ---

InNotify = false

function ShowNotification(text, time)
    _time = time or 2000
    CreateThread(function()
        if(InNotify == false) then
            QBCore.Functions.Notify(text, 'primary', _time)
            InNotify = true
            Wait(_time - 1)
            InNotify = false

        end
    end)

end

RegisterCommand(refillCommand, function(source, args, rawCommand)
    if(GetSelectedPedWeapon(PlayerPedId()) == taserModel) then
        if QBCore.Functions.HasItem('taser_cardridge') then
            ShowNotification("Reloading...", 3000)
            Citizen.Wait(3000)
            taserCartsLeft = maxTaserCarts
            ShowNotification("Taser nachgeladen.")
            TriggerServerEvent('DD-taser:server:jhkjkl')
        else
            ShowNotification("You need a Cardridge")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                taserCartsLeft = taserCartsLeft - 1
                -- print("[Taser Cartridge] Taser Cartridges over = " .. taserCartsLeft)
            end
        end

        if taserCartsLeft <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
                if IsControlPressed(0, 106) then
                    ShowNotification("Your Taser is Empty. Please Reload!")
                end
            end
        end

        if longerTazeTime then
            SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
        end
    end
end)