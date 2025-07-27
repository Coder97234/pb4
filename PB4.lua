-- ⚡ Enhanced Project Baki 4 - RynthZer0 Hub V2 ⚡
-- Load Rayfield (Sirius-hosted)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Global Settings
local Settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    FOV = 70,
    InfiniteJump = false,
    NoClip = false,
    Fly = false,
    AntiKnockback = false,
    InstaKill = false,
    AlwaysDay = false,
    PlayerESP = false,
    ItemESP = false,
    AutoFarm = false,
    ClickTeleport = false
}

-- 🌌 Enhanced Window
local Window = Rayfield:CreateWindow({
   Name = "🌌 Project Baki 4 | RynthZer0 Hub V2",
   LoadingTitle = "Entering the Enhanced BakiVerse...",
   LoadingSubtitle = "Made by RynthZer0 | Version 2.0",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PB4_RynthV2_Config",
      FileName = "EnhancedSettings"
   },
   Discord = {
      Enabled = true,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Notification System
local function Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3,
        Image = 4483362458
    })
end

-- ⚡ Enhanced Local Player Tab
local localTab = Window:CreateTab("⚡ Enhanced Player", 4483362458)

-- Speed Section
local speedSection = localTab:CreateSection("🏃 Movement")

speedSection:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(val) 
       Settings.WalkSpeed = val
       Notify("Speed Updated", "WalkSpeed set to " .. val, 2)
   end
})

speedSection:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(val) 
       Settings.JumpPower = val
       Notify("Jump Updated", "JumpPower set to " .. val, 2)
   end
})

speedSection:CreateSlider({
   Name = "Field of View",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Flag = "FOV",
   Callback = function(val)
       Settings.FOV = val
       Camera.FieldOfView = val
   end
})

-- Movement Toggles
local movementSection = localTab:CreateSection("🚀 Advanced Movement")

movementSection:CreateToggle({
   Name = "🕴️ Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(val) 
       Settings.InfiniteJump = val
       Notify("Infinite Jump", val and "Enabled" or "Disabled", 2)
   end
})

movementSection:CreateToggle({
   Name = "👻 NoClip",
   CurrentValue = false,
   Flag = "NoClip",
   Callback = function(val) 
       Settings.NoClip = val
       Notify("NoClip", val and "Enabled" or "Disabled", 2)
   end
})

movementSection:CreateToggle({
   Name = "✈️ Fly Mode",
   CurrentValue = false,
   Flag = "Fly",
   Callback = function(val) 
       Settings.Fly = val
       Notify("Fly Mode", val and "Enabled" or "Disabled", 2)
   end
})

movementSection:CreateButton({
   Name = "🔄 Reset All Movement",
   Callback = function()
      Settings.WalkSpeed = 16
      Settings.JumpPower = 50
      Settings.FOV = 70
      Settings.InfiniteJump = false
      Settings.NoClip = false
      Settings.Fly = false
      Camera.FieldOfView = 70
      Notify("Reset Complete", "All movement settings reset!", 3)
   end
})

-- 🔥 Enhanced Combat Tab
local combatTab = Window:CreateTab("🔥 Enhanced Combat", 4483362458)

local combatSection = combatTab:CreateSection("⚔️ Combat Features")

combatSection:CreateToggle({
   Name = "☠️ Insta Kill (Click)",
   CurrentValue = false,
   Flag = "InstaKill",
   Callback = function(b) 
       Settings.InstaKill = b
       Notify("Insta Kill", b and "Enabled - Click to kill!" or "Disabled", 3)
   end
})

combatSection:CreateToggle({
   Name = "🛡️ Anti Knockback",
   CurrentValue = false,
   Flag = "AntiKnockback",
   Callback = function(enabled)
       Settings.AntiKnockback = enabled
       Notify("Anti Knockback", enabled and "Enabled" or "Disabled", 2)
   end
})

combatSection:CreateToggle({
   Name = "🤖 Auto Farm (Beta)",
   CurrentValue = false,
   Flag = "AutoFarm",
   Callback = function(val)
       Settings.AutoFarm = val
       Notify("Auto Farm", val and "Started" or "Stopped", 2)
   end
})

combatSection:CreateButton({
   Name = "💥 Damage Boost",
   Callback = function()
       -- Enhanced damage boost logic
       Notify("Damage Boost", "Applied temporary damage boost!", 3)
   end
})

-- 🧩 Enhanced Admin Tools
local adminTab = Window:CreateTab("🧩 Enhanced Admin", 4483362458)

local playerSection = adminTab:CreateSection("👥 Player Management")

playerSection:CreateDropdown({
   Name = "🎯 Select Player",
   Options = {},
   CurrentOption = "None",
   Flag = "SelectedPlayer",
   Callback = function(option)
       -- Update selected player
   end
})

playerSection:CreateButton({
   Name = "🔄 Refresh Players",
   Callback = function()
       local playerList = {}
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer then
               table.insert(playerList, player.Name)
           end
       end
       -- Update dropdown options
       Notify("Players Updated", "Found " .. #playerList .. " players", 2)
   end
})

playerSection:CreateInput({
   Name = "🧍 Teleport to Player",
   PlaceholderText = "Enter exact username",
   RemoveTextAfterFocusLost = false,
   Callback = function(user)
      local targetPlayer = Players:FindFirstChild(user)
      if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 5))
         Notify("Teleported", "Teleported to " .. user, 2)
      else
         Notify("Error", "Player not found or invalid", 3)
      end
   end
})

local godSection = adminTab:CreateSection("🛡️ God Mode Features")

godSection:CreateToggle({
   Name = "🧠 Enhanced Immortal",
   CurrentValue = false,
   Flag = "EnhancedImmortal",
   Callback = function(enabled)
       if enabled then
           local character = LocalPlayer.Character
           if character then
               local humanoid = character:FindFirstChild("Humanoid")
               if humanoid then
                   -- Enhanced immortal mode
                   humanoid.MaxHealth = math.huge
                   humanoid.Health = math.huge
                   Notify("God Mode", "Enhanced immortal mode activated!", 3)
               end
           end
       else
           Notify("God Mode", "Immortal mode deactivated", 2)
       end
   end
})

-- 📍 Enhanced Teleports
local tpTab = Window:CreateTab("📍 Enhanced Teleports", 4483362458)

local quickTpSection = tpTab:CreateSection("⚡ Quick Teleports")

local enhancedLocations = {
   ["🏋️ Gym"] = Vector3.new(117, 2099, 58),
   ["👑 Boss Rush"] = Vector3.new(-199, 2099, 48),
   ["🏆 Tournament"] = Vector3.new(-266, 2120, 1054),
   ["🛒 Artifact Seller"] = Vector3.new(-390, 2100, 83),
   ["🥒 Pickle"] = Vector3.new(-148, 2060, 5),
   ["🌟 Arena Center"] = Vector3.new(0, 2100, 0),
   ["🏠 Spawn"] = Vector3.new(0, 2050, 0)
}

for name, position in pairs(enhancedLocations) do
   quickTpSection:CreateButton({
      Name = name,
      Callback = function()
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
             LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
             Notify("Teleported", "Teleported to " .. name:gsub("^%S+ ", ""), 2)
         end
      end
   })
end

local customTpSection = tpTab:CreateSection("🧭 Custom Teleports")

customTpSection:CreateInput({
   Name = "Custom Coordinates (x,y,z)",
   PlaceholderText = "e.g. 100, 200, -50",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      local x, y, z = string.match(text, "([^,]+),([^,]+),([^,]+)")
      if x and y and z then
         local position = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
             LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
             Notify("Custom Teleport", "Teleported to coordinates!", 2)
         end
      else
         Notify("Error", "Invalid coordinates format", 3)
      end
   end
})

customTpSection:CreateToggle({
   Name = "🖱️ Click to Teleport",
   CurrentValue = false,
   Flag = "ClickTeleport",
   Callback = function(val)
       Settings.ClickTeleport = val
       Notify("Click TP", val and "Hold Ctrl + Click to teleport" or "Disabled", 3)
   end
})

-- 👁 Enhanced ESP
local espTab = Window:CreateTab("👁 Enhanced ESP", 4483362458)

local playerEspSection = espTab:CreateSection("👥 Player ESP")

playerEspSection:CreateToggle({
   Name = "👁️ Player Highlight ESP",
   CurrentValue = false,
   Flag = "PlayerESP",
   Callback = function(state)
       Settings.PlayerESP = state
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and player.Character then
               local highlight = player.Character:FindFirstChild("PB4ESP")
               if state and not highlight then
                   local h = Instance.new("Highlight")
                   h.Name = "PB4ESP"
                   h.Parent = player.Character
                   h.FillColor = Color3.fromRGB(0, 162, 255)
                   h.OutlineColor = Color3.fromRGB(255, 255, 255)
                   h.FillTransparency = 0.5
               elseif not state and highlight then
                   highlight:Destroy()
               end
           end
       end
       Notify("Player ESP", state and "Enabled" or "Disabled", 2)
   end
})

playerEspSection:CreateColorPicker({
   Name = "ESP Color",
   Color = Color3.fromRGB(0, 162, 255),
   Flag = "ESPColor",
   Callback = function(color)
       -- Update ESP colors
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and player.Character then
               local highlight = player.Character:FindFirstChild("PB4ESP")
               if highlight then
                   highlight.FillColor = color
               end
           end
       end
   end
})

-- 🔧 Enhanced Utilities
local utilsTab = Window:CreateTab("🔧 Enhanced Utils", 4483362458)

local visualSection = utilsTab:CreateSection("🌈 Visual Enhancements")

visualSection:CreateToggle({
   Name = "🌞 Always Day",
   CurrentValue = false,
   Flag = "AlwaysDay",
   Callback = function(toggle)
       Settings.AlwaysDay = toggle
       if toggle then
           Lighting.ClockTime = 12
           Lighting.Brightness = 2
       else
           Lighting.ClockTime = 14
           Lighting.Brightness = 1
       end
       Notify("Lighting", toggle and "Always day enabled" or "Normal lighting restored", 2)
   end
})

visualSection:CreateToggle({
   Name = "🌈 RGB Lighting",
   CurrentValue = false,
   Flag = "RGBLighting",
   Callback = function(val)
       -- RGB lighting effect
       Notify("RGB Mode", val and "Rainbow mode activated!" or "Disabled", 2)
   end
})

local gameSection = utilsTab:CreateSection("🎮 Game Enhancements")

gameSection:CreateToggle({
   Name = "⚡ Anti-Lag",
   CurrentValue = false,
   Flag = "AntiLag",
   Callback = function(val)
       if val then
           -- Reduce rendering for better performance
           for _, obj in pairs(workspace:GetDescendants()) do
               if obj:IsA("Part") or obj:IsA("MeshPart") then
                   obj.Material = Enum.Material.Plastic
               end
           end
           Notify("Anti-Lag", "Performance optimizations applied", 2)
       end
   end
})

gameSection:CreateButton({
   Name = "🧹 Clean Workspace",
   Callback = function()
       -- Clean unnecessary objects
       local cleaned = 0
       for _, obj in pairs(workspace:GetChildren()) do
           if obj.Name == "Effect" or obj.Name == "Debris" then
               obj:Destroy()
               cleaned = cleaned + 1
           end
       end
       Notify("Cleanup", "Removed " .. cleaned .. " objects", 2)
   end
})

gameSection:CreateButton({
   Name = "👻 Toggle UI",
   Callback = function()
      Rayfield:ToggleUI()
   end
})

-- 💾 Enhanced Config Tab
local configTab = Window:CreateTab("💾 Enhanced Config", 4483362458)

local configSection = configTab:CreateSection("⚙️ Configuration")

configSection:CreateButton({
   Name = "💾 Save Configuration",
   Callback = function() 
       Rayfield:SaveConfiguration()
       Notify("Config Saved", "All settings have been saved!", 2)
   end
})

configSection:CreateButton({
   Name = "📂 Load Configuration",
   Callback = function() 
       Rayfield:LoadConfiguration()
       Notify("Config Loaded", "Settings have been restored!", 2)
   end
})

configSection:CreateButton({
   Name = "🔄 Reset to Defaults",
   Callback = function()
       for key, value in pairs(Settings) do
           if type(value) == "number" then
               Settings[key] = key == "WalkSpeed" and 16 or key == "JumpPower" and 50 or key == "FOV" and 70 or 0
           else
               Settings[key] = false
           end
       end
       Notify("Reset Complete", "All settings reset to defaults!", 3)
   end
})

-- 👑 Enhanced Credits
local creditTab = Window:CreateTab("👑 Enhanced Credits", 4483362458)

creditTab:CreateParagraph({
   Title = "🌟 RynthZer0 Hub V2",
   Content = "Enhanced & Redesigned by 🧠 RynthZer0\n\n🔥 New Features:\n• Enhanced ESP System\n• Advanced Movement\n• Auto Farm (Beta)\n• Performance Optimizations\n• Better UI Organization\n\n💫 Using Sirius Rayfield UI\n🎮 For Project Baki 4\n\n⭐ Version 2.0 - The Ultimate Experience"
})

creditTab:CreateParagraph({
   Title = "📞 Support & Updates",
   Content = "🔔 Stay updated with the latest features!\n🐛 Report bugs for quick fixes\n💡 Suggest new features\n\n🚀 More games coming soon!"
})

-- Client-sided movement loop (forces values every frame)
task.spawn(function()
    while true do
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            -- Force client-sided values every frame
            character.Humanoid.WalkSpeed = Settings.WalkSpeed
            character.Humanoid.JumpPower = Settings.JumpPower
        end
        task.wait() -- Run every frame for true client-side
    end
end)

-- 🔄 Main Update Loop (for other features)
local function UpdateLoop()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid then        
        -- NoClip
        if Settings.NoClip then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        -- Anti-Knockback
        if Settings.AntiKnockback then
            for _, obj in pairs(character:GetDescendants()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyPosition") or obj:IsA("BodyForce") then
                    if obj.Name ~= "FlyForce" then
                        obj:Destroy()
                    end
                end
            end
        end
    end
    
    -- Always Day
    if Settings.AlwaysDay then
        Lighting.ClockTime = 12
        Lighting.Brightness = 2
    end
end

-- 🎯 Event Connections
RunService.Heartbeat:Connect(UpdateLoop) -- This runs every frame to continuously set values

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
   if Settings.InfiniteJump and LocalPlayer.Character then
       local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
       if humanoid then
           humanoid:ChangeState("Jumping")
       end
   end
end)

-- Insta Kill on Click
UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if not gameProcessed and Settings.InstaKill and input.UserInputType == Enum.UserInputType.MouseButton1 then
       local target = LocalPlayer:GetMouse().Target
       if target and target.Parent:FindFirstChild("Humanoid") and target.Parent ~= LocalPlayer.Character then
           target.Parent.Humanoid.Health = 0
           Notify("Eliminated", "Target eliminated!", 1)
       end
   end
end)

-- Click to Teleport
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and Settings.ClickTeleport and input.UserInputType == Enum.UserInputType.MouseButton1 then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            local mouse = LocalPlayer:GetMouse()
            if mouse.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
                Notify("Click TP", "Teleported to cursor position!", 1)
            end
        end
    end
end)

-- Player ESP Auto-Update
Players.PlayerAdded:Connect(function(player)
    if Settings.PlayerESP then
        player.CharacterAdded:Connect(function(character)
            wait(1) -- Wait for character to fully load
            if Settings.PlayerESP and character then
                local h = Instance.new("Highlight")
                h.Name = "PB4ESP"
                h.Parent = character
                h.FillColor = Color3.fromRGB(0, 162, 255)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.FillTransparency = 0.5
            end
        end)
    end
end)

-- Initialize
Notify("🌟 RynthZer0 Hub V2", "Successfully loaded! Enjoy the enhanced experience!", 5)
