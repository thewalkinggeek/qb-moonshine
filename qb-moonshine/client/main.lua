QBCore = nil

--- Lets Rock, -Hark ---
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

--- Initialize Blip ---
Citizen.CreateThread(function()
    setBlip()
end)

--- Blip Function ---
function setBlip()
    blip = AddBlipForCoord(1233.039, 1852.777, 79.37341)
    SetBlipSprite(blip, 434)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.75)
    SetBlipColour(blip, 56)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Larry The Farmer Guy')
    EndTextCommandSetBlipName(blip)
end

isLoggedIn = true
DrinkCount = 0

--- Anim Load function ---
function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

--- Item Use Functions and Effects ---
--- Set Armor to 110 for 15 Secs(85 after), -5 Hunger, -10 Thrist, 20 Stress ---
RegisterNetEvent('qb-moonshine:client:UseShine')
AddEventHandler('qb-moonshine:client:UseShine', function()
TriggerEvent('animations:client:EmoteCommandStart', {"moonshine"})
	QBCore.Functions.Progressbar("use_shine", "Drinking ...", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function()
        local luck = math.random(1, 100)
        local IsDrunk = true

        DrinkCount = DrinkCount + 1
        TriggerServerEvent('hospital:server:SetArmor', 110)
        SetPedArmour(GetPlayerPed(-1), 110)
		TriggerServerEvent("QBCore:Server:RemoveItem", "moonshine", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] - 5)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        TriggerServerEvent('qb-hud:Server:RelieveStress', 20)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        SetPedMotionBlur(GetPlayerPed(-1), true)
        QBCore.Functions.Notify('You have liquid courage! (Armor)', 'luck')
        QBCore.Functions.Notify('You are extremely drunk.', 'error')
        while IsDrunk do 
            while true do 
                if luck <= 4 or DrinkCount >= 3 then
                    DoScreenFadeOut(1000)
                    QBCore.Functions.Notify('You went temporarily blind!', 'error')
                    Citizen.Wait(5000)
                    DoScreenFadeIn(1000)
                end
                break
            end
            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            AnimpostfxPlay('DeathFailMPIn', 10000, true)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ShakeGameplayCam('DRUNK_SHAKE', 0.8)
            TriggerServerEvent('hospital:server:SetArmor', 85)
            SetPedArmour(GetPlayerPed(-1), 85)
            RequestAnimSet('move_m@drunk@a')
            while not HasAnimSetLoaded('move_m@drunk@a') do
                Citizen.Wait(1)
            end
            SetPedMovementClipset(GetPlayerPed(-1), 'move_m@drunk@a', 1.0)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
            AnimpostfxStop('DeathFailMPIn')
            StopGameplayCamShaking(true)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)

            DrinkCount = DrinkCount - 1
            IsDrunk = false
        end 
	end)
end)

--- Speed Boost, +5 Hunger, -5 Thirst, 15 Stress ---
RegisterNetEvent('qb-moonshine:client:UseToplessGranny')
AddEventHandler('qb-moonshine:client:UseToplessGranny', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
	QBCore.Functions.Progressbar("use_shine", "Drinking ...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function()
        local luck = math.random(1, 100)
        local IsDrunk = true

        DrinkCount = DrinkCount + 1
		TriggerServerEvent("QBCore:Server:RemoveItem", "toplessgranny", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 5)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 5)
        TriggerServerEvent('qb-hud:Server:RelieveStress', 15)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        SetPedMotionBlur(GetPlayerPed(-1), true)
        QBCore.Functions.Notify('You feel high octane! (Speed)', 'luck')
        QBCore.Functions.Notify('You are extremely drunk.', 'error')
        while IsDrunk do 
            SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
            while true do 
                if DrinkCount >= 3 then
                    DoScreenFadeOut(1000)
                    QBCore.Functions.Notify('You went temporarily blind!', 'error')
                    Citizen.Wait(5000)
                    DoScreenFadeIn(1000)
                end
                break
            end
            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            AnimpostfxPlay('DMT_flight', 10000, true)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ShakeGameplayCam('DRUNK_SHAKE', 1.0)
            Citizen.Wait(4000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
            SetRunSprintMultiplierForPlayer(PlayerId(),1.00)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            Citizen.Wait(25000)
            AnimpostfxStop('DMT_flight')
            StopGameplayCamShaking(true)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)
            

            DrinkCount = DrinkCount - 1
            IsDrunk = false
        end
	end)
end)

--- +100HP, +25 Hunger, -5 Thirst, 10 Stress ---
RegisterNetEvent('qb-moonshine:client:UsePeachFurry')
AddEventHandler('qb-moonshine:client:UsePeachFurry', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
	QBCore.Functions.Progressbar("use_shine", "Drinking ...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function()
        local luck = math.random(1, 100)
        local IsDrunk = true

        DrinkCount = DrinkCount + 1
        SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 100)
		TriggerServerEvent("QBCore:Server:RemoveItem", "peachfurry", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 25)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 5)
        TriggerServerEvent('qb-hud:Server:RelieveStress', 10)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        SetPedMotionBlur(GetPlayerPed(-1), true)
        QBCore.Functions.Notify('You feel mighty peachy! (Health)', 'luck')
        QBCore.Functions.Notify('You are extremely drunk.', 'error')
        while IsDrunk do 
            while true do 
                if DrinkCount >= 3 then
                    DoScreenFadeOut(1000)
                    QBCore.Functions.Notify('You went temporarily blind!', 'error')
                    Citizen.Wait(5000)
                    DoScreenFadeIn(1000)
                end
                break
            end
            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            AnimpostfxPlay('DrugsTrevorClownsFight', 10000, true)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ShakeGameplayCam('DRUNK_SHAKE', 0.8)
            RequestAnimSet('move_m@drunk@a')
            while not HasAnimSetLoaded('move_m@drunk@a') do
                Citizen.Wait(1)
            end
            SetPedMovementClipset(GetPlayerPed(-1), 'move_m@drunk@a', 1.0)
            Citizen.Wait(4000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            Citizen.Wait(25000)
            AnimpostfxStop('DrugsTrevorClownsFight')
            StopGameplayCamShaking(true)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)

            DrinkCount = DrinkCount - 1
            IsDrunk = false
        end
	end)
end)




--- +50HP, +10 Hunger, -5 Thirst, 50 Stress ---
RegisterNetEvent('qb-moonshine:client:UseCherryBomb')
AddEventHandler('qb-moonshine:client:UseCherryBomb', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
	QBCore.Functions.Progressbar("use_shine", "Drinking ...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function()
        local luck = math.random(1, 100)
        local IsDrunk = true

        DrinkCount = DrinkCount + 1
        SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 50)
		TriggerServerEvent("QBCore:Server:RemoveItem", "cherrybomb", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 10)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 5)
        TriggerServerEvent('qb-hud:Server:RelieveStress', 50)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        SetPedMotionBlur(GetPlayerPed(-1), true)
        QBCore.Functions.Notify('You feel emboldened!', 'luck')
        QBCore.Functions.Notify('You are extremely drunk.', 'error')
        while IsDrunk do 
            while true do 
                if DrinkCount >= 3 then
                    DoScreenFadeOut(1000)
                    QBCore.Functions.Notify('You went temporarily blind!', 'error')
                    Citizen.Wait(5000)
                    DoScreenFadeIn(1000)
                end
                break
            end
            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            AnimpostfxPlay('PPPurple', 10000, true)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ShakeGameplayCam('DRUNK_SHAKE', 0.8)
            RequestAnimSet('move_m@drunk@a')
            while not HasAnimSetLoaded('move_m@drunk@a') do
                Citizen.Wait(1)
            end
            SetPedMovementClipset(GetPlayerPed(-1), 'move_m@drunk@a', 1.0)
            Citizen.Wait(4000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            Citizen.Wait(25000)
            AnimpostfxStop('PPPurple')
            StopGameplayCamShaking(true)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)

            DrinkCount = DrinkCount - 1
            IsDrunk = false
        end
	end)
end)

--- +20HP, +20 Hunger, +20 Thirst, 20 Stress ---
RegisterNetEvent('qb-moonshine:client:UseHolyWater')
AddEventHandler('qb-moonshine:client:UseHolyWater', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
	QBCore.Functions.Progressbar("use_shine", "Drinking ...", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
    }, {}, {}, function()
        local luck = math.random(1, 100)
        local IsDrunk = true

        DrinkCount = DrinkCount + 1
        SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 20)
		TriggerServerEvent("QBCore:Server:RemoveItem", "holywater", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 20)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 20)
        TriggerServerEvent('qb-hud:Server:RelieveStress', 20)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        SetPedMotionBlur(GetPlayerPed(-1), true)
        QBCore.Functions.Notify('You feel blessed!', 'luck')
        QBCore.Functions.Notify('You are extremely drunk.', 'error')
        while IsDrunk do 
            while true do 
                if DrinkCount >= 3 then
                    DoScreenFadeOut(1000)
                    QBCore.Functions.Notify('You went temporarily blind!', 'error')
                    Citizen.Wait(5000)
                    DoScreenFadeIn(1000)
                end
                break
            end
            Citizen.Wait(1000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            AnimpostfxPlay('DeadlineNeon', 10000, true)
            Citizen.Wait(9000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ShakeGameplayCam('DRUNK_SHAKE', 0.8)
            RequestAnimSet('move_m@drunk@a')
            while not HasAnimSetLoaded('move_m@drunk@a') do
                Citizen.Wait(1)
            end
            SetPedMovementClipset(GetPlayerPed(-1), 'move_m@drunk@a', 1.0)
            Citizen.Wait(4000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ResetPedMovementClipset(GetPlayerPed(-1), 0.0)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            Citizen.Wait(25000)
            AnimpostfxStop('DeadlineNeon')
            StopGameplayCamShaking(true)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)

            DrinkCount = DrinkCount - 1
            IsDrunk = false
        end
	end)
end)

--- Emails ---
RegisterNetEvent('qb-moonshine:client:larryEmail')
AddEventHandler('qb-moonshine:client:larryEmail', function()
    SetTimeout(math.random(2000, 5000), function()
        local charinfo = QBCore.Functions.GetPlayerData().charinfo

        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Larry",
            subject = "Howdy ".. charinfo.firstname .. "",
            message = "Im not as dumb as people think. I know why yall love my mash. Might wanna take a gander in the national park and some gas stations if ur just getn started ...",
            button = {}
        })
    end)
end)

RegisterNetEvent('qb-moonshine:client:hippieEmail')
AddEventHandler('qb-moonshine:client:hippieEmail', function()
    SetTimeout(math.random(2500, 5000), function()

        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Midnight",
            subject = "Well Hello",
            message = "Listen man, a few of us have some things going on and we need big coin.  Im selling some old family beverage recipes. High octane stuff. 5 racks and its yours.  Peace friend!",
            button = {}
        })
    end)
end)

--- Inventory Shop for Larry and Fruit PED ---
RegisterNetEvent("qb-moonshine:client:openStore")
AddEventHandler("qb-moonshine:client:openStore", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Larry The Farmer Guy", Config.Larry)
    CheckLarryStore()
end)

RegisterNetEvent("qb-moonshine:client:openfruitStore")
AddEventHandler("qb-moonshine:client:openfruitStore", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Fruit Stand", Config.FruitStand)
end)

--- Brew Moonshine, check to see if you have mash ---
RegisterNetEvent("qb-moonshine:client:brew")
AddEventHandler("qb-moonshine:client:brew", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            FillMash()
        else
            QBCore.Functions.Notify('You don\'t appear to have the right item(s).', 'error')
        end
    end, "mash")    
end)

--- Brew Recipes, checks to see if you have recipes ---
RegisterNetEvent("qb-moonshine:client:stewApple")
AddEventHandler("qb-moonshine:client:stewApple", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            StewApple()   
        else
            EvapBrew()  
        end
    end, "shinerecipe")    
end)

RegisterNetEvent("qb-moonshine:client:stewPeach")
AddEventHandler("qb-moonshine:client:stewPeach", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            StewPeach()   
        else
            EvapBrew()  
        end
    end, "shinerecipe")    
end)

RegisterNetEvent("qb-moonshine:client:stewCherries")
AddEventHandler("qb-moonshine:client:stewCherries", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            StewCherries()   
        else
            EvapBrew()  
        end
    end, "shinerecipe")    
end)

RegisterNetEvent("qb-moonshine:client:stewHoly")
AddEventHandler("qb-moonshine:client:stewHoly", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then 
            Distill()   
        else
            EvapBrew()  
        end
    end, "shinerecipe")    
end)

--- Midnight Hippie PED Money Check and Emails ---
RegisterNetEvent("qb-moonshine:client:tradeHippie")
AddEventHandler("qb-moonshine:client:tradeHippie", function()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:HasMoney', function(HasMoney)
        if HasMoney then
            QBCore.Functions.Notify('You paid Midnight $5000.', 'success')
            TriggerServerEvent('qb-moonshine:server:AddItem', 'shinerecipe', 1)
            SetTimeout(math.random(4000, 8000), function()
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Midnight",
                    subject = "Hell yeah!",
                    message = "This is going to help alot man ... you dont even know.  Those recipes are pretty wild if you know what you are doing man, so enjoy!  -Midnight",
                    button = {}
                })
            end)
        else
            QBCore.Functions.Notify('You don\'t have the $5000.', 'error')
            SetTimeout(math.random(4000, 8000), function()
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Midnight",
                    subject = "Set in stone.",
                    message = "Sorry friend but five lids is the best I can do. This isnt just a meatloaf recipe. Its worth, promise.  Mmmmmm ... dam ... moms meatloaf  -M",
                    button = {}
                })
            end)
        end
    end)
end)

--- Larry The Farmer Guy PED Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("mashsell", vector3(1233.039, 1852.777, 79.37341), 1.0, 1.0, {
        name = "mashsell",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:larryEmail",
                icon = "fa fa-envelope",
                label = "Exchange Emails",
            },
            {
                event = "qb-moonshine:client:openStore",
                icon = "fas fa-hand-holding-usd",
                label = "Buy Goods",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Prison Fruit Stand PED Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("fruitsell", vector3(1478.234,2722.251,37.63801), 1.0, 1.0, {
        name = "fruitsell",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:openfruitStore",
                icon = "fas fa-hand-holding-usd",
                label = "Buy Goods",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Hippie Park PED Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("hippietrade", vector3(2477.537, 3761.575, 41.92), 1.0, 1.0, {
        name = "hippietrade",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:hippieEmail",
                icon = "fa fa-envelope",
                label = "Exchange Emails",
            },
            {
                event = "qb-moonshine:client:tradeHippie",
                icon = "fas fa-hand-holding-usd",
                label = "Give $5,000",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- National Park Hotdog Stand Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("distillspotone", vector3(2083.136, 3553.394, 42.23972), 1.0, 1.0, {
        name = "distillspotone",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:brew",
                icon = "fa fa-plus",
                label = "Fill",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Flywheel/Global Oil Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("distillspottwo", vector3(1684.928, 3288.924, 41.14656), 1.0, 1.0, {
        name = "distillspottwo",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:brew",
                icon = "fa fa-plus",
                label = "Fill",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Old Grainery Still #1 Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("distillspotthree", vector3(1538.902, 1699.244, 109.7629), 1.0, 1.0, {
        name = "distillspotthree",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:brew",
                icon = "fa fa-plus",
                label = "Fill",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Old Grainery Still #2 Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("distillspotfour", vector3(1536.502, 1699.754, 109.721), 1.0, 1.0, {
        name = "distillspotfour",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:brew",
                icon = "fa fa-plus",
                label = "Fill",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Old Grainery Cook Pot Zone ---
Citizen.CreateThread(function()
    exports["qb-target"]:AddBoxZone("stewspot", vector3(1538.983, 1700.254, 109.6786), 1.0, 1.0, {
        name = "stewspot",
        heading = 0,
        debugPoly = false,
    }, {
        options = {
            {
                event = "qb-moonshine:client:stewApple",
                icon = "fa fa-plus",
                label = "Apple",
            },
            {
                event = "qb-moonshine:client:stewPeach",
                icon = "fa fa-plus",
                label = "Peach",
            },
            {
                event = "qb-moonshine:client:stewCherries",
                icon = "fa fa-plus",
                label = "Cherries",
            },
            {
                event = "qb-moonshine:client:stewHoly",
                icon = "fa fa-plus",
                label = "Purify",
            },
        },
        job = {"all"},
        distance = 1.5
    })
end)

--- Animation Functions ---
function PreparingAnimCheck()
    
    Citizen.CreateThread(function()
        while true do
            local ped = GetPlayerPed(-1)

            if PreparingMash then
                if not IsEntityPlayingAnim(ped, 'creatures@rottweiler@tricks@', 'petting_franklin', 3) then
                    LoadAnim('creatures@rottweiler@tricks@')
                    TaskPlayAnim(ped, 'creatures@rottweiler@tricks@', 'petting_franklin', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            elseif CookingMash then 
                if not IsEntityPlayingAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 3) then
                    LoadAnim('amb@prop_human_bbq@male@idle_a')
                    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                ClearPedTasksImmediately(ped)
                break
            end
            Citizen.Wait(200)
        end
    end)
end

function PrepareFillAnim()
    local ped = GetPlayerPed(-1)

    ClearPedTasksImmediately(ped)
    LoadAnim('creatures@rottweiler@tricks@')
    TaskPlayAnim(ped, 'creatures@rottweiler@tricks@', 'petting_franklin', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    PreparingMash = true
    PreparingAnimCheck()
end

function PrepareCookAnim()
    local ped = GetPlayerPed(-1)

    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    CookingMash = true
    PreparingAnimCheck()
end

--- Moonshine Making Functions, checks for proper items ---
function FillMash()
    PrepareFillAnim()
    TriggerServerEvent('QBCore:Server:RemoveItem', "mash", 1)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["mash"], "remove")
    QBCore.Functions.Progressbar("shine_filling", "Filling ...", 7000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    })
    Citizen.Wait(7500)
    PreparingMash = false
    CookMash()
end

function CookMash()
    local randomtime = math.random(10000, 25000)

    PrepareCookAnim()
    QBCore.Functions.Progressbar("shine_distilling", "Distilling ...", randomtime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    })
    Citizen.Wait(randomtime + 500)
    QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    })
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
    Citizen.Wait(10000)
    TriggerServerEvent('QBCore:Server:AddItem', "moonshine", 2)
	TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "add")
    QBCore.Functions.Notify('You made 2 jugs of White Lightning!', 'success')
    CookingMash = false
    CheckCookBefore()
end

--- Check if player cooked moonshine before, if not, send last Larry clue email  ---
function CheckCookBefore()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["mademoonshine"] == nil then 
            local charinfo = QBCore.Functions.GetPlayerData().charinfo

            SetTimeout(math.random(3000, 6000), function()
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "Larry",
                    subject = "One more thing ...",
                    message = "I got a son who ran off with them dam hippies and now goes by the name Midnight. If you see him, please tell him his ma misses him.  Ur a pal " .. charinfo.firstname .."!",
                    button = {}
                }) 
            end)
            TriggerServerEvent("QBCore:Server:SetMetaData", "mademoonshine", true) 
        end  
    end)
end

--- Check if player has checked Larry store, if so, send Prison Fruit Stand clue email ---
function CheckLarryStore()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["larrystore"] == nil then 
            local charinfo = QBCore.Functions.GetPlayerData().charinfo

            SetTimeout(math.random(15000, 30000), function()
                local charinfo = QBCore.Functions.GetPlayerData().charinfo
            
                TriggerServerEvent('qb-phone:server:sendNewMail', {
                    sender = "BB Fruit Stand",
                    subject = "CC: Fruit Sale",
                    message = "Hola! We just wanted everyone to know that we have fresh batches of apples, peaches, and cherries on sale at our fruit stand on Route 68, by the prison.  Stop by anytime!",
                    button = {}
                })
            end)
            TriggerServerEvent("QBCore:Server:SetMetaData", "larrystore", true) 
        end  
    end)
end

--- Moonshine Recipe Making Functions, checks for proper items ---
function StewApple()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:get:apple:recipe', function(HasApple)
        if HasApple then 
            local randomtime = math.random(10000, 25000)

            TriggerServerEvent('QBCore:Server:RemoveItem', "moonshine", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "remove")
            TriggerServerEvent('QBCore:Server:RemoveItem', "apple", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["apple"], "remove")
            PrepareCookAnim()
            QBCore.Functions.Progressbar("stew_apple", "Stewing Apple ...", randomtime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            Citizen.Wait(randomtime + 500)
            QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
            Citizen.Wait(10000)
            QBCore.Functions.Notify('You made 2 jars of Topless Granny!', 'luck')
            TriggerServerEvent('QBCore:Server:AddItem', "toplessgranny", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["toplessgranny"], "add")
            CookingMash = false
        else 
            QBCore.Functions.Notify('You are missing ingredients.', 'error')
        end
    end) 
end

function StewPeach()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:get:peach:recipe', function(HasPeach)
        if HasPeach then
            local randomtime = math.random(10000, 25000)

            TriggerServerEvent('QBCore:Server:RemoveItem', "moonshine", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "remove")
            TriggerServerEvent('QBCore:Server:RemoveItem', "peach", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["peach"], "remove") 
            PrepareCookAnim()
            QBCore.Functions.Progressbar("stew_peach", "Stewing Peach ...", randomtime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            Citizen.Wait(randomtime + 500)
            QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
            Citizen.Wait(10000)
            QBCore.Functions.Notify('You made 2 jars of Peach Furry!', 'luck')
            TriggerServerEvent('QBCore:Server:AddItem', "peachfurry", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["peachfurry"], "add")
            CookingMash = false
        else 
            QBCore.Functions.Notify('You are missing ingredients.', 'error')
        end
    end)
end

function StewCherries()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:get:cherries:recipe', function(HasCherries)
        if HasCherries then
            local randomtime = math.random(10000, 25000)

            TriggerServerEvent('QBCore:Server:RemoveItem', "moonshine", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "remove")
            TriggerServerEvent('QBCore:Server:RemoveItem', "cherries", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cherries"], "remove")
            PrepareCookAnim()
            QBCore.Functions.Progressbar("stew_cherries", "Stewing Cherries ...", randomtime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            Citizen.Wait(randomtime + 500)
            QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
            Citizen.Wait(10000)
            QBCore.Functions.Notify('You made 2 jars of Cherry Bomb!', 'luck')
            TriggerServerEvent('QBCore:Server:AddItem', "cherrybomb", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cherrybomb"], "add")
            CookingMash = false
        else 
            QBCore.Functions.Notify('You are missing ingredients.', 'error')
        end
    end)
end

function Distill()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:check:shine', function(HasMoonS)
        if HasMoonS then
            local randomtime = math.random(10000, 25000)

            PrepareCookAnim()
            TriggerServerEvent('QBCore:Server:RemoveItem', "moonshine", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "remove")
            QBCore.Functions.Progressbar("moon_shine", "Purifying ...", randomtime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            Citizen.Wait(randomtime + 500)
            QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
            Citizen.Wait(10000)
            QBCore.Functions.Notify('You made 2 jars of Holy Water!', 'luck')
            TriggerServerEvent('QBCore:Server:AddItem', "holywater", 2)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["holywater"], "add")
            CookingMash = false
        else 
            QBCore.Functions.Notify('You are missing ingredients.', 'error')
        end
    end) 
end

function EvapBrew()
    QBCore.Functions.TriggerCallback('qb-moonshine:server:check:shine', function(HasMoonS)
        if HasMoonS then 
            local randomtime = math.random(10000, 25000)

            TriggerServerEvent('QBCore:Server:RemoveItem', "moonshine", 1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine"], "remove")
            PrepareCookAnim()
            QBCore.Functions.Progressbar("moon_shine", "Purifying ...", randomtime, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            Citizen.Wait(randomtime + 500)
            QBCore.Functions.Progressbar("moon_shine", "Lowering Heat and Pressure ...", 10000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            })
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "boil", 0.2)
            Citizen.Wait(10000)
            QBCore.Functions.Notify('Moonshine evaporated!', 'error')
            QBCore.Functions.Notify('You didn\'t have the right ingredients.', 'error')
            CookingMash = false   
        else
            QBCore.Functions.Notify('You are missing ingredients.', 'error')
        end
    end)   
end
--h--