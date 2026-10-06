local SakkaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rawn1s/SakkaUI-library/refs/heads/main/SakkaUI.lua"))()


print("A: before SakkaUI")
local SakkaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rawn1s/SakkaUI-library/refs/heads/main/SakkaUI.lua"))()
print("B: SakkaUI =", SakkaUI)
local lib = SakkaUI.new()
print("C: lib =", lib)
local win = lib:CreateWindow({ Title = "Sakka" })
print("D: win =", win)
