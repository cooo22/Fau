-- ================== SAFE RAYFIELD LOADER ==================
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("[WARN] Primary Rayfield URL failed, trying GitHub fallback...")
    success, Rayfield = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    end)
    if not success then
        error("[FATAL] Rayfield could not be loaded. Error: " .. tostring(Rayfield))
    end
end

-- ================== SERVICES ==================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- ================== HELPER FUNCTIONS ==================
local function getHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

-- ================== CREATE WINDOW ==================
local Window = Rayfield:CreateWindow({
    Name = "My Own",
    Icon = 0,
    LoadingTitle = "My Own",
    LoadingSubtitle = "by Fau",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    ToggleUIKeybind = Enum.KeyCode.RightShift,  -- Hide/Show UI
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyOwn",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

-- ================== HOME TAB (Player Tweaks) ==================
local HomeTab = Window:CreateTab("🏠 Home", nil)
HomeTab:CreateSection("Player Tweaks")

HomeTab:CreateSlider({
    Name = "Walkspeed",
    Range = {0, 500},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = Value end
    end
})

HomeTab:CreateSlider({
    Name = "JumpPower",
    Range = {0, 500},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        local hum = getHumanoid()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = Value
        end
    end
})

HomeTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

HomeTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        end
    end
})

-- ================== MISC TAB (Utility) ==================
local MiscTab = Window:CreateTab("🔧 Misc", nil)
MiscTab:CreateSection("Utility")

MiscTab:CreateButton({
    Name = "🗑️ Destroy UI",
    Callback = function()
        Rayfield:Destroy()
        print("✅ Rayfield UI has been destroyed.")
    end
})

MiscTab:CreateButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

-- ================== CREDITS TAB ==================
local CreditsTab = Window:CreateTab("📜 Credits", nil)
CreditsTab:CreateSection("About")

CreditsTab:CreateLabel("Created by Fau", nil)  -- Simple label (if Rayfield supports it)
-- If labels aren't supported, we can use a paragraph or just leave the section title.

-- ================== LOGIC CONNECTIONS ==================

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local hum = getHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and _G.InfiniteJump then
        task.wait(0.1)
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

Rayfield:Notify({
    Title = "Hub Loaded",
    Content = "JumpPower fix, Infinite Jump, and Utility buttons are active.",
    Duration = 3
})

print("✅ Script updated with organized tabs: Home, Misc, Credits.")    CurrentValue = 50,
    Callback = function(Value)
        local hum = getHumanoid()
        if hum then
            -- This forces the game to recognize JumpPower instead of JumpHeight
            hum.UseJumpPower = true 
            hum.JumpPower = Value
        end
    end
})

-- Infinite Jump Toggle
HomeTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
    end
})

HomeTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
        end
    end
})

-- ================== LOGIC CONNECTIONS ==================

-- Improved Infinite Jump Logic
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local hum = getHumanoid()
        if hum then
            -- Enum is more stable than strings for state changes
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Ensure JumpPower/Infinite Jump persists or stays active after respawning
LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and _G.InfiniteJump then
        task.wait(0.1)
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

Rayfield:Notify({
    Title = "Hub Loaded",
    Content = "JumpPower fix and Infinite Jump are active.",
    Duration = 3
})

print("✅ Script updated with UseJumpPower fix.")
