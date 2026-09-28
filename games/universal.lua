-- games/universal.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. Window Creation
local Window = Rayfield:CreateWindow({
    Name = "Sakka Hub",
    LoadingTitle = "Sakka is loading...",
    LoadingSubtitle = "by rawn1s",
    Theme = "Default",

    ConfigurationSaving = {
       Enabled = true,
       FolderName = "SakkaHub",
       FileName = "UniversalConfig"
    },
    
    Discord = {
       Enabled = false,
       Invite = "noinvite",
       RememberJoins = true
    },
    KeySystem = false,
})

-- ==========================================
-- -- INFORMATION TAB
-- ==========================================
local InfoTab = Window:CreateTab("Information", "info")
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
    Title = "Greetings",
    Content = "Welcome to Sakka Hub! Active and running successfully."
})

InfoTab:CreateParagraph({
    Title = "Discord Link",
    Content = "discord.gg/sakku"
})


-- ==========================================
-- -- FARMING TAB
-- ==========================================
local FarmingTab = Window:CreateTab("Farming", "swords")

-- --- Mobs / Bosses Section
local MobsSection = FarmingTab:CreateSection("Mobs / Bosses")

MobsSection:CreateDropdown({
    Name = "Boss / NPC Selection",
    Options = {"Bandit", "Mother Bear", "Boss Placeholder"},
    CurrentOption = {"Bandit"},
    MultipleOptions = true,
    Flag = "BossSelection",
    Callback = function(Option) end,
})

MobsSection:CreateToggle({
    Name = "Auto Hop After Boss Kill",
    CurrentValue = false,
    Flag = "AutoHopBoss",
    Callback = function(Value) end,
})

MobsSection:CreateInput({
    Name = "Auto Hop Settings (Players / Region)",
    PlaceholderText = "Max Players: 5, Region: US",
    RemoveTextOnFocusLost = false,
    Callback = function(Text) end,
})

MobsSection:CreateToggle({
    Name = "Auto Collect Chest",
    CurrentValue = false,
    Flag = "AutoCollectChest",
    Callback = function(Value) end,
})

-- --- Weapons / Items Section
local WeaponsSection = FarmingTab:CreateSection("Weapons / Items")

WeaponsSection:CreateDropdown({
    Name = "Auto Farm Weapon Drops (Priority)",
    Options = {"Best Available", "Katana", "Spear"},
    CurrentOption = {"Best Available"},
    MultipleOptions = true,
    Flag = "WeaponDrops",
    Callback = function(Option) end,
})

WeaponsSection:CreateDropdown({
    Name = "Auto Farm Item Drops (Priority)",
    Options = {"Scroll", "Pouch", "Gem"},
    CurrentOption = {"Scroll"},
    MultipleOptions = true,
    Flag = "ItemDrops",
    Callback = function(Option) end,
})

WeaponsSection:CreateToggle({
    Name = "Auto Hop If Drop NPC Not Spawned",
    CurrentValue = false,
    Flag = "AutoHopNoSpawn",
    Callback = function(Value) end,
})

WeaponsSection:CreateInput({
    Name = "Auto Hop Settings (Players / Region)",
    PlaceholderText = "Max Players: 5, Region: US",
    RemoveTextOnFocusLost = false,
    Callback = function(Text) end,
})

-- --- Quests Section
local QuestsSection = FarmingTab:CreateSection("Quests")

QuestsSection:CreateDropdown({
    Name = "Quest Selection",
    Options = {"Quest 1: Bandit Sweep", "Quest 2: Boss Extermination"},
    CurrentOption = {"Quest 1: Bandit Sweep"},
    MultipleOptions = false,
    Flag = "QuestSelection",
    Callback = function(Option) end,
})

QuestsSection:CreateToggle({
    Name = "Auto Hop Servers After Timed Quest",
    CurrentValue = false,
    Flag = "AutoHopQuest",
    Callback = function(Value) end,
})


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungeonTab = Window:CreateTab("Dungeon", "shield")
local CardsSection = DungeonTab:CreateSection("Cards")

CardsSection:CreateToggle({
    Name = "Auto Pick Card",
    CurrentValue = false,
    Flag = "AutoPickCard",
    Callback = function(Value) end,
})

CardsSection:CreateDropdown({
    Name = "What Cards NOT to Pick",
    Options = {"Card A", "Card B"},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "CardsBlacklist",
    Callback = function(Option) end,
})

CardsSection:CreateDropdown({
    Name = "What Cards ALWAYS to Pick",
    Options = {"Card X", "Card Y"},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "CardsWhitelist",
    Callback = function(Option) end,
})

CardsSection:CreateDropdown({
    Name = "Card TYPE Priority",
    Options = {"Damage", "Defense", "Utility"},
    CurrentOption = {"Damage"},
    MultipleOptions = true,
    Flag = "CardTypePriority",
    Callback = function(Option) end,
})


-- ==========================================
-- -- PLAYER TAB
-- ==========================================
local PlayerTab = Window:CreateTab("Player", "user")
local MovementSection = PlayerTab:CreateSection("Movement")

MovementSection:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value) end,
})

MovementSection:CreateToggle({
    Name = "High Jump",
    CurrentValue = false,
    Flag = "HighJumpToggle",
    Callback = function(Value) end,
})

MovementSection:CreateSlider({
    Name = "High Jump Height (Studs)",
    Range = {10, 100},
    Increment = 5,
    Suffix = " studs",
    CurrentValue = 25,
    Flag = "HighJumpHeight",
    Callback = function(Value) end,
})

MovementSection:CreateSlider({
    Name = "Unlimited FOV",
    Range = {70, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 90,
    Flag = "UnlimitedFOV",
    Callback = function(Value) end,
})

MovementSection:CreateSlider({
    Name = "Movement Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = " spd",
    CurrentValue = 16,
    Flag = "MovementSpeed",
    Callback = function(Value) end,
})


-- ==========================================
-- -- TRAINING TAB
-- ==========================================
local TrainingTab = Window:CreateTab("Training", "dumbbell")

-- --- Dojo Drills Section
local DrillsSection = TrainingTab:CreateSection("Dojo Drills")

DrillsSection:CreateToggle({Name = "Auto Push Ups", CurrentValue = false, Callback = function() end})
DrillsSection:CreateToggle({Name = "Auto Meditation", CurrentValue = false, Callback = function() end})
DrillsSection:CreateToggle({Name = "Auto Squats", CurrentValue = false, Callback = function() end})
DrillsSection:CreateToggle({Name = "Auto Boulder Split", CurrentValue = false, Callback = function() end})
DrillsSection:CreateToggle({Name = "Auto Boulder Push", CurrentValue = false, Callback = function() end})
DrillsSection:CreateToggle({Name = "Instant Training Complete", CurrentValue = false, Callback = function() end})

-- --- Auto Skill Tree Section
local SkillTreeSection = TrainingTab:CreateSection("Auto Skill Tree")

SkillTreeSection:CreateParagraph({
    Title = "Skill Points Balance",
    Content = "Current Unspent Skill Points: 0 SP"
})

SkillTreeSection:CreateToggle({
    Name = "Auto Allocate Skill Points on Level Up",
    CurrentValue = false,
    Callback = function(Value) end,
})

SkillTreeSection:CreateDropdown({
    Name = "Allocation Priority",
    Options = {"Max Health Focus", "Damage Focus", "Stamina Focus", "Balanced"},
    CurrentOption = {"Balanced"},
    MultipleOptions = false,
    Callback = function(Option) end,
})

SkillTreeSection:CreateButton({
    Name = "Allocate All Available Skill Points Now",
    Callback = function() end,
})


-- ==========================================
-- -- COMBAT TAB
-- ==========================================
local CombatTab = Window:CreateTab("Combat", "swords")

-- --- Offense Section
local OffenseSection = CombatTab:CreateSection("Offense")

OffenseSection:CreateSlider({
    Name = "Kill Aura Range (Studs)",
    Range = {0, 50},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 0,
    Callback = function(Value) end,
})

OffenseSection:CreateToggle({Name = "Auto Attack", CurrentValue = false, Callback = function() end})

OffenseSection:CreateSlider({
    Name = "AA Speed",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "x",
    CurrentValue = 1,
    Callback = function(Value) end,
})

OffenseSection:CreateDropdown({
    Name = "Equip Weapon",
    Options = {"Weapon 1", "Weapon 2"},
    CurrentOption = {"Weapon 1"},
    Callback = function() end,
})

OffenseSection:CreateDropdown({
    Name = "Auto Skills",
    Options = {"Skill A", "Skill B", "Skill C"},
    CurrentOption = {},
    MultipleOptions = true,
    Callback = function() end,
})

OffenseSection:CreateToggle({Name = "TP All Mobs to Person", CurrentValue = false, Callback = function() end})

-- --- Defense Section
local DefenseSection = CombatTab:CreateSection("Defense")

DefenseSection:CreateToggle({
    Name = "Enemy Hitboxes",
    CurrentValue = false,
    Callback = function(Value) end,
})

DefenseSection:CreateSlider({
    Name = "Expand Enemy Hitboxes (Studs)",
    Range = {2, 20},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 2,
    Callback = function(Value) end,
})

DefenseSection:CreateToggle({
    Name = "Auto Parry / Block",
    CurrentValue = false,
    Callback = function(Value) end,
})


Rayfield:LoadConfiguration()

-- 4. Runtime UI Patch: Title Font & Color Customization
task.spawn(function()
    task.wait(0.8)
    local containers = {game:GetService("CoreGui")}
    pcall(function() if gethui then table.insert(containers, gethui()) end end)
    pcall(function() table.insert(containers, game:GetService("Players").LocalPlayer.PlayerGui) end)
    
    for _, container in ipairs(containers) do
        pcall(function()
            for _, descendant in ipairs(container:GetDescendants()) do
                if descendant:IsA("TextLabel") and descendant.Text == "Sakka Hub" then
                    descendant.TextColor3 = Color3.fromRGB(235, 50, 50)
                    pcall(function()
                        descendant.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
                    end)
                end
            end
        end)
    end
end)
