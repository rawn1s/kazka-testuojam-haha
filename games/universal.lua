-- games/universal.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. Window Creation with correct Gen2 parameters
local Window = Rayfield:CreateWindow({
    Name = "Sakka Hub",
    LoadingTitle = "Sakka is loading...",
    LoadingSubtitle = "by rawn1s",
    
    Theme = "Default", 
    ToggleUIKeybind = Enum.KeyCode.K, -- Standard safe KeyCode enum for Gen2

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

-- 2. Create Tabs
local InfoTab = Window:CreateTab("Information", "info")

-- 3. Information Tab Content
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
    Title = "Welcome to Sakka",
    Content = "Sakka Hub is active and running successfully!"
})

Rayfield:LoadConfiguration()
