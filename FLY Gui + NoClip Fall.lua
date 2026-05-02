local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootpart = character:WaitForChild("HumanoidRootPart")

local flying = false
local noclip = false
local flySpeed = 50
local maxSpeed = 400
local minSpeed = 10

-- Create GUI
local sg = Instance.new("ScreenGui")
sg.Name = "FALL_FlyGUI"
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 220)
frame.Position = UDim2.new(0.5, -130, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = sg

-- Title = FALL
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(170, 0, 255)  -- Warna ungu keren
title.Text = "🌪️ FALL"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = frame

-- Speed Label
local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(1, 0, 0, 30)
speedText.Position = UDim2.new(0, 0, 0, 45)
speedText.BackgroundTransparency = 1
speedText.Text = "Speed : " .. flySpeed
speedText.TextColor3 = Color3.new(1,1,1)
speedText.TextScaled = true
speedText.Font = Enum.Font.GothamSemibold
speedText.Parent = frame

-- Toggle Fly
local toggleFly = Instance.new("TextButton")
toggleFly.Size = UDim2.new(0.9, 0, 0, 45)
toggleFly.Position = UDim2.new(0.05, 0, 0, 80)
toggleFly.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
toggleFly.Text = "ENABLE FLY"
toggleFly.TextColor3 = Color3.new(1,1,1)
toggleFly.TextScaled = true
toggleFly.Font = Enum.Font.GothamBold
toggleFly.Parent = frame

-- Toggle NoClip
local toggleNoclip = Instance.new("TextButton")
toggleNoclip.Size = UDim2.new(0.9, 0, 0, 40)
toggleNoclip.Position = UDim2.new(0.05, 0, 0, 130)
toggleNoclip.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
toggleNoclip.Text = "NOCLIP : OFF"
toggleNoclip.TextColor3 = Color3.new(1,1,1)
toggleNoclip.TextScaled = true
toggleNoclip.Font = Enum.Font.GothamBold
toggleNoclip.Parent = frame

-- Speed Buttons
local plus = Instance.new("TextButton")
plus.Size = UDim2.new(0.42, 0, 0, 35)
plus.Position = UDim2.new(0.05, 0, 0, 175)
plus.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
plus.Text = "+ SPEED"
plus.TextColor3 = Color3.new(1,1,1)
plus.TextScaled = true
plus.Font = Enum.Font.GothamBold
plus.Parent = frame

local minus = Instance.new("TextButton")
minus.Size = UDim2.new(0.42, 0, 0, 35)
minus.Position = UDim2.new(0.53, 0, 0, 175)
minus.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
minus.Text = "- SPEED"
minus.TextColor3 = Color3.new(1,1,1)
minus.TextScaled = true
minus.Font = Enum.Font.GothamBold
minus.Parent = frame

local bv, bg

local function startFly()
    if flying then return end
    flying = true
    toggleFly.Text = "DISABLE FLY"
    toggleFly.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    
    humanoid.PlatformStand = true
    
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = rootpart
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 12500
    bg.Parent = rootpart
    
    spawn(function()
        while flying and rootpart.Parent do
            local move = Vector3.new()
            local cam = workspace.CurrentCamera
            
            if uis:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
            
            bv.Velocity = (move.Magnitude > 0 and move.Unit * flySpeed) or Vector3.new(0,0,0)
            bg.CFrame = cam.CFrame
            rs.Heartbeat:Wait()
        end
    end)
end

local function stopFly()
    flying = false
    toggleFly.Text = "ENABLE FLY"
    toggleFly.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if humanoid then humanoid.PlatformStand = false end
end

local function toggleNoClip()
    noclip = not noclip
    toggleNoclip.Text = "NOCLIP : " .. (noclip and "ON" or "OFF")
    toggleNoclip.BackgroundColor3 = noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 140, 0)
    
    if noclip then
        spawn(function()
            while noclip and character and character.Parent do
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                rs.Stepped:Wait()
            end
        end)
    end
end

-- Connections
closeBtn.MouseButton1Click:Connect(function()
    stopFly()
    noclip = false
    sg:Destroy()
end)

toggleFly.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

toggleNoclip.MouseButton1Click:Connect(toggleNoClip)

plus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 10, maxSpeed)
    speedText.Text = "Speed : " .. flySpeed
end)

minus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 10, minSpeed)
    speedText.Text = "Speed : " .. flySpeed
end)

uis.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

print("✅ FALL Fly GUI Loaded! Tekan F untuk Fly | ✕ untuk Close")