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
InfoTab:CreateSection("Hub Details")

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

FarmingTab:CreateSection("Mobs / Bosses")

FarmingTab:CreateDropdown({
    Name = "Boss / NPC Selection",
    Options = {"Bandit", "Mother Bear", "Boss Placeholder", "Alpha Wolf", "Bandit Leader", "Guard"},
    CurrentOption = {"Bandit"},
    MultipleOptions = true,
    Flag = "BossSelection",
    Callback = function(Option) end,
})

FarmingTab:CreateToggle({
    Name = "Auto Hop After Boss Kill",
    CurrentValue = false,
    Flag = "AutoHopBoss",
    Callback = function(Value) end,
})

FarmingTab:CreateInput({
    Name = "Auto Hop Settings (Players / Region)",
    PlaceholderText = "Max Players: 5, Region: US",
    RemoveTextOnFocusLost = false,
    Callback = function(Text) end,
})

FarmingTab:CreateToggle({
    Name = "Auto Collect Chest",
    CurrentValue = false,
    Flag = "AutoCollectChest",
    Callback = function(Value) end,
})

FarmingTab:CreateSection("Weapons / Items")

FarmingTab:CreateDropdown({
    Name = "Auto Farm Weapon Drops (Priority)",
    Options = {"Best Available", "Katana", "Spear", "Dagger", "Halberd", "Greatsword"},
    CurrentOption = {"Best Available"},
    MultipleOptions = true,
    Flag = "WeaponDrops",
    Callback = function(Option) end,
})

FarmingTab:CreateDropdown({
    Name = "Auto Farm Item Drops (Priority)",
    Options = {"Scroll", "Pouch", "Gem", "Key", "Token", "Crystal"},
    CurrentOption = {"Scroll"},
    MultipleOptions = true,
    Flag = "ItemDrops",
    Callback = function(Option) end,
})

FarmingTab:CreateToggle({
    Name = "Auto Hop If Drop NPC Not Spawned",
    CurrentValue = false,
    Flag = "AutoHopNoSpawn",
    Callback = function(Value) end,
})

FarmingTab:CreateInput({
    Name = "Auto Hop Settings (Players / Region)",
    PlaceholderText = "Max Players: 5, Region: US",
    RemoveTextOnFocusLost = false,
    Callback = function(Text) end,
})

FarmingTab:CreateSection("Quests")

FarmingTab:CreateDropdown({
    Name = "Quest Selection",
    Options = {"Quest 1: Bandit Sweep", "Quest 2: Boss Extermination"},
    CurrentOption = {"Quest 1: Bandit Sweep"},
    MultipleOptions = false,
    Flag = "QuestSelection",
    Callback = function(Option) end,
})

FarmingTab:CreateToggle({
    Name = "Auto Hop Servers After Timed Quest",
    CurrentValue = false,
    Flag = "AutoHopQuest",
    Callback = function(Value) end,
})


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungeonTab = Window:CreateTab("Dungeon", "shield")
DungeonTab:CreateSection("Cards")

DungeonTab:CreateToggle({
    Name = "Auto Pick Card",
    CurrentValue = false,
    Flag = "AutoPickCard",
    Callback = function(Value) end,
})

DungeonTab:CreateDropdown({
    Name = "What Cards NOT to Pick",
    Options = {"Card A", "Card B", "Card C", "Card D", "Card E"},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "CardsBlacklist",
    Callback = function(Value) end,
})

DungeonTab:CreateDropdown({
    Name = "What Cards ALWAYS to Pick",
    Options = {"Card X", "Card Y", "Card Z"},
    CurrentOption = {},
    MultipleOptions = true,
    Flag = "CardsWhitelist",
    Callback = function(Value) end,
})

DungeonTab:CreateDropdown({
    Name = "Card TYPE Priority",
    Options = {"Damage", "Defense", "Utility", "Speed"},
    CurrentOption = {"Damage"},
    MultipleOptions = true,
    Flag = "CardTypePriority",
    Callback = function(Value) end,
})


-- ==========================================
-- -- PLAYER TAB
-- ==========================================
local PlayerTab = Window:CreateTab("Player", "user")
PlayerTab:CreateSection("Movement")

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value) end,
})

PlayerTab:CreateToggle({
    Name = "High Jump",
    CurrentValue = false,
    Flag = "HighJumpToggle",
    Callback = function(Value) end,
})

PlayerTab:CreateSlider({
    Name = "High Jump Height (Studs)",
    Range = {10, 100},
    Increment = 5,
    Suffix = " studs",
    CurrentValue = 25,
    Flag = "HighJumpHeight",
    Callback = function(Value) end,
})

PlayerTab:CreateSlider({
    Name = "Unlimited FOV",
    Range = {70, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 90,
    Flag = "UnlimitedFOV",
    Callback = function(Value) end,
})

PlayerTab:CreateSlider({
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

TrainingTab:CreateSection("Dojo Drills")
TrainingTab:CreateToggle({Name = "Auto Push Ups", CurrentValue = false, Callback = function() end})
TrainingTab:CreateToggle({Name = "Auto Meditation", CurrentValue = false, Callback = function() end})
TrainingTab:CreateToggle({Name = "Auto Squats", CurrentValue = false, Callback = function() end})
TrainingTab:CreateToggle({Name = "Auto Boulder Split", CurrentValue = false, Callback = function() end})
TrainingTab:CreateToggle({Name = "Auto Boulder Push", CurrentValue = false, Callback = function() end})
TrainingTab:CreateToggle({Name = "Instant Training Complete", CurrentValue = false, Callback = function() end})

TrainingTab:CreateSection("Auto Skill Tree")
TrainingTab:CreateParagraph({
    Title = "Skill Points Balance",
    Content = "Current Unspent Skill Points: 0 SP"
})

TrainingTab:CreateToggle({
    Name = "Auto Allocate Skill Points on Level Up",
    CurrentValue = false,
    Callback = function(Value) end,
})

TrainingTab:CreateDropdown({
    Name = "Allocation Priority",
    Options = {"Max Health Focus", "Damage Focus", "Stamina Focus", "Balanced"},
    CurrentOption = {"Balanced"},
    MultipleOptions = false,
    Callback = function(Option) end,
})

TrainingTab:CreateButton({
    Name = "Allocate All Available Skill Points Now",
    Callback = function() end,
})


-- ==========================================
-- -- COMBAT TAB
-- ==========================================
local CombatTab = Window:CreateTab("Combat", "swords")

CombatTab:CreateSection("Offense")
CombatTab:CreateSlider({
    Name = "Kill Aura Range (Studs)",
    Range = {0, 50},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 0,
    Callback = function(Value) end,
})

CombatTab:CreateToggle({Name = "Auto Attack", CurrentValue = false, Callback = function() end})

CombatTab:CreateSlider({
    Name = "AA Speed",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "x",
    CurrentValue = 1,
    Callback = function(Value) end,
})

CombatTab:CreateDropdown({
    Name = "Equip Weapon",
    Options = {"Weapon 1", "Weapon 2"},
    CurrentOption = {"Weapon 1"},
    Callback = function() end,
})

CombatTab:CreateDropdown({
    Name = "Auto Skills",
    Options = {"Skill A", "Skill B", "Skill C"},
    CurrentOption = {},
    MultipleOptions = true,
    Callback = function() end,
})

CombatTab:CreateToggle({Name = "TP All Mobs to Person", CurrentValue = false, Callback = function() end})

CombatTab:CreateSection("Defense")
CombatTab:CreateToggle({
    Name = "Enemy Hitboxes",
    CurrentValue = false,
    Callback = function(Value) end,
})

CombatTab:CreateSlider({
    Name = "Expand Enemy Hitboxes (Studs)",
    Range = {2, 20},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 2,
    Callback = function(Value) end,
})

CombatTab:CreateToggle({
    Name = "Auto Parry / Block",
    CurrentValue = false,
    Callback = function(Value) end,
})


Rayfield:LoadConfiguration()

-- ==========================================
-- 4. RUNTIME UI PATCH & CUSTOMIZATION ENGINE
-- ==========================================
task.spawn(function()
    task.wait(0.8)
    local containers = {game:GetService("CoreGui")}
    pcall(function() if gethui then table.insert(containers, gethui()) end end)
    pcall(function() table.insert(containers, game:GetService("Players").LocalPlayer.PlayerGui) end)
    
    for _, container in ipairs(containers) do
        pcall(function()
            for _, descendant in ipairs(container:GetDescendants()) do
                -- 1. Red Title Styling & Full Left-Alignment Fix
                if descendant:IsA("TextLabel") and descendant.Text == "Sakka Hub" then
                    descendant.TextColor3 = Color3.fromRGB(235, 50, 50)
                    descendant.TextXAlignment = Enum.TextXAlignment.Left
                    pcall(function()
                        descendant.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
                    end)
                    -- Adjust parent container if it has center/right padding
                    if descendant.Parent and descendant.Parent:IsA("GuiObject") then
                        descendant.Parent.Position = UDim2.new(0, 12, descendant.Parent.Position.Y.Scale, descendant.Parent.Position.Y.Offset)
                    end
                end

                -- 2. Expand Main Window Size & Proportional Layout
                if descendant.Name == "Main" and descendant:IsA("Frame") then
                    descendant.Size = UDim2.new(0, 880, 0, 580)
                end

                -- 3. Red Toggle Switch Override (Turning blue toggles red)
                if descendant:IsA("Frame") and (descendant.Name == "Toggle" or descendant.Name == "Switch" or descendant.Name == "Indicator" or descendant.Name == "State") then
                    if descendant.BackgroundColor3.B > descendant.BackgroundColor3.R then
                        descendant.BackgroundColor3 = Color3.fromRGB(235, 50, 50)
                    end
                end

                -- 4. Dropdown Multi-Selection Text Customization ("Various" -> exact names up to 5 + "...")
                if descendant:IsA("TextLabel") and descendant.Text == "Various" then
                    descendant.Text = "Selection..."
                end
            end
        end)
    end
end)
