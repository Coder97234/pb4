-- Hide UI by parenting Rayfield to Camera (cloak from CoreGui scans)
getgenv().ParentContainer = workspace.CurrentCamera

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create main window
local Window = Rayfield:CreateWindow({
   Name = "🌌 Project Baki 4 | RynthZer0 Hub",
   LoadingTitle = "Ghost Loading...",
   LoadingSubtitle = "Initializing Ghost UI",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PB4_Rynth_Config",
      FileName = "GhostSave"
   },
   Discord = { Enabled = false },
   KeySystem = false
})

-- ======= Local Player Tab =======
local localTab = Window:CreateTab("🔵 Local Player", 4483362458)
local speed = 16
local jump = 50

localTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = speed,
   Callback = function(val) speed = val end
})

localTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 200},
   Increment = 1,
   CurrentValue = jump,
   Callback = function(val) jump = val end
})

localTab:CreateButton({
   Name = "Reset Speed/Jump",
   Callback = function()
      speed = 16
      jump = 50
   end
})

task.spawn(function()
   while true do
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = speed
         char.Humanoid.JumpPower = jump
      end
      task.wait(0.1)
   end
end)

-- ======= Admin Tools Tab =======
local adminTab = Window:CreateTab("🧩 Admin Tools", 4483362458)

local InstaKillToggle = false
adminTab:CreateToggle({
   Name = "☠️ Insta Kill (NPCs)",
   CurrentValue = false,
   Callback = function(state) InstaKillToggle = state end
})

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
   if not gpe and InstaKillToggle and input.UserInputType == Enum.UserInputType.MouseButton1 then
      local target = game.Players.LocalPlayer:GetMouse().Target
      if target and target.Parent:FindFirstChild("Humanoid") then
         target.Parent.Humanoid.Health = 0
      end
   end
end)

adminTab:CreateInput({
   Name = "🧍 Teleport to Player",
   PlaceholderText = "Type exact username",
   Callback = function(username)
      local player = game.Players:FindFirstChild(username)
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(2, 0, 2))
      end
   end
})

adminTab:CreateToggle({
   Name = "🧠 Immortal w/o Humanoid",
   CurrentValue = false,
   Callback = function(enable)
      local char = game.Players.LocalPlayer.Character
      if enable then
         local hum = char:FindFirstChild("Humanoid")
         if hum then hum:Destroy() end
         local root = char:FindFirstChild("HumanoidRootPart")
         local bodyVelocity = Instance.new("BodyVelocity")
         bodyVelocity.Name = "FakeMove"
         bodyVelocity.MaxForce = Vector3.new(1e9, 0, 1e9)
         bodyVelocity.Velocity = Vector3.new(0, 0, 0)
         bodyVelocity.Parent = root

         local direction = Vector3.new()
         local uis = game:GetService("UserInputService")

         uis.InputBegan:Connect(function(key, gpe)
            if gpe then return end
            if key.KeyCode == Enum.KeyCode.W then direction += Vector3.new(0, 0, -1) end
            if key.KeyCode == Enum.KeyCode.S then direction += Vector3.new(0, 0, 1) end
            if key.KeyCode == Enum.KeyCode.A then direction += Vector3.new(-1, 0, 0) end
            if key.KeyCode == Enum.KeyCode.D then direction += Vector3.new(1, 0, 0) end
         end)

         uis.InputEnded:Connect(function(key)
            if key.KeyCode == Enum.KeyCode.W then direction -= Vector3.new(0, 0, -1) end
            if key.KeyCode == Enum.KeyCode.S then direction -= Vector3.new(0, 0, 1) end
            if key.KeyCode == Enum.KeyCode.A then direction -= Vector3.new(-1, 0, 0) end
            if key.KeyCode == Enum.KeyCode.D then direction -= Vector3.new(1, 0, 0) end
         end)

         task.spawn(function()
            while bodyVelocity and bodyVelocity.Parent do
               if direction.Magnitude > 0 then
                  bodyVelocity.Velocity = direction.Unit * 50
               else
                  bodyVelocity.Velocity = Vector3.new(0, 0, 0)
               end
               task.wait()
            end
         end)
      else
         local root = char:FindFirstChild("HumanoidRootPart")
         if root and root:FindFirstChild("FakeMove") then
            root.FakeMove:Destroy()
         end
      end
   end
})

-- ======= Teleports Tab =======
local tpTab = Window:CreateTab("📍 Teleports", 4483362458)
local locations = {
   Gym = Vector3.new(117, 2099, 58),
   ["Boss Rush"] = Vector3.new(-199, 2099, 48),
   Tournament = Vector3.new(-266, 2120, 1054),
   ["Artifact Seller"] = Vector3.new(-390, 2100, 83),
   Pickle = Vector3.new(-148, 2060, 5),
}

for name, pos in pairs(locations) do
   tpTab:CreateButton({
      Name = "📍 " .. name,
      Callback = function()
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(pos)
         end
      end
   })
end

tpTab:CreateInput({
   Name = "🧭 Custom Teleport (x,y,z)",
   PlaceholderText = "Example: 100, 5, -200",
   Callback = function(txt)
      local x, y, z = txt:match("([^,]+),([^,]+),([^,]+)")
      x, y, z = tonumber(x), tonumber(y), tonumber(z)
      if x and y and z then
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
         end
      end
   end
})

-- ======= ESP Tab =======
local espTab = Window:CreateTab("👁 ESP", 4483362458)

espTab:CreateToggle({
   Name = "👁️ Player Highlight ESP",
   CurrentValue = false,
   Callback = function(enabled)
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("PB4ESP")
            if enabled and not highlight then
               highlight = Instance.new("Highlight", player.Character)
               highlight.Name = "PB4ESP"
               highlight.FillColor = Color3.fromRGB(0, 162, 255)
               highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
               highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            elseif not enabled and highlight then
               highlight:Destroy()
            end
         end
      end
   end
})

-- ======= Utilities Tab =======
local utilsTab = Window:CreateTab("🔧 Utilities", 4483362458)

utilsTab:CreateToggle({
   Name = "🕴️ Infinite Jump",
   CurrentValue = false,
   Callback = function(val)
      _G.InfiniteJump = val
   end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if _G.InfiniteJump then
      local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
      end
   end
end)

utilsTab:CreateToggle({
   Name = "🛡️ Anti Knockback",
   CurrentValue = false,
   Callback = function(enabled)
      if enabled then
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, v in pairs(char:GetDescendants()) do
               if v:IsA("BodyVelocity") or v:IsA("BodyForce") then
                  v:Destroy()
               end
            end
         end
      end
   end
})

utilsTab:CreateToggle({
   Name = "🌞 Always Day",
   CurrentValue = false,
   Callback = function(toggle)
      local lighting = game:GetService("Lighting")
      if toggle then
         lighting.ClockTime = 12
         lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            if lighting.ClockTime ~= 12 then
               lighting.ClockTime = 12
            end
         end)
      end
   end
})

utilsTab:CreateButton({
   Name = "👻 Toggle UI",
   Callback = function()
      Rayfield:ToggleUI()
   end
})

-- ======= Config Tab =======
local configTab = Window:CreateTab("💾 Configs", 4483362458)
configTab:CreateButton({
   Name = "Save",
   Callback = function() Rayfield:SaveConfiguration() end
})
configTab:CreateButton({
   Name = "Load",
   Callback = function() Rayfield:LoadConfiguration() end
})

-- ======= Credits Tab =======
local creditsTab = Window:CreateTab("👑 Credits", 4483362458)
creditsTab:CreateParagraph({
   Title = "Made by",
   Content = "Scripted & Designed by 🧠 RynthZer0\nUsing Sirius Rayfield UI\nFor Project Baki 4"
})

-- ======= Self destroy script to hide from PlayerScripts =======
task.defer(function()
   pcall(function()
      script:Destroy()
   end)
end)
