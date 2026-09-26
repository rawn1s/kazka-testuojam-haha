-- games/universal.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. Window Creation with a Custom Red Accent Theme
local Window = Rayfield:CreateWindow({
    Name = "Sakka Hub",
    LoadingTitle = "Sakka is loading...",
    LoadingSubtitle = "by rawn1s",
    
    Theme = {
        TextColor = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(18, 18, 18),
        Topbar = Color3.fromRGB(24, 24, 24),
        Accent = Color3.fromRGB(235, 50, 50), -- Cool Red Accent
        Outline = Color3.fromRGB(45, 45, 45),
        TabBackground = Color3.fromRGB(24, 24, 24),
        TabStroke = Color3.fromRGB(45, 45, 45),
        TabTextColor = Color3.fromRGB(200, 200, 200),
        SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
    },

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
