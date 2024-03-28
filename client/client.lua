RegisterCommand("postal", function(source, args, raw)
	local input = lib.inputDialog('GPS', {{type = 'number', label = 'Postal Code', description = 'Enter the postal code destination', required = true, min = 1, max = #wx.Postals}})
	if input then
		Postal(tostring(input[1]))
	end
end, false)

Citizen.CreateThread(function()	
	TriggerEvent('chat:addSuggestion', '/postal', 'Sets your GPS to a set postal code')
end)

function Postal(postalCode)
	local postalCode_coords = vector2(0,0)
	for i = 1, #wx.Postals, 1 do
		if wx.Postals[i].code == postalCode then
			postalCode_coords = vector2(wx.Postals[i].x, wx.Postals[i].y)
		end
	end
	
	if postalCode_coords.x ~= 0.0 and postalCode_coords.y ~= 0.0 then
		SetNewWaypoint(postalCode_coords.x, postalCode_coords.y)
		lib.notify({title="GPS",description="Waypoint has been set for Postal Code "..postalCode,type='success'})
	else
		lib.notify({title="GPS",description="Postal "..postalCode.." is invalid!",type='error'})
	end
	
end