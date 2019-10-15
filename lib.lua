
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
	return coord_Plus(a, coord_ManipulateWithNum(coord_Minus(b, a), t))
end


function coord_Plus(a, b)
  a.x = a.x + b.x
  a.y = a.y + b.y
  a.z = a.z + b.z

  return a
end

function coord_Minus(a, b)
  a.x = a.x - b.x
  a.y = a.y - b.y
  a.z = a.z - b.z

  return a
end

function coord_ManipulateWithNum(a, t)
  a.x = a.x * t
  a.y = a.y * t
  a.z = a.z * t

  return a
end
