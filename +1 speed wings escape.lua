-- 🌪️ FALL - Auto Teleport to Button (Close Button Simple X)
local player = game.Players.LocalPlayer

local targetPosition = Vector3.new(2748.086, 266.092, -7856.561)

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "FALL_Teleport"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(200, 0, 255)
title.Text = "🌪️ FALL - AUTO TELEPORT"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Close Button Simple "X"
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundTransparency = 1  -- Hilangkan background kotak
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame

local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0.9, 0, 0, 70)
teleportBtn.Position = UDim2.new(0.05, 0, 0, 70)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
teleportBtn.Text = "🚀 TELEPORT KE BUTTON"
teleportBtn.TextColor3 = Color3.new(1,1,1)
teleportBtn.TextScaled = true
teleportBtn.Font = Enum.Font.GothamBold
teleportBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0, 155)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.new(1,1,1)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

local function teleport()
    local character = player.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
        status.Text = "✅ Berhasil Teleport!"
        wait(1)
        status.Text = "Ready"
    end
end

teleportBtn.MouseButton1Click:Connect(teleport)

-- Hotkey T
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        teleport()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

print("✅ FALL Auto Teleport Loaded! Tekan tombol atau tekan T")