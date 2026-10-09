--=============================================================
--  Sakka Hub  --  universal.lua
--  Loaded by loader.lua; runs in the executor.
--=============================================================

local SakkaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rawn1s/SakkaUI-library/refs/heads/main/SakkaUI.lua"))()

--== services ==--
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer      = Players.LocalPlayer

local lib = SakkaUI.new()

--== helpers ==--
local function placeholder(name)
	return function()
		lib:Notify({ Title = "Not Implemented", Content = name .. " has no game logic yet.", Duration = 3 })
	end
end

-- Shown BELOW any dropdown whose order matters.
local ORDER_NOTE = "Select in order: first = most important, last = least important"

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

--== window ==--
local window = lib:CreateWindow({
	Title = "Sakka",
	Font = Enum.Font.PermanentMarker,
	TextSize = 24,
	-- KeySystem = true, Key = "SAKKA-2026", KeyLink = "https://...",
})

window:LoadLocalAvatar()
window:SetCharacterInfo({
	Client = executorName(),
	KeyType = "Free",
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

farmTab:AddSection("Caches / Bosses")
farmTab:AddToggle({
	Text = "Auto Farm Bosses",
	Default = false,
	Callback = placeholder("Auto Farm Bosses"),
})
farmTab:AddMultiDropdown({
	Title = "Boss Selection",
	Options = {
		"Zuko", "Mother Bear", "Obanai", "Zentaro", "Sumari", "Yahari",
		"Giyu", "Reaper", "Datai", "Gyutaro", "Sanemi", "Shinobu",
		"Rengoku", "Nezura", "Gyomei", "Fujiko", "Yeti", "Tengen",
		"Doma", "Akaza", "Enru", "Water Trainee Sabito", "Serpent Trainee",
		"Insect Trainee", "Kaiden",
	},
	Default = {},
	Callback = placeholder("Boss Selection"),
})
farmTab:AddDisclaimer(ORDER_NOTE)
farmTab:AddToggle({
	Text = "Auto Farm Caches",
	Default = false,
	Callback = placeholder("Auto Farm Caches"),
})
farmTab:AddMultiDropdown({
	Title = "Cache Selection",
	Options = { "T1", "T2", "T3" },
	Default = {},
	Callback = placeholder("Cache Selection"),
})
farmTab:AddDisclaimer(ORDER_NOTE)
local autoChest = farmTab:AddToggle({
	Text = "Auto Collect Chest",
	Default = false,
	Callback = placeholder("Auto Collect Chest"),
})
farmTab:AddSlider({
	Text = "Auto Collect Chest Distance",
	Min = 1, Max = 300, Default = 20, Suffix = " studs",
	DependsOn = autoChest,
	Callback = placeholder("Auto Collect Chest Distance"),
})

farmTab:AddSection("Weapons")
farmTab:AddToggle({
	Text = "Auto Farm Weapons",
	Default = false,
	Callback = placeholder("Auto Farm Weapons"),
})
farmTab:AddMultiDropdown({
	Title = "Auto Farm Weapon Drops",
	Options = {
		"Flame Katana", "Water Katana", "Thunder Katana", "Wind Katana",
		"Insect Katana", "Serpent Katana", "Sound Katanas", "Cutlass",
		"Spear", "Tanto", "Axe and Mace", "Claws", "Sickles",
		"Blood Sickles", "Scythe", "War Fans", "Bladed Wagasa",
	},
	Default = {},
	Callback = placeholder("Auto Farm Weapon Drops"),
})
farmTab:AddDisclaimer(ORDER_NOTE)

farmTab:AddSection("Quests")
farmTab:AddMultiDropdown({
	Title = "Quest Selection",
	Options = {
		"Report to Noote (Lv 0)", "Recover the Lost Pages (Lv 0)",
		"Clear the Village Spies (Lv 0)", "Deliver Package to Elara (Lv 0)",
		"Deliver the Coded Letter (Lv 0)", "The Plate Trial (Lv 0)",
		"Defeat 3 bandits (Lv 0)", "Defeat The Bandit Boss (Lv 7)",
		"Find Betty's Gemstone (Lv 10)", "Acquire Bear Meat (Lv 10)",
		"Hunt the Bears (Lv 10)", "Fell the Mother Bear (Lv 18)",
		"Five Hundred Pennies (Lv 21)", "Serpent Breathing Training (Lv 25)",
		"Insect Breathing Training (Lv 25)", "Stone Breathing Training (Lv 25)",
		"Sound Breathing Training (Lv 25)", "Water Breathing Training (Lv 25)",
		"Wind Breathing Training (Lv 25)", "Thunder Breathing Training (Lv 25)",
		"Flame Breathing Training (Lv 25)", "Clear Kaiden's Subordinates (Lv 26)",
		"Defeat Kaiden (Lv 34)", "Clear Hoyuzo's Guard (Lv 40)",
		"Earn a Fishing Permit (Lv 45)", "The Morning Haul (Lv 45)",
		"Retrieve Ginzo's Jewelry Box (Lv 45)", "Hold the Night (Lv 47)",
		"Defeat Hoyuzo (Lv 50)", "The Good Catch (Lv 60)",
		"The Soryu Trial (Lv 62)", "The Tai Chi Trial (Lv 65)",
		"The Forge Above (Lv 65)", "Deliver Niko's Supply Box (Lv 70)",
	},
	Default = {},
	Callback = placeholder("Quest Selection"),
})
farmTab:AddDisclaimer(ORDER_NOTE)
farmTab:AddToggle({
	Text = "Auto Quest",
	Default = false,
	Callback = placeholder("Auto Quest"),
})
farmTab:AddToggle({
	Text = "Auto Repeat Quest",
	Default = false,
	Callback = placeholder("Auto Repeat Quest"),
})

farmTab:AddSection("Race")
farmTab:AddToggle({
	Text = "Auto Demon",
	Default = false,
	Callback = placeholder("Auto Demon"),
})
farmTab:AddToggle({
	Text = "Auto Slayer",
	Default = false,
	Callback = placeholder("Auto Slayer"),
})

farmTab:AddSection("Breathing Style / BDA")
-- NOTE: the dropdowns here are ALWAYS visible (no DependsOn) by design.
-- The CALLBACK checks whether the player is a slayer/demon and whether an
-- option is selected, and warns the user otherwise.
farmTab:AddToggle({
	Text = "Auto Breathing Style",
	Default = false,
	Callback = placeholder("Auto Breathing Style"),
})
farmTab:AddDropdown({
	Text = "Breathing Style",
	Options = { "Serpent", "Water", "Insect", "Thunder", "Stone", "Flame", "Wind", "Sound" },
	Default = "Serpent",
	Callback = placeholder("Breathing Style"),
})
farmTab:AddToggle({
	Text = "Auto BDA",
	Default = false,
	Callback = placeholder("Auto BDA"),
})
farmTab:AddDropdown({
	Text = "BDA",
	Options = {
		"Blood Manipulation", "Pyrokinesis", "Reaper", "Dream Manipulation",
		"Shockwave", "Obi Manipulation", "Arrow", "Tamari", "Cryokinesis",
	},
	Default = "Blood Manipulation",
	Callback = placeholder("BDA"),
})

farmTab:AddSection("Server Hop")
local autoHop = farmTab:AddToggle({
	Text = "Auto Hop",
	Default = false,
	Callback = placeholder("Auto Hop"),
})
farmTab:AddTextInput({
	Text = "Auto Hop - Max Players",
	Placeholder = "e.g. 6",
	DependsOn = autoHop,
	Callback = placeholder("Auto Hop - Max Players"),
})
farmTab:AddDropdown({
	Text = "Auto Hop - Region",
	Options = { "Auto", "NA", "EU", "ASIA" },
	Default = "Auto",
	DependsOn = autoHop,
	Callback = placeholder("Auto Hop - Region"),
})

farmTab:AddSection("Execution Priority")
farmTab:AddMultiDropdown({
	Title = "Section Priority",
	Options = {
		"Caches / Bosses", "Weapons", "Quests", "Race",
		"Breathing Style / BDA", "Server Hop",
	},
	Default = {},
	Callback = placeholder("Section Priority"),
})
farmTab:AddDisclaimer(ORDER_NOTE)

--=============================================================
--  DUNGEON / ROGUELIKE
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
	Options = { "-- add card options here --" },
	Default = {},
	Callback = placeholder("Cards Not To Pick"),
})
dungeonTab:AddDisclaimer(ORDER_NOTE)
dungeonTab:AddMultiDropdown({
	Title = "Cards Always To Pick",
	Options = { "-- add card options here --" },
	Default = {},
	Callback = placeholder("Cards Always To Pick"),
})
dungeonTab:AddDisclaimer(ORDER_NOTE)
dungeonTab:AddMultiDropdown({
	Title = "Stat Card Priority",
	Options = {
		"Damage", "HP", "Cooldown Reduction", "Block Points",
		"Stamina Regen", "Damage Reduction",
	},
	Default = {},
	Callback = placeholder("Stat Card Priority"),
})
dungeonTab:AddDisclaimer(ORDER_NOTE)

dungeonTab:AddSection("Action")
dungeonTab:AddToggle({
	Text = "Auto Start Dungeon",
	Default = false,
	Callback = placeholder("Auto Start Dungeon"),
})
dungeonTab:AddToggle({
	Text = "Auto Repeat Dungeon",
	Default = false,
	Callback = placeholder("Auto Repeat Dungeon"),
})
dungeonTab:AddTextInput({
	Text = "Auto End Dungeon At Floor",
	Placeholder = "e.g. 10",
	Callback = placeholder("Auto End Dungeon At Floor"),
})

dungeonTab:AddSection("Loot")
local function exchangePair(title, label)
	local t = dungeonTab:AddToggle({
		Text = title,
		Default = false,
		Callback = placeholder(title),
	})
	dungeonTab:AddTextInput({
		Text = label .. " - How Many Times",
		Placeholder = "e.g. 10",
		DependsOn = t,
		Callback = placeholder(label .. " - How Many Times"),
	})
	return t
end

exchangePair("Auto Open Dungeon Chest", "Open Chest")
exchangePair("Auto Exchange Wen", "Wen")
exchangePair("Auto Exchange Mythic Ore", "Mythic Ore")
exchangePair("Auto Exchange Refinement Ore", "Refinement Ore")
exchangePair("Auto Exchange EXP", "EXP")

--=============================================================
--  PLAYER  (universal - fully implemented)
--=============================================================
local playerTab = window:CreateTab("Player")

local pstate = {
	speed = 16,
	jumpPower = 50,
	jumpEnabled = false,
	noclip = false,
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
		hum.JumpPower = pstate.jumpEnabled and pstate.jumpPower or 50
	end
end

local function applyNoclip()
	local char = LocalPlayer.Character
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = not pstate.noclip
		end
	end
end

local function refreshMovement()
	local hum = getHumanoid()
	if hum then hum.WalkSpeed = pstate.speed end
	applyJump()
	applyNoclip()
end

local function setNoclip(on)
	pstate.noclip = on
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
	refreshMovement()
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
	Callback = function(on) pstate.jumpEnabled = on; applyJump() end,
})
playerTab:AddSlider({
	Text = "High Jump Height",
	Min = 50, Max = 500, Default = 100, Suffix = " studs",
	DependsOn = highJump,
	Callback = function(v) pstate.jumpPower = v; applyJump() end,
})
playerTab:AddSlider({
	Text = "Unlimited FOV",
	Min = 70, Max = 200, Default = 70,
	Callback = function(v)
		if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = v end
	end,
})
playerTab:AddSlider({
	Text = "Movement Speed",
	Min = 16, Max = 500, Default = 16,
	Callback = function(v)
		pstate.speed = v
		local hum = getHumanoid()
		if hum then hum.WalkSpeed = v end
	end,
})

--=============================================================
--  TRAINING
--=============================================================
local trainTab = window:CreateTab("Training")

trainTab:AddSection("Dojo Drills")
trainTab:AddToggle({ Text = "Auto Push Ups",            Default = false, Callback = placeholder("Auto Push Ups") })
trainTab:AddToggle({ Text = "Auto Meditation",          Default = false, Callback = placeholder("Auto Meditation") })
trainTab:AddToggle({ Text = "Auto Squats",              Default = false, Callback = placeholder("Auto Squats") })
trainTab:AddToggle({ Text = "Auto Boulder Split",       Default = false, Callback = placeholder("Auto Boulder Split") })
trainTab:AddToggle({ Text = "Auto Boulder Push",        Default = false, Callback = placeholder("Auto Boulder Push") })
trainTab:AddToggle({ Text = "Instant Training Complete",Default = false, Callback = placeholder("Instant Training Complete") })

trainTab:AddSection("Auto Skill Tree")
trainTab:AddLabel("Skill Points Balance: 0")  -- update from a polling loop reading the game's stat
local autoSkill = trainTab:AddToggle({
	Text = "Auto Allocate Skill Points On Level Up",
	Default = false,
	Callback = placeholder("Auto Allocate Skill Points On Level Up"),
})
trainTab:AddMultiDropdown({
	Title = "Allocation Priority",
	Options = {
		"Max Stamina", "Health Regen Speed", "Stamina Regen Speed",
		"Max Health", "Additional Damage", "Block Regen",
		"Block Points", "Clan Skills", "Weapon Skills",
		"BDA / Breathing Style Skills",
	},
	Default = {},
	DependsOn = autoSkill,
	Callback = placeholder("Allocation Priority"),
})
trainTab:AddDisclaimer(ORDER_NOTE)
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
	Min = 0, Max = 200, Default = 0, Suffix = " studs",
	Callback = placeholder("Kill Aura"),
})
local autoAA = combatTab:AddToggle({
	Text = "Auto Attack",
	Default = false,
	Callback = placeholder("Auto Attack"),
})
combatTab:AddSlider({
	Text = "AA Speed",
	Min = 1, Max = 20, Default = 5,
	DependsOn = autoAA,
	Callback = placeholder("AA Speed"),
})

local equipWeapon = combatTab:AddDropdown({
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

combatTab:AddMultiDropdown({
	Title = "Auto Skills",
	Options = { "-- add skill names here --" },
	Default = {},
	Callback = placeholder("Auto Skills"),
})
combatTab:AddDisclaimer(ORDER_NOTE)
local tpMobs = combatTab:AddToggle({
	Text = "TP All Mobs To Person",
	Default = false,
	Callback = placeholder("TP All Mobs To Person"),
})
combatTab:AddSlider({
	Text = "Mob TP Distance",
	Min = 0, Max = 200, Default = 10, Suffix = " studs",
	DependsOn = tpMobs,
	Callback = placeholder("Mob TP Distance"),
})

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
combatTab:AddToggle({
	Text = "Auto Parry / Block",
	Default = false,
	Callback = placeholder("Auto Parry / Block"),
})

--== ready ==--
lib:Notify({ Title = "Sakka Hub", Content = "Loaded. Press RightControl to toggle.", Duration = 4 })
