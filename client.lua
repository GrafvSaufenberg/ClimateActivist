if GetResourceState("es_extended") == "started" then
	if exports["es_extended"] and exports["es_extended"].getSharedObject then
		ESX = exports["es_extended"]:getSharedObject()
	else
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
	end
end

RegisterNetEvent('superglue:use', function()

animDict = "amb@world_human_picnic@male@idle_a"
animName = "idle_a"



RequestAnimDict(animDict)
while not HasAnimDictLoaded(animDict) do
  Citizen.Wait(0)
end

    local blendInSpeed = 8.0
    local blendOutSpeed = 8.0
    local duration = -1
    local flag = 1
    local playbackRate = 0.0
    local lockX = false
    local lockY = false
    local lockZ = false
    local ped = PlayerPedId()

    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate, lockX, lockY, lockZ)
    Citizen.Wait(100)
    SetEntityAnimCurrentTime(PlayerPedId(), animDict, animName, 0.0)
    SetEntityAnimSpeed(PlayerPedId(),  animDict, animName, 0.0)
festgeklebt = true 
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if festgeklebt == true then
          DisableAllControlActions(0)
          -- enable mouse + esc + T
            EnableControlAction(0, 1, true) -- LookLeftRight
            EnableControlAction(0, 2, true) -- LookUpDown
            EnableControlAction(0, 200, true) -- ESC
            EnableControlAction(0, 245, true) -- T
        elseif festgeklebt and IsEntityDead(PlayerPedId()) then
          losloesen()
          ClearPedTasksImmediately(PlayerPedId())
        elseif festgeklebt == false then
          Citizen.Wait(1000)
        end 
    end
end)
function losloesen()
    festgeklebt = false
    ClearPedTasksImmediately(PlayerPedId())
end

RegisterNetEvent('superglue:loose', function(nonadmin)
  if nonadmin == nil then
losloesen()
  else

    if festgeklebt == true and Config.Looseyourself then
      losloesen()
      return
    end
   
    closestplayer , distance = ESX.Game.GetClosestPlayer()
    print(closestplayer, distance)
    if closestplayer == -1 or distance > 3.0 then
      ESX.ShowNotification("Kein Spieler in der Nähe!")
      return
    end
    TriggerEvent("superglue:loose", closestplayer)
  end
end)

if Config.Looseonrestart then
AddEventHandler('onResourceStop', function(resourceName)
if resourceName == GetCurrentResourceName() then
  if festgeklebt then
    losloesen()
  end
end
end)
end

function getklebestatus()
  return festgeklebt
end

exports('supergluestatus', getklebestatus)