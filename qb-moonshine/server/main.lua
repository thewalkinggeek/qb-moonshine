QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--- Register Fruit For Use ---
QBCore.Functions.CreateUseableItem("apple", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("peach", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("cherries", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

--- Register Moonshine Items for Use ---
QBCore.Functions.CreateUseableItem("moonshine", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("qb-moonshine:client:UseShine", source, item.name)
	end
end)

QBCore.Functions.CreateUseableItem("toplessgranny", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("qb-moonshine:client:UseToplessGranny", source, item.name)
	end
end)

QBCore.Functions.CreateUseableItem("peachfurry", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("qb-moonshine:client:UsePeachFurry", source, item.name)
	end
end)

QBCore.Functions.CreateUseableItem("cherrybomb", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("qb-moonshine:client:UseCherryBomb", source, item.name)
	end
end)

QBCore.Functions.CreateUseableItem("holywater", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("qb-moonshine:client:UseHolyWater", source, item.name)
	end
end)

--- Check if Player Has $ for Midnight Hippie PED ---
QBCore.Functions.CreateCallback('qb-moonshine:server:HasMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.cash >= 5000 then
        Player.Functions.RemoveMoney('cash', 5000)
        cb(true)
    elseif Player.PlayerData.money.bank >= 5000 then
        Player.Functions.RemoveMoney('bank', 5000)
        cb(true)
    else
        cb(false)
    end
end)

--- Check if Player Has Items for Recipes ---
QBCore.Functions.CreateCallback('qb-moonshine:server:get:apple:recipe', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local moonshine = Player.Functions.GetItemByName("moonshine")
    local apple = Player.Functions.GetItemByName("apple")

    if moonshine ~= nil and apple ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-moonshine:server:get:peach:recipe', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local moonshine = Player.Functions.GetItemByName("moonshine")
    local peach = Player.Functions.GetItemByName("peach")

    if moonshine ~= nil and peach ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-moonshine:server:get:cherries:recipe', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local moonshine = Player.Functions.GetItemByName("moonshine")
    local cherries = Player.Functions.GetItemByName("cherries")

    if moonshine ~= nil and cherries ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-moonshine:server:check:shine', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local moonshine = Player.Functions.GetItemByName("moonshine")

    if moonshine ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
--h--