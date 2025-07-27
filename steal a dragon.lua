-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create UI Window
local Window = Rayfield:CreateWindow({
	Name = "🐉 Steal a Dragon | RynthZer0 Hub",
	LoadingTitle = "Loading Rynth Tools...",
	LoadingSubtitle = "Stealing them dragons",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "StealADragon",
		FileName = "Rynth_UI_Config"
	},
	KeySystem = false
})

-- 🐲 Farming Tab
local FarmingTab = Window:CreateTab("🐲 Farming", Color3.fromRGB(0, 255, 170))
FarmingTab:CreateSection("Dragon Farming Tools")

FarmingTab:CreateToggle({
	Name = "Auto Touch Farm",
	CurrentValue = false,
	Callback = function(Value)
		_G.AutoFarmTouch = Value
		local lp = game.Players.LocalPlayer
		local char = lp.Character or lp.CharacterAdded:Wait()
		local root = char:WaitForChild("HumanoidRootPart")

		spawn(function()
			while _G.AutoFarmTouch do
				for _, v in pairs(workspace:GetDescendants()) do
					if not _G.AutoFarmTouch then break end
					if v:IsA("TouchTransmitter") and v.Parent then
						firetouchinterest(root, v.Parent, 0)
						task.wait()
						firetouchinterest(root, v.Parent, 1)
					end
					task.wait(0.01)
				end
				task.wait(0.5)
			end
		end)
	end
})

-- ⚙️ Local Player Tab
local PlayerTab = Window:CreateTab("⚙️ Local Player", Color3.fromRGB(0, 140, 255))
PlayerTab:CreateSection("Your Stats & Movement")

PlayerTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 200},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Callback = function(Value)
		local plr = game.Players.LocalPlayer
		local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = Value end
	end
})

PlayerTab:CreateSlider({
	Name = "JumpPower",
	Range = {50, 300},
	Increment = 1,
	Suffix = "Jump",
	CurrentValue = 50,
	Callback = function(Value)
		local plr = game.Players.LocalPlayer
		local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.JumpPower = Value end
	end
})

PlayerTab:CreateButton({
	Name = "Reset Character",
	Callback = function()
		local plr = game.Players.LocalPlayer
		if plr.Character then
			plr.Character:BreakJoints()
		end
	end
})

-- 🛠️ Admin Tools Tab
local AdminTab = Window:CreateTab("🛠️ Admin Tools", Color3.fromRGB(255, 100, 100))
AdminTab:CreateSection("Troll & Control")

AdminTab:CreateToggle({
	Name = "Auto_Steal_Steal",
	CurrentValue = false,
	Callback = function(Value)
		_G.AdminAutoSteal = Value

		spawn(function()
			while _G.AdminAutoSteal do
				if not _G.AdminAutoSteal then break end

				local stealPrompts = {}
				local sellPrompts = {}

				for _, prompt in pairs(workspace:GetDescendants()) do
					if prompt:IsA("ProximityPrompt") then
						if prompt.Name:match("Dragon_Prompt_Steal") then
							table.insert(stealPrompts, prompt)
						elseif prompt.Name:match("Dragon_Prompt_Sell") then
							table.insert(sellPrompts, prompt)
						end
					end
				end

				for i = 1, math.min(10, #stealPrompts) do
					if not _G.AdminAutoSteal then break end
					local prompt = stealPrompts[i]
					if prompt then
						prompt:InputHoldBegin()
						task.wait(0.1)
						prompt:InputHoldEnd()
					end
					task.wait(0.1)
				end

				for _, prompt in pairs(sellPrompts) do
					if not _G.AdminAutoSteal then break end
					prompt:InputHoldBegin()
					task.wait(0.1)
					prompt:InputHoldEnd()
					task.wait(0.1)
				end

				task.wait(1)
			end
		end)
	end
})

-- 📜 Credits Tab
local CreditsTab = Window:CreateTab("📜 Credits", Color3.fromRGB(85, 85, 255))
CreditsTab:CreateSection("Made by RynthZer0 🔵")
CreditsTab:CreateLabel("Game: Steal a Dragon")
CreditsTab:CreateLabel("UI: Rayfield | sirius.menu")
CreditsTab:CreateLabel("Hub Version: Updated for ProximityPrompt")
