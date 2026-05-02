-- LocalScript → StarterPlayer > StarterPlayerScripts

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local sg = Instance.new("ScreenGui")
sg.Name = "FallMenu"
sg.ResetOnSpawn = false
sg.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 460, 0, 520)
frame.Position = UDim2.new(0.5, -230, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2.5
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Parent = frame

-- Snowflake
local snow = Instance.new("TextLabel")
snow.Size = UDim2.new(0,80,0,80)
snow.Position = UDim2.new(0,25,0,20)
snow.BackgroundTransparency = 1
snow.Text = "❄️"
snow.TextColor3 = Color3.fromRGB(150, 230, 255)
snow.TextScaled = true
snow.Font = Enum.Font.GothamBold
snow.Parent = frame

-- Title FALL
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.65,0,0,80)
title.Position = UDim2.new(0.28,0,0,25)
title.BackgroundTransparency = 1
title.Text = "FALL"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = frame

-- Subtitle
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,-50,0,30)
sub.Position = UDim2.new(0,25,0,95)
sub.BackgroundTransparency = 1
sub.Text = "Fall Teleport Menu siap! Tekan M untuk buka"
sub.TextColor3 = Color3.fromRGB(180, 255, 220)
sub.TextScaled = true
sub.Font = Enum.Font.GothamMedium
sub.Parent = frame

-- Close
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,45,0,45)
close.Position = UDim2.new(1,-55,0,20)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255,100,100)
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.Parent = frame

local function createBtn(text, y, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85,0,0,68)
    btn.Position = UDim2.new(0.075,0,0,y)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = frame

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,16)
    return btn
end

local b1 = createBtn("CHECKPOINT 1", 145, Color3.fromRGB(0, 130, 255))
local b2 = createBtn("CHECKPOINT 2", 225, Color3.fromRGB(255, 145, 0))
local b3 = createBtn("CHECKPOINT 3", 305, Color3.fromRGB(255, 60, 60))
local b4 = createBtn("CHECKPOINT 4", 385, Color3.fromRGB(0, 190, 100))
local finish = createBtn("FINISH - SOUTH POLE", 465, Color3.fromRGB(170, 0, 255))

-- Coordinates
local cps = {
    [b1] = CFrame.new(-3719.171, 222.14, 235.419),
    [b2] = CFrame.new(1790.329, 102.39, -137.831),
    [b3] = CFrame.new(5892.4, 318.08, -19.049),
    [b4] = CFrame.new(8992.375, 592.83, 103.09),
    [finish] = CFrame.new(11001.9, 551.5, 103.8)
}

local function tp(cf)
    local root = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
    local hum = player.Character:WaitForChild("Humanoid")
    root.CFrame = cf + cf.LookVector * -8 + Vector3.new(0,13,0)
    wait(0.15)
    hum:ChangeState(Enum.HumanoidStateType.Freefall)
    wait(0.25)
    root.CFrame = cf + cf.LookVector * -4
    hum:ChangeState(Enum.HumanoidStateType.Landed)
    root.Velocity = cf.LookVector * 40 + Vector3.new(0,28,0)
end

b1.MouseButton1Click:Connect(function() tp(cps[b1]) end)
b2.MouseButton1Click:Connect(function() tp(cps[b2]) end)
b3.MouseButton1Click:Connect(function() tp(cps[b3]) end)
b4.MouseButton1Click:Connect(function() tp(cps[b4]) end)
finish.MouseButton1Click:Connect(function() tp(cps[finish]) end)

close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Resize (bisa gede & kecil)
local resizing = false
local UserInput = game:GetService("UserInputService")

local resizeHandle = Instance.new("TextButton")
resizeHandle.Size = UDim2.new(0,30,0,30)
resizeHandle.Position = UDim2.new(1,-30,1,-30)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Text = "↘"
resizeHandle.TextColor3 = Color3.fromRGB(0,255,200)
resizeHandle.TextScaled = true
resizeHandle.Parent = frame

resizeHandle.MouseButton1Down:Connect(function()
    resizing = true
end)

UserInput.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if resizing then
        local mouse = UserInput:GetMouseLocation()
        local absPos = frame.AbsolutePosition
        local newWidth = math.clamp(mouse.X - absPos.X, 380, 700)
        local newHeight = math.clamp(mouse.Y - absPos.Y, 420, 650)
        frame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

-- Toggle M
game:GetService("UserInputService").InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.M then
        sg.Enabled = not sg.Enabled
    end
end)

print("✅ UI Fall Premium + Resize siap! Tekan M")