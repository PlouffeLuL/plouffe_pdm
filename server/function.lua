function PdmFnc:Init()
    MySQL.query('SELECT * FROM pdm_orders', {}, function(orders)
        MySQL.query('SELECT * FROM pdm_display', {}, function(display)
            MySQL.query('SELECT * FROM pdm_stock', {}, function(stock)
                self:SetStock(stock)
                Wait(100)
                self:SetDisplay(display)
                Wait(100)
                self:SetOrders(orders)
                Wait(100)
                self:SetDeliveryTimes()
                Wait(100)
    
                Server.Init = true
            end)
        end)
    end)
end
   
function PdmFnc:GetArrayLenght(array)
    local lenght = 0
    for k,v in pairs(array) do 
        lenght = lenght + 1
    end
    return lenght
end

function PdmFnc:CreateCallbackName()
    local x = {
        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
        "!","@","#","$","%","^","&","*","(",")","_","-","=","+","{","}","[","]",";",":","'","?",">","<",
        "0","1","2","3","4","5","6","7","8","9","penis","PENIS","PLOUFFE","plouffe","KEKW","kekw","MINUCE","minuce"
    }
    local currentName = ""
    local timesDone = 0
    local maxLengh = math.random(10,20)

    repeat
        local randi = math.random(1,#x)
        currentName = currentName..tostring(x[randi])
        timesDone = timesDone + 1
    until timesDone > maxLengh

    return currentName
end

function PdmFnc:CreateCallbackKey()
    local x = {
        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
        "!","@","#","$","%","^","&","*","(",")","_","-","=","+","{","}","[","]",";",":","'","?",">","<",
        "0","1","2","3","4","5","6","7","8","9","penis","PENIS","PLOUFFE","plouffe","KEKW","kekw","MINUCE","minuce"
    }
    local currentName = ""
    local timesDone = 0
    local maxLengh = math.random(5,10)

    repeat
        local randi = math.random(1,#x)
        currentName = currentName..tostring(x[randi])
        timesDone = timesDone + 1
    until timesDone > maxLengh

    return currentName
end

function PdmFnc:ClientCallback(playerId,cb,data)
    local cbKey = PdmFnc:CreateCallbackKey()
    data.cbKey = cbKey
    data.name = PdmFnc:CreateCallbackName()
    Server.Callbacks[playerId] = {}
    Server.Callbacks[playerId][data.name] = {cb = cb, cbKey = cbKey, serverTime = os.time()}
    TriggerClientEvent("plouffe_pdm:ClientCallback",playerId,data)
end

function PdmFnc:ValidateCallbackKey(playerId,name,key)
    local reason = "Invalid callback key"
    if Server.Callbacks[playerId][name] then
        if Server.Callbacks[playerId][name].cbKey == key then
            if os.time() - Server.Callbacks[playerId][name].serverTime <= 20 then
                return true
            else
                reason = "Client timeout on callback"
            end
        end
    end
    PdmFnc:SendLogs(reason, playerId)
    return false
end

function PdmFnc:SendTxt(playerId,label,txt)
    local text = {
        playerId = playerId,
        type = "message",
        sender = label,
        message = txt
    }

    -- exports.evo_phone:SendCustomMessage(text)
end

function PdmFnc:Notify(playerId,txt,type,length)
    local aType, atxt, alength = type,txt,length
    if not type or tostring(type) ~= ("error" or "success" or "inform") then
        aType = "inform" 
    end
    if not txt or not tostring(txt) then
        return 
    else 
        atxt = txt 
    end
    if not length or not tonumber(length) then
        if tonumber(type) then
            alength = tonumber(type)
        else
            alength = 5000 
        end
    else 
        alength = tonumber(length)
    end
    TriggerClientEvent('plouffe_lib:notify', playerId, { type = aType, text = atxt, length = alength})
end

function PdmFnc:SetOrders(orders)
    for k,v in pairs(orders) do
        table.insert(Server.Orders, {
            model = v.model, 
            label = v.label, 
            price = v.price, 
            delivery_time = v.delivery_time, 
            order_time = v.order_time, 
            ordered_by = v.ordered_by
        })
    end
    self:OrderThread()
end

function PdmFnc:SetStock(stock)
    for k,v in pairs(stock) do
        table.insert(Pdm.StockVehicles, {
            model = v.model,
            label = v.label, 
            price = v.price,
            props = json.decode(v.props)
        })
    end
end

function PdmFnc:SetDisplay(display)
    for k,v in pairs(display) do
        local decodedCoords = json.decode(v.coords)
        table.insert(Pdm.Display,{
            coords = vector3(decodedCoords.coords.x,decodedCoords.coords.y,decodedCoords.coords.z),
            heading = decodedCoords.heading,
            props = json.decode(v.props),
            price = v.price,
            model = v.model,
            label = v.label
        })
    end
end

function PdmFnc:GetDeliveryTime(class)
    local time = Pdm.DeliveryTimes.set[class]
    return math.ceil(time / (60 * 60))
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

function PdmFnc:SetDeliveryTimes()
    for k,v in pairs(Pdm.DeliveryTimes.randoms) do
        math.randomseed(os.time())
        Pdm.DeliveryTimes.set[k] = math.random(v.min, v.max)
    end
end

function PdmFnc:DoesVehicleExistsInList(class,model)
    if Pdm.Vehicles_list[class] then
        return Pdm.Vehicles_list[class][model] ~= nil
    end
end

function PdmFnc:CanOrderVehicles(xPlayer)
    return Pdm.PlaceOrderGrades[tostring(xPlayer.job.grade)] ~= nil
end

function PdmFnc:IsPdm(xPlayer)
    return xPlayer.job.name == "pdm"
end

function PdmFnc:CreateDemoVehicle(model)
    local vehicle = NetworkGetEntityFromNetworkId(Pdm.Demo.netId)
    local init = os.time()

    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end

    vehicle = CreateVehicle(model, Pdm.Demo.coords, Pdm.Demo.heading, true, true)

    while not DoesEntityExist(vehicle) and os.time() - init < 5 do
        Wait(0)
    end

    Pdm.Demo.netId = NetworkGetNetworkIdFromEntity(vehicle)

    Wait(500)

    FreezeEntityPosition(vehicle, true)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleDoorsLocked(vehicle,2)
end

function PdmFnc:CreateDemo(playerId,vehicle)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)

    if self:IsPdm(xPlayer) and self:DoesVehicleExistsInList(vehicle.class,vehicle.model) then
        self:CreateDemoVehicle(vehicle.model)
        self:Notify(playerId,"Démonstrateur sortit")
    end
end

function PdmFnc:RemoveDemo(playerId)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)
    if self:IsPdm(xPlayer) then
        local vehicle = NetworkGetEntityFromNetworkId(Pdm.Demo.netId)

        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
            Pdm.Demo.netId = 0
            self:Notify(playerId,"Démonstrateur Ranger")
        else
            self:Notify(playerId,"Il n'y a pas de démonstrateur présentement")
        end
    end
end

function PdmFnc:OrderVehicle(playerId,vehicle)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)
    
    if self:IsPdm(xPlayer) and self:CanOrderVehicles(xPlayer) and self:DoesVehicleExistsInList(vehicle.class,vehicle.model) then
        local vehicle = Pdm.Vehicles_list[vehicle.class][vehicle.model]

        exports.plouffe_society:RemoveSocietyAccountMoney(nil,Server.society,"bank",vehicle.price, function(valid)
            if valid then
                MySQL.query("INSERT INTO pdm_orders (model, label, price, delivery_time, order_time, ordered_by) VALUES (@model, @label, @price, @delivery_time, @order_time, @ordered_by)", {
                    ["@model"] = vehicle.model, 
                    ["@label"] = vehicle.label, 
                    ["@price"] = vehicle.price, 
                    ["@delivery_time"] = os.time() +  Pdm.DeliveryTimes.set[vehicle.class], 
                    ["@order_time"] = os.time(), 
                    ["@ordered_by"] = xPlayer.name
                }, function()
                    MySQL.query("INSERT INTO pdm_orders_history (model, label, price, delivery_time, order_time, ordered_by) VALUES (@model, @label, @price, @delivery_time, @order_time, @ordered_by)", {
                        ["@model"] = vehicle.model, 
                        ["@label"] = vehicle.label, 
                        ["@price"] = vehicle.price, 
                        ["@delivery_time"] = os.time() +  Pdm.DeliveryTimes.set[vehicle.class], 
                        ["@order_time"] = os.time(), 
                        ["@ordered_by"] = xPlayer.name
                    }, function()
                        table.insert(Server.Orders, {
                            model = vehicle.model, 
                            label = vehicle.label, 
                            price = vehicle.price, 
                            delivery_time = os.time() +  Pdm.DeliveryTimes.set[vehicle.class], 
                            order_time = os.time(), 
                            ordered_by = xPlayer.name
                        })

                        self:OrderThread()
                        self:SendTxt(playerId, "Pdm", ("Votre comande pour: %s au montant de %s a été passer. Livraison estimer dans %s heurs."):format(vehicle.label, self:StrPrice(vehicle.price), self:GetDeliveryTime(vehicle.class)))
                    end)
                end)
            else
                self:SendTxt(playerId, "Pdm", "Il n'y a pas asser d'argent dans le compte d'entreprise pour placer la comande")
            end
        end)
    end
end

function PdmFnc:DeliverVehicle(vehicle)
    local plate = exports.plouffe_garage:CreatePlate()
    local props = {plate = plate}

    MySQL.query("INSERT INTO pdm_stock (model, price, label, plate, props) VALUES (@model, @price, @label, @plate, @props)",{
        ["@model"] = vehicle.model, 
        ["@price"] = vehicle.price, 
        ["@label"] = vehicle.label,
        ["@plate"] = plate,
        ["@props"] = json.encode(props)
    }, function()
        MySQL.query("DELETE FROM pdm_orders WHERE model = @model AND label = @label AND price = @price AND delivery_time = @delivery_time AND order_time = @order_time AND ordered_by = @ordered_by",{
            ["@model"] = vehicle.model, 
            ["@label"] = vehicle.label, 
            ["@price"] = vehicle.price, 
            ["@delivery_time"] = vehicle.delivery_time, 
            ["@order_time"] = vehicle.order_time, 
            ["@ordered_by"] = vehicle.ordered_by
        }, function()

            table.insert(Pdm.StockVehicles, {
                model = vehicle.model,
                label = vehicle.label, 
                price = vehicle.price,
                props = props   
            })

            local players = exports.plouffe_society:GetPlayersPerJob("pdm")
            
            vehicle.props = props

            if players and self:GetArrayLenght(players) > 0 then
                for k,v in pairs(players) do
                    self:SendTxt(k, "Pdm", ("Vous avez recu la livraison de: %s"):format(vehicle.label))
                    TriggerClientEvent("plouffe_pdm:sync_new_stock", k, vehicle)
                end
            end
        end)
    end)
end

function PdmFnc:OrderThread()
    if Server.OrderThreadActive then
        return
    end

    Server.OrderThreadActive = true

    CreateThread(function()
        Wait(5000)
        while #Server.Orders > 0 do
            local time = os.time()

            for k,v in pairs(Server.Orders) do
                if v.delivery_time < time then
                    self:DeliverVehicle(v)
                    table.remove(Server.Orders, k)
                    break
                end
            end

            Wait(Server.OrdersSleep)
        end
        
        Server.OrderThreadActive = false
    end)
end

function PdmFnc:IsVehicleInStock(model,label,price,plate)
    for k,v in pairs(Pdm.StockVehicles) do
        if v.model == model and v.label == label and v.price == price and v.props.plate == plate then
            return true, k
        end
    end
end

function PdmFnc:AddNewDisplay(playerId,vehicle)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)
    
    if self:IsPdm(xPlayer) then
        local exists, index = self:IsVehicleInStock(vehicle.model,vehicle.label,vehicle.price,vehicle.props.plate)

        if exists then
            MySQL.query("SELECT id, performance_state, owned FROM pdm_stock WHERE label = @label AND model = @model AND price = @price AND plate = @plate", {
                ["@label"] = vehicle.label,
                ["@model"] = vehicle.model,
                ["@price"] = vehicle.price,
                ["@plate"] = vehicle.props.plate
            }, function(result)
                if result[1] then
                    MySQL.query("DELETE FROM pdm_stock WHERE id = @id",{
                        ["@id"] = result[1].id
                    }, function()
                        MySQL.query("INSERT INTO pdm_display (coords, props, price, model, label, plate, owned) VALUES (@coords, @props, @price, @model, @label, @plate, @owned)", {
                            ["@coords"] =  json.encode({coords = vehicle.coords, heading = vehicle.heading}),
                            ["@props"] = json.encode(vehicle.props),
                            ["@price"] = vehicle.price,
                            ["@model"] = vehicle.model,
                            ["@label"] = vehicle.label,
                            ["@plate"] = vehicle.props.plate,
                            ["@performance_state"] = result[1].performance_state,
                            ["@owned"] = result[1].owned
                        }, function()
                            local players = exports.plouffe_society:GetPlayersPerJob("pdm")
            
                            TriggerClientEvent("plouffe_pdm:sync_new_display", -1, vehicle)
            
                            if players and self:GetArrayLenght(players) > 0 then
                                for k,v in pairs(players) do
                                    TriggerClientEvent("plouffe_pdm:remove_stock", k, vehicle)
                                end
                            end
            
                            table.insert(Pdm.Display, vehicle)
            
                            table.remove(Pdm.StockVehicles,index)
                        end)
                    end)
                end
            end)
        end
    end
end

function PdmFnc:RemoveDisplay(playerId,vehicle)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)
    
    if self:IsPdm(xPlayer) then
        MySQL.query("SELECT * FROM pdm_display WHERE plate = @plate",{
            ["@plate"] = vehicle.props.plate
        }, function(results)
            if results[1] then
                MySQL.query("DELETE FROM pdm_display WHERE plate = @plate",{
                    ["@plate"] = vehicle.props.plate
                }, function()
                    MySQL.query("INSERT INTO pdm_stock (label, model, price, props, performance_state, plate, owned) VALUES (@label, @model, @price, @props, @performance_state, @plate, @owned)", {
                        ["@label"] = results[1].label,
                        ["@model"] = results[1].model,
                        ["@price"] = results[1].price,
                        ["@props"] = results[1].props,
                        ["@performance_state"] = results[1].performance_state,
                        ["@plate"] = vehicle.props.plate,
                        ["@owned"] = results[1].owned
                    }, function(result)
                        local vehicle_info = {
                            model = results[1].model,
                            label = results[1].label,
                            price = results[1].price,
                            props = json.decode(results[1].props)
                        }

                        table.insert(Pdm.StockVehicles, vehicle_info)
            
                        local players = exports.plouffe_society:GetPlayersPerJob("pdm")
                        
                        TriggerClientEvent("plouffe_pdm:remove_from_display", -1, vehicle_info)

                        if players and self:GetArrayLenght(players) > 0 then
                            for k,v in pairs(players) do
                                TriggerClientEvent("plouffe_pdm:sync_new_stock", k, vehicle_info)
                            end
                        end

                        for k,v in pairs(Pdm.Display) do
                            if v.props.plate == vehicle.props.plate then
                                table.remove(Pdm.Display, k)
                                break
                            end
                        end
                    end)
                end)
            end
        end)
    end
end

function PdmFnc:AddOwnedVehicle(playerId)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)
    
    if self:IsPdm(xPlayer) then
        local ped = GetPlayerPed(playerId)
        local vehicle_Id = GetVehiclePedIsIn(ped, false)
        local plate = GetVehicleNumberPlateText(vehicle_Id)

        MySQL.query("SELECT plate, vehicle, performance_state FROM owned_vehicles WHERE state_id = @state_id AND plate = @plate",{
            ["@state_id"] = xPlayer.state_id,
            ["@plate"] = plate
        },function(results)
            if results[1] then
                local vehicle_props = json.decode(results[1].vehicle)

                self:ClientCallback(playerId, function(label,model,price)
                    MySQL.query("INSERT INTO pdm_stock (label, model, price, props, performance_state, owned, plate) VALUES (@label, @model, @price, @props, @performance_state, @owned, @plate)", {
                        ["@label"] = label,
                        ["@model"] = model,
                        ["@price"] = price,
                        ["@props"] = results[1].vehicle,
                        ["@performance_state"] = results[1].performance_state,
                        ["@owned"] = 1,
                        ["@plate"] = plate
                    }, function(result)
                        MySQL.query("DELETE FROM owned_vehicles WHERE plate = @plate",{
                            ["@plate"] = plate
                        }, function()                        
                            local vehicle_info = {
                                model = model,
                                label = label,
                                price = price,
                                props = json.decode(results[1].vehicle)
                            }
        
                            table.insert(Pdm.StockVehicles, vehicle_info)
                            
                            local players = exports.plouffe_society:GetPlayersPerJob("pdm")
                
                            if players and self:GetArrayLenght(players) > 0 then
                                for k,v in pairs(players) do
                                    TriggerClientEvent("plouffe_pdm:sync_new_stock", k, vehicle_info)
                                end
                            end

                            DeleteEntity(vehicle_Id)
                        end)
                    end)
                end,{fnc = "GetLabelAndModel", model = vehicle_props.model})
            else
                self:Notify(playerId,"Ce véchicule ne vous appartiens pas", "error")
            end
        end)
    end
end

function PdmFnc:GetPaiment(xPlayer,price)
    if xPlayer.getAccount("bank").money >= price then
        return true, "bank"
    elseif exports.ooc_core.getItemCount(xPlayer.source,"money") >= price then
        return true, "money"
    end

    return false, ""
end

function PdmFnc:SellVehicle(playerId,targetId,vehicle)
    local xPlayer = exports.ooc_core:getPlayerFromId(playerId)

    if self:IsPdm(xPlayer) then
        local xTarget = exports.ooc_core:getPlayerFromId(targetId)

        if xTarget then
            local exists, index = self:IsVehicleInStock(vehicle.model, vehicle.label, vehicle.price, vehicle.props.plate)

            if exists then
                MySQL.query("SELECT * FROM pdm_stock WHERE plate = @plate",{
                    ["@plate"] = vehicle.props.plate
                }, function(results)

                    if results[1] then
                        local price = results[1].price
                        local cut = math.floor(price * (Pdm.JobPercentOnSales/100))
                        local can_pay, paiment_type = self:GetPaiment(xTarget,price)

                        if results[1].owned == 1 then
                            cut = price
                        end

                        if can_pay then
                            local plate = exports.plouffe_garage:CreatePlate()
                            local decode_props = json.decode(results[1].props)
                            
                            decode_props.plate = plate

                            if not decode_props.model then
                                decode_props.model = GetHashKey(vehicle.model)
                            end

                            local new_props = json.encode(decode_props)

                            MySQL.query("INSERT INTO owned_vehicles (state_id,plate,vehicle,vehiclemodel,performance_state,garage) VALUES (@state_id, @plate, @vehicle, @vehiclemodel, @performance_state, @garage)", {
                                ["@state_id"] = xTarget.state_id, 
                                ["@plate"] = plate, 
                                ["@vehicle"] = new_props, 
                                ["@vehiclemodel"] = vehicle.model, 
                                ["@performance_state"] = results[1].performance_state, 
                                ["@garage"] = "sortit"
                            }, function()

                                if paiment_type == "money" then
                                    exports.ooc_core:removeItem(targetId,"money",price)
                                else
                                    xTarget.removeAccountMoney("bank",price)
                                end

                                MySQL.query("DELETE FROM pdm_stock WHERE id = @id", {
                                    ["@id"] = results[1].id
                                }, function()
                                    exports.plouffe_society:AddSocietyAccountMoney(nil, Server.society, "bank", cut + price, function()
                                        
                                        self:SendTxt(playerId,"Pdm",("Vous avez vendu: %s , pour un montant de %s $ et un profit de %s $"):format(vehicle.label, self:StrPrice(price), self:StrPrice(cut)))
                                        self:SendTxt(targetId,"Pdm",("Vous avez acheter: %s , pour un montant de %s $"):format(vehicle.label, self:StrPrice(price)))
                                        
                                        TriggerClientEvent("plouffe_pdm:spawn_my_new_car", targetId, vehicle.model, decode_props)

                                        local players = exports.plouffe_society:GetPlayersPerJob("pdm")
                                        
                                        if players and self:GetArrayLenght(players) > 0 then
                                            for k,v in pairs(players) do
                                                TriggerClientEvent("plouffe_pdm:remove_stock", k, vehicle)
                                            end
                                        end
                        
                                        table.remove(Pdm.StockVehicles, index)
                                    end)
                                end)
                            end)
                        else
                            self:SendTxt(targetId, "Pdm", ("Vous avez besoin de %s $ pour pouvoir acheter ce véhicule"):format(self:StrPrice(price)))
                            self:SendTxt(playerId, "Pdm", ("Le paiment de %s $ na pas pu etre valider"):format(self:StrPrice(price)))
                        end
                    end
                end)
            end
        end
    end
end