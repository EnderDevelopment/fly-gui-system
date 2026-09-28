local ESX = nil
local Config = Config

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if Config.FlyEnabled then
            local playerPed = PlayerPedId()
            if IsControlPressed(0, 32) then -- W key
                SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 0.5)
            end
            if IsControlPressed(0, 33) then -- S key
                SetEntityHeading(playerPed, GetEntityHeading(playerPed) - 0.5)
            end
            if IsControlPressed(0, 34) then -- A key
                SetEntityHeading(playerPed, GetEntityHeading(playerPed) - 0.5)
            end
            if IsControlPressed(0, 35) then -- D key
                SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 0.5)
            end
            if IsControlPressed(0, 21) then -- Space key
                SetEntityCoords(playerPed, GetEntityCoords(playerPed).x, GetEntityCoords(playerPed).y, GetEntityCoords(playerPed).z + Config.FlySpeed, true, false, false, true)
            end
            if IsControlPressed(0, 36) then -- Left Ctrl key
                SetEntityCoords(playerPed, GetEntityCoords(playerPed).x, GetEntityCoords(playerPed).y, GetEntityCoords(playerPed).z - Config.FlySpeed, true, false, false, true)
            end
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('fly_system:loadPlayerData')
end)

RegisterNetEvent('fly_system:updateFlySettings')
AddEventHandler('fly_system:updateFlySettings', function(flyEnabled, flySpeed)
    Config.FlyEnabled = flyEnabled
    Config.FlySpeed = flySpeed
end)

function OpenFlyGui()
    local elements = {
        {label = 'Fly Enabled', value = Config.FlyEnabled},
        {label = 'Fly Speed', value = Config.FlySpeed}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fly_gui', {
        title = 'Fly GUI',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.label == 'Fly Enabled' then
            Config.FlyEnabled = not Config.FlyEnabled
            TriggerServerEvent('fly_system:saveFlySettings', Config.FlyEnabled, Config.FlySpeed)
            menu.update({{label = 'Fly Enabled', value = Config.FlyEnabled}}, menu.current)
        elseif data.current.label == 'Fly Speed' then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fly_speed', {
                title = 'Enter Fly Speed'
            }, function(data2, menu2)
                local speed = tonumber(data2.value)
                if speed ~= nil then
                    Config.FlySpeed = speed
                    TriggerServerEvent('fly_system:saveFlySettings', Config.FlyEnabled, Config.FlySpeed)
                    menu.update({{label = 'Fly Speed', value = Config.FlySpeed}}, menu.current)
                else
                    ESX.ShowNotification('Invalid speed value!')
                end
                menu2.close()
            end, function(data2, menu2)
                menu2.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterCommand('flygui', function(source, args, rawCommand)
    OpenFlyGui()
end, false)