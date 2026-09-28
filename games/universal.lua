-- games/universal.lua

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- ==========================================
-- 1. CREATE WINDOW FIRST
-- ==========================================
local Window = Fluent:CreateWindow({
    Title = "Sakka",
    SubTitle = "by rawn1s",
    TabWidth = 160,
    Size = UDim2.fromOffset(920, 600),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- ==========================================
-- 2. SAFE CRIMSON RED ACCENT OVERRIDE
-- ==========================================
local CrimsonRed = Color3.fromRGB(235, 50, 50)
local DarkCrimson = Color3.fromRGB(180, 30, 30)

-- Intercept theme property calls so all toggle/tab tweens target Crimson Red natively
local rawGetThemeProperty = Fluent.GetThemeProperty
Fluent.GetThemeProperty = function(self, property)
    if property == "Accent" or property == "ActiveTab" or property == "Focus" then
        return CrimsonRed
    elseif property == "DarkAccent" then
        return DarkCrimson
    end
    if rawGetThemeProperty then
        return rawGetThemeProperty(self, property)
    end
    return CrimsonRed
end

-- Safely mutate loaded theme dictionaries
if type(Fluent.Themes) == "table" then
    for themeName, themeTable in pairs(Fluent.Themes) do
        if type(themeTable) == "table" then
            themeTable.Accent = CrimsonRed
            themeTable.DarkAccent = DarkCrimson
            themeTable.ActiveTab = CrimsonRed
        end
    end
end

-- ==========================================
-- 3. CREATE TABS
-- ==========================================
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
-- HELPER: 2-COLUMN SECTION CONTAINER
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
    LeftColumn.Size = UDim2.new(0.485, 0, 0, 0)
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
    RightColumn.Size = UDim2.new(0.485, 0, 0, 0)
    RightColumn.Position = UDim2.new(0.515, 0, 0, 0)
    RightColumn.AutomaticSize = Enum.AutomaticSize.Y
    RightColumn.BackgroundTransparency = 1
    RightColumn.Parent = ColumnHolder

    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 10)
    RightLayout.Parent = RightColumn

    return LeftColumn, RightColumn
end

local function AddSectionToColumn(Tab, column, title)
    local section = Tab:AddSection(title)
    local sectionFrame = section.Frame or (section.Container and section.Container.Parent)
    if sectionFrame then
        sectionFrame.Parent = column
    end
    return section
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

-- Left Column
local FarmingSection1 = AddSectionToColumn(Tabs.Farming, FarmLeft, "Mobs / Bosses")
FarmingSection1:AddDropdown("BossSelection", {
    Title = "Boss / NPC Selection",
    Values = {"Bandit", "Mother Bear", "Boss Placeholder", "Alpha Wolf", "Bandit Leader", "Guard"},
    Multi = true,
    Default = {"Bandit"},
})
FarmingSection1:AddToggle("AutoHopBoss", { Title = "Auto Hop After Boss Kill", Default = false })
FarmingSection1:AddInput("HopSettings1", {
    Title = "Auto Hop Settings",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
})
FarmingSection1:AddToggle("AutoCollectChest", { Title = "Auto Collect Chest", Default = false })

local FarmingSection3 = AddSectionToColumn(Tabs.Farming, FarmLeft, "Quests")
FarmingSection3:AddDropdown("QuestSelection", {
    Title = "Quest Selection",
    Values = {"Quest 1: Bandit Sweep", "Quest 2: Boss Extermination"},
    Multi = false,
    Default = 1,
})
FarmingSection3:AddToggle("AutoHopQuest", { Title = "Auto Hop After Quest", Default = false })

-- Right Column
local FarmingSection2 = AddSectionToColumn(Tabs.Farming, FarmRight, "Weapons / Items")
FarmingSection2:AddDropdown("WeaponDrops", {
    Title = "Weapon Drops Priority",
    Values = {"Best Available", "Katana", "Spear", "Dagger", "Halberd", "Greatsword"},
    Multi = true,
    Default = {"Best Available"},
})
FarmingSection2:AddDropdown("ItemDrops", {
    Title = "Item Drops Priority",
    Values = {"Scroll", "Pouch", "Gem", "Key", "Token", "Crystal"},
    Multi = true,
    Default = {"Scroll"},
})
FarmingSection2:AddToggle("AutoHopNoSpawn", { Title = "Auto Hop (NPC Unspawned)", Default = false })
FarmingSection2:AddInput("HopSettings2", {
    Title = "Auto Hop Settings",
    Default = "Max Players: 5, Region: US",
    Placeholder = "Max Players: 5, Region: US",
    Numeric = false,
    Finished = true,
})


-- ==========================================
-- -- DUNGEON TAB
-- ==========================================
local DungLeft, DungRight = CreateTwoColumns(Tabs.Dungeon)

-- Left Column
local DungeonSection1 = AddSectionToColumn(Tabs.Dungeon, DungLeft, "Cards")
DungeonSection1:AddToggle("AutoPickCard", { Title = "Auto Pick Card", Default = false })
DungeonSection1:AddDropdown("CardsBlacklist", {
    Title = "Card Blacklist",
    Values = {"Card A", "Card B", "Card C", "Card D", "Card E"},
    Multi = true,
    Default = {},
})

-- Right Column
local DungeonSection2 = AddSectionToColumn(Tabs.Dungeon, DungRight, "Priorities & Whitelist")
DungeonSection2:AddDropdown("CardsWhitelist", {
    Title = "Card Whitelist",
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
local PlayLeft, PlayRight = CreateTwoColumns(Tabs.Player)

local PlayerSection1 = AddSectionToColumn(Tabs.Player, PlayLeft, "Movement Hacks")
PlayerSection1:AddToggle("Noclip", { Title = "Noclip", Default = false })
PlayerSection1:AddToggle("HighJumpToggle", { Title = "High Jump", Default = false })
PlayerSection1:AddSlider("HighJumpHeight", {
    Title = "High Jump Height",
    Description = "Adjust jump velocity height",
    Default = 25,
    Min = 10,
    Max = 100,
    Rounding = 0,
    Suffix = " studs"
})

local PlayerSection2 = AddSectionToColumn(Tabs.Player, PlayRight, "Attributes")
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
local TrainLeft, TrainRight = CreateTwoColumns(Tabs.Training)

local TrainingSection1 = AddSectionToColumn(Tabs.Training, TrainLeft, "Dojo Drills")
TrainingSection1:AddToggle("AutoPushUps", { Title = "Auto Push Ups", Default = false })
TrainingSection1:AddToggle("AutoMeditation", { Title = "Auto Meditation", Default = false })
TrainingSection1:AddToggle("AutoSquats", { Title = "Auto Squats", Default = false })
TrainingSection1:AddToggle("AutoBoulderSplit", { Title = "Auto Boulder Split", Default = false })
TrainingSection1:AddToggle("AutoBoulderPush", { Title = "Auto Boulder Push", Default = false })
TrainingSection1:AddToggle("InstantTraining", { Title = "Instant Training Complete", Default = false })

local TrainingSection2 = AddSectionToColumn(Tabs.Training, TrainRight, "Auto Skill Tree")
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
local CombLeft, CombRight = CreateTwoColumns(Tabs.Combat)

local CombatSection1 = AddSectionToColumn(Tabs.Combat, CombLeft, "Offense")
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

local CombatSection2 = AddSectionToColumn(Tabs.Combat, CombRight, "Defense")
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
-- -- SETTINGS / CONFIG TAB
-- ==========================================
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("Sakka")
SaveManager:SetFolder("Sakka/configs")
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Sakka",
    Content = "Loaded cleanly with Crimson Red theme!",
    Duration = 5
})
