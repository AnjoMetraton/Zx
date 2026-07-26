local ok, err = pcall(function()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

local flyBV = nil
local flyBG = nil
local toggleFlags = {}
local auraRange = 15
local flySpeed = 50
local speedMult = 2
local jumpMult = 3

local C = {
	bg = Color3.fromRGB(10, 10, 10),
	panel = Color3.fromRGB(16, 16, 16),
	card = Color3.fromRGB(22, 22, 22),
	cardHover = Color3.fromRGB(30, 30, 30),
	accent = Color3.fromRGB(0, 255, 255),
	accentDim = Color3.fromRGB(0, 180, 180),
	accentDark = Color3.fromRGB(0, 80, 80),
	white = Color3.fromRGB(240, 240, 240),
	gray = Color3.fromRGB(140, 140, 140),
	darkGray = Color3.fromRGB(60, 60, 60),
	red = Color3.fromRGB(255, 40, 40),
	green = Color3.fromRGB(0, 255, 120),
	off = Color3.fromRGB(50, 50, 50),
	offText = Color3.fromRGB(180, 180, 180),
	onBg = Color3.fromRGB(0, 40, 40),
	onText = Color3.fromRGB(0, 255, 255),
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2ZXXHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
local okCG, errCG = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not okCG then ScreenGui.Parent = player:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 460)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -230)
MainFrame.BackgroundColor3 = C.bg
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = C.accent
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.4
MainStroke.Parent = MainFrame

local GlowFrame = Instance.new("Frame")
GlowFrame.Size = UDim2.new(1, 4, 1, 4)
GlowFrame.Position = UDim2.new(0, -2, 0, -2)
GlowFrame.BackgroundColor3 = C.accent
GlowFrame.BackgroundTransparency = 0.85
GlowFrame.BorderSizePixel = 0
GlowFrame.ZIndex = 0
GlowFrame.Parent = MainFrame

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 12)
GlowCorner.Parent = GlowFrame

local isDragging = false
local dragStart = nil
local dragPos = nil

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		dragStart = input.Position
		dragPos = MainFrame.Position
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and isDragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + delta.X, dragPos.Y.Scale, dragPos.Y.Offset + delta.Y)
	end
end)

MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		isDragging = false
	end
end)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = C.panel
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.Position = UDim2.new(0, 0, 1, -1)
HeaderLine.BackgroundColor3 = C.accent
HeaderLine.BackgroundTransparency = 0.6
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.65, 0, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MM2 ZXX.HUB"
Title.TextColor3 = C.accent
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local TitleUnder = Instance.new("TextLabel")
TitleUnder.Size = UDim2.new(0.65, 0, 0, 12)
TitleUnder.Position = UDim2.new(0, 16, 1, -14)
TitleUnder.BackgroundTransparency = 1
TitleUnder.Text = "CYBERPUNK EDITION"
TitleUnder.TextColor3 = C.darkGray
TitleUnder.Font = Enum.Font.Code
TitleUnder.TextSize = 9
TitleUnder.TextXAlignment = Enum.TextXAlignment.Left
TitleUnder.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.Position = UDim2.new(1, -44, 0, 8)
CloseBtn.BackgroundColor3 = C.red
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.white
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 6)
CloseBtnCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 36, 0, 36)
MinBtn.Position = UDim2.new(1, -86, 0, 8)
MinBtn.BackgroundColor3 = C.darkGray
MinBtn.Text = "-"
MinBtn.TextColor3 = C.white
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Header

local MinBtnCorner = Instance.new("UICorner")
MinBtnCorner.CornerRadius = UDim.new(0, 6)
MinBtnCorner.Parent = MinBtn

local isMinimized = false
local FloatingBtn = nil

local function minimizeHub()
	isMinimized = true
	MainFrame.Visible = false

	FloatingBtn = Instance.new("TextButton")
	FloatingBtn.Name = "FloatingBtn"
	FloatingBtn.Size = UDim2.new(0, 90, 0, 40)
	FloatingBtn.Position = UDim2.new(0, 12, 1, -52)
	FloatingBtn.BackgroundColor3 = C.bg
	FloatingBtn.Text = "MM2 HUB"
	FloatingBtn.TextColor3 = C.accent
	FloatingBtn.Font = Enum.Font.GothamBlack
	FloatingBtn.TextSize = 12
	FloatingBtn.BorderSizePixel = 0
	FloatingBtn.Parent = ScreenGui

	local fbCorner = Instance.new("UICorner")
	fbCorner.CornerRadius = UDim.new(0, 8)
	fbCorner.Parent = FloatingBtn

	local fbStroke = Instance.new("UIStroke")
	fbStroke.Color = C.accent
	fbStroke.Thickness = 1.5
	fbStroke.Parent = FloatingBtn

	local fbGlow = Instance.new("Frame")
	fbGlow.Size = UDim2.new(1, 4, 1, 4)
	fbGlow.Position = UDim2.new(0, -2, 0, -2)
	fbGlow.BackgroundColor3 = C.accent
	fbGlow.BackgroundTransparency = 0.8
	fbGlow.BorderSizePixel = 0
	fbGlow.ZIndex = 0
	fbGlow.Parent = FloatingBtn

	local fbGlowCorner = Instance.new("UICorner")
	fbGlowCorner.CornerRadius = UDim.new(0, 10)
	fbGlowCorner.Parent = fbGlow

	local fbDragStart = nil
	local fbDragPos = nil
	local fbDragging = false

	FloatingBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			fbDragging = true
			fbDragStart = input.Position
			fbDragPos = FloatingBtn.Position
		end
	end)

	FloatingBtn.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and fbDragging then
			local delta = input.Position - fbDragStart
			FloatingBtn.Position = UDim2.new(fbDragPos.X.Scale, fbDragPos.X.Offset + delta.X, fbDragPos.Y.Scale, fbDragPos.Y.Offset + delta.Y)
		end
	end)

	FloatingBtn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			fbDragging = false
		end
	end)

	FloatingBtn.MouseButton1Click:Connect(function()
		isMinimized = false
		MainFrame.Visible = true
		if FloatingBtn and FloatingBtn.Parent then
			FloatingBtn:Destroy()
		end
		FloatingBtn = nil
	end)
end

MinBtn.MouseButton1Click:Connect(minimizeHub)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -16, 0, 42)
TabBar.Position = UDim2.new(0, 8, 0, 58)
TabBar.BackgroundColor3 = C.panel
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabBarCorner = Instance.new("UICorner")
TabBarCorner.CornerRadius = UDim.new(0, 8)
TabBarCorner.Parent = TabBar

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, -8, 1, 0)
TabScroll.Position = UDim2.new(0, 4, 0, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 0
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
TabScroll.ScrollingDirection = Enum.ScrollingDirection.X
TabScroll.Parent = TabBar

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabScroll

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -16, 1, -116)
ContentFrame.Position = UDim2.new(0, 8, 0, 108)
ContentFrame.BackgroundColor3 = C.bg
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

local ContentStroke = Instance.new("UIStroke")
ContentStroke.Color = C.darkGray
ContentStroke.Thickness = 1
ContentStroke.Transparency = 0.5
ContentStroke.Parent = ContentFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -8, 1, -8)
ContentScroll.Position = UDim2.new(0, 4, 0, 4)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = C.accent
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.Parent = ContentScroll

local CurrentTab = nil
local TabPages = {}
local TabBtns = {}

local function SwitchTab(name)
	for _, t in pairs(TabPages) do
		t.Page.Visible = (t.Name == name)
	end
	CurrentTab = name
	for _, t in pairs(TabBtns) do
		if t.Name == name then
			t.Btn.BackgroundColor3 = C.accentDark
			t.Btn.TextColor3 = C.accent
		else
			t.Btn.BackgroundColor3 = C.card
			t.Btn.TextColor3 = C.gray
		end
	end
end

local function CreateTab(name, order)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 0, 1, 0)
	btn.AutomaticSize = Enum.AutomaticSize.X
	btn.BackgroundColor3 = C.card
	btn.Text = "  " .. name .. "  "
	btn.TextColor3 = C.gray
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.TextXAlignment = Enum.TextXAlignment.Center
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.LayoutOrder = order
	btn.Parent = TabScroll

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	local page = Instance.new("Frame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 0, 0)
	page.AutomaticSize = Enum.AutomaticSize.Y
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.Visible = false
	page.LayoutOrder = order
	page.Parent = ContentScroll

	local pLayout = Instance.new("UIListLayout")
	pLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pLayout.Padding = UDim.new(0, 6)
	pLayout.Parent = page

	local pPad = Instance.new("UIPadding")
	pPad.PaddingTop = UDim.new(0, 2)
	pPad.PaddingBottom = UDim.new(0, 2)
	pPad.Parent = page

	TabPages[name] = {Name = name, Page = page, Btn = btn}

	btn.MouseButton1Click:Connect(function()
		SwitchTab(name)
	end)

	table.insert(TabBtns, btn)
	return page
end

local MurderPage = CreateTab("ASSASSINO", 1)
local SheriffPage = CreateTab("XERIFE", 2)
local MovePage = CreateTab("MOVIMENTO", 3)
local EspPage = CreateTab("VISAO", 4)
local FarmPage = CreateTab("FARM", 5)
local SettingsPage = CreateTab("CONFIG", 6)

SwitchTab("ASSASSINO")

local function CreateToggle(parent, label, description, onToggle)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 58)
	container.BackgroundColor3 = C.card
	container.BorderSizePixel = 0
	container.Parent = parent

	local cc = Instance.new("UICorner")
	cc.CornerRadius = UDim.new(0, 8)
	cc.Parent = container

	local accentLine = Instance.new("Frame")
	accentLine.Size = UDim2.new(0, 3, 1, -12)
	accentLine.Position = UDim2.new(0, 6, 0, 6)
	accentLine.BackgroundColor3 = C.darkGray
	accentLine.BorderSizePixel = 0
	accentLine.Parent = container

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(0.65, 0, 0, 20)
	nameLabel.Position = UDim2.new(0, 16, 0, 6)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = label
	nameLabel.TextColor3 = C.white
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 13
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = container

	local descLabel = Instance.new("TextLabel")
	descLabel.Size = UDim2.new(0.65, 0, 0, 14)
	descLabel.Position = UDim2.new(0, 16, 0, 28)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = description
	descLabel.TextColor3 = C.darkGray
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 10
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.Parent = container

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(0, 52, 0, 26)
	toggleBtn.Position = UDim2.new(1, -64, 0.5, -13)
	toggleBtn.BackgroundColor3 = C.off
	toggleBtn.Text = ""
	toggleBtn.BorderSizePixel = 0
	toggleBtn.Parent = container

	local tbCorner = Instance.new("UICorner")
	tbCorner.CornerRadius = UDim.new(1, 0)
	tbCorner.Parent = toggleBtn

	local tbStroke = Instance.new("UIStroke")
	tbStroke.Color = C.darkGray
	tbStroke.Thickness = 1
	tbStroke.Parent = toggleBtn

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 20, 0, 20)
	knob.Position = UDim2.new(0, 3, 0.5, -10)
	knob.BackgroundColor3 = C.darkGray
	knob.BorderSizePixel = 0
	knob.Parent = toggleBtn

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local stateOn = false

	toggleBtn.MouseButton1Click:Connect(function()
		stateOn = not stateOn
		if stateOn then
			toggleBtn.BackgroundColor3 = C.accentDark
			knob.Position = UDim2.new(1, -23, 0.5, -10)
			knob.BackgroundColor3 = C.accent
			tbStroke.Color = C.accent
			accentLine.BackgroundColor3 = C.accent
		else
			toggleBtn.BackgroundColor3 = C.off
			knob.Position = UDim2.new(0, 3, 0.5, -10)
			knob.BackgroundColor3 = C.darkGray
			tbStroke.Color = C.darkGray
			accentLine.BackgroundColor3 = C.darkGray
		end
		if onToggle then onToggle(stateOn) end
	end)

	return container, function() return stateOn end
end

local function CreateSlider(parent, label, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 58)
	container.BackgroundColor3 = C.card
	container.BorderSizePixel = 0
	container.Parent = parent

	local cc = Instance.new("UICorner")
	cc.CornerRadius = UDim.new(0, 8)
	cc.Parent = container

	local accentLine = Instance.new("Frame")
	accentLine.Size = UDim2.new(0, 3, 1, -12)
	accentLine.Position = UDim2.new(0, 6, 0, 6)
	accentLine.BackgroundColor3 = C.darkGray
	accentLine.BorderSizePixel = 0
	accentLine.Parent = container

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.7, 0, 0, 20)
	lbl.Position = UDim2.new(0, 16, 0, 6)
	lbl.BackgroundTransparency = 1
	lbl.Text = label .. ": " .. default
	lbl.TextColor3 = C.white
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = container

	local valLabel = Instance.new("TextLabel")
	valLabel.Size = UDim2.new(0.25, 0, 0, 20)
	valLabel.Position = UDim2.new(0.72, 0, 0, 6)
	valLabel.BackgroundTransparency = 1
	valLabel.Text = tostring(default)
	valLabel.TextColor3 = C.accent
	valLabel.Font = Enum.Font.Code
	valLabel.TextSize = 14
	valLabel.TextXAlignment = Enum.TextXAlignment.Right
	valLabel.Parent = container

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(0.82, 0, 0, 6)
	sliderBg.Position = UDim2.new(0.09, 0, 0, 36)
	sliderBg.BackgroundColor3 = C.off
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local sliderBgCorner = Instance.new("UICorner")
	sliderBgCorner.CornerRadius = UDim.new(1, 0)
	sliderBgCorner.Parent = sliderBg

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(default / max, 0, 1, 0)
	sliderFill.BackgroundColor3 = C.accent
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = sliderFill

	local sliderThumb = Instance.new("TextButton")
	sliderThumb.Size = UDim2.new(0, 24, 0, 24)
	sliderThumb.Position = UDim2.new(default / max, -12, 0.5, -12)
	sliderThumb.BackgroundColor3 = C.white
	sliderThumb.Text = ""
	sliderThumb.BorderSizePixel = 0
	sliderThumb.ZIndex = 2
	sliderThumb.Parent = sliderBg

	local thumbCorner = Instance.new("UICorner")
	thumbCorner.CornerRadius = UDim.new(1, 0)
	thumbCorner.Parent = sliderThumb

	local thumbStroke = Instance.new("UIStroke")
	thumbStroke.Color = C.accent
	thumbStroke.Thickness = 2
	thumbStroke.Parent = sliderThumb

	local isDraggingSlider = false

	sliderThumb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			isDraggingSlider = true
		end
	end)

	sliderThumb.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			isDraggingSlider = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if not isDraggingSlider then return end
		if input.UserInputType ~= Enum.UserInputType.Touch then return end
		if not sliderBg.AbsoluteSize.X or sliderBg.AbsoluteSize.X <= 0 then return end

		local pos = input.Position.X
		local barAbs = sliderBg.AbsolutePosition.X
		local barSize = sliderBg.AbsoluteSize.X
		local norm = math.clamp((pos - barAbs) / barSize, 0, 1)
		local val = math.floor(min + (max - min) * norm)

		sliderFill.Size = UDim2.new(val / max, 0, 1, 0)
		sliderThumb.Position = UDim2.new(val / max, -12, 0.5, -12)
		lbl.Text = label .. ": " .. val
		valLabel.Text = tostring(val)
		accentLine.BackgroundColor3 = C.accent

		if callback then callback(val) end
	end)

	return container
end

local function CreateButton(parent, label, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 42)
	btn.BackgroundColor3 = C.card
	btn.Text = label
	btn.TextColor3 = C.white
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Parent = parent

	local bc = Instance.new("UICorner")
	bc.CornerRadius = UDim.new(0, 8)
	bc.Parent = btn

	local accentLine = Instance.new("Frame")
	accentLine.Size = UDim2.new(0, 3, 1, -12)
	accentLine.Position = UDim2.new(0, 6, 0, 6)
	accentLine.BackgroundColor3 = C.darkGray
	accentLine.BorderSizePixel = 0
	accentLine.Parent = btn

	btn.MouseButton1Click:Connect(function()
		btn.BackgroundColor3 = C.cardHover
		accentLine.BackgroundColor3 = C.accent
		coroutine.wrap(function()
			coroutine.wait(0.15)
			btn.BackgroundColor3 = C.card
			accentLine.BackgroundColor3 = C.darkGray
		end)()
		callback()
	end)

	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			btn.BackgroundColor3 = C.cardHover
		end
	end)

	btn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			btn.BackgroundColor3 = C.card
		end
	end)

	return btn
end

local function cleanupFly()
	if flyBV then flyBV:Destroy() flyBV = nil end
	if flyBG then flyBG:Destroy() flyBG = nil end
	if humanoid then humanoid.PlatformStand = false end
end

CreateToggle(MurderPage, "Kill Aura", "Atira faca em jogadores proximos", function(on)
	toggleFlags["KillAura"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["KillAura"] do
				if character and humanoid and rootPart then
					for _, v in pairs(Players:GetPlayers()) do
						if v ~= player and v.Character then
							local head = v.Character:FindFirstChild("Head")
							local torso = v.Character:FindFirstChild("Torso") or v.Character:FindFirstChild("UpperTorso")
							if head and torso then
								local dist = (rootPart.Position - head.Position).Magnitude
								if dist < auraRange and humanoid.Health > 0 then
									local knife = character:FindFirstChild("Knife")
									if not knife then
										knife = character:FindFirstChildOfClass("Tool")
									end
									if knife and knife.Name == "Knife" then
										knife.Parent = character
									end
								end
							end
						end
					end
				end
				coroutine.wait(0.15)
			end
		end)()
	end
end)

CreateSlider(MurderPage, "Raio da Aura", 5, 30, 15, function(val)
	auraRange = val
end)

CreateToggle(MurderPage, "Expandir Hitbox", "Expande hitbox dos alvos", function(on)
	toggleFlags["Hitbox"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["Hitbox"] do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.Size = Vector3.new(4, 6, 4)
						end
					end
				end
				coroutine.wait(0.3)
			end
			for _, v in pairs(Players:GetPlayers()) do
				if v ~= player and v.Character then
					local hrp = v.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.Size = Vector3.new(2, 1, 1)
					end
				end
			end
		end)()
	end
end)

CreateToggle(MurderPage, "Teletransportar Gun", "Vai ate a arma dropada", function(on)
	toggleFlags["TeleGun"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["TeleGun"] do
				local gun = Workspace:FindFirstChild("GunDrop") or Workspace:FindFirstChild("Gun")
				if gun and rootPart then
					rootPart.CFrame = gun.CFrame * CFrame.new(0, 5, 0)
				end
				coroutine.wait(0.3)
			end
		end)()
	end
end)

CreateToggle(MurderPage, "Salto Infinito", "Pula sem limite", function(on)
	toggleFlags["InfJump"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["InfJump"] do
				UIS.JumpRequest:Wait()
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)()
	end
end)

CreateToggle(MurderPage, "Velocidade Turbo", "Corre mais rapido", function(on)
	if humanoid then
		humanoid.WalkSpeed = on and 50 or 16
	end
end)

CreateToggle(SheriffPage, "Mira Silenciosa", "Mira auto no assassino", function(on)
	toggleFlags["SilentAim"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["SilentAim"] do
				if character and rootPart then
					local targetHead = nil
					for _, v in pairs(Players:GetPlayers()) do
						if v ~= player and v.Character then
							for _, item in pairs(v.Backpack:GetChildren()) do
								if item.Name == "Knife" then
									targetHead = v.Character:FindFirstChild("Head")
									break
								end
							end
							if not targetHead then
								for _, item in pairs(v.Character:GetChildren()) do
									if item.Name == "Knife" then
										targetHead = v.Character:FindFirstChild("Head")
										break
									end
								end
							end
						end
						if targetHead then break end
					end
					if targetHead and rootPart then
						Camera.CFrame = CFrame.lookAt(rootPart.Position, Vector3.new(targetHead.Position.X, targetHead.Position.Y, targetHead.Position.Z))
					end
				end
				coroutine.wait(0.05)
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "Atirar Auto", "Dispara automaticamente no assassino", function(on)
	toggleFlags["AutoShoot"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["AutoShoot"] do
				if character and rootPart then
					for _, v in pairs(Players:GetPlayers()) do
						if v ~= player and v.Character then
							local hasKnife = false
							for _, item in pairs(v.Backpack:GetChildren()) do
								if item.Name == "Knife" then hasKnife = true; break end
							end
							for _, item in pairs(v.Character:GetChildren()) do
								if item.Name == "Knife" then hasKnife = true; break end
							end
							if hasKnife then
								local h = v.Character:FindFirstChild("Head")
								if h then
									local dist = (rootPart.Position - h.Position).Magnitude
									if dist < 30 then
										local hrp = character:FindFirstChild("HumanoidRootPart")
										if hrp then
											hrp.CFrame = h.CFrame * CFrame.new(0, 0, -5)
										end
									end
								end
							end
						end
					end
				end
				coroutine.wait(0.15)
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "ESP Gun Dropada", "Mostra onde a gun dropou", function(on)
	toggleFlags["ESPGun"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["ESPGun"] do
				for _, obj in pairs(Workspace:GetChildren()) do
					if obj.Name == "GunDrop" or (obj.Name == "Gun" and obj:IsA("BasePart")) then
						if not obj:FindFirstChild("MM2esp") then
							local bg = Instance.new("BillboardGui")
							bg.Name = "MM2esp"
							bg.Adornee = obj
							bg.Size = UDim2.new(0, 150, 0, 40)
							bg.StudsOffset = Vector3.new(0, 3, 0)
							bg.AlwaysOnTop = true
							bg.Parent = obj
							local txt = Instance.new("TextLabel")
							txt.Size = UDim2.new(1, 0, 1, 0)
							txt.BackgroundTransparency = 1
							txt.Text = "[GUN] Dropada"
							txt.TextColor3 = C.accent
							txt.Font = Enum.Font.Code
							txt.TextScaled = true
							txt.Parent = bg
						end
					end
				end
				coroutine.wait(0.4)
			end
			for _, obj in pairs(Workspace:GetChildren()) do
				if obj:FindFirstChild("MM2esp") then
					obj.MM2esp:Destroy()
				end
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "ESP Jogadores", "Mostra nome e distancia", function(on)
	toggleFlags["ESPPlayers"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["ESPPlayers"] do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
						local head = v.Character.Head
						if head:FindFirstChild("MM2name") then head.MM2name:Destroy() end
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						local dist = 0
						if hrp and rootPart then
							dist = math.floor((rootPart.Position - head.Position).Magnitude)
						end
						local bg = Instance.new("BillboardGui")
						bg.Name = "MM2name"
						bg.Adornee = head
						bg.Size = UDim2.new(0, 140, 0, 30)
						bg.StudsOffset = Vector3.new(0, 2.8, 0)
						bg.AlwaysOnTop = true
						bg.Parent = head
						local txt = Instance.new("TextLabel")
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.Text = v.Name .. " [" .. dist .. "m]"
						txt.TextColor3 = C.white
						txt.Font = Enum.Font.Code
						txt.TextScaled = true
						txt.Parent = bg
					end
				end
				coroutine.wait(1)
			end
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("Head") then
					local head = v.Character.Head
					if head:FindFirstChild("MM2name") then head.MM2name:Destroy() end
				end
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "ESP de Papel", "Assassino/Xerife/Inocente", function(on)
	toggleFlags["ESPRole"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["ESPRole"] do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
						local head = v.Character.Head
						if head:FindFirstChild("MM2role") then head.MM2role:Destroy() end
						local role = "Inocente"
						local color = C.green
						for _, item in pairs(v.Backpack:GetChildren()) do
							if item.Name == "Knife" then role = "ASSASSINO"; color = C.red; break end
							if item.Name == "Revolver" or item.Name == "Gun" then role = "XERIFE"; color = C.accent; break end
						end
						for _, item in pairs(v.Character:GetChildren()) do
							if item.Name == "Knife" then role = "ASSASSINO"; color = C.red; break end
							if item.Name == "Revolver" or item.Name == "Gun" then role = "XERIFE"; color = C.accent; break end
						end
						local bg = Instance.new("BillboardGui")
						bg.Name = "MM2role"
						bg.Adornee = head
						bg.Size = UDim2.new(0, 160, 0, 35)
						bg.StudsOffset = Vector3.new(0, 3.5, 0)
						bg.AlwaysOnTop = true
						bg.Parent = head
						local txt = Instance.new("TextLabel")
						txt.Size = UDim2.new(1, 0, 1, 0)
						txt.BackgroundTransparency = 1
						txt.Text = role .. " | " .. v.Name
						txt.TextColor3 = color
						txt.Font = Enum.Font.Code
						txt.TextScaled = true
						txt.Parent = bg
					end
				end
				coroutine.wait(0.8)
			end
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("Head") then
					local head = v.Character.Head
					if head:FindFirstChild("MM2role") then head.MM2role:Destroy() end
				end
			end
		end)()
	end
end)

CreateToggle(EspPage, "Chams", "Colore os corpos dos inimigos", function(on)
	toggleFlags["Chams"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["Chams"] do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						for _, part in pairs(v.Character:GetChildren()) do
							if part:IsA("BasePart") then
								if not part:FindFirstChild("MM2cham") then
									local h = Instance.new("Highlight")
									h.Name = "MM2cham"
									h.FillColor = C.accent
									h.FillTransparency = 0.6
									h.OutlineColor = C.white
									h.OutlineTransparency = 0.3
									h.Parent = part
								end
							end
						end
					end
				end
				coroutine.wait(0.5)
			end
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character then
					for _, part in pairs(v.Character:GetChildren()) do
						if part:IsA("BasePart") and part:FindFirstChild("MM2cham") then
							part.MM2cham:Destroy()
						end
					end
				end
			end
		end)()
	end
end)

CreateToggle(EspPage, "Raio X", "Ver atraves de paredes", function(on)
	toggleFlags["Xray"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["Xray"] do
				for _, obj in pairs(Workspace:GetDescendants()) do
					if obj:IsA("BasePart") and obj.Transparency < 0.8 then
						if not obj:FindFirstChild("MM2xray") then
							local ns = Instance.new("BoolValue")
							ns.Name = "MM2xray"
							ns.Parent = obj
						end
						obj.LocalTransparencyModifier = 0.7
					end
				end
				coroutine.wait(0.3)
			end
			for _, obj in pairs(Workspace:GetDescendants()) do
				if obj:IsA("BasePart") and obj:FindFirstChild("MM2xray") then
					obj.MM2xray:Destroy()
					obj.LocalTransparencyModifier = 0
				end
			end
		end)()
	end
end)

CreateToggle(EspPage, "Luz Total", "Iluminacao maxima no mapa", function(on)
	if on then
		Lighting.Brightness = 2
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.ClockTime = 14
	else
		Lighting.Brightness = 1
		Lighting.Ambient = Color3.fromRGB(123, 123, 123)
		Lighting.OutdoorAmbient = Color3.fromRGB(123, 123, 123)
	end
end)

CreateToggle(MovePage, "Voo", "Voa livremente", function(on)
	toggleFlags["Fly"] = on
	if on then
		humanoid.PlatformStand = true
		coroutine.wrap(function()
			while toggleFlags["Fly"] do
				if humanoid and rootPart then
					humanoid.PlatformStand = true
					if flyBV == nil or not flyBV.Parent then
						flyBV = Instance.new("BodyVelocity")
						flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
						flyBV.Velocity = Vector3.new(0, 5, 0)
						flyBV.Parent = rootPart
					end
					if flyBG == nil or not flyBG.Parent then
						flyBG = Instance.new("BodyGyro")
						flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
						flyBG.P = 9e4
						flyBG.Parent = rootPart
					end
					local moveDir = Vector3.new(0, 0.5, 0)
					if moveDir.Magnitude > 0 then
						moveDir = moveDir.Unit * flySpeed
					end
					flyBV.Velocity = moveDir
					if Camera then
						flyBG.CFrame = Camera.CFrame
					end
				end
				coroutine.wait(0.01)
			end
			cleanupFly()
		end)()
	else
		cleanupFly()
	end
end)

CreateToggle(MovePage, "Sem Colisao", "Atravessa paredes", function(on)
	toggleFlags["NoClip"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["NoClip"] do
				if character then
					for _, part in pairs(character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
				coroutine.wait(0.05)
			end
			if character then
				for _, part in pairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = true
					end
				end
			end
		end)()
	end
end)

CreateToggle(MovePage, "Velocidade Turbo", "Corre 3x mais rapido", function(on)
	if humanoid then
		humanoid.WalkSpeed = on and 50 or 16
	end
end)

CreateToggle(MovePage, "Salto Turbo", "Pula 3x mais alto", function(on)
	if humanoid then
		humanoid.JumpPower = on and 150 or 50
		humanoid.JumpHeight = on and 200 or 72
	end
end)

CreateToggle(MovePage, "Voo Anti-Gravidade", "Voo suave", function(on)
	toggleFlags["AntiGrav"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["AntiGrav"] and rootPart do
				rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
				coroutine.wait(0.016)
			end
		end)()
	end
end)

CreateToggle(FarmPage, "Farm Moedas", "Atrai moedas e gems", function(on)
	toggleFlags["FarmCoins"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["FarmCoins"] do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gem")) then
							obj.CFrame = rootPart.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
						end
					end
				end
				coroutine.wait(0.08)
			end
		end)()
	end
end)

CreateToggle(FarmPage, "Farm XP", "Coleta XP automaticamente", function(on)
	toggleFlags["FarmXP"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["FarmXP"] do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("xp") or obj.Name:lower():find("exp")) then
							obj.CFrame = rootPart.CFrame
						end
					end
				end
				coroutine.wait(0.1)
			end
		end)()
	end
end)

CreateToggle(FarmPage, "Mystery Box Auto", "Abre mystery boxes auto", function(on)
	toggleFlags["MysteryBox"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["MysteryBox"] do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("mystery") or obj.Name:lower():find("box")) then
							rootPart.CFrame = obj.CFrame * CFrame.new(0, 0, -3)
							coroutine.wait(0.5)
						end
					end
				end
				coroutine.wait(0.5)
			end
		end)()
	end
end)

CreateToggle(FarmPage, "Anti AFK", "Nao ser kickado por inatividade", function(on)
	toggleFlags["AntiAFK"] = on
	if on then
		local ok2, vu = pcall(function() return game:GetService("VirtualUser") end)
		if ok2 and vu then
			coroutine.wrap(function()
				while toggleFlags["AntiAFK"] do
					pcall(function()
						vu:Button2Down(Vector2.new(0, 0), Camera.CFrame)
						vu:Button2Up(Vector2.new(0, 0), Camera.CFrame)
					end)
					coroutine.wait(300)
				end
			end)()
		end
	end
end)

CreateToggle(SettingsPage, "Modo Deus", "Imune a todas as mortes", function(on)
	toggleFlags["GodMode"] = on
	if on then
		coroutine.wrap(function()
			while toggleFlags["GodMode"] and humanoid do
				humanoid.Health = humanoid.MaxHealth
				coroutine.wait(0.3)
			end
		end)()
	end
end)

CreateSlider(SettingsPage, "Velocidade do Voo", 10, 150, 50, function(val)
	flySpeed = val
end)

CreateSlider(SettingsPage, "Raio da Aura", 5, 30, 15, function(val)
	auraRange = val
end)

CreateSlider(SettingsPage, "Multiplicador Velocidade", 1, 5, 2, function(val)
	speedMult = val
	if humanoid then humanoid.WalkSpeed = 16 * val end
end)

CreateSlider(SettingsPage, "Multiplicador Salto", 1, 5, 3, function(val)
	jumpMult = val
	if humanoid then
		humanoid.JumpPower = 50 * val
		humanoid.JumpHeight = 72 * val
	end
end)

CreateButton(SettingsPage, "Reiniciar Personagem", function()
	if humanoid then humanoid.Health = 0 end
end)

CreateButton(SettingsPage, "Atualizar Interface", function()
	ScreenGui:Destroy()
end)

CreateButton(MovePage, "Joystick Virtual para Voo", function()
	local JoyBase = Instance.new("Frame")
	JoyBase.Name = "VirtualJoy"
	JoyBase.Size = UDim2.new(0, 120, 0, 120)
	JoyBase.Position = UDim2.new(0, 20, 1, -150)
	JoyBase.BackgroundTransparency = 0.5
	JoyBase.BackgroundColor3 = C.bg
	JoyBase.BorderSizePixel = 0
	JoyBase.Visible = true
	JoyBase.Parent = ScreenGui

	local JoyCorner = Instance.new("UICorner")
	JoyCorner.CornerRadius = UDim.new(1, 0)
	JoyCorner.Parent = JoyBase

	local JoyStroke = Instance.new("UIStroke")
	JoyStroke.Color = C.accent
	JoyStroke.Thickness = 1.5
	JoyStroke.Transparency = 0.3
	JoyStroke.Parent = JoyBase

	local JoyKnob = Instance.new("TextButton")
	JoyKnob.Size = UDim2.new(0, 40, 0, 40)
	JoyKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
	JoyKnob.BackgroundColor3 = C.accent
	JoyKnob.Text = ""
	JoyKnob.BorderSizePixel = 0
	JoyKnob.Parent = JoyBase

	local JoyKnobCorner = Instance.new("UICorner")
	JoyKnobCorner.CornerRadius = UDim.new(1, 0)
	JoyKnobCorner.Parent = JoyKnob

	local joyDragging = false
	JoyBase.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			joyDragging = true
		end
	end)
	JoyBase.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			joyDragging = false
			JoyKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
		end
	end)
	JoyBase.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and joyDragging then
			local delta = input.Position - (JoyBase.AbsolutePosition + Vector2.new(60, 60))
			local dist = math.min(delta.Magnitude, 40)
			local angle = math.atan2(delta.Y, delta.X)
			JoyKnob.Position = UDim2.new(0.5, math.cos(angle) * dist - 20, 0.5, math.sin(angle) * dist - 20)
			if flyBV and toggleFlags["Fly"] then
				local moveDir = Vector3.new(math.cos(angle) * dist / 40, 0.5, math.sin(angle) * dist / 40)
				flyBV.Velocity = moveDir.Unit * flySpeed
				if Camera and flyBG then
					flyBG.CFrame = Camera.CFrame
				end
			end
		end
	end)
end)

RunService.Heartbeat:Connect(function()
	if humanoid and rootPart then
		if toggleFlags["GodMode"] then
			humanoid.Health = humanoid.MaxHealth
		end
	end
end)

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	rootPart = newChar:WaitForChild("HumanoidRootPart")
	Camera = Workspace.CurrentCamera
	cleanupFly()
	for key, _ in pairs(toggleFlags) do
		toggleFlags[key] = false
	end
	coroutine.wait(0.2)
	if toggleFlags["GodMode"] and humanoid then
		humanoid.Health = humanoid.MaxHealth
	end
end)

print("mm2 zxx.hub carregado com sucesso!")

end)

if not ok then
	print("mm2 zxx.hub erro: " .. tostring(err))
end
