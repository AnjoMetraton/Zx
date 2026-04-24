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

local LoadBG = New("Frame", {
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(3, 3, 6),
	BorderSizePixel = 0,
	ZIndex = 10,
	Parent = ScreenGui
})

local LoadGrid = New("Frame", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 11,
	Parent = LoadBG
})

for i = 1, 12 do
	New("Frame", {
		Size = UDim2.new(0, 1, 1, 0),
		Position = UDim2.new(i / 12, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(80, 0, 180),
		BackgroundTransparency = 0.88,
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = LoadGrid
	})
end
for i = 1, 20 do
	New("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, i / 20, 0),
		BackgroundColor3 = Color3.fromRGB(80, 0, 180),
		BackgroundTransparency = 0.88,
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = LoadGrid
	})
end

local GlowTop = New("Frame", {
	Size = UDim2.new(1, 0, 0, 180),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(120, 0, 255),
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
	ZIndex = 11,
	Parent = LoadBG
})
New("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	}),
	Rotation = 90,
	Parent = GlowTop
})

local GlowBot = New("Frame", {
	Size = UDim2.new(1, 0, 0, 180),
	Position = UDim2.new(0, 0, 1, -180),
	BackgroundColor3 = Color3.fromRGB(0, 200, 255),
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
	ZIndex = 11,
	Parent = LoadBG
})
New("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
	}),
	Rotation = 90,
	Parent = GlowBot
})

local LoadCard = New("Frame", {
	Size = UDim2.new(0, 320, 0, 230),
	Position = UDim2.new(0.5, -160, 0.5, -115),
	BackgroundColor3 = Color3.fromRGB(8, 5, 18),
	BorderSizePixel = 0,
	ZIndex = 12,
	Parent = LoadBG
})
New("UICorner", {CornerRadius = UDim.new(0, 12), Parent = LoadCard})
local LoadCardStroke = New("UIStroke", {
	Color = Color3.fromRGB(120, 0, 255),
	Thickness = 1.5,
	Transparency = 0.2,
	Parent = LoadCard
})

local LoadTopLine = New("Frame", {
	Size = UDim2.new(0.6, 0, 0, 2),
	Position = UDim2.new(0.2, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(160, 0, 255),
	BorderSizePixel = 0,
	ZIndex = 13,
	Parent = LoadCard
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = LoadTopLine})

local LoadSymbol = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 38),
	Position = UDim2.new(0, 0, 0, 14),
	BackgroundTransparency = 1,
	Text = "⬡",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(160, 0, 255),
	TextSize = 28,
	TextXAlignment = Enum.TextXAlignment.Center,
	ZIndex = 13,
	Parent = LoadCard
})

local LoadTitle = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.new(0, 0, 0, 52),
	BackgroundTransparency = 1,
	Text = "ZX  V2026",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 22,
	TextXAlignment = Enum.TextXAlignment.Center,
	ZIndex = 13,
	Parent = LoadCard
})
New("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 100, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
	}),
	Rotation = 0,
	Parent = LoadTitle
})

local LoadSub = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 18),
	Position = UDim2.new(0, 0, 0, 82),
	BackgroundTransparency = 1,
	Text = "SISTEMA INICIANDO",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(120, 80, 200),
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Center,
	ZIndex = 13,
	Parent = LoadCard
})

local LoadBarTrack = New("Frame", {
	Size = UDim2.new(0.82, 0, 0, 4),
	Position = UDim2.new(0.09, 0, 0, 118),
	BackgroundColor3 = Color3.fromRGB(20, 12, 35),
	BorderSizePixel = 0,
	ZIndex = 13,
	Parent = LoadCard
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = LoadBarTrack})

local LoadBarFill = New("Frame", {
	Size = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(140, 0, 255),
	BorderSizePixel = 0,
	ZIndex = 14,
	Parent = LoadBarTrack
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = LoadBarFill})
New("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 200)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 255))
	}),
	Rotation = 0,
	Parent = LoadBarFill
})

local LoadPercent = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 20),
	Position = UDim2.new(0, 0, 0, 130),
	BackgroundTransparency = 1,
	Text = "0%",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(160, 0, 255),
	TextSize = 13,
	TextXAlignment = Enum.TextXAlignment.Center,
	ZIndex = 13,
	Parent = LoadCard
})

local LoadStatus = New("TextLabel", {
	Size = UDim2.new(1, 0, 0, 18),
	Position = UDim2.new(0, 0, 0, 156),
	BackgroundTransparency = 1,
	Text = "[ CARREGANDO MÓDULOS ]",
	Font = Enum.Font.Gotham,
	TextColor3 = Color3.fromRGB(80, 50, 130),
	TextSize = 10,
	TextXAlignment = Enum.TextXAlignment.Center,
	ZIndex = 13,
	Parent = LoadCard
})

local LoadBotLine = New("Frame", {
	Size = UDim2.new(0.4, 0, 0, 1),
	Position = UDim2.new(0.3, 0, 1, -1),
	BackgroundColor3 = Color3.fromRGB(0, 200, 255),
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
	ZIndex = 13,
	Parent = LoadCard
})
New("UICorner", {CornerRadius = UDim.new(0, 1), Parent = LoadBotLine})

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
		BackgroundColor3 = Color3.fromRGB(10, 6, 20),
		BorderSizePixel = 0,
		Parent = NotifHolder
	})
	New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = n})
	New("UIStroke", {Color = Color3.fromRGB(120, 0, 255), Thickness = 1.2, Parent = n})
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
	Size = UDim2.new(0, 290, 0, 510),
	Position = UDim2.new(0.5, -145, 0.5, 1000),
	BackgroundColor3 = Color3.fromRGB(6, 4, 14),
	BorderSizePixel = 0,
	Parent = ScreenGui,
	Visible = false
})
New("UICorner", {CornerRadius = UDim.new(0, 14), Parent = Panel})
local PanelStroke = New("UIStroke", {Color = Color3.fromRGB(120, 0, 255), Thickness = 1.5, Transparency = 0.2, Parent = Panel})

local PanelTopAccent = New("Frame", {
	Size = UDim2.new(0.5, 0, 0, 2),
	Position = UDim2.new(0.25, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(160, 0, 255),
	BorderSizePixel = 0,
	Parent = Panel
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = PanelTopAccent})

local TopBar = New("Frame", {
	Size = UDim2.new(1, 0, 0, 52),
	BackgroundColor3 = Color3.fromRGB(10, 6, 22),
	Parent = Panel
})
New("UICorner", {CornerRadius = UDim.new(0, 14), Parent = TopBar})

local TopIcon = New("TextLabel", {
	Size = UDim2.new(0, 30, 1, 0),
	Position = UDim2.new(0, 14, 0, 0),
	BackgroundTransparency = 1,
	Text = "⬡",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(140, 0, 255),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = TopBar
})

New("TextLabel", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "ZX MENU",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = TopBar
})

local TopDivider = New("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(100, 0, 200),
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
	Parent = TopBar
})

local function MakeButton(txt, yPos, active)
	local btn = New("TextButton", {
		Size = UDim2.new(0.86, 0, 0, 40),
		Position = UDim2.new(0.07, 0, yPos, 0),
		BackgroundColor3 = active and Color3.fromRGB(40, 0, 80) or Color3.fromRGB(14, 10, 28),
		BorderSizePixel = 0,
		Text = txt,
		Font = Enum.Font.GothamBold,
		TextColor3 = active and Color3.fromRGB(200, 150, 255) or Color3.fromRGB(180, 180, 200),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = Panel,
		Active = true
	})
	New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = btn})
	New("UIStroke", {
		Color = active and Color3.fromRGB(120, 0, 255) or Color3.fromRGB(40, 30, 60),
		Thickness = 1.2,
		Parent = btn
	})
	return btn
end

local BtnAim = MakeButton("⬡  MIRA: OFF", 0.11, false)
local BtnAimFix = MakeButton("⬡  AIMBOT FIX: OFF", 0.22, false)
local BtnCircle = MakeButton("⬡  RGB CÍRCULO: OFF", 0.33, false)
local BtnESP = MakeButton("⬡  ESP: OFF", 0.44, false)
local BtnRGBESP = MakeButton("⬡  RGB ESP: OFF", 0.55, false)

local SliderFrame = New("Frame", {
	Size = UDim2.new(0.86, 0, 0, 44),
	Position = UDim2.new(0.07, 0, 0.67, 0),
	BackgroundColor3 = Color3.fromRGB(12, 8, 24),
	BorderSizePixel = 0,
	Parent = Panel,
	Active = true
})
New("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SliderFrame})
New("UIStroke", {Color = Color3.fromRGB(40, 30, 60), Thickness = 1, Parent = SliderFrame})

local SliderLabel = New("TextLabel", {
	Size = UDim2.new(1, -10, 0, 16),
	Position = UDim2.new(0, 8, 0, 5),
	BackgroundTransparency = 1,
	Text = "RAIO: 500",
	Font = Enum.Font.GothamBold,
	TextColor3 = Color3.fromRGB(140, 100, 220),
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = SliderFrame
})

local SliderTrack = New("Frame", {
	Size = UDim2.new(0.86, 0, 0, 4),
	Position = UDim2.new(0.07, 0, 0.68, 0),
	BackgroundColor3 = Color3.fromRGB(20, 14, 36),
	BorderSizePixel = 0,
	Parent = SliderFrame
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = SliderTrack})

local SliderFill = New("Frame", {
	Size = UDim2.new(0.45, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(120, 0, 255),
	BorderSizePixel = 0,
	Parent = SliderTrack
})
New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = SliderFill})
New("UIGradient", {
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 200)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
	}),
	Parent = SliderFill
})

local SliderThumb = New("Frame", {
	Size = UDim2.new(0, 14, 0, 14),
	Position = UDim2.new(0.45, -7, 0.5, -7),
	BackgroundColor3 = Color3.fromRGB(180, 100, 255),
	BorderSizePixel = 0,
	Parent = SliderTrack,
	Active = true
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = SliderThumb})

local aimPart = "Cabeça"
local checkboxes = {}

local function MakeCheckbox(label, yPos, isActive)
	local frame = New("Frame", {
		Size = UDim2.new(0.86, 0, 0, 24),
		Position = UDim2.new(0.07, 0, yPos, 0),
		BackgroundColor3 = Color3.fromRGB(12, 8, 22),
		BorderSizePixel = 0,
		Parent = Panel,
		Active = true
	})
	New("UICorner", {CornerRadius = UDim.new(0, 5), Parent = frame})

	local indicator = New("Frame", {
		Size = UDim2.new(0, 12, 0, 12),
		Position = UDim2.new(0, 8, 0.5, -6),
		BackgroundColor3 = isActive and Color3.fromRGB(100, 0, 200) or Color3.fromRGB(28, 20, 45),
		BorderSizePixel = 0,
		Parent = frame
	})
	New("UICorner", {CornerRadius = UDim.new(0, 2), Parent = indicator})
	New("UIStroke", {Color = Color3.fromRGB(80, 0, 160), Thickness = 1, Parent = indicator})

	if isActive then
		New("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "✓",
			Font = Enum.Font.GothamBold,
			TextColor3 = Color3.fromRGB(200, 150, 255),
			TextSize = 9,
			TextXAlignment = Enum.TextXAlignment.Center,
			Parent = indicator
		})
	end

	New("TextLabel", {
		Size = UDim2.new(1, -30, 1, 0),
		Position = UDim2.new(0, 26, 0, 0),
		BackgroundTransparency = 1,
		Text = label,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(180, 160, 220),
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = frame
	})

	local entry = {Frame = frame, Indicator = indicator, Active = isActive}
	table.insert(checkboxes, entry)

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			for _, cb in pairs(checkboxes) do
				cb.Indicator.BackgroundColor3 = Color3.fromRGB(28, 20, 45)
				local mark = cb.Indicator:FindFirstChildOfClass("TextLabel")
				if mark then mark:Destroy() end
				cb.Active = false
			end
			indicator.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
			if not indicator:FindFirstChildOfClass("TextLabel") then
				New("TextLabel", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = "✓",
					Font = Enum.Font.GothamBold,
					TextColor3 = Color3.fromRGB(200, 150, 255),
					TextSize = 9,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = indicator
				})
			end
			aimPart = label
			entry.Active = true
			Notify("ALVO: " .. string.upper(label))
		end
	end)
end

MakeCheckbox("Cabeça", 0.80, true)
MakeCheckbox("Peito", 0.86, false)
MakeCheckbox("Pé", 0.92, false)

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
local CircleStroke = New("UIStroke", {Color = Color3.fromRGB(120, 0, 255), Thickness = 1.5, Transparency = 0.3, Parent = Circle})
local CircleFill = New("Frame", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(100, 0, 255),
	BackgroundTransparency = 0.94,
	BorderSizePixel = 0,
	Parent = Circle
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = CircleFill})

local Crosshair = New("Frame", {
	Size = UDim2.new(0, 22, 0, 22),
	Position = UDim2.new(0.5, -11, 0.5, -11),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Parent = ScreenGui
})
New("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 0.5, 0),
	BackgroundColor3 = Color3.fromRGB(220, 180, 255),
	BorderSizePixel = 0,
	Parent = Crosshair
})
New("Frame", {
	Size = UDim2.new(0, 1, 1, 0),
	Position = UDim2.new(0.5, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(220, 180, 255),
	BorderSizePixel = 0,
	Parent = Crosshair
})
local CrossDot = New("Frame", {
	Size = UDim2.new(0, 3, 0, 3),
	Position = UDim2.new(0.5, -1, 0.5, -1),
	BackgroundColor3 = Color3.fromRGB(200, 100, 255),
	BorderSizePixel = 0,
	Parent = Crosshair
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = CrossDot})

local LockIndicator = New("Frame", {
	Size = UDim2.new(0, 48, 0, 48),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Visible = false,
	Parent = ScreenGui
})

New("Frame", {Size = UDim2.new(0, 10, 0, 1), Position = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})
New("Frame", {Size = UDim2.new(0, 1, 0, 10), Position = UDim2.new(0, 0, 0, 0), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})

New("Frame", {Size = UDim2.new(0, 10, 0, 1), Position = UDim2.new(1, -10, 0, 0), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})
New("Frame", {Size = UDim2.new(0, 1, 0, 10), Position = UDim2.new(1, -1, 0, 0), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})

New("Frame", {Size = UDim2.new(0, 10, 0, 1), Position = UDim2.new(0, 0, 1, -1), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})
New("Frame", {Size = UDim2.new(0, 1, 0, 10), Position = UDim2.new(0, 0, 1, -10), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})

New("Frame", {Size = UDim2.new(0, 10, 0, 1), Position = UDim2.new(1, -10, 1, -1), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})
New("Frame", {Size = UDim2.new(0, 1, 0, 10), Position = UDim2.new(1, -1, 1, -10), BackgroundColor3 = Color3.fromRGB(0, 220, 255), BorderSizePixel = 0, Parent = LockIndicator})

local LockDot = New("Frame", {
	Size = UDim2.new(0, 4, 0, 4),
	Position = UDim2.new(0.5, -2, 0.5, -2),
	BackgroundColor3 = Color3.fromRGB(0, 220, 255),
	BorderSizePixel = 0,
	Parent = LockIndicator
})
New("UICorner", {CornerRadius = UDim.new(0.5, 0), Parent = LockDot})

local aimOn = false
local aimFixOn = false
local rgbCircleOn = false
local espOn = false
local rgbEspOn = false
local circleRadius = 500
local lockedTarget = nil
local lockedPlayer = nil
local espCache = {}

local function SetButtonState(btn, state)
	btn.BackgroundColor3 = state and Color3.fromRGB(40, 0, 80) or Color3.fromRGB(14, 10, 28)
	btn.TextColor3 = state and Color3.fromRGB(200, 150, 255) or Color3.fromRGB(180, 180, 200)
	local stroke = btn:FindFirstChildOfClass("UIStroke")
	if stroke then stroke.Color = state and Color3.fromRGB(120, 0, 255) or Color3.fromRGB(40, 30, 60) end
end

BtnAim.MouseButton1Click:Connect(function()
	aimOn = not aimOn
	local onTxt = aimOn and "ON" or "OFF"
	BtnAim.Text = "⬡  MIRA: " .. onTxt
	SetButtonState(BtnAim, aimOn)
	Circle.Visible = aimOn
	if not aimOn then
		lockedTarget = nil
		lockedPlayer = nil
		LockIndicator.Visible = false
	end
	Notify("MIRA " .. (aimOn and "ATIVADA" or "DESATIVADA"))
end)

BtnAimFix.MouseButton1Click:Connect(function()
	aimFixOn = not aimFixOn
	local onTxt = aimFixOn and "ON" or "OFF"
	BtnAimFix.Text = "⬡  AIMBOT FIX: " .. onTxt
	SetButtonState(BtnAimFix, aimFixOn)
	if not aimFixOn then
		lockedTarget = nil
		lockedPlayer = nil
		LockIndicator.Visible = false
	end
	Notify("AIMBOT FIX " .. (aimFixOn and "ATIVADO" or "DESATIVADO"))
end)

BtnCircle.MouseButton1Click:Connect(function()
	rgbCircleOn = not rgbCircleOn
	BtnCircle.Text = "⬡  RGB CÍRCULO: " .. (rgbCircleOn and "ON" or "OFF")
	SetButtonState(BtnCircle, rgbCircleOn)
	Notify("RGB CÍRCULO " .. (rgbCircleOn and "ATIVADO" or "DESATIVADO"))
end)

BtnESP.MouseButton1Click:Connect(function()
	espOn = not espOn
	BtnESP.Text = "⬡  ESP: " .. (espOn and "ON" or "OFF")
	SetButtonState(BtnESP, espOn)
	Notify("ESP " .. (espOn and "ATIVADO" or "DESATIVADO"))
	if not espOn then
		for _, h in pairs(espCache) do
			if h and h.Parent then h:Destroy() end
		end
		espCache = {}
	end
end)

BtnRGBESP.MouseButton1Click:Connect(function()
	rgbEspOn = not rgbEspOn
	BtnRGBESP.Text = "⬡  RGB ESP: " .. (rgbEspOn and "ON" or "OFF")
	SetButtonState(BtnRGBESP, rgbEspOn)
	Notify("RGB ESP " .. (rgbEspOn and "ATIVADO" or "DESATIVADO"))
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
		SliderLabel.Text = "RAIO: " .. circleRadius
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

local function getClosestPlayer(cam, partName)
	local best = nil
	local bestPart = nil
	local bestDist = math.huge
	local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
	local pName = partMap[partName] or "Head"

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if humanoid and humanoid.Health > 0 and root then
				local screenPos, onScreen = cam:WorldToViewportPoint(root.Position)
				if onScreen then
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
					if dist < bestDist then
						bestDist = dist
						best = player
						bestPart = player.Character:FindFirstChild(pName) or root
					end
				end
			end
		end
	end
	return best, bestPart
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if espOn then
			task.wait(0.5)
			if espCache[player] then
				espCache[player]:Destroy()
				espCache[player] = nil
			end
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	if espCache[player] then
		espCache[player]:Destroy()
		espCache[player] = nil
	end
	if lockedPlayer == player then
		lockedTarget = nil
		lockedPlayer = nil
		LockIndicator.Visible = false
	end
end)

RunService.RenderStepped:Connect(function()
	local cam = workspace.CurrentCamera
	if not cam then return end
	local t = tick()

	PanelStroke.Color = RGB(t)

	if aimFixOn then
		if lockedPlayer == nil or lockedPlayer.Character == nil then
			local player, part = getClosestPlayer(cam, aimPart)
			if player then
				lockedPlayer = player
				lockedTarget = part
				Notify("FIXADO: " .. player.Name)
			end
		end

		if lockedTarget and lockedTarget.Parent then
			local humanoid = lockedPlayer and lockedPlayer.Character and lockedPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local screenPos, onScreen = cam:WorldToViewportPoint(lockedTarget.Position)
				if onScreen then
					Crosshair.Position = UDim2.new(0, screenPos.X - 11, 0, screenPos.Y - 11)
					LockIndicator.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)
					LockIndicator.Visible = true
					local cf = cam.CFrame
					cam.CFrame = CFrame.new(cf.Position, lockedTarget.Position)
				else
					LockIndicator.Visible = false
				end
			else
				lockedTarget = nil
				lockedPlayer = nil
				LockIndicator.Visible = false
			end
		else
			lockedTarget = nil
			lockedPlayer = nil
			LockIndicator.Visible = false
			Crosshair.Position = UDim2.new(0.5, -11, 0.5, -11)
		end

	elseif aimOn then
		local _, part = getClosestPlayer(cam, aimPart)

		if part and part.Parent then
			local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
			if onScreen then
				Crosshair.Position = UDim2.new(0, screenPos.X - 11, 0, screenPos.Y - 11)
				local cf = cam.CFrame
				local targetCF = CFrame.new(cf.Position, part.Position)
				cam.CFrame = cf:Lerp(targetCF, 0.2)
			end
		else
			Crosshair.Position = UDim2.new(0.5, -11, 0.5, -11)
		end

		LockIndicator.Visible = false

		if rgbCircleOn then
			CircleStroke.Color = RGB(t)
			CircleFill.BackgroundColor3 = RGB(t)
		else
			CircleStroke.Color = Color3.fromRGB(120, 0, 255)
			CircleFill.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
		end
	else
		Crosshair.Position = UDim2.new(0.5, -11, 0.5, -11)
		LockIndicator.Visible = false
	end

	if LockIndicator.Visible then
		local pulse = math.abs(math.sin(t * 3))
		for _, child in ipairs(LockIndicator:GetChildren()) do
			if child:IsA("Frame") then
				child.BackgroundTransparency = 0.1 + pulse * 0.4
			end
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if not espOn then return end
	local t = tick()
	local espColor = rgbEspOn and RGB(t) or Color3.fromRGB(120, 0, 255)

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				if not espCache[player] or not espCache[player].Parent then
					if espCache[player] then espCache[player]:Destroy() end
					local highlight = Instance.new("Highlight")
					highlight.FillColor = espColor
					highlight.OutlineColor = Color3.fromRGB(200, 150, 255)
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0.1
					highlight.Adornee = player.Character
					highlight.Parent = player.Character
					espCache[player] = highlight
				else
					espCache[player].FillColor = espColor
				end
			else
				if espCache[player] then
					espCache[player]:Destroy()
					espCache[player] = nil
				end
			end
		else
			if espCache[player] then
				espCache[player]:Destroy()
				espCache[player] = nil
			end
		end
	end
end)

local statusMessages = {
	"[ CARREGANDO MÓDULOS ]",
	"[ INICIANDO ESP ]",
	"[ COMPILANDO MIRA ]",
	"[ APLICANDO PATCHES ]",
	"[ FINALIZANDO ]"
}

task.spawn(function()
	for i = 0, 100, 1 do
		LoadBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
		LoadPercent.Text = i .. "%"
		LoadCardStroke.Color = RGB(i * 0.05)
		LoadSymbol.TextColor3 = RGB(i * 0.05)
		local msgIdx = math.clamp(math.floor(i / 21) + 1, 1, #statusMessages)
		LoadStatus.Text = statusMessages[msgIdx]
		task.wait(0.022)
	end

	Tween(LoadBG, {BackgroundTransparency = 1}, 0.5)
	Tween(LoadCard, {BackgroundTransparency = 1}, 0.4)
	Tween(LoadCardStroke, {Transparency = 1}, 0.3)
	Tween(LoadTitle, {TextTransparency = 1}, 0.3)
	Tween(LoadSub, {TextTransparency = 1}, 0.3)
	Tween(LoadPercent, {TextTransparency = 1}, 0.3)
	Tween(LoadStatus, {TextTransparency = 1}, 0.3)
	Tween(LoadSymbol, {TextTransparency = 1}, 0.3)
	Tween(LoadBarFill, {BackgroundTransparency = 1}, 0.3)
	Tween(LoadTopLine, {BackgroundTransparency = 1}, 0.3)
	Tween(LoadBotLine, {BackgroundTransparency = 1}, 0.3)
	Tween(GlowTop, {BackgroundTransparency = 1}, 0.4)
	Tween(GlowBot, {BackgroundTransparency = 1}, 0.4)

	task.wait(0.5)
	LoadBG:Destroy()

	Panel.Visible = true
	Tween(Panel, {Position = UDim2.new(0.5, -145, 0.5, -255)}, 0.65)
	Notify("ZX CARREGADO!")
end)
