
local SakkaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rawn1s/SakkaUI-library/refs/heads/main/SakkaUI.lua"))()

-- services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local lib = SakkaUI.new()

-- helpers 
local function noop() end

local function placeholder(name)
	return function()
		lib:Notify({ Title = "Not Implemented", Content = name .. " has no game logic yet.", Duration = 3 })
	end
end

local function executorName()
	local ok, name = pcall(function()
		if identifyexecutor then return identifyexecutor() end
	end)
	if ok and name then return tostring(name) end
	return "Unknown"
end

local function deviceName()
	local touch = UserInputService.TouchEnabled
	local mouse = UserInputService.MouseEnabled
	if touch and mouse then return "PC (Touch)" end
	if touch then return "Mobile" end
	if mouse then return "PC" end
	return "Unknown"
end

local execCount = 1
pcall(function()
	getgenv().SakkaExecutions = (getgenv().SakkaExecutions or 0) + 1
	execCount = getgenv().SakkaExecutions
end)

-- window
local window = lib:CreateWindow({
	Title = "Sakka",
	Font = Enum.Font.PermanentMarker,
	TextSize = 24,
	-- KeySystem = true, Key = "SAKKA-2026", KeyLink = "https://...",
})

window:LoadLocalAvatar()
-- The profile card's four slots: Client / KeyType / TimeLeft / Executions.
-- We repurpose "TimeLeft" to show the device.
window:SetCharacterInfo({
	Client = executorName(),
	KeyType = "Free",        -- change to "Paid" once you add a key check
	TimeLeft = deviceName(),
	Executions = execCount,
})

--=============================================================
--  INFORMATION
--=============================================================
local infoTab = window:CreateTab("Information")
window:BuildProfileCard(infoTab.LeftColumn)

infoTab:AddSection("Info", "Right")
infoTab:AddLabel("Greetings, " .. LocalPlayer.DisplayName .. "!")
infoTab:AddButton({
	Text = "Discord",
	Callback = function()
		lib:Notify({ Title = "Discord", Content = "Link coming soon.", Duration = 3 })
	end,
})

--=============================================================
--  FARMING
--=============================================================
local farmTab = window:CreateTab("Farming")

farmTab:AddSection("Mobs / Bosses")
farmTab:AddMultiDropdown({
	Title = "Boss / NPC Selection",
	Options = { "Boss 1", "Boss 2", "Boss 3" }, -- TODO: fill with the game's bosses
	Default = {},
	Callback = placeholder("Boss / NPC Selection"),
})
local bossAutoHop = farmTab:AddToggle({
	Text = "Auto Hop After Boss Kill",
	Default = false,
	Callback = placeholder("Auto Hop After Boss Kill"),
})
farmTab:AddTextInput({
	Text = "Auto Hop - Max Players",
	Placeholder = "e.g. 6",
	DependsOn = bossAutoHop,
	Callback = placeholder("Auto Hop - Max Players"),
})
farmTab:AddDropdown({
	Text = "Auto Hop - Region",
	Options = { "Auto", "NA", "EU", "ASIA" },
	Default = "Auto",
	DependsOn = bossAutoHop,
	Callback = placeholder("Auto Hop - Region"),
})
local autoChest = farmTab:AddToggle({
	Text = "Auto Collect Chest",
	Default = false,
	Callback = placeholder("Auto Collect Chest"),
})
farmTab:AddSlider({
	Text = "Auto Collect Chest Distance",
	Min = 1, Max = 200, Default = 20, Suffix = " studs",
	DependsOn = autoChest,
	Callback = placeholder("Auto Collect Chest Distance"),
})

farmTab:AddSection("Weapons / Items")
farmTab:AddMultiDropdown({
	Title = "Auto Farm Weapon Drops (Priority)",
	Options = { "Sword", "Gun", "Accessory" }, -- TODO
	Default = {},
	Callback = placeholder("Auto Farm Weapon Drops"),
})
farmTab:AddMultiDropdown({
	Title = "Auto Farm Item Drops (Priority)",
	Options = { "Common", "Rare", "Legendary" }, -- TODO
	Default = {},
	Callback = placeholder("Auto Farm Item Drops"),
})
local dropAutoHop = farmTab:AddToggle({
	Text = "Auto Hop If Drop NPC Not Spawned",
	Default = false,
	Callback = placeholder("Auto Hop If Drop NPC Not Spawned"),
})
farmTab:AddTextInput({
	Text = "Auto Hop - Max Players",
	Placeholder = "e.g. 6",
	DependsOn = dropAutoHop,
	Callback = placeholder("Auto Hop - Max Players"),
})
farmTab:AddDropdown({
	Text = "Auto Hop - Region",
	Options = { "Auto", "NA", "EU", "ASIA" },
	Default = "Auto",
	DependsOn = dropAutoHop,
	Callback = placeholder("Auto Hop - Region"),
})

farmTab:AddSection("Quests")
farmTab:AddDropdown({
	Text = "Quest Selection",
	Options = { "Quest 1", "Quest 2", "Quest 3" }, -- TODO
	Default = "Quest 1",
	Callback = placeholder("Quest Selection"),
})
local questAutoHop = farmTab:AddToggle({
	Text = "Auto Hop Quests",
	Default = false,
	Callback = placeholder("Auto Hop Quests"),
})
farmTab:AddTextInput({
	Text = "Auto Hop - Max Players",
	Placeholder = "e.g. 6",
	DependsOn = questAutoHop,
	Callback = placeholder("Auto Hop - Max Players"),
})
farmTab:AddDropdown({
	Text = "Auto Hop - Region",
	Options = { "Auto", "NA", "EU", "ASIA" },
	Default = "Auto",
	DependsOn = questAutoHop,
	Callback = placeholder("Auto Hop - Region"),
})

--=============================================================
--  DUNGEON
--=============================================================
local dungeonTab = window:CreateTab("Dungeon")

dungeonTab:AddSection("Cards")
dungeonTab:AddToggle({
	Text = "Auto Pick Card",
	Default = false,
	Callback = placeholder("Auto Pick Card"),
})
dungeonTab:AddMultiDropdown({
	Title = "Cards Not To Pick",
	Options = { "Card A", "Card B", "Card C" }, -- TODO
	Default = {},
	Callback = placeholder("Cards Not To Pick"),
})
dungeonTab:AddMultiDropdown({
	Title = "Cards Always To Pick",
	Options = { "Card A", "Card B", "Card C" }, -- TODO
	Default = {},
	Callback = placeholder("Cards Always To Pick"),
})
dungeonTab:AddMultiDropdown({
	Title = "Card Type Priority",
	Options = { "Damage", "Health", "Utility" }, -- TODO
	Default = {},
	Callback = placeholder("Card Type Priority"),
})

--=============================================================
--  PLAYER  (universal logic, implemented)
--=============================================================
local playerTab = window:CreateTab("Player")

local state = {
	speed = 16,
	jumpPower = 50,
	jumpEnabled = false,
	noclip = false,
	fov = 70,
}
local noclipConn = nil

local function getHumanoid()
	local char = LocalPlayer.Character
	return char and char:FindFirstChildOfClass("Humanoid") or nil
end

local function applyJump()
	local hum = getHumanoid()
	if hum then
		hum.UseJumpPower = true
		hum.JumpPower = state.jumpEnabled and state.jumpPower or 50
	end
end

local function applyNoclip()
	local char = LocalPlayer.Character
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not state.noclip
		end
	end
end

local function refresh()
	local hum = getHumanoid()
	if hum then hum.WalkSpeed = state.speed end
	applyJump()
	applyNoclip()
end

local function setNoclip(on)
	state.noclip = on
	if on then
		applyNoclip()
		if noclipConn then noclipConn:Disconnect() end
		noclipConn = RunService.Stepped:Connect(applyNoclip)
	else
		if noclipConn then noclipConn:Disconnect() noclipConn = nil end
		applyNoclip()
	end
end

LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	refresh()
end)

playerTab:AddSection("Movement")
playerTab:AddToggle({
	Text = "Noclip",
	Default = false,
	Callback = function(on) setNoclip(on) end,
})
local highJump = playerTab:AddToggle({
	Text = "High Jump",
	Default = false,
	Callback = function(on) state.jumpEnabled = on; applyJump() end,
})
playerTab:AddSlider({
	Text = "High Jump Height",
	Min = 50, Max = 500, Default = 100, Suffix = " studs",
	DependsOn = highJump,
	Callback = function(v) state.jumpPower = v; applyJump() end,
})
playerTab:AddSlider({
	Text = "Unlimited FOV",
	Min = 70, Max = 200, Default = 70,
	Callback = function(v)
		state.fov = v
		if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = v end
	end,
})
playerTab:AddSlider({
	Text = "Movement Speed",
	Min = 16, Max = 500, Default = 16,
	Callback = function(v)
		state.speed = v
		local hum = getHumanoid()
		if hum then hum.WalkSpeed = v end
	end,
})

--=============================================================
--  TRAINING
--=============================================================
local trainTab = window:CreateTab("Training")

trainTab:AddSection("Dojo Drills")
trainTab:AddToggle({ Text = "Auto Push Ups", Default = false, Callback = placeholder("Auto Push Ups") })
trainTab:AddToggle({ Text = "Auto Meditation", Default = false, Callback = placeholder("Auto Meditation") })
trainTab:AddToggle({ Text = "Auto Squats", Default = false, Callback = placeholder("Auto Squats") })
trainTab:AddToggle({ Text = "Auto Boulder Split", Default = false, Callback = placeholder("Auto Boulder Split") })
trainTab:AddToggle({ Text = "Auto Boulder Push", Default = false, Callback = placeholder("Auto Boulder Push") })
trainTab:AddToggle({ Text = "Instant Training Complete", Default = false, Callback = placeholder("Instant Training Complete") })

trainTab:AddSection("Auto Skill Tree")
trainTab:AddLabel("Skill Points Balance: 0")  -- update this from a loop reading the game's stat
local autoAllocate = trainTab:AddToggle({
	Text = "Auto Allocate Skill Points On Level Up",
	Default = false,
	Callback = placeholder("Auto Allocate Skill Points"),
})
trainTab:AddDropdown({
	Text = "Allocation Priority",
	Options = { "Strength", "Defense", "Speed", "Ki" }, -- TODO
	Default = "Strength",
	DependsOn = autoAllocate,
	Callback = placeholder("Allocation Priority"),
})
trainTab:AddButton({
	Text = "Allocate All Available Skill Points",
	Callback = placeholder("Allocate All Skill Points"),
})

--=============================================================
--  COMBAT
--=============================================================
local combatTab = window:CreateTab("Combat")

combatTab:AddSection("Offense")
combatTab:AddSlider({
	Text = "Kill Aura",
	Min = 0, Max = 100, Default = 0, Suffix = " studs",
	Callback = placeholder("Kill Aura"),
})
combatTab:AddToggle({ Text = "Auto Attack", Default = false, Callback = placeholder("Auto Attack") })
combatTab:AddSlider({
	Text = "AA Speed",
	Min = 1, Max = 20, Default = 5,
	Callback = placeholder("AA Speed"),
})
combatTab:AddDropdown({
	Text = "Equip Weapon",
	Options = { "Weapon 1", "Weapon 2", "Weapon 3" }, -- TODO
	Default = "Weapon 1",
	Callback = placeholder("Equip Weapon"),
})
combatTab:AddDropdown({
	Text = "Auto Skills",
	Options = { "Skill 1", "Skill 2", "Skill 3" }, -- TODO
	Default = "Skill 1",
	Callback = placeholder("Auto Skills"),
})
combatTab:AddToggle({ Text = "TP All Mobs To Person", Default = false, Callback = placeholder("TP All Mobs") })

combatTab:AddSection("Defense")
local hitboxes = combatTab:AddToggle({
	Text = "Enemy Hitboxes",
	Default = false,
	Callback = placeholder("Enemy Hitboxes"),
})
combatTab:AddSlider({
	Text = "Expand Enemy Hitboxes",
	Min = 0, Max = 10, Default = 1, Suffix = "x",
	DependsOn = hitboxes,
	Callback = placeholder("Expand Enemy Hitboxes"),
})
combatTab:AddToggle({ Text = "Auto Parry / Block", Default = false, Callback = placeholder("Auto Parry / Block") })

--== ready ==--
lib:Notify({ Title = "Sakka Hub", Content = "Loaded. Press RightControl to toggle.", Duration = 4 })
