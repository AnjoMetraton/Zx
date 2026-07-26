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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2ZXXHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 440)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 140, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local dragStart = nil
local dragPos = nil
local isDragging = false

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
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.15, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "mm2 zxx.hub"
Title.TextColor3 = Color3.fromRGB(180, 180, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextScaled = true
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 44, 0, 44)
CloseBtn.Position = UDim2.new(1, -48, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
CloseBtn.TextScaled = true
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 44, 0, 44)
MinBtn.Position = UDim2.new(1, -100, 0, 3)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 180, 50)
MinBtn.Text = "minus"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.TextScaled = true
MinBtn.BorderSizePixel = 0
MinBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinBtn

local isMinimized = false
local FloatingBtn = nil

local function minimizeHub()
	isMinimized = true
	MainFrame.Size = UDim2.new(0, 50, 0, 36)
	MainFrame.Position = UDim2.new(0, 8, 1, -46)
	Header.Visible = false
	TabBar.Visible = false
	ContentContainer.Visible = false

	FloatingBtn = Instance.new("TextButton")
	FloatingBtn.Name = "FloatingBtn"
	FloatingBtn.Size = UDim2.new(0, 80, 0, 44)
	FloatingBtn.Position = UDim2.new(0, 8, 1, -50)
	FloatingBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 220)
	FloatingBtn.Text = "mm2 zxx.hub"
	FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	FloatingBtn.Font = Enum.Font.GothamBold
	FloatingBtn.TextSize = 11
	FloatingBtn.TextScaled = true
	FloatingBtn.BorderSizePixel = 0
	FloatingBtn.Parent = ScreenGui

	local fbCorner = Instance.new("UICorner")
	fbCorner.CornerRadius = UDim.new(0, 8)
	fbCorner.Parent = FloatingBtn

	local fbStroke = Instance.new("UIStroke")
	fbStroke.Color = Color3.fromRGB(100, 160, 255)
	fbStroke.Thickness = 1.5
	fbStroke.Parent = FloatingBtn

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
		MainFrame.Size = UDim2.new(0, 350, 0, 440)
		MainFrame.Position = UDim2.new(0.5, -175, 0.5, -220)
		Header.Visible = true
		TabBar.Visible = true
		ContentContainer.Visible = true
		if FloatingBtn and FloatingBtn.Parent then
			FloatingBtn:Destroy()
		end
		FloatingBtn = nil
	end)
end

MinBtn.MouseButton1Click:Connect(minimizeHub)

local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -10, 0, 55)
TabBar.Position = UDim2.new(0.05, 0, 0, 55)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
TabBar.BorderSizePixel = 0
TabBar.ScrollBarThickness = 4
TabBar.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
TabBar.HorizontalScrollBarThickness = 6
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.ScrollBarThickness = 3
TabBar.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = TabBar

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -10, 1, -120)
ContentContainer.Position = UDim2.new(0.05, 0, 0, 115)
ContentContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
ContentContainer.BorderSizePixel = 0
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = MainFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.Parent = ContentContainer

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
end

local function CreateTab(name, icon, color)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 120, 0, 45)
	btn.MinimumSize = Vector2.new(120, 45)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
	btn.Text = icon .. " " .. name
	btn.TextColor3 = Color3.fromRGB(200, 200, 220)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 14
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.Parent = TabBar

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = btn

	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = (CurrentTab == nil)
	page.Parent = ContentScroll

	local pLayout = Instance.new("UIListLayout")
	pLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pLayout.Padding = UDim.new(0, 5)
	pLayout.Parent = page

	TabPages[name] = {Name = name, Page = page, Btn = btn}

	btn.MouseButton1Click:Connect(function()
		SwitchTab(name)
		for _, t in pairs(TabBtns) do
			t.Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
		end
		btn.BackgroundColor3 = Color3.fromRGB(color or 60, 60, 100)
	end)

	table.insert(TabBtns, btn)
	return page
end

local MurderPage = CreateTab("Assassino", "Faca", {60, 50, 120})
local SheriffPage = CreateTab("Xerife", "Gun", {50, 120, 80})
local MovePage = CreateTab("Movimento", "Rocket", {50, 150, 50})
local EspPage = CreateTab("Visao", "Eye", {100, 100, 200})
local FarmPage = CreateTab("Farm", "Coin", {200, 180, 50})
local SettingsPage = CreateTab("Config", "Gear", {150, 150, 150})

TabBtns[1].BackgroundColor3 = Color3.fromRGB(80, 50, 120)
CurrentTab = "Assassino"

local function CreateToggle(parent, label, description, onToggle)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 64)
	container.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
	container.BorderSizePixel = 0
	container.Parent = parent

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = container

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 44)
	btn.Position = UDim2.new(0.05, 0, 0, 6)
	btn.AutoButtonColor = true
	btn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
	btn.Text = "[OFF] " .. label
	btn.TextColor3 = Color3.fromRGB(255, 150, 150)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.Parent = container

	local bc = Instance.new("UICorner")
	bc.CornerRadius = UDim.new(0, 6)
	bc.Parent = btn

	local stateOn = false

	btn.MouseButton1Click:Connect(function()
		stateOn = not stateOn
		if stateOn then
			btn.Text = "[ON] " .. label
			btn.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
			btn.TextColor3 = Color3.fromRGB(150, 255, 150)
		else
			btn.Text = "[OFF] " .. label
			btn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
			btn.TextColor3 = Color3.fromRGB(255, 150, 150)
		end
		if onToggle then onToggle(stateOn) end
	end)

	local descLabel = Instance.new("TextLabel")
	descLabel.Size = UDim2.new(0.9, 0, 0, 16)
	descLabel.Position = UDim2.new(0.05, 0, 0, 52)
	descLabel.BackgroundTransparency = 1
	descLabel.Text = description
	descLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
	descLabel.Font = Enum.Font.Gotham
	descLabel.TextSize = 11
	descLabel.TextScaled = true
	descLabel.TextXAlignment = Enum.TextXAlignment.Left
	descLabel.Parent = container

	return btn, function() return stateOn end
end

local function CreateSlider(parent, label, min, max, default, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 64)
	container.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
	container.BorderSizePixel = 0
	container.Parent = parent

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = container

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -12, 0, 22)
	lbl.Position = UDim2.new(0.05, 0, 0, 4)
	lbl.BackgroundTransparency = 1
	lbl.Text = label .. ": " .. default
	lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 13
	lbl.TextScaled = true
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = container

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(0.9, 0, 0, 20)
	sliderBg.Position = UDim2.new(0.05, 0, 0, 30)
	sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new(default / max, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg

	local sliderThumb = Instance.new("TextButton")
	sliderThumb.Size = UDim2.new(0, 36, 1, 0)
	sliderThumb.Position = UDim2.new(default / max, -18, 0, 0)
	sliderThumb.BackgroundColor3 = Color3.fromRGB(120, 150, 255)
	sliderThumb.Text = ""
	sliderThumb.TextSize = 18
	sliderThumb.TextColor3 = Color3.fromRGB(255, 255, 255)
	sliderThumb.Font = Enum.Font.GothamBold
	sliderThumb.BorderSizePixel = 0
	sliderThumb.Parent = sliderBg

	local thumbCorner = Instance.new("UICorner")
	thumbCorner.CornerRadius = UDim.new(1, 0)
	thumbCorner.Parent = sliderThumb

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
		sliderThumb.Position = UDim2.new(val / max, -18, 0, 0)
		lbl.Text = label .. ": " .. val

		if callback then callback(val) end
	end)

	return container
end

local function CreateButton(parent, label, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 44)
	btn.Position = UDim2.new(0.05, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
	btn.Text = label
	btn.TextColor3 = Color3.fromRGB(200, 200, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.Parent = parent

	local b = Instance.new("UICorner")
	b.CornerRadius = UDim.new(0, 8)
	b.Parent = btn

	btn.MouseButton1Click:Connect(callback)
	return btn
end

local auraRange = 15
local flySpeed = 50
local speedMult = 2
local jumpMult = 3

CreateToggle(MurderPage, "Kill Aura - Faca", "Atira faca em jogadores proximos", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character and humanoid and rootPart then
					for _, v in pairs(Players:GetPlayers()) do
						if v ~= player and v.Character then
							local head = v.Character:FindFirstChild("Head")
							local torso = v.Character:FindFirstChild("Torso") or v.Character:FindFirstChild("UpperTorso")
							if head and torso then
								local dist = (rootPart.Position - head.Position).Magnitude
								if dist < auraRange then
									if humanoid.Health > 0 then
										local knife = character:FindFirstChild("Knife")
										if not knife and character:FindFirstChild("Backpack") then
											knife = character.Backpack:FindFirstChild("Knife")
										end
										if knife then
											knife.Parent = character
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

CreateSlider(MurderPage, "Raio da Aura", 5, 30, 15, function(val)
	auraRange = val
end)

CreateToggle(MurderPage, "Expandir Hitbox", "Expande hitbox dos alvos", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						if hrp then
							hrp.Size = on and Vector3.new(4, 6, 4) or Vector3.new(2, 6, 2)
						end
					end
				end
				coroutine.wait(0.3)
			end
		end)()
	end
end)

CreateToggle(MurderPage, "Teletransportar para Gun", "Vai ate a arma dropada", function(on)
	if on then
		coroutine.wrap(function()
			while on do
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
	if on then
		UIS.JumpRequest:Connect(function()
			if on then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end
end)

CreateToggle(MurderPage, "Pegar Gun Auto", "Pega a arma quando cai", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetChildren()) do
						if obj.Name == "GunDrop" or (obj.Name == "Gun" and obj:IsA("BasePart")) then
							obj.CFrame = rootPart.CFrame * CFrame.new(0, -3, 0)
						end
					end
				end
				coroutine.wait(0.1)
			end
		end)()
	end
end)

CreateToggle(MurderPage, "Velocidade Turbo (Assassino)", "Corre 3x mais rapido", function(on)
	if humanoid then
		humanoid.WalkSpeed = on and 50 or 16
	end
end)

CreateToggle(SheriffPage, "Mira Silenciosa - Atirar no Assassin", "Mira auto no murderer como xerife", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character then
					local targetHead = nil
					for _, v in pairs(Players:GetPlayers()) do
						if v ~= player and v.Character then
							for _, item in pairs(v.Backpack:GetChildren()) do
								if item.Name == "Knife" then targetHead = v.Character:FindFirstChild("Head"); break end
							end
							if not targetHead then
								for _, item in pairs(v.Character:GetChildren()) do
									if item.Name == "Knife" then targetHead = v.Character:FindFirstChild("Head"); break end
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

CreateToggle(SheriffPage, "Atirar Auto no Assassin", "Dispara automaticamente no murderer", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character then
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

CreateToggle(SheriffPage, "ESP de Gun Dropada", "Mostra onde a gun dropou", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, obj in pairs(Workspace:GetChildren()) do
					if obj.Name == "GunDrop" or (obj.Name == "Gun" and obj:IsA("BasePart")) then
						if obj:FindFirstChild("MM2esp") == nil then
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
							txt.TextColor3 = Color3.fromRGB(255, 220, 0)
							txt.Font = Enum.Font.GothamBold
							txt.TextScaled = true
							txt.Parent = bg
						end
					end
				end
				coroutine.wait(0.4)
			end
			for _, obj in pairs(Workspace:GetChildren()) do
				if obj.Name == "GunDrop" or (obj.Name == "Gun" and obj:IsA("BasePart")) then
					if obj:FindFirstChild("MM2esp") then obj.MM2esp:Destroy() end
				end
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "ESP de Gun dos Jogadores", "Mostra quem tem arma equipada", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						if hrp and hrp:FindFirstChild("MM2gun") == nil then
							local bg = Instance.new("BillboardGui")
							bg.Name = "MM2gun"
							bg.Adornee = hrp
							bg.Size = UDim2.new(0, 100, 0, 30)
							bg.StudsOffset = Vector3.new(0, 3, 0)
							bg.AlwaysOnTop = true
							bg.Parent = hrp
							local txt = Instance.new("TextLabel")
							txt.Size = UDim2.new(1, 0, 1, 0)
							txt.BackgroundTransparency = 1
							txt.Text = "[GUN]"
							txt.TextColor3 = Color3.fromRGB(255, 200, 0)
							txt.Font = Enum.Font.GothamBold
							txt.TextScaled = true
							txt.Parent = bg
						end
					end
				end
				coroutine.wait(0.8)
			end
		end)()
	end
end)

CreateToggle(SheriffPage, "Rastreadores", "Linhas ate os inimigos", function(on) end)

CreateToggle(MovePage, "Voo", "Voa livremente", function(on)
	if on then
		humanoid.PlatformStand = true
		coroutine.wrap(function()
			while on do
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
					flyBG.CFrame = camCF
				end
				coroutine.wait(0.01)
			end
			if flyBV then flyBV:Destroy() flyBV = nil end
			if flyBG then flyBG:Destroy() flyBG = nil end
			if humanoid then humanoid.PlatformStand = false end
		end)()
	else
		if humanoid then humanoid.PlatformStand = false end
		if flyBV then flyBV:Destroy() flyBV = nil end
		if flyBG then flyBG:Destroy() flyBG = nil end
	end
end)

CreateToggle(MovePage, "Sem Colisao", "Atravessa paredes", function(on)
	if on then
		coroutine.wrap(function()
			while on do
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

CreateToggle(MovePage, "Caminho Fase", "Atravessa superficies", function(on) end)

CreateToggle(MovePage, "Voo Anti-Gravidade", "Voo suave sem subir infinito", function(on)
	if on then
		coroutine.wrap(function()
			while on and rootPart do
				rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
				coroutine.wait(0.016)
			end
		end)()
	end
end)

CreateToggle(EspPage, "ESP de Papel (Assassin/Xerife/Inocente)", "Mostra papel de cada jogador", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
						local head = v.Character.Head
						if head:FindFirstChild("MM2role") then head.MM2role:Destroy() end
						local role = "Inocente"
						local color = Color3.fromRGB(0, 255, 0)
						for _, item in pairs(v.Backpack:GetChildren()) do
							if item.Name == "Knife" then role = "Assassin"; color = Color3.fromRGB(255, 0, 0); break end
							if item.Name == "Revolver" or item.Name == "Gun" then role = "Xerife"; color = Color3.fromRGB(0, 0, 255); break end
						end
						for _, item in pairs(v.Character:GetChildren()) do
							if item.Name == "Knife" then role = "Assassin"; color = Color3.fromRGB(255, 0, 0); break end
							if item.Name == "Revolver" or item.Name == "Gun" then role = "Xerife"; color = Color3.fromRGB(0, 0, 255); break end
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
						txt.Text = role .. ": " .. v.Name
						txt.TextColor3 = color
						txt.Font = Enum.Font.GothamBold
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

CreateToggle(EspPage, "ESP de Jogadores (Nome + Distancia)", "Mostra nome e distancia", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
						local head = v.Character.Head
						if head:FindFirstChild("MM2name") then head.MM2name:Destroy() end
						local dist = math.floor((rootPart.Position - head.Position).Magnitude)
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
						txt.TextColor3 = Color3.fromRGB(100, 200, 255)
						txt.Font = Enum.Font.GothamSemibold
						txt.TextScaled = true
						txt.Parent = bg
					end
				end
				coroutine.wait(1)
			end
		end)()
	end
end)

CreateToggle(EspPage, "Chams (Destaque Colorido)", "Colore os corpos dos inimigos", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, v in pairs(Players:GetPlayers()) do
					if v ~= player and v.Character then
						for _, part in pairs(v.Character:GetChildren()) do
							if part:IsA("BasePart") then
								if on and part:FindFirstChild("MM2cham") == nil then
									local h = Instance.new("Highlight")
									h.Name = "MM2cham"
									h.FillColor = Color3.fromRGB(255, 0, 0)
									h.FillTransparency = 0.5
									h.OutlineColor = Color3.fromRGB(255, 0, 0)
									h.OutlineTransparency = 0
									h.Parent = part
								elseif not on and part:FindFirstChild("MM2cham") then
									part.MM2cham:Destroy()
								end
							end
						end
					end
				end
				coroutine.wait(0.5)
			end
		end)()
	end
end)

CreateToggle(EspPage, "Raio X (Ver Paredes)", "Torna paredes semi-transparentes", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				for _, obj in pairs(Workspace:GetDescendants()) do
					if obj:IsA("BasePart") and obj.Transparency < 1 then
						if not obj:FindFirstChild("MM2xray") then
							local ns = obj:Clone()
							ns.Name = "MM2xray"
							ns.Transparency = 0.7
							ns.Parent = obj
						end
						obj.Transparency = 0.7
					end
				end
				coroutine.wait(0.3)
			end
			for _, obj in pairs(Workspace:GetDescendants()) do
				if obj:IsA("BasePart") and obj:FindFirstChild("MM2xray") then
					obj:FindFirstChild("MM2xray"):Destroy()
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

CreateToggle(FarmPage, "Farm Auto de Moedas", "Atrai moedas e gems", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gem") or obj.Name:lower():find("cash") or obj.Name:lower():find("money")) then
							obj.CFrame = rootPart.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
						end
					end
				end
				coroutine.wait(0.08)
			end
		end)()
	end
end)

CreateToggle(FarmPage, "Farm Auto de XP", "Coleta XP automaticamente", function(on)
	if on then
		coroutine.wrap(function()
			while on do
				if character and rootPart then
					for _, obj in pairs(Workspace:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("xp") or obj.Name:lower():find("exp") or obj.Name:lower():find("experience")) then
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
	if on then
		coroutine.wrap(function()
			while on do
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
	if on then
		local ok, vu = pcall(function() return game:GetService("VirtualUser") end)
		if ok and vu then
			vu:Button2Down(Vector2.new(0, 0), Camera.CFrame)
			coroutine.wrap(function()
				while on do
					vu:Move(Vector2.new(math.random(0, UIS.ViewportSize.X), math.random(0, UIS.ViewportSize.Y)), true)
					coroutine.wait(300)
				end
			end)()
		end
	end
end)

CreateToggle(SettingsPage, "Modo Deus", "Imune a todas as mortes", function(on)
	if on then
		coroutine.wrap(function()
			while on and humanoid do
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

CreateSlider(SettingsPage, "Multiplicador de Velocidade", 1, 5, 2, function(val)
	speedMult = val
	if humanoid then humanoid.WalkSpeed = 16 * val end
end)

CreateSlider(SettingsPage, "Multiplicador de Salto", 1, 5, 3, function(val)
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
	JoyBase.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	JoyBase.BackgroundTransparency = 0.7
	JoyBase.BorderSizePixel = 0
	JoyBase.Visible = true
	JoyBase.Parent = ScreenGui

	local JoyCorner = Instance.new("UICorner")
	JoyCorner.CornerRadius = UDim.new(1, 0)
	JoyCorner.Parent = JoyBase

	local JoyKnob = Instance.new("TextButton")
	JoyKnob.Size = UDim2.new(0, 40, 0, 40)
	JoyKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
	JoyKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
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
		end
	end)
end)

RunService.Heartbeat:Connect(function()
	if humanoid and rootPart then
		if States and States.GodMode then
			humanoid.Health = humanoid.MaxHealth
		end
	end
end)

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	rootPart = newChar:WaitForChild("HumanoidRootPart")
	if flyBV then flyBV:Destroy() flyBV = nil end
	if flyBG then flyBG:Destroy() flyBG = nil end
	if States and States.GodMode then
		coroutine.wait(0.2)
		if humanoid then humanoid.Health = humanoid.MaxHealth end
	end
end)

print("mm2 zxx.hub carregado com sucesso!")
end)

if not ok then
	print("mm2 zxx.hub erro: " .. tostring(err))
endend
