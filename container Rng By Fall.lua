local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local remote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Warp"):WaitForChild("Index"):WaitForChild("Event"):WaitForChild("Reliable")
local plr = Players.LocalPlayer

local name = plr.Name
local plot = nil

for _, blot in ipairs(workspace:WaitForChild("Gameplay"):WaitForChild("Plots"):GetChildren()) do
	local label = blot.PlotLogic.PlotNameSign.PlayerInfoSign.PlayerNameSign.MainFrame.NameLabel
	if label.Text:find(name .. "'s") then
		plot = blot
		break
	end
end

if not plot then error("No plot found, disabling") return end

local coinHolder = workspace:WaitForChild("Gameplay"):WaitForChild("CoinHolder")
local customers = workspace:WaitForChild("Gameplay"):WaitForChild("Customers")
local containerHolder = plot:WaitForChild("PlotLogic"):WaitForChild("ContainerHolder")
local itemCache = plot.PlotLogic.ItemCache

local containerMap = {
	["JunkContainer"] = string.char(13) .. "JunkContainer",
	["ScratchedContainer"] = string.char(18) .. "ScratchedContainer",
	["SealedContainer"] = string.char(15) .. "SealedContainer",
	["MilitaryContainer"] = string.char(17) .. "MilitaryContainer",
	["MetalContainer"] = string.char(14) .. "MetalContainer",
	["FrozenContainer"] = string.char(15) .. "FrozenContainer",
	["LavaContainer"] = string.char(13) .. "LavaContainer",
	["CorruptedContainer"] = string.char(18) .. "CorruptedContainer",
	["StormedContainer"] = string.char(16) .. "StormedContainer",
	["LightningContainer"] = string.char(18) .. "LightningContainer",
	["InfernalContainer"] = string.char(17) .. "InfernalContainer",
	["MysticContainer"] = string.char(15) .. "MysticContainer",
	["GlitchedContainer"] = string.char(17) .. "GlitchedContainer",
	["AstralContainer"] = string.char(15) .. "AstralContainer",
	["DreamContainer"] = string.char(14) .. "DreamContainer",
	["CelestialContainer"] = string.char(18) .. "CelestialContainer",
	["FireContainer"] = string.char(13) .. "FireContainer",
	["GoldenContainer"] = string.char(15) .. "GoldenContainer",
	["DiamondContainer"] = string.char(16) .. "DiamondContainer",
	["EmeraldContainer"] = string.char(16) .. "EmeraldContainer",
	["RubyContainer"] = string.char(13) .. "RubyContainer",
	["SapphireContainer"] = string.char(17) .. "SapphireContainer",
	["SpaceContainer"] = string.char(14) .. "SpaceContainer",
	["DeepSpaceContainer"] = string.char(18) .. "DeepSpaceContainer"
}

local containerOptions = {
	"JunkContainer",
	"ScratchedContainer",
	"SealedContainer",
	"MilitaryContainer",
	"MetalContainer",
	"FrozenContainer",
	"LavaContainer",
	"CorruptedContainer",
	"StormedContainer",
	"LightningContainer",
	"InfernalContainer",
	"MysticContainer",
	"GlitchedContainer",
	"AstralContainer",
	"DreamContainer",
	"CelestialContainer",
	"FireContainer",
	"GoldenContainer",
	"DiamondContainer",
	"EmeraldContainer",
	"RubyContainer",
	"SapphireContainer",
	"SpaceContainer",
	"DeepSpaceContainer"
}

local flowerMap = {
	["BasicFlowerContainer"] = string.char(20) .. "BasicFlowerContainer",
	["GoodFlowerContainer"] = string.char(19) .. "GoodFlowerContainer"
}

local flowerOptions = {
	"BasicFlowerContainer",
	"GoodFlowerContainer"
}

local function runFpsBooster()
	if not _G.Ignore then
		_G.Ignore = {}
	end
	if _G.SendNotifications == nil then
		_G.SendNotifications = true
	end
	if _G.ConsoleLogs == nil then
		_G.ConsoleLogs = false
	end

	if not game:IsLoaded() then
		repeat
			task.wait()
		until game:IsLoaded()
	end
	if not _G.Settings then
		_G.Settings = {
			Players = {
				["Ignore Me"] = true,
				["Ignore Others"] = true,
				["Ignore Tools"] = true
			},
			Meshes = {
				NoMesh = false,
				NoTexture = false,
				Destroy = false
			},
			Images = {
				Invisible = true,
				Destroy = false
			},
			Explosions = {
				Smaller = true,
				Invisible = false,
				Destroy = false
			},
			Particles = {
				Invisible = true,
				Destroy = false
			},
			TextLabels = {
				LowerQuality = false,
				Invisible = false,
				Destroy = false
			},
			MeshParts = {
				LowerQuality = true,
				Invisible = false,
				NoTexture = false,
				NoMesh = false,
				Destroy = false
			},
			Other = {
				["FPS Cap"] = true,
				["No Camera Effects"] = true,
				["No Clothes"] = true,
				["Low Water Graphics"] = true,
				["No Shadows"] = true,
				["Low Rendering"] = true,
				["Low Quality Parts"] = true,
				["Low Quality Models"] = true,
				["Reset Materials"] = true,
				["Lower Quality MeshParts"] = true,
				ClearNilInstances = false
			}
		}
	end

	local Lighting = game:GetService("Lighting")
	local StarterGui = game:GetService("StarterGui")
	local MaterialService = game:GetService("MaterialService")
	local ME = Players.LocalPlayer
	local CanBeEnabled = {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}

	local function PartOfCharacter(Inst)
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= ME and v.Character and Inst:IsDescendantOf(v.Character) then
				return true
			end
		end
		return false
	end

	local function DescendantOfIgnore(Inst)
		for _, v in pairs(_G.Ignore) do
			if Inst:IsDescendantOf(v) then
				return true
			end
		end
		return false
	end

	local function CheckIfBad(Inst)
		if not Inst:IsDescendantOf(Players) and (_G.Settings.Players["Ignore Others"] and not PartOfCharacter(Inst)
		or not _G.Settings.Players["Ignore Others"]) and (_G.Settings.Players["Ignore Me"] and ME.Character and not Inst:IsDescendantOf(ME.Character)
		or not _G.Settings.Players["Ignore Me"]) and (_G.Settings.Players["Ignore Tools"] and not Inst:IsA("BackpackItem") and not Inst:FindFirstAncestorWhichIsA("BackpackItem")
		or not _G.Settings.Players["Ignore Tools"]) and (_G.Ignore and not table.find(_G.Ignore, Inst) and not DescendantOfIgnore(Inst)
		or (not _G.Ignore or type(_G.Ignore) ~= "table" or #_G.Ignore <= 0)) then
			if Inst:IsA("DataModelMesh") then
				if Inst:IsA("SpecialMesh") then
					if _G.Settings.Meshes.NoMesh then
						Inst.MeshId = ""
					end
					if _G.Settings.Meshes.NoTexture then
						Inst.TextureId = ""
					end
				end
				if _G.Settings.Meshes.Destroy or _G.Settings["No Meshes"] then
					Inst:Destroy()
				end
			elseif Inst:IsA("FaceInstance") then
				if _G.Settings.Images.Invisible then
					Inst.Transparency = 1
					Inst.Shiny = 1
				end
				if _G.Settings.Images.LowDetail then
					Inst.Shiny = 1
				end
				if _G.Settings.Images.Destroy then
					Inst:Destroy()
				end
			elseif Inst:IsA("ShirtGraphic") then
				if _G.Settings.Images.Invisible then
					Inst.Graphic = ""
				end
				if _G.Settings.Images.Destroy then
					Inst:Destroy()
				end
			elseif table.find(CanBeEnabled, Inst.ClassName) then
				if _G.Settings["Invisible Particles"] or _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["Invisible Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Invisible) then
					Inst.Enabled = false
				end
				if (_G.Settings.Other and _G.Settings.Other["No Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Destroy) then
					Inst:Destroy()
				end
			elseif Inst:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
				Inst.Enabled = false
			elseif Inst:IsA("Explosion") then
				if _G.Settings["Smaller Explosions"] or (_G.Settings.Other and _G.Settings.Other["Smaller Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Smaller) then
					Inst.BlastPressure = 1
					Inst.BlastRadius = 1
				end
				if _G.Settings["Invisible Explosions"] or (_G.Settings.Other and _G.Settings.Other["Invisible Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Invisible) then
					Inst.BlastPressure = 1
					Inst.BlastRadius = 1
					Inst.Visible = false
				end
				if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Destroy) then
					Inst:Destroy()
				end
			elseif Inst:IsA("Clothing") or Inst:IsA("SurfaceAppearance") or Inst:IsA("BaseWrap") then
				if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
					Inst:Destroy()
				end
			elseif Inst:IsA("BasePart") and not Inst:IsA("MeshPart") then
				if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
					Inst.Material = Enum.Material.Plastic
					Inst.Reflectance = 0
				end
			elseif Inst:IsA("TextLabel") and Inst:IsDescendantOf(workspace) then
				if _G.Settings["Lower Quality TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Lower Quality TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.LowerQuality) then
					Inst.Font = Enum.Font.SourceSans
					Inst.TextScaled = false
					Inst.RichText = false
					Inst.TextSize = 14
				end
				if _G.Settings["Invisible TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Invisible TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Invisible) then
					Inst.Visible = false
				end
				if _G.Settings["No TextLabels"] or (_G.Settings.Other and _G.Settings.Other["No TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Destroy) then
					Inst:Destroy()
				end
			elseif Inst:IsA("Model") then
				if _G.Settings["Low Quality Models"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Models"]) then
					Inst.LevelOfDetail = 1
				end
			elseif Inst:IsA("MeshPart") then
				if _G.Settings["Low Quality MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.LowerQuality) then
					Inst.RenderFidelity = 2
					Inst.Reflectance = 0
					Inst.Material = Enum.Material.Plastic
				end
				if _G.Settings["Invisible MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Invisible MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Invisible) then
					Inst.Transparency = 1
					Inst.RenderFidelity = 2
					Inst.Reflectance = 0
					Inst.Material = Enum.Material.Plastic
				end
				if _G.Settings.MeshParts and _G.Settings.MeshParts.NoTexture then
					Inst.TextureID = ""
				end
				if _G.Settings.MeshParts and _G.Settings.MeshParts.NoMesh then
					Inst.MeshId = ""
				end
				if _G.Settings["No MeshParts"] or (_G.Settings.Other and _G.Settings.Other["No MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Destroy) then
					Inst:Destroy()
				end
			end
		end
	end

	if _G.SendNotifications then
		StarterGui:SetCore("SendNotification", {
			Title = "FPS Active",
			Text = "Loading FPS Booster...",
			Duration = math.huge,
			Button1 = "Okay"
		})
	end

	coroutine.wrap(pcall)(function()
		if (_G.Settings["Low Water Graphics"] or (_G.Settings.Other and _G.Settings.Other["Low Water Graphics"])) then
			local terrain = workspace:FindFirstChildOfClass("Terrain")
			if not terrain then
				repeat
					task.wait()
				until workspace:FindFirstChildOfClass("Terrain")
				terrain = workspace:FindFirstChildOfClass("Terrain")
			end
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 0
			if sethiddenproperty then
				sethiddenproperty(terrain, "Decoration", false)
			else
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
					Duration = 5,
					Button1 = "Okay"
				})
				warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
			end
			if _G.SendNotifications then
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Low Water Graphics Enabled",
					Duration = 5,
					Button1 = "Okay"
				})
			end
			if _G.ConsoleLogs then
				warn("Low Water Graphics Enabled")
			end
		end
	end)

	coroutine.wrap(pcall)(function()
		if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
			Lighting.GlobalShadows = false
			Lighting.FogEnd = 9e9
			Lighting.ShadowSoftness = 0
			if sethiddenproperty then
				sethiddenproperty(Lighting, "Technology", 2)
			else
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
					Duration = 5,
					Button1 = "Okay"
				})
				warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
			end
			if _G.SendNotifications then
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "No Shadows Enabled",
					Duration = 5,
					Button1 = "Okay"
				})
			end
			if _G.ConsoleLogs then
				warn("No Shadows Enabled")
			end
		end
	end)

	coroutine.wrap(pcall)(function()
		if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
			settings().Rendering.QualityLevel = 1
			settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
			if _G.SendNotifications then
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Low Rendering Enabled",
					Duration = 5,
					Button1 = "Okay"
				})
			end
			if _G.ConsoleLogs then
				warn("Low Rendering Enabled")
			end
		end
	end)

	coroutine.wrap(pcall)(function()
		if _G.Settings["Reset Materials"] or (_G.Settings.Other and _G.Settings.Other["Reset Materials"]) then
			for _, v in pairs(MaterialService:GetChildren()) do
				v:Destroy()
			end
			MaterialService.Use2022Materials = false
			if _G.SendNotifications then
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Reset Materials Enabled",
					Duration = 5,
					Button1 = "Okay"
				})
			end
			if _G.ConsoleLogs then
				warn("Reset Materials Enabled")
			end
		end
	end)

	coroutine.wrap(pcall)(function()
		if _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) then
			if setfpscap then
				if type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "string" or type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "number" then
					setfpscap(tonumber(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
					if _G.SendNotifications then
						StarterGui:SetCore("SendNotification", {
							Title = "FPS Active",
							Text = "FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])),
							Duration = 5,
							Button1 = "Okay"
						})
					end
					if _G.ConsoleLogs then
						warn("FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
					end
				elseif _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) == true then
					setfpscap(1e6)
					if _G.SendNotifications then
						StarterGui:SetCore("SendNotification", {
							Title = "FPS Active",
							Text = "FPS Uncapped",
							Duration = 5,
							Button1 = "Okay"
						})
					end
					if _G.ConsoleLogs then
						warn("FPS Uncapped")
					end
				end
			else
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "FPS Cap Failed",
					Duration = math.huge,
					Button1 = "Okay"
				})
				warn("FPS Cap Failed")
			end
		end
	end)

	coroutine.wrap(pcall)(function()
		if _G.Settings.Other["ClearNilInstances"] then
			if getnilinstances then
				for _, v in pairs(getnilinstances()) do
					pcall(v.Destroy, v)
				end
				if _G.SendNotifications then
					StarterGui:SetCore("SendNotification", {
						Title = "FPS Active",
						Text = "Cleared Nil Instances",
						Duration = 5,
						Button1 = "Okay"
					})
				end
			else
				StarterGui:SetCore("SendNotification", {
					Title = "FPS Active",
					Text = "Your exploit does not support getnilinstances, please use a different exploit.",
					Duration = 5,
					Button1 = "Okay"
				})
				warn("Your exploit does not support getnilinstances, please use a different exploit.")
			end
		end
	end)

	local Descendants = game:GetDescendants()
	if _G.SendNotifications then
		StarterGui:SetCore("SendNotification", {
			Title = "FPS Active",
			Text = "Checking " .. #Descendants .. " Instances...",
			Duration = 15,
			Button1 = "Okay"
		})
	end
	if _G.ConsoleLogs then
		warn("Checking " .. #Descendants .. " Instances...")
	end
	for _, v in pairs(Descendants) do
		CheckIfBad(v)
	end
	StarterGui:SetCore("SendNotification", {
		Title = "FPS Active",
		Text = "FPS Booster Loaded!",
		Duration = math.huge,
		Button1 = "Okay"
	})
	warn("FPS Booster Loaded!")

	game.DescendantAdded:Connect(function(value)
		wait(_G.LoadedWait or 1)
		CheckIfBad(value)
	end)
end

local function createUI()
	local gui = Instance.new("ScreenGui")
	gui.Name = "ContainerRNG_UI"
	gui.ResetOnSpawn = false
	gui.Enabled = true
	gui.Parent = plr:WaitForChild("PlayerGui")

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.Size = UDim2.new(0, 560, 0, 420)
	main.Position = UDim2.new(0.5, -280, 0.5, -210)
	main.BackgroundColor3 = Color3.fromRGB(20, 24, 34)
	main.BorderSizePixel = 0
	main.ClipsDescendants = true
	main.Parent = gui

	local header = Instance.new("TextLabel")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 36)
	header.BackgroundColor3 = Color3.fromRGB(26, 32, 46)
	header.BorderSizePixel = 0
	header.Text = "Container RNG By Fall"
	header.TextColor3 = Color3.fromRGB(230, 230, 230)
	header.Font = Enum.Font.GothamBold
	header.TextSize = 16
	header.TextXAlignment = Enum.TextXAlignment.Center
	header.ZIndex = 5
	header.Parent = main

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Name = "ToggleBtn"
	toggleBtn.Size = UDim2.new(0, 70, 0, 22)
	toggleBtn.Position = UDim2.new(1, -120, 0.5, -11)
	toggleBtn.BackgroundColor3 = Color3.fromRGB(24, 29, 42)
	toggleBtn.BorderSizePixel = 0
	toggleBtn.Text = "Hide"
	toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
	toggleBtn.Font = Enum.Font.GothamBold
	toggleBtn.TextSize = 12
	toggleBtn.ZIndex = 6
	toggleBtn.Parent = header

	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseBtn"
	closeBtn.Size = UDim2.new(0, 24, 0, 22)
	closeBtn.Position = UDim2.new(1, -36, 0.5, -11)
	closeBtn.BackgroundColor3 = Color3.fromRGB(70, 32, 36)
	closeBtn.BorderSizePixel = 0
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(240, 230, 230)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 12
	closeBtn.ZIndex = 6
	closeBtn.Parent = header

	local tabsBar = Instance.new("Frame")
	tabsBar.Name = "TabsBar"
	tabsBar.Size = UDim2.new(0, 140, 1, -36)
	tabsBar.Position = UDim2.new(0, 0, 0, 36)
	tabsBar.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
	tabsBar.BorderSizePixel = 0
	tabsBar.Parent = main

	local tabsList = Instance.new("UIListLayout")
	tabsList.Padding = UDim.new(0, 6)
	tabsList.SortOrder = Enum.SortOrder.LayoutOrder
	tabsList.Parent = tabsBar

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Size = UDim2.new(1, -140, 1, -36)
	content.Position = UDim2.new(0, 140, 0, 36)
	content.BackgroundColor3 = Color3.fromRGB(22, 27, 38)
	content.BorderSizePixel = 0
	content.ClipsDescendants = true
	content.Parent = main

	local dragInput
	local dragStart
	local startPos
	local dragging = false
	local isClosed = false

	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragInput = nil
					dragging = false
				end
			end)
		end
	end)

	header.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput and dragStart and startPos then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
			dragInput = nil
		end
	end)

	local window = {}
	local tabs = {}

	function window:CreateTab(title)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(1, -12, 0, 32)
		tabButton.Position = UDim2.new(0, 6, 0, 0)
		tabButton.BackgroundColor3 = Color3.fromRGB(28, 35, 50)
		tabButton.BorderSizePixel = 0
		tabButton.Text = title
		tabButton.TextColor3 = Color3.fromRGB(220, 220, 220)
		tabButton.Font = Enum.Font.GothamSemibold
		tabButton.TextSize = 14
		tabButton.Parent = tabsBar

		local tabFrame = Instance.new("ScrollingFrame")
		tabFrame.Name = title
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.BorderSizePixel = 0
		tabFrame.ScrollBarThickness = 6
		tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabFrame.ClipsDescendants = true
		tabFrame.Visible = false
		tabFrame.Parent = content

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 10)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = tabFrame

		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		end)

		local tab = {}

		function tab:Show()
			for _, t in ipairs(tabs) do
				t.frame.Visible = false
				t.button.BackgroundColor3 = Color3.fromRGB(28, 35, 50)
			end
			tabFrame.Visible = true
			tabButton.BackgroundColor3 = Color3.fromRGB(42, 54, 78)
		end

		function tab:CreateSection(text)
			local section = Instance.new("TextLabel")
			section.Size = UDim2.new(1, -16, 0, 24)
			section.Position = UDim2.new(0, 8, 0, 0)
			section.BackgroundColor3 = Color3.fromRGB(26, 32, 46)
			section.BorderSizePixel = 0
			section.Text = text
			section.TextColor3 = Color3.fromRGB(210, 210, 210)
			section.Font = Enum.Font.GothamBold
			section.TextSize = 13
			section.Parent = tabFrame
		end

		function tab:CreateButton(cfg)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -16, 0, 30)
			btn.Position = UDim2.new(0, 8, 0, 0)
			btn.BackgroundColor3 = Color3.fromRGB(36, 44, 62)
			btn.BorderSizePixel = 0
			btn.Text = cfg.Name or "Button"
			btn.TextColor3 = Color3.fromRGB(230, 230, 230)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 13
			btn.Parent = tabFrame

			btn.MouseButton1Click:Connect(function()
				if cfg.Callback then
					cfg.Callback()
				end
			end)
		end

		function tab:CreateToggle(cfg)
			local wrap = Instance.new("Frame")
			wrap.Size = UDim2.new(1, -16, 0, 30)
			wrap.Position = UDim2.new(0, 8, 0, 0)
			wrap.BackgroundColor3 = Color3.fromRGB(36, 44, 62)
			wrap.BorderSizePixel = 0
			wrap.ClipsDescendants = false
			wrap.Parent = tabFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -60, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = cfg.Name or "Toggle"
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = wrap

			local stateBtn = Instance.new("TextButton")
			stateBtn.Size = UDim2.new(0, 44, 0, 22)
			stateBtn.Position = UDim2.new(1, -52, 0.5, -11)
			stateBtn.BackgroundColor3 = Color3.fromRGB(24, 29, 42)
			stateBtn.BorderSizePixel = 0
			stateBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
			stateBtn.Font = Enum.Font.GothamBold
			stateBtn.TextSize = 12
			stateBtn.Parent = wrap

			local state = cfg.CurrentValue and true or false
			local function render()
				stateBtn.Text = state and "ON" or "OFF"
				stateBtn.BackgroundColor3 = state and Color3.fromRGB(52, 92, 66) or Color3.fromRGB(24, 29, 42)
				wrap.BackgroundColor3 = state and Color3.fromRGB(38, 58, 44) or Color3.fromRGB(36, 44, 62)
				label.TextColor3 = state and Color3.fromRGB(220, 255, 230) or Color3.fromRGB(230, 230, 230)
			end
			render()

			stateBtn.MouseButton1Click:Connect(function()
				state = not state
				render()
				if cfg.Callback then
					cfg.Callback(state)
				end
			end)

			if cfg.Callback then
				cfg.Callback(state)
			end
		end

		function tab:CreateInput(cfg)
			local wrap = Instance.new("Frame")
			wrap.Size = UDim2.new(1, -16, 0, 30)
			wrap.Position = UDim2.new(0, 8, 0, 0)
			wrap.BackgroundColor3 = Color3.fromRGB(36, 44, 62)
			wrap.BorderSizePixel = 0
			wrap.ClipsDescendants = false
			wrap.Parent = tabFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.5, -10, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = cfg.Name or "Input"
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = wrap

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0.45, -10, 0, 22)
			box.Position = UDim2.new(0.55, 0, 0.5, -11)
			box.BackgroundColor3 = Color3.fromRGB(24, 29, 42)
			box.BorderSizePixel = 0
			box.Text = cfg.CurrentValue or ""
			box.PlaceholderText = cfg.PlaceholderText or ""
			box.TextColor3 = Color3.fromRGB(230, 230, 230)
			box.Font = Enum.Font.Gotham
			box.TextSize = 12
			box.ClearTextOnFocus = cfg.RemoveTextAfterFocusLost and true or false
			box.Parent = wrap

			box.FocusLost:Connect(function()
				if cfg.Callback then
					cfg.Callback(box.Text)
				end
			end)
		end

		function tab:CreateSlider(cfg)
			local wrap = Instance.new("Frame")
			wrap.Size = UDim2.new(1, -16, 0, 44)
			wrap.Position = UDim2.new(0, 8, 0, 0)
			wrap.BackgroundColor3 = Color3.fromRGB(36, 44, 62)
			wrap.BorderSizePixel = 0
			wrap.ClipsDescendants = false
			wrap.Parent = tabFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -16, 0, 18)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = (cfg.Name or "Slider") .. " : " .. tostring(cfg.CurrentValue or 0)
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 12
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = wrap

			local bar = Instance.new("Frame")
			bar.Size = UDim2.new(1, -16, 0, 8)
			bar.Position = UDim2.new(0, 8, 0, 26)
			bar.BackgroundColor3 = Color3.fromRGB(24, 29, 42)
			bar.BorderSizePixel = 0
			bar.Parent = wrap

			local fill = Instance.new("Frame")
			fill.Size = UDim2.new(0, 0, 1, 0)
			fill.BackgroundColor3 = Color3.fromRGB(80, 120, 170)
			fill.BorderSizePixel = 0
			fill.Parent = bar

			local min = cfg.Range and cfg.Range[1] or 0
			local max = cfg.Range and cfg.Range[2] or 100
			local inc = cfg.Increment or 1
			local value = cfg.CurrentValue or min

			local function setValueFromX(x)
				local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
				local raw = min + (max - min) * rel
				local snapped = math.floor(raw / inc + 0.5) * inc
				value = math.clamp(snapped, min, max)
				local pct = (value - min) / (max - min)
				fill.Size = UDim2.new(pct, 0, 1, 0)
				label.Text = (cfg.Name or "Slider") .. " : " .. tostring(value)
				if cfg.Callback then
					cfg.Callback(value)
				end
			end

			setValueFromX(bar.AbsolutePosition.X + (value - min) / (max - min) * bar.AbsoluteSize.X)

			local dragging = false
			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					setValueFromX(input.Position.X)
				end
			end)

			bar.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					setValueFromX(input.Position.X)
				end
			end)
		end

		function tab:CreateDropdown(cfg)
			local wrap = Instance.new("Frame")
			wrap.Size = UDim2.new(1, -16, 0, 30)
			wrap.Position = UDim2.new(0, 8, 0, 0)
			wrap.BackgroundColor3 = Color3.fromRGB(36, 44, 62)
			wrap.BorderSizePixel = 0
			wrap.ClipsDescendants = false
			wrap.Parent = tabFrame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.5, -10, 1, 0)
			label.Position = UDim2.new(0, 8, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = cfg.Name or "Dropdown"
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.ZIndex = 2
			label.Parent = wrap

			local button = Instance.new("TextButton")
			button.Size = UDim2.new(0.45, -10, 0, 22)
			button.Position = UDim2.new(0.55, 0, 0.5, -11)
			button.BackgroundColor3 = Color3.fromRGB(24, 29, 42)
			button.BorderSizePixel = 0
			button.Text = cfg.CurrentOption or "Select"
			button.TextColor3 = Color3.fromRGB(230, 230, 230)
			button.Font = Enum.Font.Gotham
			button.TextSize = 12
			button.ZIndex = 2
			button.Parent = wrap

			local list = Instance.new("Frame")
			list.Size = UDim2.new(1, 0, 0, 0)
			list.Position = UDim2.new(0, 0, 1, 2)
			list.BackgroundColor3 = Color3.fromRGB(28, 35, 50)
			list.BorderSizePixel = 0
			list.Visible = false
			list.ZIndex = 10
			list.Parent = wrap

			local listLayout = Instance.new("UIListLayout")
			listLayout.SortOrder = Enum.SortOrder.LayoutOrder
			listLayout.Parent = list

			local function closeList()
				list.Visible = false
				list.Size = UDim2.new(1, 0, 0, 0)
			end

			button.MouseButton1Click:Connect(function()
				list.Visible = not list.Visible
				if list.Visible then
					list.Size = UDim2.new(1, 0, 0, math.min(160, #cfg.Options * 24))
				else
					closeList()
				end
			end)

			for _, opt in ipairs(cfg.Options or {}) do
				local optBtn = Instance.new("TextButton")
				optBtn.Size = UDim2.new(1, 0, 0, 24)
				optBtn.BackgroundColor3 = Color3.fromRGB(28, 35, 50)
				optBtn.BorderSizePixel = 0
				optBtn.Text = opt
				optBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
				optBtn.Font = Enum.Font.Gotham
				optBtn.TextSize = 12
				optBtn.ZIndex = 11
				optBtn.Parent = list

				optBtn.MouseButton1Click:Connect(function()
					button.Text = opt
					closeList()
					if cfg.Callback then
						cfg.Callback(opt)
					end
				end)
			end
		end

		table.insert(tabs, { button = tabButton, frame = tabFrame, api = tab })
		tabButton.MouseButton1Click:Connect(function()
			tab:Show()
		end)

		if #tabs == 1 then
			tab:Show()
		end

		return tab
	end

	local function applyToggle()
		if isClosed then
			return
		end
		content.Visible = not content.Visible
		tabsBar.Visible = not tabsBar.Visible
		if content.Visible then
			main.Size = UDim2.new(0, 560, 0, 420)
			toggleBtn.Text = "Hide"
		else
			main.Size = UDim2.new(0, 260, 0, 36)
			toggleBtn.Text = "Show"
		end
	end

	toggleBtn.MouseButton1Click:Connect(applyToggle)

	closeBtn.MouseButton1Click:Connect(function()
		isClosed = true
		main.Visible = false
		content.Visible = false
		tabsBar.Visible = false
		toggleBtn.Text = "Show"
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if UserInputService:GetFocusedTextBox() then return end
		if input.KeyCode == Enum.KeyCode.Equals then
			if isClosed then
				return
			end
			applyToggle()
		end
	end)

	return window
end

local Window = createUI()

local Tab = Window:CreateTab("Main")
Tab:CreateSection("Main")

Tab:CreateToggle({
	Name = "Coin Collector",
	CurrentValue = false,
	Callback = function(Value)
		if not coinHolder then
			error("No coin folder")
			return
		end
		_G.coin = Value
		while _G.coin do
			for _, coin in ipairs(coinHolder:GetChildren()) do
				remote:FireServer(buffer.fromstring("\6"), buffer.fromstring("\254\1\0\6" .. "0" .. coin.Name))
			end
			task.wait()
		end
	end,
})

local delete

Tab:CreateToggle({
	Name = "Item Collector",
	CurrentValue = false,
	Callback = function(Value)
		if not itemCache then
			error("No item folder")
			return
		end

		_G.item = Value

		local housePart = plot:WaitForChild("PlotDecor"):WaitForChild("House"):WaitForChild("Part")

		while _G.item do
			for _, item in ipairs(itemCache:GetChildren()) do
				if item:IsA("Model") and item.PrimaryPart then
					local itemPos = item.PrimaryPart.Position
					local housePos = housePart.Position
					local houseSize = housePart.Size

					local inBounds =
						math.abs(itemPos.X - housePos.X) <= houseSize.X / 2 and
						math.abs(itemPos.Z - housePos.Z) <= houseSize.Z / 2 and
						itemPos.Y >= housePos.Y

					if not inBounds then
						remote:FireServer(buffer.fromstring("\v"), buffer.fromstring("\254\1\0\6)" .. item.Name))
					else
						if delete then
							item:Destroy()
						end
					end
				end
			end
			task.wait()
		end
	end,
})

Tab:CreateToggle({
	Name = "Delete Plot Items",
	CurrentValue = false,
	Callback = function(Value)
		print("Items will delete when Item Collector is enabled")
		delete = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Drop Items",
	CurrentValue = false,
	Callback = function(Value)
		_G.drop = Value

		if Value then
			local housePart = plot:WaitForChild("PlotDecor"):WaitForChild("House"):WaitForChild("Part")

			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				plr.Character.HumanoidRootPart.CFrame = housePart.CFrame + Vector3.new(0, 7, 0)
			end

			while _G.drop do
				remote:FireServer(buffer.fromstring("\t"), buffer.fromstring("\254\0\0"))

				task.wait(0.1)
			end
		end
	end,
})

local speed
local speedV = 16

Tab:CreateToggle({
	Name = "Customer Speed",
	CurrentValue = false,
	Callback = function(Value)
		speed = Value

		if speed and customers then
			for _, customer in ipairs(customers:GetChildren()) do
				customer:WaitForChild("Humanoid").WalkSpeed = speedV
			end
		end
	end,
})

Tab:CreateSlider({
	Name = "Speed",
	Range = {16, 250},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(Value)
		speedV = Value

		if speed and customers then
			for _, customer in ipairs(customers:GetChildren()) do
				customer:WaitForChild("Humanoid").WalkSpeed = Value
			end
		end
	end,
})

customers.ChildAdded:Connect(function(customer)
	if not speed or not speedV then return end
	customer:WaitForChild("Humanoid").WalkSpeed = speedV
end)

Tab:CreateButton({
	Name = "Toggle Notifications",
	Callback = function()
		local pask = plr.PlayerGui
		for _, thing in ipairs(pask:GetChildren()) do
			if thing:FindFirstChild("NotificationFrame") then
				local frame = thing:FindFirstChild("NotificationFrame")
				frame.Visible = not frame.Visible
			end
		end
	end,
})

local Container = Window:CreateTab("Container")
Container:CreateSection("Container")

Container:CreateToggle({
	Name = "Container Open",
	CurrentValue = false,
	Callback = function(Value)
		if not containerHolder then
			error("No container folder")
			return
		end
		_G.container = Value
		while _G.container do
			for _, container in ipairs(containerHolder:GetChildren()) do
				remote:FireServer(buffer.fromstring("\28"), buffer.fromstring("\254\1\0\6." .. container.Name))
			end
			task.wait()
		end
	end,
})

local selectedContainer = "JunkContainer"

Container:CreateDropdown({
	Name = "Container",
	Options = containerOptions,
	CurrentOption = "JunkContainer",
	MultipleOptions = false,
	Callback = function(Option)
		selectedContainer = typeof(Option) == "table" and Option[1] or Option
	end,
})

local buyDelay
local maxContainers
local minMoney

Container:CreateToggle({
	Name = "Auto Buy Container",
	CurrentValue = false,
	Callback = function(Value)
		_G.buy = Value
		while _G.buy do
			local e = containerMap[selectedContainer]
			if not e then
				warn("Invalid container:", selectedContainer)
				break
			end

			local max = maxContainers or 8
			local containers = #containerHolder:GetChildren()

			local money = tonumber(plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Money") and plr.leaderstats.Money.Value) or 0

			if containers < max and (not minMoney or money >= minMoney) then
				remote:FireServer(buffer.fromstring("\26"), buffer.fromstring("\254\1\0\6" .. e))
			end

			task.wait(buyDelay or 0)
		end
	end,
})

Container:CreateSlider({
	Name = "Max Containers",
	Range = {1, 8},
	Increment = 1,
	CurrentValue = 8,
	Callback = function(Value)
		maxContainers = Value
	end,
})

Container:CreateInput({
   Name = "Min Money",
   CurrentValue = "0",
   PlaceholderText = "$",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
		local value = tonumber(Text)
		if value then
			minMoney = value
		else
			warn("Invalid money input")
		end
   end,
})

Container:CreateSlider({
	Name = "Buy Delay",
	Range = {0, 60},
	Increment = 0.1,
	CurrentValue = 0,
	Callback = function(Value)
		buyDelay = Value
	end,
})

local selectedFlower = "BasicFlowerContainer"

Container:CreateDropdown({
	Name = "Flower Container",
	Options = flowerOptions,
	CurrentOption = "BasicFlowerContainer",
	MultipleOptions = false,
	Callback = function(Option)
		selectedFlower = typeof(Option) == "table" and Option[1] or Option
	end,
})

local buyDelayFlower

Container:CreateToggle({
	Name = "Auto Buy Flower Container",
	CurrentValue = false,
	Callback = function(Value)
		_G.buyflower = Value
		while _G.buyflower do
			local e = flowerMap[selectedFlower]
			if not e then
				warn("Invalid container:", selectedFlower)
				break
			end

			remote:FireServer(buffer.fromstring("\26"), buffer.fromstring("\254\1\0\6" .. e))

			task.wait(buyDelayFlower or 0)
		end
	end,
})

Container:CreateSlider({
	Name = "Buy Delay",
	Range = {0, 60},
	Increment = 0.1,
	CurrentValue = 0,
	Callback = function(Value)
		buyDelayFlower = Value
	end,
})

local Upgrades = Window:CreateTab("Upgrades")
Upgrades:CreateSection("Upgrades")

Upgrades:CreateToggle({
	Name = "Upgrade Inventory Size",
	CurrentValue = false,
	Callback = function(Value)
		_G.upgradeinv = Value
		while _G.upgradeinv do
			remote:FireServer(buffer.fromstring("5"), buffer.fromstring("\254\1\0\6\17MaxInventoryItems"))

			task.wait(0.5)
		end
	end,
})

Upgrades:CreateToggle({
	Name = "Upgrade Max Flowers Placed",
	CurrentValue = false,
	Callback = function(Value)
		_G.upgradeflowers = Value
		while _G.upgradeflowers do
			remote:FireServer(buffer.fromstring("5"), buffer.fromstring("\254\1\0\6\16MaxFlowersPlaced"))

			task.wait(0.5)
		end
	end,
})

Upgrades:CreateToggle({
	Name = "Upgrade Max Customers",
	CurrentValue = false,
	Callback = function(Value)
		_G.upgradecustomers = Value
		while _G.upgradecustomers do
			remote:FireServer(buffer.fromstring("5"), buffer.fromstring("\254\1\0\6\fMaxCustomers"))

			task.wait(0.5)
		end
	end,
})

Upgrades:CreateToggle({
	Name = "Upgrade Max Containers",
	CurrentValue = false,
	Callback = function(Value)
		_G.upgradecontainers = Value
		while _G.upgradecontainers do
			remote:FireServer(buffer.fromstring("5"), buffer.fromstring("\254\1\0\6\rMaxContainers"))

			task.wait(0.5)
		end
	end,
})

Upgrades:CreateToggle({
	Name = "Upgrade Max Plot Items",
	CurrentValue = false,
	Callback = function(Value)
		_G.upgradepitems = Value
		while _G.upgradepitems do
			remote:FireServer(buffer.fromstring("5"), buffer.fromstring("\254\1\0\6\14MaxItemsOnPlot"))

			task.wait(0.5)
		end
	end,
})

local Event = Window:CreateTab("Event")
Event:CreateSection("Event")

Event:CreateButton({
	Name = "Buy Lavender [10M]",
	Callback = function()
		remote:FireServer(buffer.fromstring("\22"), buffer.fromstring("\254\1\0\6\bLavender"))
	end,
})

Event:CreateButton({
	Name = "Buy Lilly Pad [1B]",
	Callback = function()
		remote:FireServer(buffer.fromstring("\22"), buffer.fromstring("\254\1\0\6\bLillyPad"))
	end,
})

Event:CreateButton({
	Name = "Buy Cactus [250B]",
	Callback = function()
		remote:FireServer(buffer.fromstring("\22"), buffer.fromstring("\254\1\0\6\6Cactus"))
	end,
})

Event:CreateButton({
	Name = "Buy Palm Tree [1T]",
	Callback = function()
		remote:FireServer(buffer.fromstring("\22"), buffer.fromstring("\254\1\0\6\bPalmTree"))
	end,
})

local Misc = Window:CreateTab("Misc")
Misc:CreateSection("Misc")

Misc:CreateButton({
	Name = "FPS Boost",
	Callback = function()
		runFpsBooster()
	end,
})

Misc:CreateButton({
	Name = "Allow Reset",
	Callback = function()
		plr.PlayerScripts:FindFirstChild("ResetOff").Enabled = false
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	end,
})

Misc:CreateButton({
	Name = "Free Container",
	Callback = function()
		remote:FireServer(buffer.fromstring("<"), buffer.fromstring("\254\0\0"))
	end,
})

Misc:CreateSlider({
	Name = "Walkspeed",
	Range = {24, 500},
	Increment = 1,
	CurrentValue = 24,
	Callback = function(Value)
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.WalkSpeed = Value
		end
	end,
})

Misc:CreateSlider({
	Name = "Jumppower",
	Range = {50, 500},
	Increment = 1,
	CurrentValue = 50,
	Callback = function(Value)
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.JumpPower = Value
			plr.Character.Humanoid.UseJumpPower = true
		end
	end,
})

Misc:CreateSlider({
	Name = "Hip height",
	Range = {0, 10},
	Increment = 1,
	CurrentValue = 2,
	Callback = function(Value)
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.HipHeight = Value
		end
	end,
})

Misc:CreateToggle({
	Name = "Auto Rotate",
	CurrentValue = true,
	Callback = function(Value)
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.AutoRotate = Value
		end
	end,
})
