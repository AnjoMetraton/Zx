local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function New(c,p) local o=Instance.new(c) for k,v in pairs(p or {}) do o[k]=v end return o end
local function Tween(o,p,d) TweenService:Create(o,TweenInfo.new(d or 0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play() end
local function RGB(t) return Color3.fromRGB(math.floor(math.sin(t*1.8)*127+128),math.floor(math.sin(t*1.8+2.094)*127+128),math.floor(math.sin(t*1.8+4.189)*127+128)) end

if _G.ZxKeybindUI then
	pcall(function() _G.ZxKeybindUI:Destroy() end)
	_G.ZxKeybindUI = nil
	return
end

local ScreenGui = New("ScreenGui",{Name="ZxKeybind",ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=LocalPlayer:WaitForChild("PlayerGui")})
_G.ZxKeybindUI = ScreenGui

local BG = New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.5,BorderSizePixel=0,Parent=ScreenGui})

local Panel = New("Frame",{Size=UDim2.new(0,350,0,500),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,1.5,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
local PStroke = New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.8,Parent=Panel})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(8,4,18)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Rotation=135,Parent=Panel})

local TopAccent = New("Frame",{Size=UDim2.new(0.5,0,0,2),Position=UDim2.new(0.25,0,0,0),BackgroundColor3=Color3.fromRGB(140,0,255),BorderSizePixel=0,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=TopAccent})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,180,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))}),Parent=TopAccent})

local TopBar = New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(12,5,28)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Rotation=90,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(0,24,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text="⬡",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=16,TextXAlignment=Enum.TextXAlignment.Center,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,34,0,0),BackgroundTransparency=1,Text="ALTERAR TECLAS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=16,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
local CloseBtn = New("TextButton",{Size=UDim2.new(0,32,0,32),Position=UDim2.new(1,-42,0.5,-16),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="✕",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=14,Parent=TopBar,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1.2,Parent=CloseBtn})
New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(80,0,180),BackgroundTransparency=0.3,BorderSizePixel=0,Parent=TopBar})

local CANVAS_HEIGHT = 0
local Scroll = New("ScrollingFrame",{
	Size=UDim2.new(1,0,1,-52),
	Position=UDim2.new(0,0,0,52),
	BackgroundTransparency=1,
	BorderSizePixel=0,
	ScrollBarThickness=2,
	ScrollBarImageColor3=Color3.fromRGB(120,0,240),
	ScrollBarImageTransparency=0.3,
	CanvasSize=UDim2.new(0,0,0,0),
	ScrollingDirection=Enum.ScrollingDirection.Y,
	ElasticBehavior=Enum.ElasticBehavior.Never,
	Parent=Panel
})

local allKeys = {
	{name="Mouse Botão 1", type="mouse", input=Enum.UserInputType.MouseButton1},
	{name="Mouse Botão 2", type="mouse", input=Enum.UserInputType.MouseButton2},
	{name="Mouse Botão 3", type="mouse", input=Enum.UserInputType.MouseButton3},
	{name="A",  type="key", input=Enum.KeyCode.A},
	{name="B",  type="key", input=Enum.KeyCode.B},
	{name="C",  type="key", input=Enum.KeyCode.C},
	{name="D",  type="key", input=Enum.KeyCode.D},
	{name="E",  type="key", input=Enum.KeyCode.E},
	{name="F",  type="key", input=Enum.KeyCode.F},
	{name="G",  type="key", input=Enum.KeyCode.G},
	{name="H",  type="key", input=Enum.KeyCode.H},
	{name="I",  type="key", input=Enum.KeyCode.I},
	{name="J",  type="key", input=Enum.KeyCode.J},
	{name="K",  type="key", input=Enum.KeyCode.K},
	{name="L",  type="key", input=Enum.KeyCode.L},
	{name="M",  type="key", input=Enum.KeyCode.M},
	{name="N",  type="key", input=Enum.KeyCode.N},
	{name="O",  type="key", input=Enum.KeyCode.O},
	{name="P",  type="key", input=Enum.KeyCode.P},
	{name="Q",  type="key", input=Enum.KeyCode.Q},
	{name="R",  type="key", input=Enum.KeyCode.R},
	{name="S",  type="key", input=Enum.KeyCode.S},
	{name="T",  type="key", input=Enum.KeyCode.T},
	{name="U",  type="key", input=Enum.KeyCode.U},
	{name="V",  type="key", input=Enum.KeyCode.V},
	{name="W",  type="key", input=Enum.KeyCode.W},
	{name="X",  type="key", input=Enum.KeyCode.X},
	{name="Y",  type="key", input=Enum.KeyCode.Y},
	{name="Z",  type="key", input=Enum.KeyCode.Z},
	{name="0",  type="key", input=Enum.KeyCode.Zero},
	{name="1",  type="key", input=Enum.KeyCode.One},
	{name="2",  type="key", input=Enum.KeyCode.Two},
	{name="3",  type="key", input=Enum.KeyCode.Three},
	{name="4",  type="key", input=Enum.KeyCode.Four},
	{name="5",  type="key", input=Enum.KeyCode.Five},
	{name="6",  type="key", input=Enum.KeyCode.Six},
	{name="7",  type="key", input=Enum.KeyCode.Seven},
	{name="8",  type="key", input=Enum.KeyCode.Eight},
	{name="9",  type="key", input=Enum.KeyCode.Nine},
	{name="F1",  type="key", input=Enum.KeyCode.F1},
	{name="F2",  type="key", input=Enum.KeyCode.F2},
	{name="F3",  type="key", input=Enum.KeyCode.F3},
	{name="F4",  type="key", input=Enum.KeyCode.F4},
	{name="F5",  type="key", input=Enum.KeyCode.F5},
	{name="F6",  type="key", input=Enum.KeyCode.F6},
	{name="F7",  type="key", input=Enum.KeyCode.F7},
	{name="F8",  type="key", input=Enum.KeyCode.F8},
	{name="F9",  type="key", input=Enum.KeyCode.F9},
	{name="F10", type="key", input=Enum.KeyCode.F10},
	{name="F11", type="key", input=Enum.KeyCode.F11},
	{name="F12", type="key", input=Enum.KeyCode.F12},
	{name="Tab",       type="key", input=Enum.KeyCode.Tab},
	{name="CapsLock",  type="key", input=Enum.KeyCode.CapsLock},
	{name="Shift Esq", type="key", input=Enum.KeyCode.LeftShift},
	{name="Shift Dir", type="key", input=Enum.KeyCode.RightShift},
	{name="Ctrl Esq",  type="key", input=Enum.KeyCode.LeftControl},
	{name="Ctrl Dir",  type="key", input=Enum.KeyCode.RightControl},
	{name="Alt Esq",   type="key", input=Enum.KeyCode.LeftAlt},
	{name="Alt Dir",   type="key", input=Enum.KeyCode.RightAlt},
	{name="Espaço",    type="key", input=Enum.KeyCode.Space},
	{name="Enter",     type="key", input=Enum.KeyCode.Return},
	{name="Backspace", type="key", input=Enum.KeyCode.Backspace},
	{name="Delete",    type="key", input=Enum.KeyCode.Delete},
	{name="Home",      type="key", input=Enum.KeyCode.Home},
	{name="End",       type="key", input=Enum.KeyCode.End},
	{name="PageUp",    type="key", input=Enum.KeyCode.PageUp},
	{name="PageDown",  type="key", input=Enum.KeyCode.PageDown},
	{name="Seta Cima", type="key", input=Enum.KeyCode.Up},
	{name="Seta Baixo",type="key", input=Enum.KeyCode.Down},
	{name="Seta Esq",  type="key", input=Enum.KeyCode.Left},
	{name="Seta Dir",  type="key", input=Enum.KeyCode.Right},
	{name="Escape",    type="key", input=Enum.KeyCode.Escape},
}

local bindings = {}
local waitingRow = nil
local waitingConn = nil
local rowFrames = {}
local rowKeyLabels = {}

local function cancelWaiting()
	if waitingConn then
		waitingConn:Disconnect()
		waitingConn = nil
	end
	if waitingRow then
		local bindBtn = waitingRow:FindFirstChild("BindBtn")
		if bindBtn then
			bindBtn.BackgroundColor3 = Color3.fromRGB(15,8,30)
			local lbl = bindBtn:FindFirstChildOfClass("TextLabel")
			if lbl then
				lbl.TextColor3 = Color3.fromRGB(160,100,255)
				local actionName = waitingRow:GetAttribute("ActionName")
				if actionName and bindings[actionName] then
					lbl.Text = bindings[actionName].name
				else
					lbl.Text = "---"
				end
			end
			local stroke = bindBtn:FindFirstChildOfClass("UIStroke")
			if stroke then stroke.Color = Color3.fromRGB(60,0,130) end
		end
		waitingRow = nil
	end
end

local function makeRow(actionName, defaultKey, yOffset)
	bindings[actionName] = defaultKey or nil

	local row = New("Frame",{
		Size=UDim2.new(0,326,0,44),
		Position=UDim2.new(0,12,0,yOffset),
		BackgroundColor3=Color3.fromRGB(5,3,12),
		BorderSizePixel=0,
		Parent=Scroll
	})
	row:SetAttribute("ActionName", actionName)
	New("UICorner",{CornerRadius=UDim.new(0,10),Parent=row})
	New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=row})

	local accent = New("Frame",{Size=UDim2.new(0,3,0.6,0),Position=UDim2.new(0,0,0.2,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=row})
	New("UICorner",{CornerRadius=UDim.new(0,2),Parent=accent})

	New("TextLabel",{Size=UDim2.new(0.52,0,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=actionName,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,170,220),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})

	local bindBtn = New("TextButton",{
		Name="BindBtn",
		Size=UDim2.new(0,110,0,28),
		Position=UDim2.new(1,-118,0.5,-14),
		BackgroundColor3=Color3.fromRGB(15,8,30),
		BorderSizePixel=0,
		Text="",
		Active=true,
		Parent=row
	})
	New("UICorner",{CornerRadius=UDim.new(0,8),Parent=bindBtn})
	New("UIStroke",{Color=Color3.fromRGB(60,0,130),Thickness=1,Parent=bindBtn})

	local keyLbl = New("TextLabel",{
		Size=UDim2.new(1,0,1,0),
		BackgroundTransparency=1,
		Text=defaultKey and defaultKey.name or "---",
		Font=Enum.Font.GothamBold,
		TextColor3=Color3.fromRGB(160,100,255),
		TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Center,
		Parent=bindBtn
	})

	rowKeyLabels[actionName] = keyLbl

	local function onPress()
		if waitingRow == row then
			cancelWaiting()
			return
		end
		cancelWaiting()
		waitingRow = row
		bindBtn.BackgroundColor3 = Color3.fromRGB(40,0,80)
		keyLbl.TextColor3 = Color3.fromRGB(255,200,255)
		keyLbl.Text = "[ ... ]"
		local stroke = bindBtn:FindFirstChildOfClass("UIStroke")
		if stroke then stroke.Color = Color3.fromRGB(160,0,255) end

		waitingConn = UserInputService.InputBegan:Connect(function(input, gp)
			local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.MouseButton2
				or input.UserInputType == Enum.UserInputType.MouseButton3
			if gp and not isMouse then return end
			local found = nil
			for _, k in ipairs(allKeys) do
				if k.type == "key" and input.KeyCode == k.input then
					found = k; break
				elseif k.type == "mouse" and input.UserInputType == k.input then
					found = k; break
				end
			end
			if found then
				bindings[actionName] = found
				keyLbl.Text = found.name
				if _G.ZxKeybindings then
					_G.ZxKeybindings[actionName] = found
				end
			end
			cancelWaiting()
		end)
	end

	bindBtn.MouseButton1Click:Connect(onPress)
	bindBtn.TouchTap:Connect(onPress)
	bindBtn.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch then
			onPress()
		end
	end)

	rowFrames[actionName] = row
	return row
end

local actions = {
	{"Mira (Aim)",      nil},
	{"Aimbot Fix",      nil},
	{"ESP",             nil},
	{"RGB ESP",         nil},
	{"RGB Círculo",     nil},
	{"Hitbox",          nil},
	{"Ignorar Time",    nil},
	{"Ignorar Parede",  nil},
	{"Ação 1 (Custom)", nil},
	{"Ação 2 (Custom)", nil},
	{"Stealth",         nil},
}

_G.ZxKeybindings = {}
local totalRows = #actions
local ROW_H = 44
local ROW_PAD = 8
local TOP_PAD = 10
local RESET_H = 38

for i, action in ipairs(actions) do
	local y = TOP_PAD + (i - 1) * (ROW_H + ROW_PAD)
	makeRow(action[1], action[2], y)
	_G.ZxKeybindings[action[1]] = action[2] or nil
end

local resetY = TOP_PAD + totalRows * (ROW_H + ROW_PAD)
CANVAS_HEIGHT = resetY + RESET_H + TOP_PAD
Scroll.CanvasSize = UDim2.new(0, 0, 0, CANVAS_HEIGHT)

local ResetBtn = New("TextButton",{
	Size=UDim2.new(0,326,0,RESET_H),
	Position=UDim2.new(0,12,0,resetY),
	BackgroundColor3=Color3.fromRGB(8,0,20),
	BorderSizePixel=0,
	Text="↺  RESETAR TUDO",
	Font=Enum.Font.GothamBold,
	TextColor3=Color3.fromRGB(120,60,200),
	TextSize=13,
	Active=true,
	Parent=Scroll
})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=ResetBtn})
New("UIStroke",{Color=Color3.fromRGB(50,0,100),Thickness=1,Parent=ResetBtn})

local function doReset()
	for _, action in ipairs(actions) do
		bindings[action[1]] = nil
		if _G.ZxKeybindings then _G.ZxKeybindings[action[1]] = nil end
		local lbl = rowKeyLabels[action[1]]
		if lbl then lbl.Text = "---" end
	end
end
ResetBtn.MouseButton1Click:Connect(doReset)
ResetBtn.TouchTap:Connect(doReset)
ResetBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then doReset() end
end)

local KbPopUp=New("TextButton",{Size=UDim2.new(0,0,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Text="⬡ ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=ScreenGui,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=KbPopUp})
New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.3,Parent=KbPopUp})

local kbDrag=false; local kbDragStart,kbDragPos=nil,nil; local kbMoved=false
KbPopUp.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
		kbDrag=true; kbMoved=false; kbDragStart=i.Position; kbDragPos=KbPopUp.Position
	end
end)
UserInputService.InputChanged:Connect(function(i)
	if kbDrag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
		local d=i.Position-kbDragStart
		if d.Magnitude>6 then kbMoved=true end
		KbPopUp.Position=UDim2.new(kbDragPos.X.Scale,kbDragPos.X.Offset+d.X,kbDragPos.Y.Scale,kbDragPos.Y.Offset+d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if kbDrag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then
		kbDrag=false
		if not kbMoved then
			KbPopUp.Visible=false
			BG.BackgroundTransparency=0.5; BG.Visible=true
			Panel.Visible=true
			Tween(Panel,{Position=UDim2.new(0.5,0,0.5,0)},0.45)
		end
	end
end)

local function doClose()
	cancelWaiting()
	Tween(Panel,{Position=UDim2.new(0.5,0,1.5,0)},0.35)
	Tween(BG,{BackgroundTransparency=1},0.35)
	task.spawn(function()
		task.wait(0.32)
		Panel.Visible=false
		BG.Visible=false
		KbPopUp.Size=UDim2.new(0,0,0,30); KbPopUp.Visible=true
		Tween(KbPopUp,{Size=UDim2.new(0,58,0,30)},0.35)
	end)
end
CloseBtn.MouseButton1Click:Connect(doClose)
CloseBtn.TouchTap:Connect(doClose)
CloseBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then doClose() end
end)

local dragging = false
local dragStart, panelStart = nil, nil
TopBar.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		if waitingRow then return end
		dragging = true
		dragStart = i.Position
		panelStart = Panel.Position
	end
end)
UserInputService.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
		local d = i.Position - dragStart
		Panel.Position = UDim2.new(panelStart.X.Scale, panelStart.X.Offset+d.X, panelStart.Y.Scale, panelStart.Y.Offset+d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

local renderConn
renderConn = RunService.RenderStepped:Connect(function()
	if not ScreenGui.Parent then
		renderConn:Disconnect()
		return
	end
	PStroke.Color = RGB(tick())
end)

Tween(Panel,{Position=UDim2.new(0.5,0,0.5,0)},0.45)
