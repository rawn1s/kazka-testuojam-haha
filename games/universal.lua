-- 1. Load the Rayfield Library properly
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. Create the Main Window using the correct Rayfield structure
local Window = Rayfield:CreateWindow({
   Name = "Sakka Hub",
   LoadingTitle = "Sakka is loading...",
   LoadingSubtitle = "by rawn1s",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SakkaHub",
      FileName = "UniversalConfig"
   },
   KeySystem = false, -- Disabled
})

-- 3. Create the Tabs
local InfoTab = Window:CreateTab("Information", "info")
local HiderTab = Window:CreateTab("Hider", "ghost")
local SeekerTab = Window:CreateTab("Seeker", "crosshair")
local VisualTab = Window:CreateTab("Visuals", "eye")

-- 4. Add test content to Info Tab
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
   Title = "Welcome to Sakka",
   Content = "Sakka Hub is active and running successfully!"
})

-- 5. Add test toggle to Hider Tab
HiderTab:CreateToggle({
   Name = "Auto Hide",
   Info = "Automatically triggers hiding mechanics.",
   CurrentValue = false,
   Flag = "AutoHideFlag",
   Callback = function(Value)
      print("Auto Hide is now: " .. tostring(Value))
   end,
})

-- Initialize Rayfield elements
Rayfield:LoadConfiguration()
