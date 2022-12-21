local QBCore = exports['qb-core']:GetCoreObject()


-- Create usable item
if Config.type == "item" then 
    QBCore.Functions.CreateUseableItem("taser_cardridge", function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent('qb-tasercart:server:refillTaser', src)
        end
    end)
end

-- Remove item event

RegisterNetEvent('qb-tasercart:server:removeCardridge', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('taser_cardridge') then
        Player.Functions.RemoveItem('taser_cardridge', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['taser_cardridge'], "remove")
    end
end)