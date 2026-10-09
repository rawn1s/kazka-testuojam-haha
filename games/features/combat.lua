return function(lib, window)
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local LocalPlayer = Players.LocalPlayer

	local function placeholder(name)
		return function()
			lib:Notify({ Title = "Not Implemented", Content = name .. " has no game logic yet.", Duration = 3 })
		end
	end

	local ORDER_NOTE = "Select in order: first = most important, last = least important"

	local tab = window:CreateTab("Combat")

	--=====================================================================
	--  OFFENSE : Auto Attack
	--=====================================================================
	local ClientEffects = ReplicatedStorage:WaitForChild("Communication")
		:WaitForChild("CnC"):WaitForChild("ClientEffects")

	local aaState = { enabled = false, speed = 5 }
	local aaConn = nil

	local function fireSwing(combo)
		local char = LocalPlayer.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum and hum.Health <= 0 then return end

		local ok, err = pcall(function()
			-- ClientEffects is a BindableEvent; firing it directly replays the
			-- same client-side swing the game triggers. Works without executor
			-- functions like firesignal (which Xeno doesn't provide).
			ClientEffects:Fire("Combat_Swings", char, combo, false)
		end)
		if not ok then
			if aaConn then aaConn:Disconnect() aaConn = nil end
			aaState.enabled = false
			lib:Notify({ Title = "Auto Attack", Content = "Swing failed: " .. tostring(err), Duration = 4 })
		end
	end

	local function stopAA()
		if aaConn then aaConn:Disconnect() aaConn = nil end
	end

	local function startAA()
		stopAA()
		local combo = 1
		local acc = 0
		aaConn = RunService.Heartbeat:Connect(function(dt)
			if not aaState.enabled then return end
			acc += dt
			local interval = 1 / math.max(1, aaState.speed)
			if acc >= interval then
				acc -= interval
				fireSwing(combo)
				combo = combo % 5 + 1
			end
		end)
	end

	tab:AddSection("Offense")
	local autoAA = tab:AddToggle({
		Text = "Auto Attack",
		Default = false,
		Callback = function(on)
			aaState.enabled = on
			if on then startAA() else stopAA() end
		end,
	})
	tab:AddSlider({
		Text = "AA Speed",
		Min = 1, Max = 20, Default = 5,
		Note = "Swings per second.",
		DependsOn = autoAA,
		Callback = function(v) aaState.speed = v end,
	})

	tab:AddSlider({
		Text = "Kill Aura",
		Min = 0, Max = 200, Default = 0, Suffix = " studs",
		Callback = placeholder("Kill Aura"),
	})

	local equipWeapon = tab:AddDropdown({
		Text = "Equip Weapon",
		Options = { "(loading...)" },
		Default = "(loading...)",
		Callback = placeholder("Equip Weapon"),
	})
	task.spawn(function()
		local list = {}
		for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
			if item:IsA("Tool") then table.insert(list, item.Name) end
		end
		local char = LocalPlayer.Character
		if char then
			for _, item in ipairs(char:GetChildren()) do
				if item:IsA("Tool") then table.insert(list, item.Name) end
			end
		end
		if #list > 0 then
			equipWeapon:Refresh(list)
			equipWeapon:Set(list[1], false)
		end
	end)

	tab:AddMultiDropdown({
		Title = "Auto Skills",
		Note = ORDER_NOTE,
		Options = { "-- add skill names here --" },
		Default = {},
		Callback = placeholder("Auto Skills"),
	})

	local tpMobs = tab:AddToggle({
		Text = "TP All Mobs To Person",
		Default = false,
		Callback = placeholder("TP All Mobs To Person"),
	})
	tab:AddSlider({
		Text = "Mob TP Distance",
		Min = 0, Max = 200, Default = 10, Suffix = " studs",
		DependsOn = tpMobs,
		Callback = placeholder("Mob TP Distance"),
	})

	--=====================================================================
	--  DEFENSE
	--=====================================================================
	tab:AddSection("Defense")
	local hitboxes = tab:AddToggle({
		Text = "Enemy Hitboxes",
		Default = false,
		Callback = placeholder("Enemy Hitboxes"),
	})
	tab:AddSlider({
		Text = "Expand Enemy Hitboxes",
		Min = 0, Max = 10, Default = 1, Suffix = "x",
		DependsOn = hitboxes,
		Callback = placeholder("Expand Enemy Hitboxes"),
	})
	tab:AddToggle({
		Text = "Auto Parry / Block",
		Default = false,
		Callback = placeholder("Auto Parry / Block"),
	})
end
