
local Rayfield = loadstring(game:HttpGet('https://githubusercontent.com'))()

local Window = Rayfield:CreateWindow({
   Name = "Solo Development Sandbox",
   LoadingTitle = "Verifying Environment Engine...",
   LoadingSubtitle = "By SoloDev",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   }
})

local TestTab = Window:CreateTab("System Diagnostics", 4483362458)

TestTab:CreateSection("Network & GUI Link Verified")

Rayfield:Notify({
   Title = "Sandbox Success!",
   Content = "The GUI system successfully loaded onto your client viewport.",
   Duration = 5,
   Image = 4483362458,
})
