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
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	ZIndex = 10,
	Parent = ScreenGui
})
local LoadGrid = New("Frame", {Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, ZIndex = 11, Parent = LoadBG})
for i = 1, 12 do
	New("Frame", {Size=UDim2.new(0,1,1,0), Position=UDim2.new(i/12,0,0,0), BackgroundColor3=Color3.fromRGB(80,0,180), BackgroundTransparency=0.91, BorderSizePixel=0, ZIndex=11, Parent=LoadGrid})
end
for i = 1, 20 do
	New("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,i/20,0), BackgroundColor3=Color3.fromRGB(80,0,180), BackgroundTransparency=0.91, BorderSizePixel=0, ZIndex=11, Parent=LoadGrid})
end

local GlowTop = New("Frame", {Size=UDim2.new(1,0,0,160), Position=UDim2.new(0,0,0,0), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, ZIndex=11, Parent=LoadBG})
New("UIGradient", {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(90,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}), Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)}), Rotation=90, Parent=GlowTop})
local GlowBot = New("Frame", {Size=UDim2.new(1,0,0,160), Position=UDim2.new(0,0,1,-160), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, ZIndex=11, Parent=LoadBG})
New("UIGradient", {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,180,255))}), Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0.6)}), Rotation=90, Parent=GlowBot})

local LoadCard = New("Frame", {Size=UDim2.new(0,310,0,220), Position=UDim2.new(0.5,-155,0.5,-110), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, ZIndex=12, Parent=LoadBG})
New("UICorner", {CornerRadius=UDim.new(0,14), Parent=LoadCard})
local LoadCardStroke = New("UIStroke", {Color=Color3.fromRGB(120,0,255), Thickness=1.5, Transparency=0.15, Parent=LoadCard})
local LoadTopLine = New("Frame", {Size=UDim2.new(0.55,0,0,2), Position=UDim2.new(0.225,0,0,0), BackgroundColor3=Color3.fromRGB(140,0,255), BackgroundTransparency=0.1, BorderSizePixel=0, ZIndex=13, Parent=LoadCard})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=LoadTopLine})
local LoadSymbol = New("TextLabel", {Size=UDim2.new(1,0,0,36), Position=UDim2.new(0,0,0,12), BackgroundTransparency=1, Text="⬡", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(140,0,255), TextSize=26, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=13, Parent=LoadCard})
local LoadTitle = New("TextLabel", {Size=UDim2.new(1,0,0,28), Position=UDim2.new(0,0,0,50), BackgroundTransparency=1, Text="ZX  V2026", Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1), TextSize=21, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=13, Parent=LoadCard})
New("UIGradient", {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,80,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}), Parent=LoadTitle})
local LoadSub = New("TextLabel", {Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,0,80), BackgroundTransparency=1, Text="SISTEMA INICIANDO", Font=Enum.Font.Gotham, TextColor3=Color3.fromRGB(100,60,180), TextSize=10, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=13, Parent=LoadCard})
local LoadBarTrack = New("Frame", {Size=UDim2.new(0.82,0,0,4), Position=UDim2.new(0.09,0,0,112), BackgroundColor3=Color3.fromRGB(8,5,15), BorderSizePixel=0, ZIndex=13, Parent=LoadCard})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=LoadBarTrack})
local LoadBarFill = New("Frame", {Size=UDim2.new(0,0,1,0), BackgroundColor3=Color3.fromRGB(120,0,255), BorderSizePixel=0, ZIndex=14, Parent=LoadBarTrack})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=LoadBarFill})
New("UIGradient", {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(100,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,210,255))}), Parent=LoadBarFill})
local LoadPercent = New("TextLabel", {Size=UDim2.new(1,0,0,18), Position=UDim2.new(0,0,0,124), BackgroundTransparency=1, Text="0%", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(140,0,255), TextSize=12, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=13, Parent=LoadCard})
local LoadStatus = New("TextLabel", {Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,0,148), BackgroundTransparency=1, Text="[ CARREGANDO MÓDULOS ]", Font=Enum.Font.Gotham, TextColor3=Color3.fromRGB(70,45,110), TextSize=10, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=13, Parent=LoadCard})
local LoadBotLine = New("Frame", {Size=UDim2.new(0.38,0,0,1), Position=UDim2.new(0.31,0,1,-1), BackgroundColor3=Color3.fromRGB(0,200,255), BackgroundTransparency=0.35, BorderSizePixel=0, ZIndex=13, Parent=LoadCard})
New("UICorner", {CornerRadius=UDim.new(0,1), Parent=LoadBotLine})

local NotifHolder = New("Frame", {Size=UDim2.new(0,260,0,300), Position=UDim2.new(0.5,-130,0.82,0), BackgroundTransparency=1, BorderSizePixel=0, Parent=ScreenGui})
local NotifList = {}
local function Notify(txt)
	local n = New("Frame", {Size=UDim2.new(1,0,0,36), Position=UDim2.new(0,0,1,0), BackgroundColor3=Color3.fromRGB(0,0,0), BackgroundTransparency=0.1, BorderSizePixel=0, Parent=NotifHolder})
	New("UICorner", {CornerRadius=UDim.new(0,8), Parent=n})
	New("UIStroke", {Color=Color3.fromRGB(100,0,220), Thickness=1.2, Parent=n})
	New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text=txt, Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1), TextSize=12, TextXAlignment=Enum.TextXAlignment.Center, Parent=n})
	Tween(n, {Position=UDim2.new(0,0,1-(#NotifList+1)*0.16,0)}, 0.3)
	table.insert(NotifList, n)
	task.delay(2.8, function()
		Tween(n, {Position=UDim2.new(0,0,1.5,0), BackgroundTransparency=1}, 0.25)
		task.wait(0.25)
		n:Destroy()
		table.remove(NotifList, 1)
	end)
end

local Panel = New("Frame", {
	Name = "Main",
	Size = UDim2.new(0, 290, 0, 480),
	Position = UDim2.new(0.5, -145, 0.5, 1200),
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	BorderSizePixel = 0,
	Parent = ScreenGui,
	Visible = false,
	ClipsDescendants = true
})
New("UICorner", {CornerRadius=UDim.new(0,14), Parent=Panel})
local PanelStroke = New("UIStroke", {Color=Color3.fromRGB(100,0,220), Thickness=1.5, Transparency=0.2, Parent=Panel})

local PanelTopAccent = New("Frame", {Size=UDim2.new(0.45,0,0,2), Position=UDim2.new(0.1,0,0,0), BackgroundColor3=Color3.fromRGB(140,0,255), BackgroundTransparency=0.1, BorderSizePixel=0, Parent=Panel})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=PanelTopAccent})

local TopBar = New("Frame", {Size=UDim2.new(1,0,0,50), BackgroundColor3=Color3.fromRGB(0,0,0), ZIndex=3, Parent=Panel})
New("UICorner", {CornerRadius=UDim.new(0,14), Parent=TopBar})
New("TextLabel", {Size=UDim2.new(1,-40,1,0), BackgroundTransparency=1, Text="⬡  ZX MENU", Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1), TextSize=17, TextXAlignment=Enum.TextXAlignment.Center, ZIndex=3, Parent=TopBar})
local CloseBtn = New("TextButton", {Size=UDim2.new(0,30,0,30), Position=UDim2.new(1,-38,0.5,-15), BackgroundColor3=Color3.fromRGB(0,0,0), BackgroundTransparency=0.3, BorderSizePixel=0, Text="✕", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(180,80,255), TextSize=14, ZIndex=4, Parent=TopBar, Active=true})
New("UICorner", {CornerRadius=UDim.new(0,6), Parent=CloseBtn})
New("UIStroke", {Color=Color3.fromRGB(80,0,160), Thickness=1, Parent=CloseBtn})
New("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,0), BackgroundColor3=Color3.fromRGB(80,0,180), BackgroundTransparency=0.5, BorderSizePixel=0, ZIndex=3, Parent=TopBar})

local ScrollFrame = New("ScrollingFrame", {
	Size = UDim2.new(1, 0, 1, -50),
	Position = UDim2.new(0, 0, 0, 50),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 3,
	ScrollBarImageColor3 = Color3.fromRGB(100, 0, 220),
	ScrollBarImageTransparency = 0.4,
	CanvasSize = UDim2.new(0, 0, 0, 680),
	ScrollingDirection = Enum.ScrollingDirection.Y,
	ElasticBehavior = Enum.ElasticBehavior.Never,
	Parent = Panel
})

local PopUp = New("TextButton", {Size=UDim2.new(0,54,0,28), Position=UDim2.new(1,-64,0,48), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, Text="⬡ ZX", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(160,80,255), TextSize=12, Visible=false, Parent=ScreenGui, Active=true})
New("UICorner", {CornerRadius=UDim.new(0,8), Parent=PopUp})
New("UIStroke", {Color=Color3.fromRGB(100,0,220), Thickness=1.2, Parent=PopUp})

local menuOpen = true
local function CloseMenu()
	menuOpen = false
	Tween(Panel, {Position=UDim2.new(0.5,-145,0.5,1200)}, 0.4)
	task.wait(0.35)
	Panel.Visible = false
	PopUp.Size = UDim2.new(0,0,0,28)
	PopUp.Visible = true
	Tween(PopUp, {Size=UDim2.new(0,54,0,28)}, 0.35)
end
local function OpenMenu()
	menuOpen = true
	Tween(PopUp, {Size=UDim2.new(0,0,0,28)}, 0.25)
	task.wait(0.22)
	PopUp.Visible = false
	Panel.Visible = true
	Tween(Panel, {Position=UDim2.new(0.5,-145,0.5,-240)}, 0.45)
end
CloseBtn.MouseButton1Click:Connect(CloseMenu)
CloseBtn.TouchTap:Connect(CloseMenu)
PopUp.MouseButton1Click:Connect(OpenMenu)
PopUp.TouchTap:Connect(OpenMenu)

local function MakeButton(txt, yOffset, active)
	local btn = New("TextButton", {
		Size = UDim2.new(0.86, 0, 0, 40),
		Position = UDim2.new(0.07, 0, 0, yOffset),
		BackgroundColor3 = active and Color3.fromRGB(22,0,44) or Color3.fromRGB(6,4,10),
		BorderSizePixel = 0,
		Text = txt,
		Font = Enum.Font.GothamBold,
		TextColor3 = active and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Center,
		Parent = ScrollFrame,
		Active = true
	})
	New("UICorner", {CornerRadius=UDim.new(0,8), Parent=btn})
	New("UIStroke", {Color=active and Color3.fromRGB(100,0,220) or Color3.fromRGB(35,25,52), Thickness=1.2, Parent=btn})
	return btn
end

local BtnAim     = MakeButton("⬡  MIRA: OFF",         10,  false)
local BtnAimFix  = MakeButton("⬡  AIMBOT FIX: OFF",   60,  false)
local BtnCircle  = MakeButton("⬡  RGB CÍRCULO: OFF",  110,  false)
local BtnESP     = MakeButton("⬡  ESP: OFF",          160,  false)
local BtnRGBESP  = MakeButton("⬡  RGB ESP: OFF",      210,  false)
local BtnRGBName = MakeButton("⬡  ESP NOME RGB: OFF", 260,  false)

local SliderOuter = New("Frame", {Size=UDim2.new(0.86,0,0,44), Position=UDim2.new(0.07,0,0,320), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, Parent=ScrollFrame, Active=true})
New("UICorner", {CornerRadius=UDim.new(0,8), Parent=SliderOuter})
New("UIStroke", {Color=Color3.fromRGB(35,25,52), Thickness=1, Parent=SliderOuter})
local SliderLabel = New("TextLabel", {Size=UDim2.new(1,-10,0,16), Position=UDim2.new(0,8,0,5), BackgroundTransparency=1, Text="RAIO: 500", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(120,80,200), TextSize=11, TextXAlignment=Enum.TextXAlignment.Left, Parent=SliderOuter})
local SliderTrack = New("Frame", {Size=UDim2.new(0.86,0,0,4), Position=UDim2.new(0.07,0,0,26), BackgroundColor3=Color3.fromRGB(10,7,18), BorderSizePixel=0, Parent=SliderOuter})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=SliderTrack})
local SliderFill = New("Frame", {Size=UDim2.new(0.45,0,1,0), BackgroundColor3=Color3.fromRGB(100,0,220), BorderSizePixel=0, Parent=SliderTrack})
New("UICorner", {CornerRadius=UDim.new(0,2), Parent=SliderFill})
New("UIGradient", {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(80,0,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}), Parent=SliderFill})
local SliderThumb = New("Frame", {Size=UDim2.new(0,14,0,14), Position=UDim2.new(0.45,-7,0.5,-7), BackgroundColor3=Color3.fromRGB(160,80,255), BorderSizePixel=0, Parent=SliderTrack, Active=true})
New("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=SliderThumb})

local SepLabel = New("TextLabel", {Size=UDim2.new(0.86,0,0,18), Position=UDim2.new(0.07,0,0,380), BackgroundTransparency=1, Text="── PARTE DO ALVO ──", Font=Enum.Font.Gotham, TextColor3=Color3.fromRGB(70,50,110), TextSize=10, TextXAlignment=Enum.TextXAlignment.Center, Parent=ScrollFrame})

local aimPart = "Cabeça"
local checkboxes = {}
local cbYOffsets = {408, 442, 476}
local cbLabels = {"Cabeça", "Peito", "Pé"}

local function MakeCheckbox(label, yOffset, isActive)
	local frame = New("Frame", {Size=UDim2.new(0.86,0,0,24), Position=UDim2.new(0.07,0,0,yOffset), BackgroundColor3=Color3.fromRGB(0,0,0), BorderSizePixel=0, Parent=ScrollFrame, Active=true})
	New("UICorner", {CornerRadius=UDim.new(0,5), Parent=frame})
	New("UIStroke", {Color=Color3.fromRGB(30,20,48), Thickness=1, Parent=frame})
	local indicator = New("Frame", {Size=UDim2.new(0,12,0,12), Position=UDim2.new(0,8,0.5,-6), BackgroundColor3=isActive and Color3.fromRGB(80,0,180) or Color3.fromRGB(15,10,28), BorderSizePixel=0, Parent=frame})
	New("UICorner", {CornerRadius=UDim.new(0,2), Parent=indicator})
	New("UIStroke", {Color=Color3.fromRGB(70,0,150), Thickness=1, Parent=indicator})
	if isActive then
		New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="✓", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(200,140,255), TextSize=9, TextXAlignment=Enum.TextXAlignment.Center, Parent=indicator})
	end
	New("TextLabel", {Size=UDim2.new(1,-30,1,0), Position=UDim2.new(0,26,0,0), BackgroundTransparency=1, Text=label, Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(160,145,200), TextSize=11, TextXAlignment=Enum.TextXAlignment.Left, Parent=frame})
	local entry = {Frame=frame, Indicator=indicator, Active=isActive}
	table.insert(checkboxes, entry)
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			for _, cb in pairs(checkboxes) do
				cb.Indicator.BackgroundColor3 = Color3.fromRGB(15,10,28)
				local mark = cb.Indicator:FindFirstChildOfClass("TextLabel")
				if mark then mark:Destroy() end
				cb.Active = false
			end
			indicator.BackgroundColor3 = Color3.fromRGB(80,0,180)
			if not indicator:FindFirstChildOfClass("TextLabel") then
				New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="✓", Font=Enum.Font.GothamBold, TextColor3=Color3.fromRGB(200,140,255), TextSize=9, TextXAlignment=Enum.TextXAlignment.Center, Parent=indicator})
			end
			aimPart = label
			entry.Active = true
			Notify("ALVO: " .. string.upper(label))
		end
	end)
end

for i, lbl in ipairs(cbLabels) do
	MakeCheckbox(lbl, cbYOffsets[i], i == 1)
end

local Circle = New("Frame", {Size=UDim2.new(0,1000,0,1000), Position=UDim2.new(0.5,-500,0.5,-500), BackgroundTransparency=1, BorderSizePixel=0, Visible=false, Parent=ScreenGui})
New("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=Circle})
local CircleStroke = New("UIStroke", {Color=Color3.fromRGB(120,0,255), Thickness=1.5, Transparency=0.25, Parent=Circle})
local CircleFill = New("Frame", {Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(80,0,200), BackgroundTransparency=0.95, BorderSizePixel=0, Parent=Circle})
New("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=CircleFill})

local Crosshair = New("Frame", {Size=UDim2.new(0,22,0,22), Position=UDim2.new(0.5,-11,0.5,-11), BackgroundTransparency=1, BorderSizePixel=0, Parent=ScreenGui})
New("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,0.5,0), BackgroundColor3=Color3.fromRGB(210,170,255), BorderSizePixel=0, Parent=Crosshair})
New("Frame", {Size=UDim2.new(0,1,1,0), Position=UDim2.new(0.5,0,0,0), BackgroundColor3=Color3.fromRGB(210,170,255), BorderSizePixel=0, Parent=Crosshair})
local CrossDot = New("Frame", {Size=UDim2.new(0,3,0,3), Position=UDim2.new(0.5,-1,0.5,-1), BackgroundColor3=Color3.fromRGB(180,80,255), BorderSizePixel=0, Parent=Crosshair})
New("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=CrossDot})

local LockIndicator = New("Frame", {Size=UDim2.new(0,52,0,52), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.5,0,0.5,0), BackgroundTransparency=1, BorderSizePixel=0, Visible=false, Parent=ScreenGui})
local cc = Color3.fromRGB(0,210,255)
local function CornerPiece(px, py, pw, ph, flip)
	local hBar = New("Frame", {Size=UDim2.new(0,pw,0,1), Position=UDim2.new(px, flip and -pw or 0, py, 0), BackgroundColor3=cc, BorderSizePixel=0, Parent=LockIndicator})
	local vBar = New("Frame", {Size=UDim2.new(0,1,0,ph), Position=UDim2.new(px, flip and -1 or 0, py, 0), BackgroundColor3=cc, BorderSizePixel=0, Parent=LockIndicator})
end
CornerPiece(0, 0, 11, 11, false)
CornerPiece(1, 0, 11, 11, true)
local function CornerBot(px, py, pw, ph, flip)
	New("Frame", {Size=UDim2.new(0,pw,0,1), Position=UDim2.new(px, flip and -pw or 0, py, -1), BackgroundColor3=cc, BorderSizePixel=0, Parent=LockIndicator})
	New("Frame", {Size=UDim2.new(0,1,0,ph), Position=UDim2.new(px, flip and -1 or 0, py, -ph), BackgroundColor3=cc, BorderSizePixel=0, Parent=LockIndicator})
end
CornerBot(0, 1, 11, 11, false)
CornerBot(1, 1, 11, 11, true)
local LockDot = New("Frame", {Size=UDim2.new(0,4,0,4), Position=UDim2.new(0.5,-2,0.5,-2), BackgroundColor3=Color3.fromRGB(0,210,255), BorderSizePixel=0, Parent=LockIndicator})
New("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=LockDot})

local aimOn = false
local aimFixOn = false
local rgbCircleOn = false
local espOn = false
local rgbEspOn = false
local rgbNameOn = false
local circleRadius = 500
local lockedPlayer = nil
local espCache = {}
local espNameCache = {}

local partMap = {["Cabeça"]="Head", ["Peito"]="UpperTorso", ["Pé"]="LeftFoot"}

local function getTargetPart(player)
	if not player or not player.Character then return nil end
	return player.Character:FindFirstChild(partMap[aimPart] or "Head") or player.Character:FindFirstChild("HumanoidRootPart")
end

local function getClosestPlayer(cam)
	local best, bestDist = nil, math.huge
	local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if humanoid and humanoid.Health > 0 and root then
				local sp, on = cam:WorldToViewportPoint(root.Position)
				if on then
					local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
					if d < bestDist then bestDist = d; best = player end
				end
			end
		end
	end
	return best
end

local function SetButtonState(btn, state)
	btn.BackgroundColor3 = state and Color3.fromRGB(22,0,44) or Color3.fromRGB(6,4,10)
	btn.TextColor3 = state and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175)
	local stroke = btn:FindFirstChildOfClass("UIStroke")
	if stroke then stroke.Color = state and Color3.fromRGB(100,0,220) or Color3.fromRGB(35,25,52) end
end

local function resetCamera()
	local cam = workspace.CurrentCamera
	if cam then cam.CameraType = Enum.CameraType.Custom end
end

local function createESPName(player)
	if not player.Character then return end
	local root = player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	if espNameCache[player] then
		if espNameCache[player].Parent then espNameCache[player]:Destroy() end
	end
	local bb = Instance.new("BillboardGui")
	bb.Name = "ZxESPName"
	bb.Size = UDim2.new(0, 120, 0, 26)
	bb.StudsOffset = Vector3.new(0, 3.2, 0)
	bb.AlwaysOnTop = true
	bb.ResetOnSpawn = false
	bb.Adornee = root
	bb.Parent = root
	local lbl = New("TextLabel", {
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		Text = player.Name,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(190, 130, 255),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextStrokeTransparency = 0.3,
		TextStrokeColor3 = Color3.new(0,0,0),
		Parent = bb
	})
	espNameCache[player] = bb
end

local function removeESPName(player)
	if espNameCache[player] then
		if espNameCache[player].Parent then espNameCache[player]:Destroy() end
		espNameCache[player] = nil
	end
end

local function removeESP(player)
	if espCache[player] then
		if espCache[player].Parent then espCache[player]:Destroy() end
		espCache[player] = nil
	end
	removeESPName(player)
end

BtnAim.MouseButton1Click:Connect(function()
	aimOn = not aimOn
	BtnAim.Text = "⬡  MIRA: " .. (aimOn and "ON" or "OFF")
	SetButtonState(BtnAim, aimOn)
	Circle.Visible = aimOn
	if not aimOn then resetCamera() end
	Notify("MIRA " .. (aimOn and "ATIVADA" or "DESATIVADA"))
end)

BtnAimFix.MouseButton1Click:Connect(function()
	aimFixOn = not aimFixOn
	BtnAimFix.Text = "⬡  AIMBOT FIX: " .. (aimFixOn and "ON" or "OFF")
	SetButtonState(BtnAimFix, aimFixOn)
	if not aimFixOn then
		lockedPlayer = nil
		LockIndicator.Visible = false
		resetCamera()
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
		for _, player in ipairs(Players:GetPlayers()) do
			removeESP(player)
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

BtnRGBName.MouseButton1Click:Connect(function()
	rgbNameOn = not rgbNameOn
	BtnRGBName.Text = "⬡  ESP NOME RGB: " .. (rgbNameOn and "ON" or "OFF")
	SetButtonState(BtnRGBName, rgbNameOn)
	if not rgbNameOn then
		for _, player in ipairs(Players:GetPlayers()) do
			if espNameCache[player] and espNameCache[player].Parent then
				local lbl = espNameCache[player]:FindFirstChildOfClass("TextLabel")
				if lbl then lbl.TextColor3 = Color3.fromRGB(190,130,255) end
			end
		end
	end
	Notify("ESP NOME RGB " .. (rgbNameOn and "ATIVADO" or "DESATIVADO"))
end)

local draggingSlider = false
SliderThumb.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end
end)
UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
end)
UserInputService.InputChanged:Connect(function(i)
	if draggingSlider and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
		local x = math.clamp((i.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
		SliderFill.Size = UDim2.new(x,0,1,0)
		SliderThumb.Position = UDim2.new(x,-7,0.5,-7)
		circleRadius = math.floor(x*900+100)
		SliderLabel.Text = "RAIO: " .. circleRadius
		Circle.Size = UDim2.new(0,circleRadius*2,0,circleRadius*2)
		Circle.Position = UDim2.new(0.5,-circleRadius,0.5,-circleRadius)
	end
end)

local draggingPanel = false
local dragStart, panelStart = nil, nil
TopBar.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingPanel = true; dragStart = i.Position; panelStart = Panel.Position
	end
end)
UserInputService.InputChanged:Connect(function(i)
	if draggingPanel and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
		local d = i.Position - dragStart
		Panel.Position = UDim2.new(panelStart.X.Scale, panelStart.X.Offset + d.X, panelStart.Y.Scale, panelStart.Y.Offset + d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then draggingPanel = false end
end)

local function onCharacterAdded(player, character)
	character:WaitForChild("HumanoidRootPart", 5)
	if espCache[player] then
		espCache[player]:Destroy()
		espCache[player] = nil
	end
	if espNameCache[player] then
		espNameCache[player]:Destroy()
		espNameCache[player] = nil
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		player.CharacterAdded:Connect(function(char)
			onCharacterAdded(player, char)
		end)
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		onCharacterAdded(player, char)
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	removeESP(player)
	if lockedPlayer == player then
		lockedPlayer = nil
		LockIndicator.Visible = false
		resetCamera()
	end
end)

RunService.RenderStepped:Connect(function()
	local cam = workspace.CurrentCamera
	if not cam then return end
	local t = tick()

	PanelStroke.Color = RGB(t)

	if aimFixOn then
		local needsNew = lockedPlayer == nil
			or not lockedPlayer.Character
			or not lockedPlayer.Character:FindFirstChildOfClass("Humanoid")
			or lockedPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0
		if needsNew then
			lockedPlayer = getClosestPlayer(cam)
			if lockedPlayer then Notify("FIXADO: " .. lockedPlayer.Name) end
		end
		if lockedPlayer then
			local part = getTargetPart(lockedPlayer)
			if part and part.Parent then
				cam.CameraType = Enum.CameraType.Scriptable
				cam.CFrame = CFrame.new(cam.CFrame.Position, part.Position)
				local sp, on = cam:WorldToViewportPoint(part.Position)
				if on then
					Crosshair.Position = UDim2.new(0, sp.X-11, 0, sp.Y-11)
					LockIndicator.Position = UDim2.new(0, sp.X, 0, sp.Y)
					LockIndicator.Visible = true
				else
					LockIndicator.Visible = false
					Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
				end
			else
				LockIndicator.Visible = false
				Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
			end
		else
			LockIndicator.Visible = false
			Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
		end
	elseif aimOn then
		local closest = getClosestPlayer(cam)
		if closest then
			local part = getTargetPart(closest)
			if part and part.Parent then
				local sp, on = cam:WorldToViewportPoint(part.Position)
				if on then
					Crosshair.Position = UDim2.new(0, sp.X-11, 0, sp.Y-11)
					cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, part.Position), 0.2)
				end
			end
		else
			Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
		end
		LockIndicator.Visible = false
		if rgbCircleOn then
			CircleStroke.Color = RGB(t)
			CircleFill.BackgroundColor3 = RGB(t)
		else
			CircleStroke.Color = Color3.fromRGB(100,0,220)
			CircleFill.BackgroundColor3 = Color3.fromRGB(80,0,200)
		end
	else
		Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
		LockIndicator.Visible = false
	end

	if LockIndicator.Visible then
		local pulse = 0.1 + math.abs(math.sin(t*4)) * 0.5
		for _, child in ipairs(LockIndicator:GetChildren()) do
			if child:IsA("Frame") and child ~= LockDot then
				child.BackgroundTransparency = pulse
			end
		end
	end

	if rgbNameOn and espOn then
		local nameColor = RGB(t)
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and espNameCache[player] and espNameCache[player].Parent then
				local lbl = espNameCache[player]:FindFirstChildOfClass("TextLabel")
				if lbl then lbl.TextColor3 = nameColor end
			end
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if not espOn then return end
	local t = tick()
	local espColor = rgbEspOn and RGB(t) or Color3.fromRGB(110,0,220)

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local char = player.Character
			if char then
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 then
					if not espCache[player] or not espCache[player].Parent then
						if espCache[player] then espCache[player]:Destroy() end
						local h = Instance.new("Highlight")
						h.FillColor = espColor
						h.OutlineColor = Color3.fromRGB(190,130,255)
						h.FillTransparency = 0.5
						h.OutlineTransparency = 0.08
						h.Adornee = char
						h.Parent = char
						espCache[player] = h
					else
						espCache[player].FillColor = espColor
					end
					if not espNameCache[player] or not espNameCache[player].Parent then
						createESPName(player)
					end
				else
					removeESP(player)
				end
			else
				removeESP(player)
			end
		end
	end
end)

local statusMessages = {"[ CARREGANDO MÓDULOS ]","[ INICIANDO ESP ]","[ COMPILANDO MIRA ]","[ APLICANDO PATCHES ]","[ FINALIZANDO SISTEMA ]"}
task.spawn(function()
	for i = 0, 100 do
		LoadBarFill.Size = UDim2.new(i/100,0,1,0)
		LoadPercent.Text = i.."%"
		LoadCardStroke.Color = RGB(i*0.05)
		LoadSymbol.TextColor3 = RGB(i*0.05)
		LoadStatus.Text = statusMessages[math.clamp(math.floor(i/21)+1,1,#statusMessages)]
		task.wait(0.022)
	end
	Tween(LoadBG, {BackgroundTransparency=1}, 0.5)
	Tween(LoadCard, {BackgroundTransparency=1}, 0.4)
	Tween(LoadCardStroke, {Transparency=1}, 0.3)
	Tween(LoadTitle, {TextTransparency=1}, 0.3)
	Tween(LoadSub, {TextTransparency=1}, 0.3)
	Tween(LoadPercent, {TextTransparency=1}, 0.3)
	Tween(LoadStatus, {TextTransparency=1}, 0.3)
	Tween(LoadSymbol, {TextTransparency=1}, 0.3)
	Tween(LoadBarFill, {BackgroundTransparency=1}, 0.3)
	Tween(LoadTopLine, {BackgroundTransparency=1}, 0.3)
	Tween(LoadBotLine, {BackgroundTransparency=1}, 0.3)
	Tween(GlowTop, {BackgroundTransparency=1}, 0.4)
	Tween(GlowBot, {BackgroundTransparency=1}, 0.4)
	task.wait(0.5)
	LoadBG:Destroy()
	Panel.Visible = true
	Tween(Panel, {Position=UDim2.new(0.5,-145,0.5,-240)}, 0.55)
	Notify("ZX CARREGADO!")
end)
