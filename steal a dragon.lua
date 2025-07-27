-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- UI Setup
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

		while _G.AutoFarmTouch do
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("TouchTransmitter") and v.Parent then
					local part = v.Parent
					firetouchinterest(root, part, 0)
					task.wait()
					firetouchinterest(root, part, 1)
				end
			end
			task.wait(0.5)
		end
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
	Name = "Auto",
	CurrentValue = false,
	Callback = function(Value)
		_G.AdminAuto = Value
		local RS = game:GetService("ReplicatedStorage")

		while _G.AdminAuto do
			-- Fire 10 steal remotes
			for i = 1, 10 do
				local steal = RS:FindFirstChild("Dragon_Prompt_Steal_" .. i)
				if steal and steal:IsA("RemoteEvent") then
					steal:FireServer()
				end
				task.wait(0.1)
			end

			-- Fire all sell remotes
			for _, v in pairs(RS:GetChildren()) do
				if v:IsA("RemoteEvent") and v.Name:match("Dragon_Prompt_Sell") then
					v:FireServer()
					task.wait(0.1)
				end
			end

			task.wait(1)
		end
	end
})

-- 📜 Credits Tab
local CreditsTab = Window:CreateTab("📜 Credits", Color3.fromRGB(85, 85, 255))
CreditsTab:CreateSection("Made by RynthZer0 🔵")
CreditsTab:CreateLabel("Game: Steal a Dragon")
CreditsTab:CreateLabel("UI: Rayfield | sirius.menu")
CreditsTab:CreateLabel("Hub Version: Stable 1.0")

