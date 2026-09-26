local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Window Creation with Custom Red Theme
local Window = Rayfield:Window({
    Name = "Sakka Hub",
    LoadingTitle = "Sakka is loading...",
    LoadingSubtitle = "by rawn1s",
    
    -- Custom Theme mapping for Red accents
    Theme = {
        TextColor = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(18, 18, 18),
        Topbar = Color3.fromRGB(24, 24, 24),
        Accent = Color3.fromRGB(235, 51, 35), -- Cool Red Accent
        Outline = Color3.fromRGB(45, 45, 45),
        TabBackground = Color3.fromRGB(24, 24, 24),
        TabStroke = Color3.fromRGB(45, 45, 45),
        TabTextColor = Color3.fromRGB(200, 200, 200),
        SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
    },
    
    ToggleUIKey = Enum.KeyCode.RightControl,

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

-- Create Tabs (Only Information tab for now)
local InfoTab = Window:CreateTab("Information", "info")

-- Information Tab Content
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
    Title = "Welcome to Sakka",
    Content = "Sakka Hub is active and running successfully with custom adjustments!"
})

Rayfield:LoadConfiguration()


task.spawn(function()
    task.wait(0.5) -- Wait for Rayfield to fully render elements into CoreGui
    
    local coreGui = game:GetService("CoreGui")
    local sakkaGui = coreGui:FindFirstChild("Rayfield") or playerGuiCheck -- Rayfield parent container
    
    -- Iterate through descendants to find and adjust topbar elements if needed
    for _, gui in ipairs(coreGui:GetDescendants()) do
        if gui.Name == "Topbar" or gui.ClassName == "Frame" then
            -- Logic to target specific icon assets or text labels can be placed here
        end
    end
end)
