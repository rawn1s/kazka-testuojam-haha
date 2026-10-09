return function(lib, window)
	local function placeholder(name)
		return function()
			lib:Notify({ Title = "Not Implemented", Content = name .. " has no game logic yet.", Duration = 3 })
		end
	end

	local ORDER_NOTE = "Select in order: first = most important, last = least important"

	local tab = window:CreateTab("Farming")

	tab:AddSection("Caches / Bosses")
	tab:AddToggle({
		Text = "Auto Farm Bosses",
		Default = false,
		Callback = placeholder("Auto Farm Bosses"),
	})
	tab:AddMultiDropdown({
		Title = "Boss Selection",
		Note = ORDER_NOTE,
		Options = {
			"Zuko", "Mother Bear", "Obanai", "Zentaro", "Sumari", "Yahari",
			"Giyu", "Reaper", "Datai", "Gyutaro", "Sanemi", "Shinobu",
			"Rengoku", "Nezura", "Gyomei", "Fujiko", "Yeti", "Tengen",
			"Doma", "Akaza", "Enru", "Water Trainee Sabito", "Serpent Trainee",
			"Insect Trainee", "Kaiden",
		},
		Default = {},
		Callback = placeholder("Boss Selection"),
	})
	tab:AddToggle({
		Text = "Auto Farm Caches",
		Default = false,
		Callback = placeholder("Auto Farm Caches"),
	})
	tab:AddMultiDropdown({
		Title = "Cache Selection",
		Note = ORDER_NOTE,
		Options = { "T1", "T2", "T3" },
		Default = {},
		Callback = placeholder("Cache Selection"),
	})
	local autoChest = tab:AddToggle({
		Text = "Auto Collect Chest",
		Default = false,
		Callback = placeholder("Auto Collect Chest"),
	})
	tab:AddSlider({
		Text = "Auto Collect Chest Distance",
		Min = 1, Max = 300, Default = 20, Suffix = " studs",
		DependsOn = autoChest,
		Callback = placeholder("Auto Collect Chest Distance"),
	})

	tab:AddSection("Weapons")
	tab:AddToggle({
		Text = "Auto Farm Weapons",
		Default = false,
		Callback = placeholder("Auto Farm Weapons"),
	})
	tab:AddMultiDropdown({
		Title = "Auto Farm Weapon Drops",
		Note = ORDER_NOTE,
		Options = {
			"Flame Katana", "Water Katana", "Thunder Katana", "Wind Katana",
			"Insect Katana", "Serpent Katana", "Sound Katanas", "Cutlass",
			"Spear", "Tanto", "Axe and Mace", "Claws", "Sickles",
			"Blood Sickles", "Scythe", "War Fans", "Bladed Wagasa",
		},
		Default = {},
		Callback = placeholder("Auto Farm Weapon Drops"),
	})

	tab:AddSection("Quests")
	tab:AddMultiDropdown({
		Title = "Quest Selection",
		Note = ORDER_NOTE,
		Options = {
			"Report to Noote (Lv 0)", "Recover the Lost Pages (Lv 0)",
			"Clear the Village Spies (Lv 0)", "Deliver Package to Elara (Lv 0)",
			"Deliver the Coded Letter (Lv 0)", "The Plate Trial (Lv 0)",
			"Defeat 3 bandits (Lv 0)", "Defeat The Bandit Boss (Lv 7)",
			"Find Betty's Gemstone (Lv 10)", "Acquire Bear Meat (Lv 10)",
			"Hunt the Bears (Lv 10)", "Fell the Mother Bear (Lv 18)",
			"Five Hundred Pennies (Lv 21)", "Serpent Breathing Training (Lv 25)",
			"Insect Breathing Training (Lv 25)", "Stone Breathing Training (Lv 25)",
			"Sound Breathing Training (Lv 25)", "Water Breathing Training (Lv 25)",
			"Wind Breathing Training (Lv 25)", "Thunder Breathing Training (Lv 25)",
			"Flame Breathing Training (Lv 25)", "Clear Kaiden's Subordinates (Lv 26)",
			"Defeat Kaiden (Lv 34)", "Clear Hoyuzo's Guard (Lv 40)",
			"Earn a Fishing Permit (Lv 45)", "The Morning Haul (Lv 45)",
			"Retrieve Ginzo's Jewelry Box (Lv 45)", "Hold the Night (Lv 47)",
			"Defeat Hoyuzo (Lv 50)", "The Good Catch (Lv 60)",
			"The Soryu Trial (Lv 62)", "The Tai Chi Trial (Lv 65)",
			"The Forge Above (Lv 65)", "Deliver Niko's Supply Box (Lv 70)",
		},
		Default = {},
		Callback = placeholder("Quest Selection"),
	})
	tab:AddToggle({
		Text = "Auto Quest",
		Default = false,
		Callback = placeholder("Auto Quest"),
	})
	tab:AddToggle({
		Text = "Auto Repeat Quest",
		Default = false,
		Callback = placeholder("Auto Repeat Quest"),
	})

	tab:AddSection("Race")
	tab:AddToggle({
		Text = "Auto Demon",
		Default = false,
		Callback = placeholder("Auto Demon"),
	})
	tab:AddToggle({
		Text = "Auto Slayer",
		Default = false,
		Callback = placeholder("Auto Slayer"),
	})

	tab:AddSection("Breathing Style / BDA")
	tab:AddToggle({
		Text = "Auto Breathing Style",
		Note = "Requires you to be a Slayer, and a Breathing Style selected.",
		Default = false,
		Callback = placeholder("Auto Breathing Style"),
	})
	tab:AddDropdown({
		Text = "Breathing Style",
		Options = { "Serpent", "Water", "Insect", "Thunder", "Stone", "Flame", "Wind", "Sound" },
		Default = "Serpent",
		Callback = placeholder("Breathing Style"),
	})
	tab:AddToggle({
		Text = "Auto BDA",
		Note = "Requires you to be a Demon, and a BDA selected.",
		Default = false,
		Callback = placeholder("Auto BDA"),
	})
	tab:AddDropdown({
		Text = "BDA",
		Options = {
			"Blood Manipulation", "Pyrokinesis", "Reaper", "Dream Manipulation",
			"Shockwave", "Obi Manipulation", "Arrow", "Tamari", "Cryokinesis",
		},
		Default = "Blood Manipulation",
		Callback = placeholder("BDA"),
	})

	tab:AddSection("Server Hop")
	local autoHop = tab:AddToggle({
		Text = "Auto Hop",
		Default = false,
		Callback = placeholder("Auto Hop"),
	})
	tab:AddTextInput({
		Text = "Auto Hop - Max Players",
		Placeholder = "e.g. 6",
		DependsOn = autoHop,
		Callback = placeholder("Auto Hop - Max Players"),
	})
	tab:AddDropdown({
		Text = "Auto Hop - Region",
		Options = { "Auto", "NA", "EU", "ASIA" },
		Default = "Auto",
		DependsOn = autoHop,
		Callback = placeholder("Auto Hop - Region"),
	})

	tab:AddSection("Execution Priority")
	tab:AddMultiDropdown({
		Title = "Section Priority",
		Note = ORDER_NOTE,
		Options = {
			"Caches / Bosses", "Weapons", "Quests", "Race",
			"Breathing Style / BDA", "Server Hop",
		},
		Default = {},
		Callback = placeholder("Section Priority"),
	})
end
