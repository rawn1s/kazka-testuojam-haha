local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:Window({
   Name = "Sakka Hub",
   LoadingTitle = "Sakka is loading...",
   LoadingSubtitle = "by rawn1s",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SakkaHub",
      FileName = "UniversalConfig"
   },
   KeySystem = false,
})

local InfoTab = Window:CreateTab("Information", "info")
local HiderTab = Window:CreateTab("Hider", "ghost")
local SeekerTab = Window:CreateTab("Seeker", "crosshair")
local VisualTab = Window:CreateTab("Visuals", "eye")


local InfoSection = InfoTab:CreateSection("Hub Details")

InfoTab:CreateParagraph({
   Title = "Welcome to Sakka",
   Content = "Sakka Hub is active and running. Select a tab on the left depending on what role or game features you want to use."
})

InfoTab:CreateButton({
   Name = "Copy Discord Link",
   Callback = function()
      if setclipboard then
         setclipboard("https://discord.gg/yourinvite")
         Rayfield:Notify({Title = "Copied!", Content = "Discord invite copied to clipboard.", Duration = 3})
      end
   end,
})


local HiderSection = HiderTab:CreateSection("Hider Powers")

HiderTab:CreateToggle({
   Name = "Auto Hide",
   Info = "Automatically triggers hiding mechanics.",
   CurrentValue = false,
   Flag = "AutoHideFlag",
   Callback = function(Value)
      print("Auto Hide is now: " .. tostring(Value))
   end,
})

HiderTab:CreateButton({
   Name = "Inf Health (Example)",
   Callback = function()
      print("Inf Health button clicked!")
      
      Rayfield:Notify({
         Title = "Success",
         Content = "Client-side health modified.",
         Duration = 3,
      })
   end,
})


local VisualSection = VisualTab:CreateSection("ESP & Lighting")

VisualTab:CreateToggle({
   Name = "Fullbright",
   Info = "Removes shadows and brightens the map.",
   CurrentValue = false,
   Flag = "FullbrightFlag",
   Callback = function(Value)
      if Value then
         game:GetService("Lighting").Brightness = 2
         game:GetService("Lighting").ClockTime = 14
      else
         game:GetService("Lighting").Brightness = 1
      end
   end,
})
