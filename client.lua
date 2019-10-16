local currentSafezoneBlip

local currentSafezoneCoord
local currentSafezoneRadius
local targetSafezoneCoord
local targetSafezoneRadius

RegisterNetEvent('brv:setCurrentSafezone')
RegisterNetEvent('brv:setTargetSafezone') 

function ResetSafezone()
    -- body
    print('ResetSafezone')
    currentSafezoneCoord = nil
    currentSafezoneRadius = nil
    targetSafezoneCoord = nil
    targetSafezoneRadius = nil
    
end

function IsSetCurrentSafezone()
    if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil  then
        return true
    else
        return false
    end
end


  function isPlayerOutOfZone()

    local playerPos = GetEntityCoords(GetPlayerPed(PlayerId()))
    local distance = math.abs(GetDistanceBetweenCoords(playerPos.x, playerPos.y, 0, currentSafezoneCoord.x, currentSafezoneCoord.y, 0, false))
  
    return distance > currentSafezoneRadius
  end

 

AddEventHandler('brv:setTargetSafezone', function(tSafezone, timer)

    targetSafezoneCoord = {x=tSafezone.x, y=tSafezone.y, z=tSafezone.z}
   
    targetSafezoneRadius = tSafezone.radius
    print('setTargetSafezone : ' .. tostring(targetSafezoneCoord.x) .. ' ' .. tostring(targetSafezoneCoord.y) .. ' ' .. tostring(targetSafezoneCoord.z) .. ' ' .. tostring(targetSafezoneRadius) )
     
    CreateTargetSafezoneBlip(targetSafezoneCoord, targetSafezoneRadius)

    showCountdown(timer, 1 , nil)
  
    
end)
  
  

  
AddEventHandler('brv:setCurrentSafezone', function(cSafezone)
  

     currentSafezoneCoord = {x=cSafezone.x, y=cSafezone.y, z=cSafezone.z}
    currentSafezoneRadius = cSafezone.radius
    print('setCurrentSafezone : ' .. tostring(currentSafezoneCoord.x) .. ' ' .. tostring(currentSafezoneCoord.y) .. ' ' .. tostring(currentSafezoneCoord.z) .. ' ' .. tostring(currentSafezoneRadius) )
     
 end)
  


local IsSafezoneArriveAtTarget = true
local TargetSafezoneBlip = nil

function CreateTargetSafezoneBlip(tSafezoneCoord, tSafezoneRadius)

    TargetSafezoneBlip = SetSafeZoneBlip(TargetSafezoneBlip, tSafezoneCoord, tSafezoneRadius, 16)
    SetBlipPriority(TargetSafezoneBlip, 5)
end




--currentSafezone move to targetSafezone update
Citizen.CreateThread(function()

    local playerOOZAt = nil
    
    
      while true do
    
        if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil then
    
            if targetSafezoneCoord ~= nil and targetSafezoneRadius ~= nil then 
    
                if playerOOZAt == nil then 
                    playerOOZAt = GetGameTimer() 
                end
    
                local deltaTime = GetTimeDifference(GetGameTimer(), playerOOZAt)
                playerOOZAt = GetGameTimer() 
    

                local isArrive = true

                if(GetDistanceBetweenCoords(currentSafezoneCoord.x, currentSafezoneCoord.y, 0, targetSafezoneCoord.x, targetSafezoneCoord.y, 0, false) > 0.1) then
                 
                  currentSafezoneCoord = coord_lerp(currentSafezoneCoord, targetSafezoneCoord, conf.safeZoneCoordMoveSpeed * ( deltaTime / 1000  ) )
              
                  isArrive = isArrive and false
                end
            
                if(math.abs( currentSafezoneRadius - targetSafezoneRadius) > 0.1) then
                  currentSafezoneRadius = math.lerp(currentSafezoneRadius, targetSafezoneRadius, conf.safeZoneRadiusMoveSpeed * ( deltaTime / 1000  ) )
                  
                  isArrive = isArrive and false
                end

                if isArrive == true then
                    RemoveBlip(TargetSafezoneBlip)
                end
            end
       
          
          currentSafezoneBlip = SetSafeZoneBlip(currentSafezoneBlip, currentSafezoneCoord, currentSafezoneRadius, 1)
          SetBlipPriority(currentSafezoneBlip, 1)
        end
    
        Wait(30)
    
      end
    
     
    
    
    
end)
    

Citizen.CreateThread(function()
    
      
        while true do
    
          if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil then
            DrawMarker(1, currentSafezoneCoord.x, currentSafezoneCoord.y, currentSafezoneCoord.z - 30, 0, 0, 0, 0, 0, 0, currentSafezoneRadius * 2.0, currentSafezoneRadius * 2.0, 80.0, 255, 0, 0, 200, 0, 0, 0, 0, 0, 0, 0)
         
          end
    
        Wait(0)
        end
    
end)
