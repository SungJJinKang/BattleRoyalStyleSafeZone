--------------------------------------------------------------------------------
--                               BATTLE ROYALE V                              --
--                              Main client file                              --
--------------------------------------------------------------------------------

local currentSafezoneCoord
local currentSafezoneRadius
local nextSafezoneCoord
local nextSafezoneRadius

local safezoneBlip

--Draw Safe Zone on world
Citizen.CreateThread(function()
    while true do
      if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil then
        DrawMarker(1, currentSafezoneCoord.x, currentSafezoneCoord.y, currentSafezoneCoord.z - 1, 0, 0, 0, 0, 0, 0, currentSafezoneRadius * 2.0, currentSafezoneRadius * 2.0, 1.1, cof.color.r, cof.color.g, cof.color.g, cof.color.a, 0, 0, 0, 0)
      end      
      Wait(0)
    end
end)



--Draw safezone blip
Citizen.CreateThread(function()
  
local playerOOZAt = nil


while true do

  if currentSafezoneCoord ~= nil and currentSafezoneRadius ~= nil then

    if nextSafezoneCoord ~= nil and nextSafezoneRadius ~= nil then 

      if playerOOZAt == nil then playerOOZAt = GetGameTimer() end

      local deltaTime = GetTimeDifference(GetGameTimer(), playerOOZAt)
      playerOOZAt = GetGameTimer() 

      if(GetDistanceBetweenCoords(table.unpack(currentSafezoneCoord), table.unpack(currentSafezoneCoord), false) > 0.1) then
        currentSafezoneCoord = coord_lerp(currentSafezoneCoord, nextSafezoneCoord, conf.safeZoneCoordMoveSpeed * ( deltaTime / 1000  ) )
      end
      
      if(math.abs( currentSafezoneRadius - nextSafezoneRadius) > 0.1) then
        currentSafezoneRadius = math.lerp(currentSafezoneRadius, nextSafezoneRadius, conf.safeZoneRadiusMoveSpeed * ( deltaTime / 1000  ) )
      end
    
    end

    --print('x : ' .. tostring(currentSafezoneCoord.x) .. 'y : ' .. tostring(currentSafezoneCoord.y) .. 'z : ' .. tostring(currentSafezoneCoord.z) .. ' currentSafezoneRadius : ' .. tostring(currentSafezoneRadius) )
    safezoneBlip = SetSafeZoneBlip(safezoneBlip, currentSafezoneCoord, currentSafezoneRadius)
    
  end



  
  
 
  
  Wait(50)

end

end)

      


