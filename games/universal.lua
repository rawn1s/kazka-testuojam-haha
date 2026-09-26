-- games/universal.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. Window Creation with a stable built-in theme string
local Window = Rayfield:CreateWindow({
    Name = "Sakka Hub",
    LoadingTitle = "Sakka is loading...",
    LoadingSubtitle = "by rawn1s",
    Theme = "Default", -- Stable built-in theme to prevent nil property crashes

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

-- 4. Runtime UI Patch: Target the title text, update its color, and change its font
task.spawn(function()
    task.wait(0.6) -- Allow Rayfield elements to fully mount in CoreGui
    
    for _, descendant in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        if descendant:IsA("TextLabel") and descendant.Text == "Sakka Hub" then
            descendant.TextColor3 = Color3.fromRGB(235, 50, 50) -- Cool Red Accent
            
            -- Change the font (You can replace Enum.Font.GothamBold with any Roblox font Enum)
            descendant.FontFace = Font.fromName("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            -- Alternatively, using built-in engine enums:
            -- descendant.FontFace = Font.fromEnum(Enum.Font.GothamBold)
        end
    end
end)
