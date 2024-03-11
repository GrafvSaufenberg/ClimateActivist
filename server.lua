if GetResourceState("es_extended") == "started" then
	if exports["es_extended"] and exports["es_extended"].getSharedObject then
		ESX = exports["es_extended"]:getSharedObject()
	else
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
	end
end

ESX.RegisterUsableItem(Config.Item, function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem(Config.Item, 1)
    TriggerClientEvent("superglue:use", playerId)
  end)

  ESX.RegisterUsableItem(Config.LooseItem, function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)  
    TriggerClientEvent("superglue:loose", playerId, true)
    xPlayer.removeInventoryItem(Config.LooseItem, 1)
  end)
  
  RegisterCommand("loose", function(source, args, rawCommand)
    group = ESX.GetPlayerFromId(source).getGroup()
    if group == Config.AdminGroup then
      if args[1] == "me" or tonumber(args[1]) == nil then
        id = source
      else
        id = args[1]
      end
      TriggerClientEvent("superglue:loose", id)
    else
        xPlayer.showNotification("Du hast keine Rechte dazu!")
    end
  end, false)