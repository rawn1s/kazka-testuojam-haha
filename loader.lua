local currentPlaceId = game.PlaceId

local baseUrl = "https://raw.githubusercontent.com/rawn1s/kazka-testuojam-haha/main/"

local supportedGames = {
    [12345678] = "games/game1.lua", -- Replace with real PlaceIds later
}

local targetScript = supportedGames[currentPlaceId]

if targetScript then
    print("Supported game detected. Loading script...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(baseUrl .. targetScript))()
    end)
    if not success then
        warn("Error loading game script: " .. tostring(err))
    end
else
    print("Game not supported. Loading Universal Hub...")
    local success, err = pcall(function()
        loadstring(game:HttpGet(baseUrl .. "games/universal.lua"))()
    end)
    if not success then
        warn("Error loading universal script: " .. tostring(err))
    end
end
