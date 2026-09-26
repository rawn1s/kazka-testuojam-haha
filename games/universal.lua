local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:Window({
   Name = "Sakka Hub",
   LoadingTitle = "Sakka is loading...",
   LoadingSubtitle = "by rawn1s",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SakkaHubConfig",
      FileName = "SakkaHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Sakka | Key System",
      Subtitle = "Link Verification",
      Note = "Complete the Platoboost link to get your unique key.",
      FileName = "SakkaPlatoKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"https://gateway.platoboost.com/a/YOUR_PROJECT_ID"} -- Replace with actual Platoboost service link/endpoint provided by their dashboard
   }
})

-- Main UI content once verified
local MainTab = Window:CreateTab("Universal", 4483345998)
local MainSection = MainTab:CreateSection("Sakka Core Features")

MainTab:CreateButton({
   Name = "Test Notification",
   Callback = function()
      Rayfield:Notify({
         Title = "Sakka Hub",
         Content = "Key verified successfully via Platoboost!",
         Duration = 6.5,
         Image = 4483345998,
      })
   end,
})
