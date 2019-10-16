
-- Returns true if the player is out of the zone, false otherwise
function isPlayerOutOfZone(safeZoneCoord, safeZoneRadius)

    local playerPos = GetEntityCoords(GetPlayerPed(PlayerId()))
    local distance = math.abs(GetDistanceBetweenCoords(playerPos.x, playerPos.y, 0, safeZoneCoord.x, safeZoneCoord.y, 0, false))
  
    return distance > safeZoneRadius
end
  

  function SetSafeZoneBlip(blip, cSafezoneCoord, cSafezoneRadius, color)
    local safeZoneBlip = AddBlipForRadius(cSafezoneCoord.x, cSafezoneCoord.y, cSafezoneCoord.z, cSafezoneRadius * 1.0)

    SetBlipColour(safeZoneBlip, color) --
    SetBlipHighDetail(safeZoneBlip, true)
    SetBlipAlpha(safeZoneBlip, 90)
    SetBlipDisplay(safeZoneBlip, 10)

  
 
  
    if blip ~= nil then
      RemoveBlip(blip) -- Remove before blip(variable 'blip')
    end
  
    return safeZoneBlip
end
  

------------------

math.lerp = function(a, b, t)
  -- body
  return a + (b - a) * t
end

function coord_lerp(a, b, t)
  local lx = math.lerp(a.x, b.x, t)
  local ly = math.lerp(a.y, b.y, t)
  local lz = math.lerp(a.z, b.z, t)
  
  return {x = lx, y = ly, z = lz}
end
