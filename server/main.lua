CreateThread(function()
    MySQL.ready(function()
        PdmFnc:Init()
    end)
end)

RegisterNetEvent("plouffe_pdm:sendConfig",function()
    local playerId = source
    local registred, key = Auth:Register(playerId)
    
    while not Server.Init do
        Wait(100)
    end
    
    if registred then
        local cbArray = Pdm
        cbArray.Utils.MyAuthKey = key
        TriggerClientEvent("plouffe_pdm:getConfig",playerId,cbArray)
    else
        TriggerClientEvent("plouffe_pdm:getConfig",playerId,nil)
    end
end)

RegisterNetEvent("plouffe_pdm:ShowDemoVehicle",function(vehicle,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:ShowDemoVehicle") then
            PdmFnc:CreateDemo(playerId,vehicle)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:RemoveDemo",function(authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:RemoveDemo") then
            PdmFnc:RemoveDemo(playerId)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:OrderVehicle",function(vehicle,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:OrderVehicle") then
            PdmFnc:OrderVehicle(playerId,vehicle)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:add_new_display",function(vehicle,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:add_new_display") then
            PdmFnc:AddNewDisplay(playerId,vehicle)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:remove_display",function(vehicle,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:remove_display") then
            PdmFnc:RemoveDisplay(playerId,vehicle)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:add_owned_vehicle_to_inventory",function(authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:add_owned_vehicle_to_inventory") then
            PdmFnc:AddOwnedVehicle(playerId)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:sell_vehicle",function(targetId,vehicle,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_pdm:sell_vehicle") then
            PdmFnc:SellVehicle(playerId,targetId,vehicle)
        end
    end
end)

RegisterNetEvent("plouffe_pdm:ClientCallback:server", function(data,...)
    local playerId = source
    if PdmFnc:ValidateCallbackKey(playerId,data.name,data.cbKey) then
        Server.Callbacks[playerId][data.name].cb(...)
        Server.Callbacks[playerId][data.name] = nil
    end
end)

Callback:RegisterServerCallback("plouffe_pdm:get_order_list", function(source,cb,authkey)
    if Auth:Validate(source,authkey) then
        if Auth:Events(source,"plouffe_pdm:get_order_list") then
            cb(Server.Orders,os.time())
        end
    end
end)