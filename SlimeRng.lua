-- Bake or Die Custom UI FULL - ESC Fixed by Grok
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local ZAP = require(game:GetService("ReplicatedStorage").Client.ClientRemotes)

-- ==================== SETTINGS ====================
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "BakeOrDie_ESP"
ESPFolder.Parent = game.CoreGui

local ESPConfig = {
    MonsterESP = false,
    ItemESP = false,
    ShowNames = true,
    ShowDistance = true,
    ShowHighlight = true
}

_G.KillAuraEnabled = false
_G.AuraDistance = 25
_G.WalkSpeed = 16
_G.JumpPower = 50
_G.WeaponSlot = 2

-- ==================== GUI ====================
local Theme = {
    Bg = Color3.fromRGB(20, 22, 25),
    Panel = Color3.fromRGB(26, 28, 32),
    Title = Color3.fromRGB(30, 33, 37),
    Button = Color3.fromRGB(36, 40, 45),
    Stroke = Color3.fromRGB(95, 100, 110),
    TextMuted = Color3.fromRGB(165, 170, 178)
}

local function applyStroke(target, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.6
    stroke.Color = Theme.Stroke
    stroke.Parent = target
end

local function styleButton(btn)
    btn.AutoButtonColor = false
    btn.TextColor3 = Color3.new(1, 1, 1)
    applyStroke(btn, 1, 0.7)
end

local function addCorner(target, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = target
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BakerOrDie_Loading"
LoadingGui.ResetOnSpawn = false
LoadingGui.DisplayOrder = 1000000
LoadingGui.IgnoreGuiInset = true
LoadingGui.Parent = game:GetService("CoreGui")

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = LoadingGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0, 40)
LoadingText.Position = UDim2.new(0, 0, 0.5, -20)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "BakerOrDie by Fall"
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextSize = 20
LoadingText.Parent = LoadingFrame

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 380)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
MainFrame.BackgroundColor3 = Theme.Panel
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
applyStroke(MainFrame, 1, 0.4)

local ModalFix = Instance.new("TextButton", MainFrame)
ModalFix.Size = UDim2.new(0, 0, 0, 0)
ModalFix.BackgroundTransparency = 1
ModalFix.Text = ""
ModalFix.Modal = true

addCorner(MainFrame, 8)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Theme.Title
TitleBar.Parent = MainFrame
addCorner(TitleBar, 8)
applyStroke(TitleBar, 1, 0.65)

local Title = Instance.new("TextLabel")
Title.Text = "BakerOrDie"
Title.Size = UDim2.new(1, -90, 0, 22)
Title.Position = UDim2.new(0, 14, 0, 6)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Text = "by Fall"
SubTitle.Size = UDim2.new(1, -90, 0, 16)
SubTitle.Position = UDim2.new(0, 14, 0, 24)
SubTitle.BackgroundTransparency = 1
SubTitle.TextColor3 = Theme.TextMuted
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = ""
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar
addCorner(CloseBtn, 4)
CloseBtn.Text = "X"
styleButton(CloseBtn)

-- ==================== TOGGLE MENU ====================
local isMenuOpen = true

local function toggleMenu()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    ModalFix.Modal = isMenuOpen
    UserInputService.MouseIconEnabled = isMenuOpen
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Equals then
        toggleMenu()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ==================== TAB SYSTEM ====================
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 150, 1, -44)
TabFrame.Position = UDim2.new(0, 0, 0, 44)
TabFrame.BackgroundColor3 = Theme.Bg
TabFrame.Parent = MainFrame
applyStroke(TabFrame, 1, 0.7)

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -165, 1, -54)
ContentFrame.Position = UDim2.new(0, 155, 0, 48)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Theme.TextMuted
ContentFrame.Parent = MainFrame

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingLeft = UDim.new(0, 8)
ContentPadding.PaddingRight = UDim.new(0, 8)
ContentPadding.PaddingTop = UDim.new(0, 8)
ContentPadding.PaddingBottom = UDim.new(0, 8)
ContentPadding.Parent = ContentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ContentFrame

local Tabs = {
    Combat = {color = Color3.fromRGB(255, 80, 80)},
    Items = {color = Color3.fromRGB(80, 180, 255)},
    Player = {color = Color3.fromRGB(80, 255, 120)},
    ESP = {color = Color3.fromRGB(255, 200, 80)},
    Info = {color = Color3.fromRGB(180, 180, 180)}
}

local TabButtons = {}
local CurrentContent = {}

for tabName, data in pairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 42)
    btn.Position = UDim2.new(0, 10, 0, #TabButtons * 70 + 10)
    btn.BackgroundColor3 = Theme.Button
    btn.Text = tabName
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = TabFrame
    addCorner(btn, 4)
    styleButton(btn)

    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(ContentFrame:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        if CurrentContent[tabName] then
            CurrentContent[tabName].Visible = true
        end
        for _, b in pairs(TabButtons) do b.BackgroundColor3 = Color3.fromRGB(30,30,34) end
        btn.BackgroundColor3 = data.color
    end)

    table.insert(TabButtons, btn)

    -- Content Container per tab
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = (tabName == "Combat")
    tabContent.Parent = ContentFrame
    CurrentContent[tabName] = tabContent

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 12)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = tabContent
end

-- ==================== COMBAT TAB ====================
local combat = CurrentContent.Combat

local kaBtn = Instance.new("TextButton")
kaBtn.Size = UDim2.new(1, -20, 0, 46)
kaBtn.BackgroundColor3 = Color3.fromRGB(40,40,45)
kaBtn.Text = "Kill Aura : OFF"
kaBtn.TextColor3 = Color3.new(1,1,1)
kaBtn.Font = Enum.Font.GothamBold
kaBtn.TextSize = 14
kaBtn.Parent = combat
addCorner(kaBtn, 4)
styleButton(kaBtn)

kaBtn.MouseButton1Click:Connect(function()
    _G.KillAuraEnabled = not _G.KillAuraEnabled
    kaBtn.Text = "Kill Aura : " .. (_G.KillAuraEnabled and "ON" or "OFF")
    kaBtn.BackgroundColor3 = _G.KillAuraEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40,40,45)
end)

local auraSliderLabel = Instance.new("TextLabel")
auraSliderLabel.Text = "Kill Aura Distance: 25"
auraSliderLabel.Size = UDim2.new(1, -20, 0, 22)
auraSliderLabel.BackgroundTransparency = 1
auraSliderLabel.TextColor3 = Theme.TextMuted
auraSliderLabel.TextSize = 12
auraSliderLabel.Parent = combat

local KillAllBtn = Instance.new("TextButton")
KillAllBtn.Size = UDim2.new(1, -20, 0, 46)
KillAllBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
KillAllBtn.Text = "Kill All Zombies"
KillAllBtn.TextColor3 = Color3.new(1,1,1)
KillAllBtn.Font = Enum.Font.GothamBold
KillAllBtn.TextSize = 14
KillAllBtn.Parent = combat
addCorner(KillAllBtn, 4)
styleButton(KillAllBtn)

KillAllBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, m in pairs(workspace.Monsters:GetChildren()) do
            if m:FindFirstChild("HumanoidRootPart") then
                ZAP.meleeAttack.fire({monsters = {m}, civilians = {}, activeSlot = _G.WeaponSlot})
                task.wait(0.1)
            end
        end
    end
end)

-- ==================== ITEMS TAB ====================
local items = CurrentContent.Items

local function makeBtn(parent, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 46)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    addCorner(btn, 4)
    styleButton(btn)
    btn.MouseButton1Click:Connect(callback)
end

makeBtn(items, "Bring Bodies", Color3.fromRGB(80, 140, 255), function()
    local char = LocalPlayer.Character
    if char and char.PrimaryPart then
        for _, v in pairs(workspace.Interactables:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not v:FindFirstChild("ProductPriceTag") then
                v.PrimaryPart.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, 3, -4)
                task.wait(0.05)
            end
        end
    end
end)

makeBtn(items, "Bring All Items", Color3.fromRGB(80, 255, 140), function()
    local char = LocalPlayer.Character
    if char and char.PrimaryPart then
        for _, v in pairs(workspace.Interactables:GetChildren()) do
            if v:IsA("Model") and v.PrimaryPart and not v:FindFirstChild("ProductPriceTag") then
                v.PrimaryPart.CFrame = char.PrimaryPart.CFrame * CFrame.new(math.random(-6,6), 2, math.random(-6,6))
                task.wait(0.05)
            end
        end
    end
end)

-- ==================== PLAYER TAB ====================
local playerTab = CurrentContent.Player

local flying = false
local noclip = false
local flySpeed = 50
local maxSpeed = 400
local minSpeed = 10
local bv
local bg
local noclipConn

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
local rootpart = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootpart = char:WaitForChild("HumanoidRootPart")
end)

local function createInput(parent, labelText, default, callback)
    local lbl = Instance.new("TextLabel")
    lbl.Text = labelText
    lbl.Size = UDim2.new(1, -20, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Theme.TextMuted
    lbl.TextSize = 12
    lbl.Parent = parent

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.7, 0, 0, 36)
    box.Text = tostring(default)
    box.BackgroundColor3 = Theme.Button
    box.TextColor3 = Color3.new(1,1,1)
    box.Parent = parent
    box.TextSize = 12
    addCorner(box, 4)
    applyStroke(box, 1, 0.7)

    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then callback(val) end
    end)
end

createInput(playerTab, "WalkSpeed", 16, function(v)
    _G.WalkSpeed = v
end)

createInput(playerTab, "JumpPower", 50, function(v)
    _G.JumpPower = v
end)

createInput(playerTab, "Weapon Slot", 2, function(v)
    _G.WeaponSlot = v
end)

local function stopFly()
    flying = false
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if humanoid then humanoid.PlatformStand = false end
end

local function startFly()
    if flying or not rootpart or not humanoid then return end
    flying = true
    humanoid.PlatformStand = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = rootpart

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 12500
    bg.Parent = rootpart

    task.spawn(function()
        while flying and rootpart and rootpart.Parent do
            local move = Vector3.new(0, 0, 0)
            local cam = workspace.CurrentCamera

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

            bv.Velocity = (move.Magnitude > 0 and move.Unit * flySpeed) or Vector3.new(0, 0, 0)
            bg.CFrame = cam.CFrame
            RunService.Heartbeat:Wait()
        end
    end)
end

local function setNoclipState(enabled)
    noclip = enabled
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    if noclip and character then
        noclipConn = RunService.Stepped:Connect(function()
            if not character or not character.Parent then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(1, -20, 0, 22)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.TextColor3 = Theme.TextMuted
flySpeedLabel.TextSize = 12
flySpeedLabel.Text = "Fly Speed: " .. flySpeed
flySpeedLabel.Parent = playerTab

local flyToggleBtn = Instance.new("TextButton")
flyToggleBtn.Size = UDim2.new(1, -20, 0, 46)
flyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flyToggleBtn.Text = "Fly: OFF"
flyToggleBtn.TextColor3 = Color3.new(1, 1, 1)
flyToggleBtn.Font = Enum.Font.GothamBold
flyToggleBtn.TextSize = 14
flyToggleBtn.Parent = playerTab
addCorner(flyToggleBtn, 4)
styleButton(flyToggleBtn)

flyToggleBtn.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        flyToggleBtn.Text = "Fly: OFF"
        flyToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        startFly()
        flyToggleBtn.Text = "Fly: ON"
        flyToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    end
end)

local noclipToggleBtn = Instance.new("TextButton")
noclipToggleBtn.Size = UDim2.new(1, -20, 0, 46)
noclipToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
noclipToggleBtn.Text = "Noclip: OFF"
noclipToggleBtn.TextColor3 = Color3.new(1, 1, 1)
noclipToggleBtn.Font = Enum.Font.GothamBold
noclipToggleBtn.TextSize = 14
noclipToggleBtn.Parent = playerTab
addCorner(noclipToggleBtn, 4)
styleButton(noclipToggleBtn)

noclipToggleBtn.MouseButton1Click:Connect(function()
    setNoclipState(not noclip)
    noclipToggleBtn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
    noclipToggleBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 140, 0)
end)

local flyPlusBtn = Instance.new("TextButton")
flyPlusBtn.Size = UDim2.new(0.48, 0, 0, 38)
flyPlusBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
flyPlusBtn.Text = "+ Speed"
flyPlusBtn.TextColor3 = Color3.new(1, 1, 1)
flyPlusBtn.Font = Enum.Font.GothamBold
flyPlusBtn.TextSize = 13
flyPlusBtn.Parent = playerTab
addCorner(flyPlusBtn, 4)
styleButton(flyPlusBtn)

local flyMinusBtn = Instance.new("TextButton")
flyMinusBtn.Size = UDim2.new(0.48, 0, 0, 38)
flyMinusBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
flyMinusBtn.Text = "- Speed"
flyMinusBtn.TextColor3 = Color3.new(1, 1, 1)
flyMinusBtn.Font = Enum.Font.GothamBold
flyMinusBtn.TextSize = 13
flyMinusBtn.Parent = playerTab
addCorner(flyMinusBtn, 4)
styleButton(flyMinusBtn)

flyPlusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 10, maxSpeed)
    flySpeedLabel.Text = "Fly Speed: " .. flySpeed
end)

flyMinusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 10, minSpeed)
    flySpeedLabel.Text = "Fly Speed: " .. flySpeed
end)

-- ==================== ESP TAB ====================
local espTab = CurrentContent.ESP

local function toggleBtn(name, configKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 46)
    btn.BackgroundColor3 = Theme.Button
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = espTab
    addCorner(btn, 4)
    styleButton(btn)

    btn.MouseButton1Click:Connect(function()
        ESPConfig[configKey] = not ESPConfig[configKey]
        btn.Text = name .. " : " .. (ESPConfig[configKey] and "ON" or "OFF")
        btn.BackgroundColor3 = ESPConfig[configKey] and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,45)
    end)
end

toggleBtn("Monster ESP", "MonsterESP")
toggleBtn("Item ESP", "ItemESP")
toggleBtn("Show Names", "ShowNames")
toggleBtn("Show Distance", "ShowDistance")
toggleBtn("Show Highlight", "ShowHighlight")

-- ==================== INFO TAB ====================
local infoTab = CurrentContent.Info
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -32, 1, -32)
infoLabel.Position = UDim2.new(0, 16, 0, 16)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1,1,1)
infoLabel.Text = "BakerOrDie by Fall\n\n- Kill Aura + Kill All\n- Bring Bodies & Items\n- WalkSpeed & JumpPower\n- Full ESP System\n- ESC Menu Friendly"
infoLabel.TextSize = 13
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextWrapped = true
infoLabel.Parent = infoTab

-- ==================== ESP FUNCTIONS ====================
local function CreateESP(part, color, name, distance)
    if ESPConfig.ShowNames or ESPConfig.ShowDistance then
        local bg = Instance.new("BillboardGui")
        bg.Adornee = part
        bg.Size = UDim2.new(0, 220, 0, 70)
        bg.StudsOffset = Vector3.new(0, 4, 0)
        bg.AlwaysOnTop = true
        bg.Parent = ESPFolder

        local tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1,0,1,0)
        tl.BackgroundTransparency = 1
        tl.Text = (ESPConfig.ShowNames and name or "") .. (ESPConfig.ShowDistance and "\n"..math.floor(distance).." studs" or "")
        tl.TextColor3 = color
        tl.TextStrokeTransparency = 0
        tl.TextStrokeColor3 = Color3.new(0,0,0)
        tl.Font = Enum.Font.GothamBold
        tl.TextSize = 15
        tl.Parent = bg
    end

    if ESPConfig.ShowHighlight then
        local hl = Instance.new("Highlight")
        hl.Adornee = part
        hl.FillColor = color
        hl.OutlineColor = Color3.new(1,1,1)
        hl.FillTransparency = 0.35
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = ESPFolder
    end
end

local function ClearESP()
    for _, v in pairs(ESPFolder:GetChildren()) do v:Destroy() end
end

local function UpdateESP()
    ClearESP()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPos = char.HumanoidRootPart.Position

    if ESPConfig.MonsterESP then
        for _, m in pairs(workspace.Monsters:GetChildren()) do
            local p = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
            if p then
                local dist = (rootPos - p.Position).Magnitude
                CreateESP(p, Color3.fromRGB(255, 60, 60), "Monster", dist)
            end
        end
    end

    if ESPConfig.ItemESP then
        for _, item in pairs(workspace.Interactables:GetChildren()) do
            local p = item:FindFirstChild("HumanoidRootPart") or item.PrimaryPart
            if p then
                local dist = (rootPos - p.Position).Magnitude
                local isBody = item:FindFirstChild("HumanoidRootPart")
                local col = isBody and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(80, 255, 100)
                local n = isBody and "Body" or "Item"
                CreateESP(p, col, n, dist)
            end
        end
    end
end

-- ==================== LOOPS ====================
task.spawn(function()
    while task.wait() do
        if _G.KillAuraEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                for _, m in pairs(workspace.Monsters:GetChildren()) do
                    local hrp = m:FindFirstChild("HumanoidRootPart")
                    if hrp and (root.Position - hrp.Position).Magnitude < _G.AuraDistance then
                        ZAP.meleeAttack.fire({monsters = {m}, civilians = {}, activeSlot = _G.WeaponSlot})
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if ESPConfig.MonsterESP or ESPConfig.ItemESP then
            UpdateESP()
        else
            ClearESP()
        end
    end
end)

task.spawn(function()
    while task.wait(0.8) do
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = _G.WalkSpeed
            char.Humanoid.JumpPower = _G.JumpPower
        end
    end
end)

task.delay(1, function()
    if LoadingGui then
        LoadingGui:Destroy()
    end
end)

print("BakerOrDie by Fall Loaded")