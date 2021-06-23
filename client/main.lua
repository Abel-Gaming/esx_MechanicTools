ESX              = nil
local editMode = false
local hoistSet = false
local engineHoist = nil
local toolboxSet = false
local toolbox = nil
local carliftSet = false
local carlift = nil
local carliftfrozen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

-- Commands
if not Config.UseMenu then
	RegisterCommand(Config.EngineHoistCommand, function()
		SetEngineHoist()
	end)

	RegisterCommand(Config.ToolboxCommand, function()
		SetToolBox()
	end)

	RegisterCommand(Config.CarLiftCommand, function()
		SetCarLift()
	end)
end

if Config.UseMenu then
	RegisterCommand(Config.MenuCommand, function()
		OpenMenu()
	end)
end

-- Engine Hoist
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if hoistSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(engineHoist) - GetEntityCoords(PlayerPedId())) < 2.0 and editMode do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(engineHoist)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Press ~y~[NUMPAD 7 & 9]~s~ to rotate engine hoist ~n~Use ~b~[arrow keys]~s~ to move engine hoist", 0.6)
				if IsControlPressed(0, 172) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(engineHoist, GetOffsetFromEntityInWorldCoords(engineHoist, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(engineHoist, GetEntityHeading(engineHoist) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(engineHoist, GetEntityHeading(engineHoist) - 0.5)
				end
			end
		end
	end
end)

-- Toolbox
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if toolboxSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(toolbox) - GetEntityCoords(PlayerPedId())) < 2.0 and editMode do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(toolbox)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Press ~y~[NUMPAD 7 & 9]~s~ to rotate toolbox ~n~Use ~b~[arrow keys]~s~ to move toolbox", 0.6)
				if IsControlPressed(0, 172) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(toolbox, GetOffsetFromEntityInWorldCoords(toolbox, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(toolbox, GetEntityHeading(toolbox) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(toolbox, GetEntityHeading(toolbox) - 0.5)
				end
			end
		end
	end
end)

-- Car Lift
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Wait(500)
	end
	
	while true do
		Citizen.Wait(1)
		if carliftSet then
			local playerPed = PlayerPedId()
			while #(GetEntityCoords(carlift) - GetEntityCoords(PlayerPedId())) < 5.0 and editMode do
				Citizen.Wait(0)
				local hoistCoords = GetEntityCoords(carlift)
				ESX.Game.Utils.DrawText3D(hoistCoords, "Press ~y~[NUMPAD 5, 7, 8 & 9]~s~ to lift / rotate lift ~n~Use ~b~[arrow keys]~s~ to move toolbox", 0.6)
				if IsControlPressed(0, 111) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.0, 0.01))
				end
				if IsControlPressed(0, 110) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.0, -0.01))
				end
				if IsControlPressed(0, 172) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, 0.01, 0.0))
				end
				if IsControlPressed(0, 173) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.0, -0.01, 0.0))
				end
				if IsControlPressed(0, 174) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, -0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 175) then
					SetEntityCoords(carlift, GetOffsetFromEntityInWorldCoords(carlift, 0.01, 0.0, 0.0))
				end
				if IsControlPressed(0, 117) then
					SetEntityHeading(carlift, GetEntityHeading(carlift) + 0.5)
				end
				if IsControlPressed(0, 118) then
					SetEntityHeading(carlift, GetEntityHeading(carlift) - 0.5)
				end
			end
		end
	end
end)

-- Menu Options
local mechanictooloptions = {
	{label = "Toggle Edit Controls", value = 'toggle_edit'},
	{label = "Engine Hoist", value = 'engine_hoist'},
	{label = "Toolbox", value = 'toolbox'},
	{label = "Car Lift", value = 'car_lift'}
}

function OpenMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = "Mechanic Tools",
		align = "left",
		elements = mechanictooloptions
	}, function(data, menu)		
		
		if data.current.value == 'engine_hoist' then
			SetEngineHoist()
		elseif data.current.value == 'toolbox' then
			SetToolBox()
		elseif data.current.value == 'car_lift' then
			SetCarLift()
		elseif data.current.value == 'toggle_edit' then
			if editMode then
				ESX.ShowNotification('~r~Edit mode disabled')
				editMode = false
			else
				ESX.ShowNotification('~g~Edit mode enabled')
				editMode = true
			end
		end

	end,
	function(data, menu)
		menu.close()
	end)
end

function SetEngineHoist()
	if hoistSet then
		DeleteEntity(engineHoist)
		ESX.ShowNotification('Engine hoist removed!')
		hoistSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		engineHoist = CreateObject(Config.HoistHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		SetEntityHeading(engineHoist, playerHeading)
		ESX.ShowNotification('Engine hoist placed!')
		hoistSet = true
	end
end

function SetToolBox()
	if toolboxSet then
		DeleteEntity(toolbox)
		ESX.ShowNotification('Tool box removed!')
		toolboxSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		toolbox = CreateObject(Config.ToolboxHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		SetEntityHeading(toolbox, playerHeading)
		ESX.ShowNotification('Tool box placed!')
		toolboxSet = true
	end
end

function SetCarLift()
	if carliftSet then
		DeleteEntity(carlift)
		ESX.ShowNotification('Car lift removed!')
		carliftSet = false
	else
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerHeading = GetEntityHeading(playerPed)
		carlift = CreateObject(Config.CarLiftHash, playerCoords.x, playerCoords.y, playerCoords.z - 0.9, true, true, false)
		FreezeEntityPosition(carlift, true)
		SetEntityHeading(carlift, playerHeading)
		ESX.ShowNotification('Car lift placed!')
		carliftSet = true
	end
end