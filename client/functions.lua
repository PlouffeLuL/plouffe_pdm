local Callback = exports.plouffe_lib:Get("Callback")
local Utils = exports.plouffe_lib:Get("Utils")

function PdmFnc:Start()
    TriggerEvent('ooc_core:getCore', function(Core)
        while not Core.Player:IsPlayerLoaded() do
            Wait(500)
        end

        Pdm.Player = Core.Player:GetPlayerData()

        self:ExportsAllZones()
        self:RegisterAllEvents()
        self:RefreshDisplay()
    end)
end

function PdmFnc:ExportsAllZones()
    for k,v in pairs(Pdm.Zones) do
        exports.plouffe_lib:ValidateZoneData(v)
    end
end

function PdmFnc:RegisterAllEvents()
    AddEventHandler('plouffe_lib:setGroup', function(data)
        Pdm.Player[data.type] = data
    end)

    RegisterNetEvent("plouffe_lib:inVehicle", function(inVehicle, vehicleId)
        Pdm.Utils.inCar = inVehicle
        Pdm.Utils.carId = vehicleId
    end)

    RegisterNetEvent("plouffe_lib:hasWeapon", function(isArmed, weaponHash)
        Pdm.Utils.isArmed = isArmed
        Pdm.Utils.currentWeaponHash = weaponHash
    end)

    RegisterNetEvent("plouffe_pdm:on_zones", function(params)
        if self[params.fnc] then
            self[params.fnc](self,params)
        end
    end)

    RegisterNetEvent("plouffe_pdm:ClientCallback", function(data)
        if data.fnc then
            if self[data.fnc] then
                TriggerServerEvent("plouffe_pdm:ClientCallback:server", data, self[data.fnc](self,data))
            end
        end
    end)

    RegisterNetEvent("plouffe_pdm:sync_new_stock", function(vehicle)
        self:AddNewStock(vehicle)
    end)

    RegisterNetEvent("plouffe_pdm:remove_stock", function(vehicle)
        self:RemoveStock(vehicle)
    end)

    RegisterNetEvent("plouffe_pdm:sync_new_display", function(vehicle)
        self:SyncNewDisplay(vehicle)
    end)

    RegisterNetEvent("plouffe_pdm:remove_from_display", function(vehicle)
        self:RemoveFromDisplay(vehicle)
    end)

    RegisterNetEvent("plouffe_pdm:entered_shop_zone", function(vehicle)
        self:RefreshDisplay()
    end)

    RegisterNetEvent("plouffe_pdm:left_shop_zone", function(vehicle)
        self:DeleteAllDisplay()
    end)

    RegisterNetEvent("plouffe_pdm:replace_vehicles", function(vehicle)
        self:ReplaceVehicles()
    end)

    RegisterNetEvent("plouffe_pdm:spawn_my_new_car", function(model,props)
        self:SpawnNewCar(model,props)
    end)
end

function PdmFnc:GetarrayLenght(a)
    local cb = 0
    for k,v in pairs(a) do
        cb = cb + 1
    end
    return cb
end

function PdmFnc:AlphabeticArray(a)
    local sortedArray = {}
    local indexArray = {}
    local elements = {}

    for k,v in pairs(a) do
        if v.header then
            sortedArray[v.header] = v
            table.insert(indexArray, v.header)
        end
    end

    table.sort(indexArray)

    for k,v in pairs(indexArray) do
        table.insert(elements, sortedArray[v])
    end

    return elements
end

function PdmFnc:StrPrice(price)
    local price = tostring(price)
    local strPrice = ""
    local space = 0

    for i = price:len(), 0, -1 do
        space = space + 1
        local c = price:sub(i,i)
        strPrice = c..strPrice
        if space == 3 then
            strPrice = " "..strPrice
            space = 0
        end
    end

    return strPrice
end

function PdmFnc:RequestModel(model)
    CreateThread(function()
        RequestModel(model)
    end)
end

function PdmFnc:AssureModel(model)
    local breakCount = 10000
    local requestStart = GetGameTimer()

    if type(model) == "string" then
        model = GetHashKey(model)
    end

    self:RequestModel(model)

    while not HasModelLoaded(model) and GetGameTimer() - requestStart < breakCount do
        self:RequestModel(model)
        Wait(0)
    end

    return HasModelLoaded(model)
end

function PdmFnc:PlayAnim(type,dict,anim,flag,time,disablemovement)
    Pdm.Utils.ped = PlayerPedId()
    Pdm.Utils.pedCoords = GetEntityCoords(Pdm.Utils.ped)

    if type == "anim" then
        self:AssureAnim(dict)

        TaskPlayAnim(Pdm.Utils.ped, dict, anim, 50.0, 50.0, time, flag, 0, false, false, false)

        CreateThread(function()
            while Pdm.Utils.forceAnim and not LocalPlayer.state.dead do
                Wait(0)
                if not IsEntityPlayingAnim(Pdm.Utils.ped, dict, anim, 3) then
                    TaskPlayAnim(Pdm.Utils.ped, dict, anim, 50.0, 50.0, time, flag, 0, false, false, false)
                end
            end

            if LocalPlayer.state.dead and Pdm.Utils.forceAnim then
                Pdm.Utils.forceAnim = false
            end

            StopAnimTask(Pdm.Utils.ped, dict, anim, 1.0)
        end)
    elseif type == "scenario" then
        TaskStartScenarioInPlace(Pdm.Utils.ped, dict, 0, true)

        CreateThread(function()
            while Pdm.Utils.forceAnim and not LocalPlayer.state.dead do
                Wait(0)
            end

            if LocalPlayer.state.dead and Pdm.Utils.forceAnim then
                Pdm.Utils.forceAnim = false
            end

            ClearPedTasks(Pdm.Utils.ped)
        end)
    end

    CreateThread(function()
        while disablemovement and Pdm.Utils.forceAnim and not LocalPlayer.state.dead do
            Wait(0)
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 21, true)
        end
    end)
end

function PdmFnc:AssureAnim(dict)
    local time = GetGameTimer()
    self:RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) and GetGameTimer() - time <= 5000 do
        self:RequestAnimDict(dict)
        Wait(0)
    end
end

function PdmFnc:RequestAnimDict(dict)
    CreateThread(function()
        RequestAnimDict(dict)
    end)
end

function PdmFnc:IsVehicleInStock(model,label,price)
    for k,v in pairs(Pdm.StockVehicles) do
        if v.model == model and v.label == label and v.price == price then
            return true, k
        end
    end
end

function PdmFnc:GetDeliveryTime(class)
    local time = Pdm.DeliveryTimes.set[class]
    return math.ceil(time / (60 * 60))
end

function PdmFnc:CanOrderVehicles()
    return Pdm.PlaceOrderGrades[tostring(Pdm.Player.job.grade)] ~= nil
end

function PdmFnc:OpenEmployeeMenu(params)
    if Pdm.Utils.boss_grade == Pdm.Player.job.grade then
        exports.ooc_menu:Open(Pdm.Menu.boss, function(selection)
            if not selection then
                return
            end

            if self[selection.fnc] then
                self[selection.fnc](self,selection)
            end
        end)
    else
        exports.ooc_menu:Open(Pdm.Menu.employee, function(selection)
            if not selection then
                return
            end

            if self[selection.fnc] then
                self[selection.fnc](self,selection)
            end
        end)
    end
end

function PdmFnc:OpenClassList(params)
    exports.ooc_menu:Open(Pdm.Menu.class_demo, function(selection)
        if not selection then
            return
        end

        if self[selection.fnc] then
            self[selection.fnc](self,selection.class)
        end
    end)
end

function PdmFnc:OpenSpecificClassVehicles(class)
    local menu = {}
    local id = 0

    for k,v in pairs(Pdm.Vehicles_list[class]) do
        id = id + 1
        table.insert(menu,{
            id = id,
            header = v.label,
            txt = ("Prix: %s %s"):format(self:StrPrice(v.price), "$"),
            params = {
                event = "",
                args = v
            }
        })
    end

    exports.ooc_menu:Open(self:AlphabeticArray(menu), function(vehicle)
        menu = {
            {
                id = 1,
                header = "Sortir comme démonstrateur",
                txt = "Le véhicule sera placer dans le garage",
                params = {
                    event = "",
                    args = {
                        choice = "demo"
                    }
                }
            }
        }

        if self:CanOrderVehicles() then
            table.insert(menu,{
                id = 2,
                header = "Commander le véhicule",
                txt = "Placer une comande pour ce véhicule",
                params = {
                    event = "",
                    args = {
                        choice = "order"
                    }
                }
            })
        end

        exports.ooc_menu:Open(menu, function(params)
            if not params then
                return
            end

            if params.choice == "demo" then
                TriggerServerEvent("plouffe_pdm:ShowDemoVehicle",vehicle,Pdm.Utils.MyAuthKey)
            elseif params.choice == "order" then
                menu = {
                    {
                        id = 1,
                        header = "Confirmer que vous voulez passer cette commande",
                        txt = "Verifier les informations",
                        params = {
                            event = "",
                            args = {
                            }
                        }
                    },

                    {
                        id = 2,
                        header = vehicle.label,
                        txt = "Model du véhicule",
                        params = {
                            event = "",
                            args = {
                            }
                        }
                    },

                    {
                        id = 3,
                        header = ("%s %s"):format(self:StrPrice(vehicle.price), "$"),
                        txt = "Prix du véhicule",
                        params = {
                            event = "",
                            args = {
                            }
                        }
                    },

                    {
                        id = 4,
                        header = ("%s Heurs"):format(self:GetDeliveryTime(vehicle.class)),
                        txt = "Délai estimer pour la livraison",
                        params = {
                            event = "",
                            args = {
                            }
                        }
                    },

                    {
                        id = 5,
                        header = "Confirmer",
                        txt = "Passer la commande",
                        params = {
                            event = "",
                            args = {
                                confirmed = true
                            }
                        }
                    }
                }

                exports.ooc_menu:Open(menu, function(params)
                    if not params then
                        return
                    end

                    if params.confirmed then
                        TriggerServerEvent("plouffe_pdm:OrderVehicle",vehicle,Pdm.Utils.MyAuthKey)
                    end
                end)

            end
        end)
    end)
end

function PdmFnc:RemoveDemoCar()
    TriggerServerEvent("plouffe_pdm:RemoveDemo",Pdm.Utils.MyAuthKey)
end

function PdmFnc:AddNewStock(vehicle)
    table.insert(Pdm.StockVehicles, {
        model = vehicle.model,
        label = vehicle.label,
        price = vehicle.price,
        props = vehicle.props
    })
end

function PdmFnc:OpenStockMenu()
    local menu = {}
    local id = 0

    for k,v in pairs(Pdm.StockVehicles) do
        id = id + 1
        table.insert(menu,{
            id = id,
            header = v.label,
            txt = ("Prix: %s %s"):format(self:StrPrice(v.price), "$"),
            params = {
                event = "",
                args = v
            }
        })
    end

    if #menu > 0 then
        exports.ooc_menu:Open(self:AlphabeticArray(menu), function(vehicle)
            menu = {
                {
                    id = 1,
                    header = "Vendre",
                    txt = "Vendre ce véhicule",
                    params = {
                        event = "",
                        args = {
                            fnc = "SellVehicle",
                            vehicle = vehicle
                        }
                    }
                },

                {
                    id = 2,
                    header = "Placer comme démonstrateur",
                    txt = "Afficher ce vehicle dans le concess",
                    params = {
                        event = "",
                        args = {
                            fnc = "DisplayVehicle",
                            vehicle = vehicle
                        }
                    }
                }
            }

            exports.ooc_menu:Open(menu, function(params)
                if not params then
                    return
                end

                if self[params.fnc] then
                    self[params.fnc](self,params)
                end
            end)
        end)
    else
        Utils:Notify("Il n'y a aucun véhicule en stock présentement", "error")
    end
end

function PdmFnc:DisplayVehicle(params)
    if Pdm.DisplayInfo.inDisplay then
        return self:ResetPlacer()
    end

    local model = params.vehicle.model

    if self:AssureModel(model) then
        local init = GetGameTimer()

        Pdm.Utils.ped = PlayerPedId()
        Pdm.Utils.pedCoords = GetEntityCoords(Pdm.Utils.ped)
        Pdm.DisplayInfo.vehicleId = CreateVehicle(GetHashKey(model), Pdm.Demo.coords, Pdm.Demo.heading, false, false)
        Pdm.DisplayInfo.vehicle_data = params.vehicle

        while not DoesEntityExist(Pdm.DisplayInfo.vehicleId) and GetGameTimer() - init < 1000 * 10 do
            Wait(100)
        end

        if DoesEntityExist(Pdm.DisplayInfo.vehicleId) then
            if not params.vehicle.props.plate then
                Pdm.DisplayInfo.vehicle_data.props = Utils:GetVehicleProps(Pdm.DisplayInfo.vehicleId)
            else
                Utils:SetVehicleProps(Pdm.DisplayInfo.vehicleId, params.vehicle.props)
                Pdm.DisplayInfo.vehicle_data.props = params.vehicle.props
            end

            Pdm.DisplayInfo.inDisplay = true

            CreateThread(function()
                while Pdm.DisplayInfo.inDisplay do
                    self:PlacerLabel()
                    self:ProcessControl()
                    self:PlacerNative()
                    Wait(0)
                end

                self:ResetPlacer()
            end)
        end
    end
end

function PdmFnc:PlacerNative()
    SetEntityCollision(Pdm.DisplayInfo.vehicleId, false, true)
    FreezeEntityPosition(Pdm.DisplayInfo.vehicleId, true)
    DisableControlAction(0, Pdm.DisplayInfo.keys['LEFTSHIFT'], true)
    Pdm.DisplayInfo.vehicle_data.coords = GetEntityCoords(Pdm.DisplayInfo.vehicleId)
    Pdm.DisplayInfo.vehicle_data.heading = GetEntityHeading(Pdm.DisplayInfo.vehicleId)
end

function PdmFnc:ResetPlacer()
    Pdm.DisplayInfo.inDisplay = false

    Wait(100)

    DeleteEntity(Pdm.DisplayInfo.vehicleId)

    Pdm.DisplayInfo.currentSpeed = 0.1
    Pdm.DisplayInfo.vehicleId = 0
    Pdm.DisplayInfo.vehicle_data = {}

    return true
end

function PdmFnc:PlacerLabel()
    local scaleform = RequestScaleformMovie("instructional_buttons")

    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end

    BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["K"], true))
    self:LabelMessage("Annuler")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["SPACE"], true))
    self:LabelMessage("Monter")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["Z"], true))
    self:LabelMessage("Descendre")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["N4"], true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["N5"], true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["N6"], true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["N8"], true))
    self:LabelMessage("Déplacement")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, Pdm.DisplayInfo.keys["E"], true))
    self:LabelMessage("Confirmer l'emplacement")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
end

function PdmFnc:ProcessControl()
    local xoff = 0.0
    local yoff = 0.0
    local zoff = 0.0

    if IsControlJustPressed(1, Pdm.DisplayInfo.keys['WHEELDOWN']) then
        Pdm.DisplayInfo.currentSpeed = Pdm.DisplayInfo.currentSpeed - 0.1
        if Pdm.DisplayInfo.currentSpeed <= 0.0 then
            Pdm.DisplayInfo.currentSpeed = 0.1
        end
    end

    if IsControlJustPressed(1, Pdm.DisplayInfo.keys['WHEELUP']) then
        Pdm.DisplayInfo.currentSpeed = Pdm.DisplayInfo.currentSpeed + 0.1
        if Pdm.DisplayInfo.currentSpeed > 1.0 then
            Pdm.DisplayInfo.currentSpeed = 1.0
        end
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys['N9']) then
        local currentRotation = GetEntityRotation(Pdm.DisplayInfo.vehicleId, 2)
        local newRotation = vector3(currentRotation.x, currentRotation.y, currentRotation.z - (Pdm.DisplayInfo.offSets.yaw * (Pdm.DisplayInfo.currentSpeed + 0.0)))
        SetEntityRotation(Pdm.DisplayInfo.vehicleId, newRotation, 2)
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys['N7']) then
        local currentRotation = GetEntityRotation(Pdm.DisplayInfo.vehicleId, 2)
        local newRotation = vector3(currentRotation.x, currentRotation.y, currentRotation.z + (Pdm.DisplayInfo.offSets.yaw * (Pdm.DisplayInfo.currentSpeed + 0.0)))
        SetEntityRotation(Pdm.DisplayInfo.vehicleId, newRotation, 2)
    end

    if IsControlJustPressed(0, Pdm.DisplayInfo.keys["K"]) then
        exports.ooc_menu:Open(Pdm.Menu.cancel_creator, function(menuParams)
            if not menuParams then
                return
            end

            if menuParams.confirm then
                self:ResetPlacer()
            end
        end)
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["N8"]) then
        yoff = Pdm.DisplayInfo.offSets.y
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["N5"]) then
        yoff = - Pdm.DisplayInfo.offSets.y
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["N4"]) then
        xoff = Pdm.DisplayInfo.offSets.x
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["N6"]) then
        xoff = - Pdm.DisplayInfo.offSets.x
    end

    if IsControlJustPressed(0, Pdm.DisplayInfo.keys["E"]) then
        exports.ooc_menu:Open(Pdm.Menu.confirm_placement, function(menuParams)
            if not menuParams then
                return
            end

            if menuParams.confirm then
                TriggerServerEvent("plouffe_pdm:add_new_display", Pdm.DisplayInfo.vehicle_data, Pdm.Utils.MyAuthKey)
                self:ResetPlacer()
            end
        end)
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["SPACE"]) then
        zoff = Pdm.DisplayInfo.offSets.z
    end

    if IsControlPressed(0, Pdm.DisplayInfo.keys["Z"]) then
        zoff = -Pdm.DisplayInfo.offSets.z
    end

    local newPos = GetOffsetFromEntityInWorldCoords(Pdm.DisplayInfo.vehicleId, xoff * (Pdm.DisplayInfo.currentSpeed + 0.0), yoff * (Pdm.DisplayInfo.currentSpeed + 0.0), zoff * (Pdm.DisplayInfo.currentSpeed + 0.0))

    if #(vector3(-39.179607391357, -1100.7562255859, 26.422357559204) - newPos) <= 20.0 then
        SetEntityCoordsNoOffset(Pdm.DisplayInfo.vehicleId, newPos.x, newPos.y, newPos.z, true, true, true)
    end
end

function PdmFnc:LabelMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function PdmFnc:CreateDisplay(vehicle)
    if self:AssureModel(vehicle.model) then
        local init = GetGameTimer()

        local vehicle_id = CreateVehicle(GetHashKey(vehicle.model), vehicle.coords, vehicle.heading, false, false)

        while not DoesEntityExist(vehicle_id) and GetGameTimer() - init < 1000 * 10 do
            Wait(100)
        end

        Utils:SetVehicleProps(vehicle_id, vehicle.props)

        FreezeEntityPosition(vehicle_id, true)
        SetVehicleDirtLevel(vehicle_id, 0.0)
        WashDecalsFromVehicle(vehicle_id,0)
        SetVehicleDoorsLocked(vehicle_id,2)

        while not HasCollisionLoadedAroundEntity(vehicle_id) and GetGameTimer() - init < 1000 * 10 do
            Wait(100)
        end

        SetEntityCoords(vehicle_id, vehicle.coords.x,vehicle.coords.y,vehicle.coords.z - 5)
        SetVehicleOnGroundProperly(vehicle_id)

        return vehicle_id
    end
    return 0
end

function PdmFnc:DeleteAllDisplay()
    for k,v in pairs(Pdm.Displayed) do
        DeleteEntity(v.entity_id)
    end

    Pdm.Displayed = {}
end

function PdmFnc:RefreshDisplay()
    if exports.plouffe_lib:IsInZone("pdm_auto_zone") then
        self:DeleteAllDisplay()

        for k,v in pairs(Pdm.Display) do
            table.insert(Pdm.Displayed, {entity_id = self:CreateDisplay(v)})
        end
    end
end

function PdmFnc:RemoveStock(vehicle)
    local exists, index = self:IsVehicleInStock(vehicle.model,vehicle.label,vehicle.price)

    if exists then
        table.remove(Pdm.StockVehicles,index)
    end
end

function PdmFnc:SyncNewDisplay(vehicle)
    table.insert(Pdm.Display, vehicle)

    self:RefreshDisplay()
end

function PdmFnc:RemoveFromDisplay(vehicle)
    for k,v in pairs(Pdm.Display) do
        if v.props.plate == vehicle.props.plate then
            table.remove(Pdm.Display, k)
            break
        end
    end

    self:RefreshDisplay()
end

function PdmFnc:ReplaceVehicles()
    for k,v in pairs(Pdm.Displayed) do
        SetVehicleOnGroundProperly(v.entity_id)
    end
end

function PdmFnc:RemoveDisplay()
    local menu = {}
    local id = 0

    for k,v in pairs(Pdm.Display) do
        id = id + 1
        table.insert(menu,{
            id = id,
            header = v.label,
            txt = ("Plaque: %s"):format(v.props.plate),
            params = {
                event = "",
                args = v
            }
        })
    end

    if #menu > 0 then
        exports.ooc_menu:Open(self:AlphabeticArray(menu), function(vehicle)
            menu = {
                {
                    id = 1,
                    header = ("Retirer: %s , plaque: %s"):format(vehicle.label, vehicle.props.plate),
                    txt = "Appuier sur OUI pour confirmer",
                    params = {
                        event = "",
                        args = {
                        }
                    }
                },
                {
                    id = 2,
                    header = "OUI",
                    txt = "Confirmer ",
                    params = {
                        event = "",
                        args = {
                            confirm = true
                        }
                    }
                },
                {
                    id = 3,
                    header = "NON",
                    txt = "Annuler",
                    params = {
                        event = "",
                        args = {
                        }
                    }
                }
            }
            exports.ooc_menu:Open(menu, function(params)
                if not params then
                    return
                end

                if params.confirm then
                    TriggerServerEvent("plouffe_pdm:remove_display", vehicle, Pdm.Utils.MyAuthKey)
                end
            end)
        end)
    else
        Utils:Notify("Il n'y a aucun véhicule sur le plancher", "error")
    end
end

function PdmFnc:OpenBilling()
    exports.plouffe_society:OpenBillMenu()
end

function PdmFnc:OpenBossMenu()
    exports.plouffe_society:OpenBossMenu()
end

function PdmFnc:AddOwnedVehicleToInventory()
    TriggerServerEvent("plouffe_pdm:add_owned_vehicle_to_inventory", Pdm.Utils.MyAuthKey)
end

function PdmFnc:GetLabelAndModel(data)
    local modelStr = GetDisplayNameFromVehicleModel(data.model)
    local labelStr = "NULL"
    local price = ""

    if not modelStr then
        modelStr = data.model
    else
        modelStr = modelStr:lower()
        labelStr = GetLabelText(modelStr)
    end

    exports.ooc_dialog:Open({
        rows = {
            {
                id = 0,
                txt = "Prix "
            }
        }
    }, function(data)
        if not data then
            price = nil
            return
        end

        local amount = tonumber(data[1].input)

        if not amount or (type(amount) == "number" and amount <= 0) then
            price = nil
            return
        end

        price = amount
    end)

    while price == "" do
        Wait(0)
    end

    if not price then
        price = 1
    end

    if not labelStr or labelStr == "NULL" then
        labelStr = modelStr
    end

    return labelStr, modelStr, price
end

function PdmFnc:SellVehicle(params)
    local closestPlayer, closestDistance = Utils:GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local name = GetPlayerName(closestPlayer)
        exports.ooc_menu:Open({
            {
                id = 1,
                header = ("Confirmer les informations"),
                txt = "Selectioner 'Oui' pour comfirmer",
                params = {
                    event = "",
                    args = {
                    }
                }
            },

            {
                id = 2,
                header = ("Nom: %s"):format(name),
                txt = "Nom de l'acheteur",
                params = {
                    event = "",
                    args = {
                    }
                }
            },

            {
                id = 3,
                header = ("Model: %s"):format(params.vehicle.label),
                txt = "Model du véhicule",
                params = {
                    event = "",
                    args = {
                    }
                }
            },

            {
                id = 4,
                header = ("Plaque: %s"):format(params.vehicle.props.plate),
                txt = "Plaque du véhicule",
                params = {
                    event = "",
                    args = {
                    }
                }
            },

            {
                id = 5,
                header = "Oui",
                txt = "Confirmer la vente",
                params = {
                    event = "",
                    args = {
                        validate = true
                    }
                }
            },

            {
                id = 6,
                header = "Non",
                txt = "Fermer le menu",
                params = {
                    event = "",
                    args = {
                    }
                }
            }
        }, function(menu)
            if not menu then
                return
            end

            if menu.validate then
                TriggerServerEvent("plouffe_pdm:sell_vehicle", GetPlayerServerId(closestPlayer), params.vehicle, Pdm.Utils.MyAuthKey)
            end
        end)
    else
        Utils:Notify("Aucun joueur a proximité", "error")
    end
end

function PdmFnc:SpawnNewCar(model,props)
    if self:AssureModel(model) then
        local init = GetGameTimer()

        local vehicle_id = CreateVehicle(GetHashKey(model), Pdm.NewCar.spawn_coords, Pdm.NewCar.spawn_heading, true, true)

        while not DoesEntityExist(vehicle_id) and GetGameTimer() - init < 1000 * 10 do
            Wait(100)
        end

        Utils:SetVehicleProps(vehicle_id, props)

        SetVehicleDirtLevel(vehicle_id, 0.0)
        WashDecalsFromVehicle(vehicle_id,0)
        SetVehicleDoorsLocked(vehicle_id,2)

        SetVehicleOnGroundProperly(vehicle_id)

        exports.plouffe_carkeys:getSpecificVehicleKey(vehicle_id)
    end
end

function PdmFnc:SeeAllOrders()
    Callback:Await("plouffe_pdm:get_order_list", function(order_list,server_time)
        local menu = {}
        local id = 0

        for k,v in pairs(order_list) do
            id = id + 1
            table.insert(menu,{
                id = id,
                header = ("Model: %s , prix: %s"):format(v.label,self:StrPrice(v.price).." $"),
                txt = ("Par: %s , livraison dans %s heures"):format(v.ordered_by,math.ceil(((v.delivery_time - server_time) / 60) / 60)),
                params = {
                    event = "",
                    args = v
                }
            })
        end

        if #menu > 0 then
            exports.ooc_menu:Open(self:AlphabeticArray(menu), function(vehicle)

            end)
        else
            Utils:Notify("Il n'y a pas de véhicule en commande présentement", "error")
        end
    end, Pdm.Utils.MyAuthKey)
end