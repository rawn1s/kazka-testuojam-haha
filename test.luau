local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "Solo Development Hub | Slayers 2",
   LoadingTitle = "Initializing Systems...",
   LoadingSubtitle = "by SoloDev",
   ConfigurationSaving = {
      Enabled = false
   }
})

local CombatTab = Window:CreateTab("Combat Features", 4483362458)

getgenv().AutoPunchActive = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ClientEffects = ReplicatedStorage:WaitForChild("Communication"):WaitForChild("CnC"):WaitForChild("ClientEffects")

CombatTab:CreateToggle({
   Name = "Automated Combat Swings",
   CurrentValue = false,
   Flag = "Toggle_AutoPunch",
   Callback = function(Value)
      getgenv().AutoPunchActive = Value
      if Value then
          Rayfield:Notify({Title = "System Action", Content = "Auto-Punch Loop Started!", Duration = 2})
      else
          Rayfield:Notify({Title = "System Action", Content = "Auto-Punch Loop Paused Safely.", Duration = 2})
      end
   end,
})

task.spawn(function()
    local currentPunchVariant = 1
    
    while true do
        task.wait(0.25)
        
        if getgenv().AutoPunchActive then
            local localCharacter = Players.LocalPlayer.Character
            
            if localCharacter and localCharacter:FindFirstChild("HumanoidRootPart") then
                firesignal(ClientEffects.Event, 
                    "Combat_Swings", 
                    localCharacter, 
                    currentPunchVariant, 
                    true
                )
                
                currentPunchVariant = currentPunchVariant + 1
                if currentPunchVariant > 5 then
                    currentPunchVariant = 1
                end
            end
        end
    end
end)

Rayfield:Notify({Title = "Execution Success", Content = "GUI Interface Dashboard Ready!", Duration = 3})
