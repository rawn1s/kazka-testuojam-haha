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

-- 2. Create Tabs
local InfoTab = Window:CreateTab("Information", "info")

-- 3. Information Tab Content
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
    Title = "Welcome to Sakka",
    Content = "Sakka Hub is active and running successfully!"
})

Rayfield:LoadConfiguration()

-- 4. Runtime UI Patch: Title Customization + Image ID Logger
task.spawn(function()
    task.wait(0.8) -- Allow Rayfield elements to fully mount
    
    for _, descendant in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        -- Style the title text
        if descendant:IsA("TextLabel") and descendant.Text == "Sakka Hub" then
            descendant.TextColor3 = Color3.fromRGB(235, 50, 50)
            descendant.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
        end
        
        -- Print out image elements so we can see their exact asset IDs in the F9 console
        if descendant:IsA("ImageButton") or descendant:IsA("ImageLabel") then
            if descendant.Image ~= "" then
                print("Found GUI Image -> Name: " .. descendant.Name .. " | ID: " .. descendant.Image)
            end
        end
    end
end)
