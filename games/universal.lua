local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:Window({
   Name = "Sakka Hub",
   LoadingTitle = "Sakka is Loading",
   LoadingSubtitle = "by rawn1s",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "RawnHubConfig",
      FileName = "UniversalHub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = true, -- Set this to true to enable key system
   KeySettings = {
      Title = "Key System",
      Subtitle = "Monetization Gateway",
      Note = "Get your key from Linkvertise/Loot-Link",
      FileName = "RawnKey",
      SaveKey = true,
      GrabKeyFromSite = false, -- Set to true if you host the key on a raw pastebin link
      Key = {"YOUR_SECRET_KEY_123"} -- The correct key(s) users need to enter
   }
})

local MainTab = Window:CreateTab("Universal", 4483345998) -- Title, Icon ID

local MainSection = MainTab:CreateSection("Main Features")

MainTab:CreateButton({
   Name = "Print Hello",
   Callback = function()
      print("Rayfield button clicked!")
      Rayfield:Notify({
         Title = "Success!",
         Content = "You have successfully executed the script.",
         Duration = 6.5,
         Image = 4483345998,
      })
   end,
})
