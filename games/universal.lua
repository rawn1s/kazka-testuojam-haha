-- games/universal.lua

-- 1. Load Fluent Modded & Addons from official Modded fork
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratu-s/Fluent-Modded/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratu-s/Fluent-Modded/main/Addons/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Iratu-s/Fluent-Modded/main/Addons/ThemeManager.lua"))()

-- 2. Register Custom Crimson Red Theme Natively in Modded Library
if Fluent.RegisterTheme then
    Fluent:RegisterTheme("Crimson", {
        Accent = Color3.fromRGB(235, 50, 50),
        DarkAccent = Color3.fromRGB(180, 30, 30),
        ActiveTab = Color3.fromRGB(235, 50, 50),
        AcrylicTF = false,
    })
end

-- 3. Create Main Window
local Window = Fluent:CreateWindow({
    Title = "Sakka",
    SubTitle = "by rawn1s",
    TabWidth = 160,
    Size = UDim2.fromOffset(900, 580),
    Acrylic = true,
    Theme = "Crimson", -- Natively uses our registered Crimson theme!
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Force accent color fallback for modded variations
if Fluent.SetAccentColor then
    Fluent:SetAccentColor(Color3.fromRGB(235, 50, 50))
end

-- 4. Create Window Tabs
local Tabs = {
    Information = Window:AddTab({ Title = "Information", Icon = "info" }),
    Farming     = Window:AddTab({ Title = "Farming", Icon = "sword" }),
    Dungeon     = Window:AddTab({ Title = "Dungeon", Icon = "shield" }),
    Player      = Window:AddTab({ Title = "Player", Icon = "user" }),
    Training    = Window:AddTab({ Title = "Training", Icon = "dumbbell" }),
    Combat      = Window:AddTab({ Title = "Combat", Icon = "swords" }),
    Settings    = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options


-- ==========================================
-- -- INFORMATION TAB
-- ==========================================
Tabs.Information:AddParagraph({
    Title = "Greetings",
    Content = "Welcome to Sakka Hub! Active and running successfully."
})

Tabs.Information:AddParagraph({
    Title = "Discord Link",
    Content = "discord.gg/sakku"
})


-- ==========================================
-- -- FARMING TAB
-- ==========================================
local FarmingSection1 = Tabs.Farming:AddSection("Mobs / Bosses")

FarmingSection1:AddDropdown("BossSelection", {
    Title = "Boss / NPC Selection",
    Values = {"Bandit", "Mother Bear", "Boss Placeholder", "Alpha Wolf", "Bandit Leader", "Guard"},
    Multi = true,
    Default = {"Bandit"},
})

FarmingSection1:AddToggle("AutoHopBoss", { 
    Title = "Auto Hop After Boss Kill", 
    Default = false 
})

FarmingSection1:AddInput("HopSettings1", {
    Title = "Auto Hop Settings",
    Description = "Players / Region format",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
})

FarmingSection1:AddToggle("AutoCollectChest", { 
    Title = "Auto Collect Chest", 
    Default = false 
})

local FarmingSection2 = Tabs.Farming:AddSection("Weapons & Items")

FarmingSection2:AddDropdown("WeaponDrops", {
    Title = "Auto Farm Weapon Drops",
    Values = {"Best Available", "Katana", "Spear", "Dagger", "Halberd", "Greatsword"},
    Multi = true,
    Default = {"Best Available"},
})

FarmingSection2:AddDropdown("ItemDrops", {
    Title = "Auto Farm Item Drops",
    Values = {"Scroll", "Pouch", "Gem", "Key", "Token", "Crystal"},
    Multi = true,
    Default = {"Scroll"},
})

FarmingSection2:AddToggle("AutoHopNoSpawn", { 
    Title = "Auto Hop If Drop NPC Not Spawned", 
    Default = false 
})

FarmingSection2:AddInput("HopSettings2", {
    Title = "Auto Hop Settings",
    Description = "Players / Region format",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
})

local FarmingSection3 = Tabs.Farming:AddSection("Quests")

FarmingSection3:AddDropdown("QuestSelection", {
    Title = "Quest Selection",
    Values = {"Quest 1: Bandit Sweep", "Quest 2: Boss Extermination"},
    Multi = false,
    Default = 1,
})

FarmingSection3:AddToggle("AutoHopQuest", { 
    Title = "Auto Hop Servers After Timed Quest", 
    Default = false 
})


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungeonSection1 = Tabs.Dungeon:AddSection("Cards")

DungeonSection1:AddToggle("AutoPickCard", { Title = "Auto Pick Card", Default = false })

DungeonSection1:AddDropdown("CardsBlacklist", {
    Title = "Card Blacklist",
    Description = "Ignored cards",
    Values = {"Card A", "Card B", "Card C", "Card D", "Card E"},
    Multi = true,
    Default = {},
})

local DungeonSection2 = Tabs.Dungeon:AddSection("Priorities & Whitelist")

DungeonSection2:AddDropdown("CardsWhitelist", {
    Title = "Card Whitelist",
    Description = "Priority cards",
    Values = {"Card X", "Card Y", "Card Z"},
    Multi = true,
    Default = {},
})

DungeonSection2:AddDropdown("CardTypePriority", {
    Title = "Card Type Priority",
    Values = {"Damage", "Defense", "Utility", "Speed"},
    Multi = true,
    Default = {"Damage"},
})


-- ==========================================
-- -- PLAYER TAB
-- ==========================================
local PlayerSection1 = Tabs.Player:AddSection("Movement Hacks")

PlayerSection1:AddToggle("Noclip", { Title = "Noclip", Default = false })
PlayerSection1:AddToggle("HighJumpToggle", { Title = "High Jump", Default = false })

PlayerSection1:AddSlider("HighJumpHeight", {
    Title = "High Jump Height",
    Description = "Adjust jump height",
    Default = 25,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Suffix = " studs"
})

local PlayerSection2 = Tabs.Player:AddSection("Attributes")

PlayerSection2:AddSlider("UnlimitedFOV", {
    Title = "Unlimited FOV",
    Default = 90,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Suffix = "°"
})

PlayerSection2:AddSlider("MovementSpeed", {
    Title = "Movement Speed",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Suffix = " spd"
})


-- ==========================================
-- -- TRAINING TAB
-- ==========================================
local TrainingSection1 = Tabs.Training:AddSection("Dojo Drills")

TrainingSection1:AddToggle("AutoPushUps", { Title = "Auto Push Ups", Default = false })
TrainingSection1:AddToggle("AutoMeditation", { Title = "Auto Meditation", Default = false })
TrainingSection1:AddToggle("AutoSquats", { Title = "Auto Squats", Default = false })
TrainingSection1:AddToggle("AutoBoulderSplit", { Title = "Auto Boulder Split", Default = false })
TrainingSection1:AddToggle("AutoBoulderPush", { Title = "Auto Boulder Push", Default = false })
TrainingSection1:AddToggle("InstantTraining", { Title = "Instant Training Complete", Default = false })

local TrainingSection2 = Tabs.Training:AddSection("Auto Skill Tree")

TrainingSection2:AddParagraph({ Title = "Skill Points Balance", Content = "Current Unspent Skill Points: 0 SP" })
TrainingSection2:AddToggle("AutoAllocateSP", { Title = "Auto Allocate Skill Points", Default = false })

TrainingSection2:AddDropdown("AllocationPriority", {
    Title = "Allocation Priority",
    Values = {"Max Health Focus", "Damage Focus", "Stamina Focus", "Balanced"},
    Multi = false,
    Default = 4,
})

TrainingSection2:AddButton({
    Title = "Allocate Skill Points Now",
    Callback = function() end
})


-- ==========================================
-- -- COMBAT TAB
-- ==========================================
local CombatSection1 = Tabs.Combat:AddSection("Offense")

CombatSection1:AddSlider("KillAuraRange", {
    Title = "Kill Aura Range",
    Default = 0,
    Min = 0,
    Max = 50,
    Rounding = 0,
    Suffix = " studs"
})

CombatSection1:AddToggle("AutoAttack", { Title = "Auto Attack", Default = false })

CombatSection1:AddSlider("AASpeed", {
    Title = "AA Speed",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Suffix = "x"
})

CombatSection1:AddDropdown("EquipWeapon", {
    Title = "Equip Weapon",
    Values = {"Weapon 1", "Weapon 2"},
    Multi = false,
    Default = 1,
})

CombatSection1:AddDropdown("AutoSkills", {
    Title = "Auto Skills",
    Values = {"Skill A", "Skill B", "Skill C"},
    Multi = true,
    Default = {},
})

CombatSection1:AddToggle("TPAllMobs", { Title = "TP All Mobs to Person", Default = false })

local CombatSection2 = Tabs.Combat:AddSection("Defense")

CombatSection2:AddToggle("EnemyHitboxes", { Title = "Enemy Hitboxes", Default = false })

CombatSection2:AddSlider("ExpandHitboxes", {
    Title = "Expand Enemy Hitboxes",
    Default = 2,
    Min = 2,
    Max = 20,
    Rounding = 0,
    Suffix = " studs"
})

CombatSection2:AddToggle("AutoParry", { Title = "Auto Parry / Block", Default = false })


-- ==========================================
-- -- SETTINGS & SAVE MANAGER
-- ==========================================
SaveManager:SetLibrary(Fluent)
ThemeManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

SaveManager:SetFolder("Sakka")
SaveManager:SetFolder("Sakka/configs")
ThemeManager:SetFolder("Sakka/themes")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Sakka",
    Content = "Loaded cleanly with Fluent Modded & Crimson Red Theme!",
    Duration = 5
})
