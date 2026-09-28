local ESX = nil
local Config = Config

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('fly_system:loadPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT fly_enabled FROM ' .. Config.DatabaseTable .. ' WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(flyEnabled)
        if flyEnabled == nil then
            MySQL.Async.execute('INSERT INTO ' .. Config.DatabaseTable .. ' (identifier, fly_enabled, fly_speed) VALUES (@identifier, @fly_enabled, @fly_speed)', {
                ['@identifier'] = identifier,
                ['@fly_enabled'] = Config.FlyEnabled,
                ['@fly_speed'] = Config.FlySpeed
            }, function(rowsChanged)
                cb(Config.FlyEnabled, Config.FlySpeed)
            end)
        else
            MySQL.Async.fetchScalar('SELECT fly_speed FROM ' .. Config.DatabaseTable .. ' WHERE identifier = @identifier', {
                ['@identifier'] = identifier
            }, function(flySpeed)
                cb(flyEnabled, flySpeed)
            end)
        end
    end)
end)

RegisterServerEvent('fly_system:saveFlySettings')
AddEventHandler('fly_system:saveFlySettings', function(flyEnabled, flySpeed)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE ' .. Config.DatabaseTable .. ' SET fly_enabled = @fly_enabled, fly_speed = @fly_speed WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@fly_enabled'] = flyEnabled,
        ['@fly_speed'] = flySpeed
    }, function(rowsChanged)
        TriggerClientEvent('fly_system:updateFlySettings', source, flyEnabled, flySpeed)
    end)
end)