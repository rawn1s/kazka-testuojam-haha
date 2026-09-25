local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

local Window = OrionLib:MakeWindow({
    Name = "Solo Development Hub", 
    HidePremium = false, 
    SaveConfig = false,
    IntroText = "Loading Sandbox..."
})

local TestTab = Window:MakeTab({
    Name = "Diagnostics",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

TestTab:AddSection({
    Name = "Interface Successfully Verified!"
})

TestTab:AddButton({
    Name = "Click to Verify Execution Line",
    Callback = function()
        print("🎉 Code Line Executed and Working perfectly!")
        OrionLib:MakeNotification({
            Name = "System Action",
            Content = "The internal function callback is responsive!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end    
})

OrionLib:Init()
