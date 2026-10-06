local SakkaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rawn1s/SakkaUI-library/refs/heads/main/SakkaUI.lua"))()

local lib = SakkaUI.new()

local window = lib:CreateWindow({
    Title = "Sakka",
    Font = Enum.Font.PermanentMarker,
    TextSize = 24,
})

local mainTab = window:CreateTab("Main")
mainTab:AddSection("Test")

mainTab:AddButton({
    Text = "Hello",
    Callback = function()
        lib:Notify({ Title = "Sakka", Content = "It works!", Duration = 3 })
    end,
})

mainTab:AddToggle({
    Text = "Test Toggle",
    Default = false,
    Callback = function(state)
        print("[Test] Toggle:", state)
    end,
})

mainTab:AddSlider({
    Text = "Test Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Suffix = "%",
    Callback = function(v)
        print("[Test] Slider:", v)
    end,
})
