-- games/universal.lua

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- ==========================================
-- 1. FORCE RED ACCENT THEME OVERRIDES
-- ==========================================
local CrimsonRed = Color3.fromRGB(235, 50, 50)
local DarkCrimson = Color3.fromRGB(180, 30, 30)

if Fluent.Themes then
    for themeName, themeTable in pairs(Fluent.Themes) do
        if type(themeTable) == "table" then
            themeTable.Accent = CrimsonRed
            themeTable.DarkAccent = DarkCrimson
        end
    end
end

-- ==========================================
-- 2. CREATE WINDOW & TABS
-- ==========================================
local Window = Fluent:CreateWindow({
    Title = "Sakka",
    SubTitle = "by rawn1s",
    TabWidth = 160,
    Size = UDim2.fromOffset(880, 580),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

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
-- HELPERS: 2-COLUMN LAYOUT & STACKED ELEMENTS
-- ==========================================
local function CreateTwoColumns(Tab)
    local ColumnHolder = Instance.new("Frame")
    ColumnHolder.Name = "ColumnHolder"
    ColumnHolder.Size = UDim2.new(1, 0, 0, 0)
    ColumnHolder.AutomaticSize = Enum.AutomaticSize.Y
    ColumnHolder.BackgroundTransparency = 1
    ColumnHolder.Parent = Tab.Container

    local LeftColumn = Instance.new("Frame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.49, 0, 0, 0)
    LeftColumn.Position = UDim2.new(0, 0, 0, 0)
    LeftColumn.AutomaticSize = Enum.AutomaticSize.Y
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.Parent = ColumnHolder

    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 10)
    LeftLayout.Parent = LeftColumn

    local RightColumn = Instance.new("Frame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.49, 0, 0, 0)
    RightColumn.Position = UDim2.new(0.51, 0, 0, 0)
    RightColumn.AutomaticSize = Enum.AutomaticSize.Y
    RightColumn.BackgroundTransparency = 1
    RightColumn.Parent = ColumnHolder

    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 10)
    RightLayout.Parent = RightColumn

    return LeftColumn, RightColumn
end

-- Function to stack element title on top and control box below
local function StackElement(element)
    if not element or not element.Frame then return element end
    task.defer(function()
        pcall(function()
            local frame = element.Frame
            frame.Size = UDim2.new(1, 0, 0, 62)
            
            -- Disable horizontal list layout if present
            for _, child in ipairs(frame:GetChildren()) do
                if child:IsA("UIListLayout") then
                    child.Enabled = false
                end
            end
            
            local titleLabel = frame:FindFirstChildWhichIsA("TextLabel", true)
            local controlBox = nil
            
            for _, child in ipairs(frame:GetChildren()) do
                if (child:IsA("Frame") or child:IsA("TextButton") or child:IsA("ImageLabel")) and child ~= titleLabel then
                    controlBox = child
                    break
                end
            end
            
            if titleLabel then
                titleLabel.Position = UDim2.new(0, 10, 0, 4)
                titleLabel.Size = UDim2.new(1, -20, 0, 20)
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.TextTruncate = Enum.TextTruncate.None
            end
            
            if controlBox then
                controlBox.Position = UDim2.new(0, 10, 0, 28)
                controlBox.Size = UDim2.new(1, -20, 0, 28)
            end
        end)
    end)
    return element
end


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
local FarmLeft, FarmRight = CreateTwoColumns(Tabs.Farming)

-- Left Column: Mobs & Quests
Tabs.Farming.Container = FarmLeft
local FarmingSection1 = Tabs.Farming:AddSection("Mobs / Bosses")
StackElement(FarmingSection1:AddDropdown("BossSelection", {
    Title = "Boss / NPC Selection",
    Values = {"Bandit", "Mother Bear", "Boss Placeholder", "Alpha Wolf", "Bandit Leader", "Guard"},
    Multi = true,
    Default = {"Bandit"},
}))
FarmingSection1:AddToggle("AutoHopBoss", { Title = "Auto Hop After Boss Kill", Default = false })
StackElement(FarmingSection1:AddInput("HopSettings1", {
    Title = "Auto Hop Settings (Players / Region)",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
}))
FarmingSection1:AddToggle("AutoCollectChest", { Title = "Auto Collect Chest", Default = false })

local FarmingSection3 = Tabs.Farming:AddSection("Quests")
StackElement(FarmingSection3:AddDropdown("QuestSelection", {
    Title = "Quest Selection",
    Values = {"Quest 1: Bandit Sweep", "Quest 2: Boss Extermination"},
    Multi = false,
    Default = 1,
}))
FarmingSection3:AddToggle("AutoHopQuest", { Title = "Auto Hop Servers After Timed Quest", Default = false })

-- Right Column: Weapons & Items
Tabs.Farming.Container = FarmRight
local FarmingSection2 = Tabs.Farming:AddSection("Weapons / Items")
StackElement(FarmingSection2:AddDropdown("WeaponDrops", {
    Title = "Auto Farm Weapon Drops (Priority)",
    Values = {"Best Available", "Katana", "Spear", "Dagger", "Halberd", "Greatsword"},
    Multi = true,
    Default = {"Best Available"},
}))
StackElement(FarmingSection2:AddDropdown("ItemDrops", {
    Title = "Auto Farm Item Drops (Priority)",
    Values = {"Scroll", "Pouch", "Gem", "Key", "Token", "Crystal"},
    Multi = true,
    Default = {"Scroll"},
}))
FarmingSection2:AddToggle("AutoHopNoSpawn", { Title = "Auto Hop If Drop NPC Not Spawned", Default = false })
StackElement(FarmingSection2:AddInput("HopSettings2", {
    Title = "Auto Hop Settings (Players / Region)",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
}))


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungLeft, DungRight = CreateTwoColumns(Tabs.Dungeon)

-- Left Column: Cards
Tabs.Dungeon.Container = DungLeft
local DungeonSection1 = Tabs.Dungeon:AddSection("Cards")
DungeonSection1:AddToggle("AutoPickCard", { Title = "Auto Pick Card", Default = false })
StackElement(DungeonSection1:AddDropdown("CardsBlacklist", {
    Title = "What Cards NOT to Pick",
    Values = {"Card A", "Card B", "Card C", "Card D", "Card E"},
    Multi = true,
    Default = {},
}))

-- Right Column: Priorities
Tabs.Dungeon.Container = DungRight
local DungeonSection2 = Tabs.Dungeon:AddSection("Priorities & Whitelist")
StackElement(DungeonSection2:AddDropdown("CardsWhitelist", {
    Title = "What Cards ALWAYS to Pick",
    Values = {"Card X", "Card Y", "Card Z"},
    Multi = true,
    Default = {},
}))
StackElement(DungeonSection2:AddDropdown("CardTypePriority", {
    Title = "Card TYPE Priority",
    Values = {"Damage", "Defense", "Utility", "Speed"},
    Multi = true,
    Default = {"Damage"},
}))


-- ==========================================
-- -- PLAYER TAB
-- ==========================================
local PlayLeft, PlayRight = CreateTwoColumns(Tabs.Player)

Tabs.Player.Container = PlayLeft
local PlayerSection1 = Tabs.Player:AddSection("Movement Hacks")
PlayerSection1:AddToggle("Noclip", { Title = "Noclip", Default = false })
PlayerSection1:AddToggle("HighJumpToggle", { Title = "High Jump", Default = false })
StackElement(PlayerSection1:AddSlider("HighJumpHeight", {
    Title = "High Jump Height (Studs)",
    Description = "Adjust jump velocity height",
    Default = 25,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Suffix = " studs"
}))

Tabs.Player.Container = PlayRight
local PlayerSection2 = Tabs.Player:AddSection("Attributes")
StackElement(PlayerSection2:AddSlider("UnlimitedFOV", {
    Title = "Unlimited FOV",
    Default = 90,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Suffix = "°"
}))
StackElement(PlayerSection2:AddSlider("MovementSpeed", {
    Title = "Movement Speed",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Suffix = " spd"
}))


-- ==========================================
-- -- TRAINING TAB
-- ==========================================
local TrainLeft, TrainRight = CreateTwoColumns(Tabs.Training)

Tabs.Training.Container = TrainLeft
local TrainingSection1 = Tabs.Training:AddSection("Dojo Drills")
TrainingSection1:AddToggle("AutoPushUps", { Title = "Auto Push Ups", Default = false })
TrainingSection1:AddToggle("AutoMeditation", { Title = "Auto Meditation", Default = false })
TrainingSection1:AddToggle("AutoSquats", { Title = "Auto Squats", Default = false })
TrainingSection1:AddToggle("AutoBoulderSplit", { Title = "Auto Boulder Split", Default = false })
TrainingSection1:AddToggle("AutoBoulderPush", { Title = "Auto Boulder Push", Default = false })
TrainingSection1:AddToggle("InstantTraining", { Title = "Instant Training Complete", Default = false })

Tabs.Training.Container = TrainRight
local TrainingSection2 = Tabs.Training:AddSection("Auto Skill Tree")
TrainingSection2:AddParagraph({ Title = "Skill Points Balance", Content = "Current Unspent Skill Points: 0 SP" })
TrainingSection2:AddToggle("AutoAllocateSP", { Title = "Auto Allocate Skill Points on Level Up", Default = false })
StackElement(TrainingSection2:AddDropdown("AllocationPriority", {
    Title = "Allocation Priority",
    Values = {"Max Health Focus", "Damage Focus", "Stamina Focus", "Balanced"},
    Multi = false,
    Default = 4,
}))
TrainingSection2:AddButton({
    Title = "Allocate All Available Skill Points Now",
    Callback = function() end
})


-- ==========================================
-- -- COMBAT TAB
-- ==========================================
local CombLeft, CombRight = CreateTwoColumns(Tabs.Combat)

Tabs.Combat.Container = CombLeft
local CombatSection1 = Tabs.Combat:AddSection("Offense")
StackElement(CombatSection1:AddSlider("KillAuraRange", {
    Title = "Kill Aura Range (Studs)",
    Default = 0,
    Min = 0,
    Max = 50,
    Rounding = 0,
    Suffix = " studs"
}))
CombatSection1:AddToggle("AutoAttack", { Title = "Auto Attack", Default = false })
StackElement(CombatSection1:AddSlider("AASpeed", {
    Title = "AA Speed",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Suffix = "x"
}))
StackElement(CombatSection1:AddDropdown("EquipWeapon", {
    Title = "Equip Weapon",
    Values = {"Weapon 1", "Weapon 2"},
    Multi = false,
    Default = 1,
}))
StackElement(CombatSection1:AddDropdown("AutoSkills", {
    Title = "Auto Skills",
    Values = {"Skill A", "Skill B", "Skill C"},
    Multi = true,
    Default = {},
}))
CombatSection1:AddToggle("TPAllMobs", { Title = "TP All Mobs to Person", Default = false })

Tabs.Combat.Container = CombRight
local CombatSection2 = Tabs.Combat:AddSection("Defense")
CombatSection2:AddToggle("EnemyHitboxes", { Title = "Enemy Hitboxes", Default = false })
StackElement(CombatSection2:AddSlider("ExpandHitboxes", {
    Title = "Expand Enemy Hitboxes (Studs)",
    Default = 2,
    Min = 2,
    Max = 20,
    Rounding = 0,
    Suffix = " studs"
}))
CombatSection2:AddToggle("AutoParry", { Title = "Auto Parry / Block", Default = false })


-- ==========================================
-- -- SETTINGS / CONFIG TAB
-- ==========================================
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("Sakka")
SaveManager:SetFolder("Sakka/configs")
SaveManager:BuildConfigSection(Tabs.Settings)


-- ==========================================
-- PERSISTENT RED ACCENT ENFORCER
-- ==========================================
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local containers = {game:GetService("CoreGui")}
            if gethui then table.insert(containers, gethui()) end
            
            for _, container in ipairs(containers) do
                for _, descendant in ipairs(container:GetDescendants()) do
                    if descendant:IsA("Frame") or descendant:IsA("TextButton") or descendant:IsA("ImageLabel") then
                        local col = descendant.BackgroundColor3
                        -- Recolor default Fluent blue frames, tab indicators, and toggles
                        if (col.B > 0.55 and col.B > col.R + 0.15) or (col.R < 0.25 and col.G < 0.65 and col.B > 0.65) then
                            descendant.BackgroundColor3 = CrimsonRed
                        end
                        if descendant:IsA("ImageLabel") then
                            local imgCol = descendant.ImageColor3
                            if imgCol.B > 0.55 and imgCol.B > imgCol.R + 0.15 then
                                descendant.ImageColor3 = CrimsonRed
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Sakka",
    Content = "Successfully loaded with persistent Red theme & stacked controls!",
    Duration = 5
})
