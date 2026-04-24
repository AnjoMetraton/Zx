local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

repeat task.wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZxMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function RGB(t)
	return Color3.fromRGB(
		math.floor(math.sin(t * 1.8) * 127 + 128),
		math.floor(math.sin(t * 1.8 + 2.094) * 127 + 128),
		math.floor(math.sin(t * 1.8 + 4.189) * 127 + 128)
	)
end

local function New(class, props)
	local obj = Instance.new(class)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	return obj
end

local function Tween(obj, props, dur)
	TweenService:Create(obj, TweenInfo.new(dur or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local LoadFrame = New("Frame", {
	Size = UDim2.new(0, 360, 0, 200),
	Position = UDim2.new(0.5, -180, 0.5, -100),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BorderSizePixel = 0,
	Parent = ScreenGui
})
New("UICorner", {CornerRadius = UDim.new(0, 14), Parent = LoadFrame})
local LoadStroke = New("UIStroke", {Color = RGB(0), Thickness = 2.5, Transparency = 0.3, Parent = LoadFrame})
New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 40),
	BackgroundTransparency = 1,
	Text = "Zx v2026",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 24,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = LoadFrame
})
local LoadDesc = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 22),
	Position = UDim2.new(0, 0, 0, 45),
	BackgroundTransparency = 1,
	Text = "Carregando.",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(180, 180, 180),
	TextSize = 15,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = LoadFrame
})
local LoadBar = New("Frame", {
	Size = UDim2.new(0, 0, 0, 8),
	Position = UDim2.new(0.5, -160, 0.5, 80),
	BackgroundColor3 = RGB(1),
	BorderSizePixel = 0,
	Parent = LoadFrame
})
New("UICorner", {CornerRadius = UDim.new(0, 4), Parent = LoadBar})
local LoadPercent = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 25),
	Position = UDim2.new(0, 0, 0, 100),
	BackgroundTransparency = 1,
	Text = "0%",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(180, 180, 180),
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = LoadFrame
})

local NotifHolder = New("Frame", {
	Size = UDim2.new(0, 260, 0, 300),
	Position = UDim2.new(0.5, -130, 0.82, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Parent = ScreenGui
})
local NotifList = {}

local function Notify(txt)
	local n = New("Frame", {
		Size = UDim2.new(1, 0, 0, 38),
		Position = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(14, 14, 14),
		BorderSizePixel = 0,
		Parent = NotifHolder
	})
	New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = n})
	New("UIStroke", {Color = RGB(0), Thickness = 1.5, Parent = n})
	New("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = txt,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = n
	})
	Tween(n, {Position = UDim2.new(0, 0, 1 - (#NotifList + 1) * 0.17, 0)}, 0.3)
	table.insert(NotifList, n)
	task.delay(2.8, function()
		Tween(n, {Position = UDim2.new(0, 0, 1.5, 0), BackgroundTransparency = 1}, 0.25)
		task.wait(0.25)
		n:Destroy()
		table.remove(NotifList, 1)
	end)
end

local Panel = New("Frame", {
	Name = "Main",
	Size = UDim2.new(0, 290, 0, 470),
	Position = UDim2.new(0.5, -145, 0.5, 1000),
	BackgroundColor3 = Color3.fromRGB(8, 8, 8),
	BorderSizePixel = 0,
	Parent = ScreenGui,
	Visible = false
})
New("UICorner", {CornerRadius = UDim.new(0, 14), Parent = Panel})
local PanelStroke = New("UIStroke", {Color = RGB(0), Thickness = 2.5, Transparency = 0.2, Parent = Panel})

local TopBar = New("Frame", {
	Size = UDim2.new(1, 0, 0, 52),
	BackgroundColor3 = Color3.fromRGB(12, 12, 12),
	Parent = Panel
})
New("UICorner", {CornerRadius = UDim.new(0, 14), Parent = TopBar})
New("TextLabel", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "Zx MENU",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = TopBar
})
New("Frame", {
	Size = UDim2.new(1, 0, 0, 2),
	Position = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = RGB(1),
	BorderSizePixel = 0,
	Parent = TopBar
})

local function MakeButton(txt, yPos, active)
	local btn = New("TextButton", {
		Size = UDim2.new(0.86, 0, 0, 42),
		Position = UDim2.new(0.07, 0, yPos, 0),
		BackgroundColor3 = active and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(20, 20, 20),
		BorderSizePixel = 0,
		Text = txt,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = Panel,
		Active = true
	})
	New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = btn})
	New("UIStroke", {
		Color = active and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45),
		Thickness = 1.5,
		Parent = btn
	})
	return btn
end

local BtnAim = MakeButton("Mira: OFF", 0.12, false)
local BtnCircle = MakeButton("RGB Círculo: OFF", 0.24, false)
local BtnESP = MakeButton("ESP: OFF", 0.36, false)
local BtnRGBESP = MakeButton("RGB ESP: OFF", 0.48, false)

local SliderFrame = New("Frame", {
	Size = UDim2.new(0.86, 0, 0, 46),
	Position = UDim2.new(0.07, 0, 0.60, 0),
	BackgroundColor3 = Color3.fromRGB(16, 16, 16),
	BorderSizePixel = 0,
	Parent = Panel,
	Active = true
})
New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SliderFrame})

local SliderLabel = New("TextLabel", {
	Size = UDim2.new(1, -10, 0, 18),
	Position = UDim2.new(0, 8, 0, 4),
	BackgroundTransparency = 1,
	Text = "Raio: 500",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(200, 200, 200),
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = SliderFrame
})

local SliderTrack = New("Frame", {
	Size = UDim2.new(0.86, 0, 0, 6),
	Position = UDim2.new(0.07, 0, 0.62, 0),
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	BorderSizePixel = 0,
	Parent = SliderFrame
})
New("UICorner", {CornerRadius = UDim.new(0, 3), Parent = SliderTrack})

local SliderFill = New("Frame", {
	Size = UDim2.new(0.45, 0, 1, 0),
	BackgroundColor3 = RGB(2),
	BorderSizePixel = 0,
	Parent = SliderTrack
})
New("UICorner", {CornerRadius = UDim.new(0, 3), Parent = SliderFill})

local SliderThumb = New("Frame", {
	Size = UDim2.new(0, 14, 0, 14),
	Position = UDim2.new(0.45, -7, 0.5, -7),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0,
	Parent = SliderTrack,
	Active = true
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = SliderThumb})

local aimPart = "Cabeça"
local checkboxes = {}

local function MakeCheckbox(label, yPos, isActive)
	local frame = New("Frame", {
		Size = UDim2.new(0.86, 0, 0, 26),
		Position = UDim2.new(0.07, 0, yPos, 0),
		BackgroundColor3 = Color3.fromRGB(18, 18, 18),
		BorderSizePixel = 0,
		Parent = Panel,
		Active = true
	})
	New("UICorner", {CornerRadius = UDim.new(0, 5), Parent = frame})

	local indicator = New("Frame", {
		Size = UDim2.new(0, 13, 0, 13),
		Position = UDim2.new(0, 8, 0.5, -6),
		BackgroundColor3 = isActive and Color3.fromRGB(0, 90, 0) or Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Parent = frame
	})
	New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = indicator})

	if isActive then
		New("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "✓",
			Font = Enum.Font.GothamBold,
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = indicator
		})
	end

	New("TextLabel", {
		Size = UDim2.new(1, -30, 1, 0),
		Position = UDim2.new(0, 28, 0, 0),
		BackgroundTransparency = 1,
		Text = label,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})

	local entry = {Frame = frame, Indicator = indicator, Active = isActive}
	table.insert(checkboxes, entry)

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			for _, cb in pairs(checkboxes) do
				cb.Indicator.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				local mark = cb.Indicator:FindFirstChildOfClass("TextLabel")
				if mark then mark:Destroy() end
				cb.Active = false
			end
			indicator.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
			if not indicator:FindFirstChildOfClass("TextLabel") then
				New("TextLabel", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = "✓",
					Font = Enum.Font.GothamBold,
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = indicator
				})
			end
			aimPart = label
			entry.Active = true
			Notify("Alvo: " .. label)
		end
	end)
end

MakeCheckbox("Cabeça", 0.72, true)
MakeCheckbox("Peito", 0.79, false)
MakeCheckbox("Pé", 0.86, false)

local Circle = New("Frame", {
	Name = "Circle",
	Size = UDim2.new(0, 1000, 0, 1000),
	Position = UDim2.new(0.5, -500, 0.5, -500),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Visible = false,
	Parent = ScreenGui
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = Circle})
local CircleStroke = New("UIStroke", {Color = Color3.new(0.6, 0, 1), Thickness = 2, Transparency = 0.3, Parent = Circle})
local CircleFill = New("Frame", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = Color3.new(0.6, 0, 1),
	BackgroundTransparency = 0.92,
	BorderSizePixel = 0,
	Parent = Circle
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = CircleFill})

local Crosshair = New("Frame", {
	Size = UDim2.new(0, 20, 0, 20),
	Position = UDim2.new(0.5, -10, 0.5, -10),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Parent = ScreenGui
})
New("Frame", {
	Size = UDim2.new(1, 0, 0, 2),
	Position = UDim2.new(0, 0, 0.5, -1),
	BackgroundColor3 = Color3.fromRGB(220, 220, 220),
	BorderSizePixel = 0,
	Parent = Crosshair
})
New("Frame", {
	Size = UDim2.new(0, 2, 1, 0),
	Position = UDim2.new(0.5, -1, 0, 0),
	BackgroundColor3 = Color3.fromRGB(220, 220, 220),
	BorderSizePixel = 0,
	Parent = Crosshair
})
local CrossDot = New("Frame", {
	Size = UDim2.new(0, 4, 0, 4),
	Position = UDim2.new(0.5, -2, 0.5, -2),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0,
	Parent = Crosshair
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = CrossDot})

local aimOn = false
local rgbCircleOn = false
local espOn = false
local rgbEspOn = false
local circleRadius = 500
local target = nil
local espCache = {}

BtnAim.MouseButton1Click:Connect(function()
	aimOn = not aimOn
	BtnAim.Text = "Mira: " .. (aimOn and "ON" or "OFF")
	BtnAim.BackgroundColor3 = aimOn and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(20, 20, 20)
	Circle.Visible = aimOn
	Notify("Mira " .. (aimOn and "Ativada" or "Desativada"))
end)

BtnCircle.MouseButton1Click:Connect(function()
	rgbCircleOn = not rgbCircleOn
	BtnCircle.Text = "RGB Círculo: " .. (rgbCircleOn and "ON" or "OFF")
	Notify("RGB Círculo " .. (rgbCircleOn and "Ativado" or "Desativado"))
end)

BtnESP.MouseButton1Click:Connect(function()
	espOn = not espOn
	BtnESP.Text = "ESP: " .. (espOn and "ON" or "OFF")
	BtnESP.BackgroundColor3 = espOn and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(20, 20, 20)
	Notify("ESP " .. (espOn and "Ativado" or "Desativado"))
	if not espOn then
		for _, h in pairs(espCache) do
			if h and h.Parent then h:Destroy() end
		end
		espCache = {}
	end
end)

BtnRGBESP.MouseButton1Click:Connect(function()
	rgbEspOn = not rgbEspOn
	BtnRGBESP.Text = "RGB ESP: " .. (rgbEspOn and "ON" or "OFF")
	Notify("RGB ESP " .. (rgbEspOn and "Ativado" or "Desativado"))
end)

local draggingSlider = false

SliderThumb.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingSlider = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingSlider and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local x = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
		SliderFill.Size = UDim2.new(x, 0, 1, 0)
		SliderThumb.Position = UDim2.new(x, -7, 0.5, -7)
		circleRadius = math.floor(x * 900 + 100)
		SliderLabel.Text = "Raio: " .. circleRadius
		Circle.Size = UDim2.new(0, circleRadius * 2, 0, circleRadius * 2)
		Circle.Position = UDim2.new(0.5, -circleRadius, 0.5, -circleRadius)
	end
end)

local draggingPanel = false
local dragStart = nil
local panelStart = nil

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingPanel = true
		dragStart = input.Position
		panelStart = Panel.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingPanel and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		Panel.Position = UDim2.new(panelStart.X.Scale, panelStart.X.Offset + delta.X, panelStart.Y.Scale, panelStart.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingPanel = false
	end
end)

local partMap = {
	["Cabeça"] = "Head",
	["Peito"] = "UpperTorso",
	["Pé"] = "LeftFoot"
}

RunService.RenderStepped:Connect(function()
	local cam = workspace.CurrentCamera
	if not cam then return end
	local t = tick()

	PanelStroke.Color = RGB(t)

	if aimOn then
		local best = nil
		local bestDist = circleRadius
		local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				local partName = partMap[aimPart] or "Head"
				local part = player.Character:FindFirstChild(partName) or player.Character:FindFirstChild("HumanoidRootPart")
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if part and humanoid and humanoid.Health > 0 then
					local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
					if onScreen then
						local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
						if dist < bestDist then
							bestDist = dist
							best = part
						end
					end
				end
			end
		end

		target = best

		if target and target.Parent then
			local screenPos, onScreen = cam:WorldToViewportPoint(target.Position)
			if onScreen then
				Crosshair.Position = UDim2.new(0, screenPos.X - 10, 0, screenPos.Y - 10)
				local cf = cam.CFrame
				local targetCF = CFrame.new(cf.Position, target.Position)
				cam.CFrame = cf:Lerp(targetCF, 0.2)
			end
		else
			Crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
		end

		if rgbCircleOn then
			CircleStroke.Color = RGB(t)
			CircleFill.BackgroundColor3 = RGB(t)
		else
			CircleStroke.Color = Color3.new(0.6, 0, 1)
			CircleFill.BackgroundColor3 = Color3.new(0.6, 0, 1)
		end
	else
		Crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
		target = nil
	end
end)

RunService.Heartbeat:Connect(function()
	if not espOn then return end
	local t = tick()
	local espColor = rgbEspOn and RGB(t) or Color3.new(0.6, 0, 1)

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			if not espCache[player] then
				local highlight = Instance.new("Highlight")
				highlight.FillColor = espColor
				highlight.OutlineColor = Color3.new(1, 1, 1)
				highlight.FillTransparency = 0.5
				highlight.OutlineTransparency = 0.1
				highlight.Adornee = player.Character
				highlight.Parent = player.Character
				espCache[player] = highlight
			else
				espCache[player].FillColor = espColor
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if espCache[player] then
		espCache[player]:Destroy()
		espCache[player] = nil
	end
end)

task.spawn(function()
	for i = 0, 100, 2 do
		LoadDesc.Text = "Carregando" .. string.rep(".", math.floor(i / 20) % 3 + 1)
		LoadBar.Size = UDim2.new(0, i * 3.2, 0, 8)
		LoadBar.Position = UDim2.new(0.5, -160 + i * 1.6, 0.5, 80)
		LoadBar.BackgroundColor3 = RGB(i * 0.05)
		LoadPercent.Text = i .. "%"
		LoadStroke.Color = RGB(i * 0.08)
		task.wait(0.018)
	end
	Tween(LoadFrame, {BackgroundTransparency = 1, Size = UDim2.new(0, 380, 0, 220)}, 0.4)
	Tween(LoadStroke, {Transparency = 1}, 0.3)
	Tween(LoadBar, {BackgroundTransparency = 1}, 0.3)
	Tween(LoadDesc, {TextTransparency = 1}, 0.3)
	Tween(LoadPercent, {TextTransparency = 1}, 0.3)
	task.wait(0.45)
	LoadFrame:Destroy()
	Panel.Visible = true
	Tween(Panel, {Position = UDim2.new(0.5, -145, 0.5, -235)}, 0.65)
	Notify("Zx Carregado!")
end)
