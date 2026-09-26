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

-- 4. Runtime UI Patch: Title customization + Accurate Icon Swapping
task.spawn(function()
    task.wait(0.8) -- Allow Rayfield elements to fully mount
    
    local containers = {game:GetService("CoreGui")}
    pcall(function() if gethui then table.insert(containers, gethui()) end end)
    pcall(function() table.insert(containers, game:GetService("Players").LocalPlayer.PlayerGui) end)
    
    for _, container in ipairs(containers) do
        pcall(function()
            for _, descendant in ipairs(container:GetDescendants()) do
                -- Style the title text
                if descendant:IsA("TextLabel") and descendant.Text == "Sakka Hub" then
                    descendant.TextColor3 = Color3.fromRGB(235, 50, 50)
                    pcall(function()
                        descendant.FontFace = Font.fromEnum(Enum.Font.PermanentMarker)
                    end)
                end
                
                -- Surgical icon replacement via precise parent and name checks
                if descendant:IsA("ImageButton") or descendant:IsA("ImageLabel") then
                    if descendant.Parent and descendant.Parent.Name == "Topbar" then
                        if descendant.Name == "Settings" then
                            descendant.Image = "rbxassetid://6031260907" -- Phone-style gear icon
                        elseif descendant.Name == "ChangeSize" or descendant.Name == "Hide" then
                            descendant.Image = "rbxassetid://6023426915" -- Clean dash icon (-)
                        end
                    end
                end
            end
        end)
    end
end)
