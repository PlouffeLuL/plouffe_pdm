Pdm = {}
PdmFnc = {} 
TriggerServerEvent("plouffe_pdm:sendConfig")

RegisterNetEvent("plouffe_pdm:getConfig",function(list)
	if list == nil then
		CreateThread(function()
			while true do
				Wait(0)
				Pdm = nil
				PdmFnc = nil
			end
		end)
	else
		Pdm = list
		PdmFnc:Start()
	end
end)