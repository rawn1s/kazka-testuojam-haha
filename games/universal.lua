-- games/universal.lua

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Sakka Hub",
    SubTitle = "by rawn1s",
    TabWidth = 160,
    Size = UDim2.fromOffset(880, 580),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Define Tabs (Settings positioned below Combat)
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

FarmingSection1:AddToggle("AutoHopBoss", { Title = "Auto Hop After Boss Kill", Default = false })

FarmingSection1:AddInput("HopSettings1", {
    Title = "Auto Hop Settings (Players / Region)",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
})

FarmingSection1:AddToggle("AutoCollectChest", { Title = "Auto Collect Chest", Default = false })


local FarmingSection2 = Tabs.Farming:AddSection("Weapons / Items")

FarmingSection2:AddDropdown("WeaponDrops", {
    Title = "Auto Farm Weapon Drops (Priority)",
    Values = {"Best Available", "Katana", "Spear", "Dagger", "Halberd", "Greatsword"},
    Multi = true,
    Default = {"Best Available"},
})

FarmingSection2:AddDropdown("ItemDrops", {
    Title = "Auto Farm Item Drops (Priority)",
    Values = {"Scroll", "Pouch", "Gem", "Key", "Token", "Crystal"},
    Multi = true,
    Default = {"Scroll"},
})

FarmingSection2:AddToggle("AutoHopNoSpawn", { Title = "Auto Hop If Drop NPC Not Spawned", Default = false })

FarmingSection2:AddInput("HopSettings2", {
    Title = "Auto Hop Settings (Players / Region)",
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

FarmingSection3:AddToggle("AutoHopQuest", { Title = "Auto Hop Servers After Timed Quest", Default = false })


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungeonSection = Tabs.Dungeon:AddSection("Cards")

DungeonSection:AddToggle("AutoPickCard", { Title = "Auto Pick Card", Default = false })

DungeonSection:AddDropdown("CardsBlacklist", {
    Title = "What Cards NOT to Pick",
    Values = {"Card A", "Card B", "Card C", "Card D", "Card E"},
    Multi = true,
    Default = {},
})

DungeonSection:AddDropdown("CardsWhitelist", {
    Title = "What Cards ALWAYS to Pick",
    Values = {"Card X", "Card Y", "Card Z"},
    Multi = true,
    Default = {},
})

DungeonSection:AddDropdown("CardTypePriority", {
    Title = "Card TYPE Priority",
    Values = {"Damage", "Defense", "Utility", "Speed"},
    Multi = true,
    Default = {"Damage"},
})


-- ==========================================
-- -- PLAYER TAB
-- ==========================================
local PlayerSection = Tabs.Player:AddSection("Movement")

PlayerSection:AddToggle("Noclip", { Title = "Noclip", Default = false })
PlayerSection:AddToggle("HighJumpToggle", { Title = "High Jump", Default = false })

PlayerSection:AddSlider("HighJumpHeight", {
    Title = "High Jump Height (Studs)",
    Description = "Adjust jump velocity height",
    Default = 25,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Suffix = " studs"
})

PlayerSection:AddSlider("UnlimitedFOV", {
    Title = "Unlimited FOV",
    Default = 90,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Suffix = "°"
})

PlayerSection:AddSlider("MovementSpeed", {
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
TrainingSection2:AddToggle("AutoAllocateSP", { Title = "Auto Allocate Skill Points on Level Up", Default = false })

TrainingSection2:AddDropdown("AllocationPriority", {
    Title = "Allocation Priority",
    Values = {"Max Health Focus", "Damage Focus", "Stamina Focus", "Balanced"},
    Multi = false,
    Default = 4,
})

TrainingSection2:AddButton({
    Title = "Allocate All Available Skill Points Now",
    Callback = function() end
})


-- ==========================================
-- -- COMBAT TAB
-- ==========================================
local CombatSection1 = Tabs.Combat:AddSection("Offense")

CombatSection1:AddSlider("KillAuraRange", {
    Title = "Kill Aura Range (Studs)",
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
    Title = "Expand Enemy Hitboxes (Studs)",
    Default = 2,
    Min = 2,
    Max = 20,
    Rounding = 0,
    Suffix = " studs"
})

CombatSection2:AddToggle("AutoParry", { Title = "Auto Parry / Block", Default = false })


-- ==========================================
-- -- SETTINGS / CONFIG TAB
-- ==========================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("SakkaHub")
SaveManager:SetFolder("SakkaHub/configs")
SaveManager:BuildConfigSection(Tabs.Settings)
InterfaceManager:SetupWindow(Tabs.Settings)


-- ==========================================
-- INSTANT UI PATCH ENGINE (RED ACCENTS & TITLE)
-- ==========================================
task.spawn(function()
    task.wait(0.3)
    local containers = {game:GetService("CoreGui")}
    pcall(function() if gethui then table.insert(containers, gethui()) end end)
    pcall(function() table.insert(containers, game:GetService("Players").LocalPlayer.PlayerGui) end)
    
    local redColor = Color3.fromRGB(235, 50, 50)

    for _, container in ipairs(containers) do
        pcall(function()
            for _, descendant in ipairs(container:GetDescendants()) do
                -- 1. Change Window Title text to "Sakka" in Red
                if descendant:IsA("TextLabel") and (descendant.Text:find("Sakka Hub") or descendant.Text == "Sakka Hub") then
                    descendant.Text = "Sakka"
                    descendant.TextColor3 = redColor
                    descendant.TextXAlignment = Enum.TextXAlignment.Left
                end

                -- 2. Force Blue Toggles, Tab Indicators, and Active Bars to Red
                if descendant:IsA("Frame" ) or descendant:IsA("TextButton") or descendant:IsA("ImageLabel") then
                    -- Check if it matches Fluent's default blue accent range
                    local col = descendant.BackgroundColor3
                    if (col.B > col.R and col.B > col.G and col.B > 0.4) or (col.G < 0.2 and col.R < 0.2 and col.B > 0.5) then
                        descendant.BackgroundColor3 = redColor
                    end
                    
                    -- Check image or active bar colors if applicable
                    if descendant:IsA("ImageLabel") and descendant.ImageColor3.B > descendant.ImageColor3.R then
                        descendant.ImageColor3 = redColor
                    end
                end
            end
        end)
    end
end)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Sakka",
    Content = "Sakka Hub initialized with red accents!",
    Duration = 5
})
