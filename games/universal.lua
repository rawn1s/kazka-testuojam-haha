-- games/universal.lua

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:Window({
   Name = "Sakka Hub",
   LoadingTitle = "Sakka is loading...",
   LoadingSubtitle = "by rawn1s",
   
   -- Custom Theme to inject Red accents into the UI text/accents
   Theme = "Default", 
   ToggleUIKey = Enum.KeyCode.RightControl, -- Key to completely hide/show UI

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

-- 2. Create the Tabs
local InfoTab = Window:CreateTab("Information", "info")
local HiderTab = Window:CreateTab("Hider", "ghost")
local SeekerTab = Window:CreateTab("Seeker", "crosshair")
local VisualTab = Window:CreateTab("Visuals", "eye")

-- 3. Information Tab Content
local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
   Title = "Welcome to Sakka",
   Content = "Sakka Hub is active and running successfully with custom adjustments!"
})

-- 4. Hider Tab Example Toggle
HiderTab:CreateToggle({
   Name = "Auto Hide",
   Info = "Automatically triggers hiding mechanics.",
   CurrentValue = false,
   Flag = "AutoHideFlag",
   Callback = function(Value)
      print("Auto Hide is now: " .. tostring(Value))
   end,
})

Rayfield:LoadConfiguration()
