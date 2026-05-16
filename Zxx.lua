local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

repeat task.wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

local function RGB(t)
	return Color3.fromRGB(
		math.floor(math.sin(t*1.8)*127+128),
		math.floor(math.sin(t*1.8+2.094)*127+128),
		math.floor(math.sin(t*1.8+4.189)*127+128)
	)
end
local function New(c,p) local o=Instance.new(c) for k,v in pairs(p or {}) do o[k]=v end return o end
local function Tween(o,p,d) TweenService:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play() end

local function ColorDistance(c1, c2)
	local dr = c1.R - c2.R
	local dg = c1.G - c2.G
	local db = c1.B - c2.B
	return dr*dr + dg*dg + db*db
end

local TEAM_RED = Color3.fromRGB(229, 72, 72)
local TEAM_BLUE = Color3.fromRGB(72, 171, 229)
local TEAM_THRESHOLD = 0.15

local function GetCharacterFromWorkspace(player)
	local playersFolder = workspace:FindFirstChild("Players")
	if playersFolder then
		return playersFolder:FindFirstChild(player.Name)
	end
	return player.Character
end

local function GetTeamColorFromNametag(char)
	if not char then return nil end
	local nametag = char:FindFirstChild("Nametag")
	if not nametag then return nil end
	local label = nametag:FindFirstChild("Player")
	if not label then return nil end
	if label:IsA("TextLabel") then
		return label.TextColor3
	end
	if label:IsA("ImageLabel") then
		return label.ImageColor3
	end
	if label:IsA("Frame") then
		return label.BackgroundColor3
	end
	return nil
end

local function ClassifyTeam(color)
	if not color then return nil end
	if ColorDistance(color, TEAM_RED) < TEAM_THRESHOLD then return "red" end
	if ColorDistance(color, TEAM_BLUE) < TEAM_THRESHOLD then return "blue" end
	return nil
end

local mySelectedTeam = nil

local function IsSameTeam(playerB)
	if not mySelectedTeam then return false end
	local charB = GetCharacterFromWorkspace(playerB)
	local nB = GetTeamColorFromNametag(charB)
	if not nB then return false end
	local teamB = ClassifyTeam(nB)
	if not teamB then return false end
	return mySelectedTeam == teamB
end

local ScreenGui = New("ScreenGui",{Name="ZxMenu",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LocalPlayer:WaitForChild("PlayerGui")})

local LoadBG = New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=ScreenGui})
local LoadGrid=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,ZIndex=11,Parent=LoadBG})
for i=1,12 do New("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(i/12,0,0,0),BackgroundColor3=Color3.fromRGB(80,0,180),BackgroundTransparency=0.91,BorderSizePixel=0,ZIndex=11,Parent=LoadGrid}) end
for i=1,20 do New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,i/20,0),BackgroundColor3=Color3.fromRGB(80,0,180),BackgroundTransparency=0.91,BorderSizePixel=0,ZIndex=11,Parent=LoadGrid}) end
local GTop=New("Frame",{Size=UDim2.new(1,0,0,160),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=11,Parent=LoadBG})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(90,0,200)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.6),NumberSequenceKeypoint.new(1,1)}),Rotation=90,Parent=GTop})
local GBot=New("Frame",{Size=UDim2.new(1,0,0,160),Position=UDim2.new(0,0,1,-160),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=11,Parent=LoadBG})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,180,255))}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0.6)}),Rotation=90,Parent=GBot})
local LCard=New("Frame",{Size=UDim2.new(0,310,0,220),Position=UDim2.new(0.5,-155,0.5,-110),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=LoadBG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
local LCardStroke=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Transparency=0.15,Parent=LCard})
local LTopLine=New("Frame",{Size=UDim2.new(0.55,0,0,2),Position=UDim2.new(0.225,0,0,0),BackgroundColor3=Color3.fromRGB(140,0,255),BackgroundTransparency=0.1,BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LTopLine})
local LSym=New("TextLabel",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="⬡",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=26,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=13,Parent=LCard})
local LTitle=New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,50),BackgroundTransparency=1,Text="ZX  V2026",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=21,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=13,Parent=LCard})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,80,255)),ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}),Parent=LTitle})
local LSub=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,80),BackgroundTransparency=1,Text="SISTEMA INICIANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(100,60,180),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=13,Parent=LCard})
local LBTrack=New("Frame",{Size=UDim2.new(0.82,0,0,4),Position=UDim2.new(0.09,0,0,112),BackgroundColor3=Color3.fromRGB(8,5,15),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
local LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(120,0,255),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(100,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,210,255))}),Parent=LBFill})
local LPct=New("TextLabel",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,0,124),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=13,Parent=LCard})
local LStat=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,148),BackgroundTransparency=1,Text="[ CARREGANDO MÓDULOS ]",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,45,110),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=13,Parent=LCard})
local LBotLine=New("Frame",{Size=UDim2.new(0.38,0,0,1),Position=UDim2.new(0.31,0,1,-1),BackgroundColor3=Color3.fromRGB(0,200,255),BackgroundTransparency=0.35,BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,1),Parent=LBotLine})

local NotifHolder=New("Frame",{Size=UDim2.new(0,260,0,300),Position=UDim2.new(0.5,-130,0.82,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
local NotifList={}
local function Notify(txt)
	local n=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.1,BorderSizePixel=0,Parent=NotifHolder})
	New("UICorner",{CornerRadius=UDim.new(0,8),Parent=n})
	New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.2,Parent=n})
	New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,Parent=n})
	Tween(n,{Position=UDim2.new(0,0,1-(#NotifList+1)*0.16,0)},0.3)
	table.insert(NotifList,n)
	task.delay(2.8,function()
		Tween(n,{Position=UDim2.new(0,0,1.5,0),BackgroundTransparency=1},0.25)
		task.wait(0.25); n:Destroy(); table.remove(NotifList,1)
	end)
end

local Panel=New("Frame",{Size=UDim2.new(0,290,0,480),Position=UDim2.new(0.5,-145,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=Panel})
local PStroke=New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.5,Transparency=0.2,Parent=Panel})
local PAccent=New("Frame",{Size=UDim2.new(0.45,0,0,2),Position=UDim2.new(0.1,0,0,0),BackgroundColor3=Color3.fromRGB(140,0,255),BackgroundTransparency=0.1,BorderSizePixel=0,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=PAccent})
local TopBar=New("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=Color3.new(0,0,0),ZIndex=3,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-40,1,0),BackgroundTransparency=1,Text="⬡  ZX MENU",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=17,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=3,Parent=TopBar})
local CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-38,0.5,-15),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.3,BorderSizePixel=0,Text="✕",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=14,ZIndex=4,Parent=TopBar,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,6),Parent=CloseBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1,Parent=CloseBtn})
New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(80,0,180),BackgroundTransparency=0.5,BorderSizePixel=0,ZIndex=3,Parent=TopBar})

local ScrollFrame=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-50),Position=UDim2.new(0,0,0,50),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=Color3.fromRGB(100,0,220),ScrollBarImageTransparency=0.4,CanvasSize=UDim2.new(0,0,0,1200),ScrollingDirection=Enum.ScrollingDirection.Y,ElasticBehavior=Enum.ElasticBehavior.Never,Parent=Panel})

local function MakeBtn(txt,y,active)
	local b=New("TextButton",{Size=UDim2.new(0.86,0,0,40),Position=UDim2.new(0.07,0,0,y),BackgroundColor3=active and Color3.fromRGB(22,0,44) or Color3.fromRGB(6,4,10),BorderSizePixel=0,Text=txt,Font=Enum.Font.GothamBold,TextColor3=active and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175),TextSize=13,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame,Active=true})
	New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
	New("UIStroke",{Color=active and Color3.fromRGB(100,0,220) or Color3.fromRGB(35,25,52),Thickness=1.2,Parent=b})
	return b
end

local BtnAim=MakeBtn("⬡  MIRA: OFF",10,false)
local BtnAimFix=MakeBtn("⬡  AIMBOT FIX: OFF",60,false)
local BtnCircle=MakeBtn("⬡  RGB CÍRCULO: OFF",110,false)
local BtnESP=MakeBtn("⬡  ESP: OFF",160,false)
local BtnRGBESP=MakeBtn("⬡  RGB ESP: OFF",210,false)
local BtnRGBName=MakeBtn("⬡  ESP NOME RGB: OFF",260,false)

local SliderOuter=New("Frame",{Size=UDim2.new(0.86,0,0,44),Position=UDim2.new(0.07,0,0,320),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScrollFrame,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=SliderOuter})
New("UIStroke",{Color=Color3.fromRGB(35,25,52),Thickness=1,Parent=SliderOuter})
local SliderLabel=New("TextLabel",{Size=UDim2.new(1,-10,0,16),Position=UDim2.new(0,8,0,5),BackgroundTransparency=1,Text="RAIO: 30",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(120,80,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=SliderOuter})
local SliderTrack=New("Frame",{Size=UDim2.new(0.86,0,0,4),Position=UDim2.new(0.07,0,0,26),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Parent=SliderOuter})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=SliderTrack})
local SliderFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=SliderTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=SliderFill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(80,0,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}),Parent=SliderFill})
local SliderThumb=New("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,-7,0.5,-7),BackgroundColor3=Color3.fromRGB(160,80,255),BorderSizePixel=0,Parent=SliderTrack,Active=true})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=SliderThumb})

New("TextLabel",{Size=UDim2.new(0.86,0,0,18),Position=UDim2.new(0.07,0,0,430),BackgroundTransparency=1,Text="── PARTE DO ALVO ──",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,50,110),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame})

local aimPart="Cabeça"
local checkboxes={}
local function MakeCB(label,y,active)
	local f=New("Frame",{Size=UDim2.new(0.86,0,0,24),Position=UDim2.new(0.07,0,0,y),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScrollFrame,Active=true})
	New("UICorner",{CornerRadius=UDim.new(0,5),Parent=f})
	New("UIStroke",{Color=Color3.fromRGB(30,20,48),Thickness=1,Parent=f})
	local ind=New("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(0,8,0.5,-6),BackgroundColor3=active and Color3.fromRGB(80,0,180) or Color3.fromRGB(15,10,28),BorderSizePixel=0,Parent=f})
	New("UICorner",{CornerRadius=UDim.new(0,2),Parent=ind})
	New("UIStroke",{Color=Color3.fromRGB(70,0,150),Thickness=1,Parent=ind})
	if active then New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,140,255),TextSize=9,TextXAlignment=Enum.TextXAlignment.Center,Parent=ind}) end
	New("TextLabel",{Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,26,0,0),BackgroundTransparency=1,Text=label,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,145,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
	local entry={Frame=f,Indicator=ind,Active=active}
	table.insert(checkboxes,entry)
	f.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
			for _,cb in pairs(checkboxes) do
				cb.Indicator.BackgroundColor3=Color3.fromRGB(15,10,28)
				local m=cb.Indicator:FindFirstChildOfClass("TextLabel"); if m then m:Destroy() end
				cb.Active=false
			end
			ind.BackgroundColor3=Color3.fromRGB(80,0,180)
			if not ind:FindFirstChildOfClass("TextLabel") then New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,140,255),TextSize=9,TextXAlignment=Enum.TextXAlignment.Center,Parent=ind}) end
			aimPart=label; entry.Active=true; Notify("ALVO: "..string.upper(label))
		end
	end)
end
MakeCB("Cabeça",458,true); MakeCB("Peito",490,false); MakeCB("Pé",522,false)

New("TextLabel",{Size=UDim2.new(0.86,0,0,18),Position=UDim2.new(0.07,0,0,562),BackgroundTransparency=1,Text="── HITBOX ──",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,50,110),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame})

local HBox=New("Frame",{Size=UDim2.new(0.86,0,0,82),Position=UDim2.new(0.07,0,0,588),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScrollFrame,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=HBox})
New("UIStroke",{Color=Color3.fromRGB(35,25,52),Thickness=1,Parent=HBox})
local HBoxToggle=New("TextButton",{Size=UDim2.new(0,36,0,20),Position=UDim2.new(1,-44,0,6),BackgroundColor3=Color3.fromRGB(15,10,28),BorderSizePixel=0,Text="",Parent=HBox,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=HBoxToggle})
New("UIStroke",{Color=Color3.fromRGB(70,0,150),Thickness=1,Parent=HBoxToggle})
local HBoxDot=New("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Color3.fromRGB(60,40,90),BorderSizePixel=0,Parent=HBoxToggle})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=HBoxDot})
local HBoxLabel=New("TextLabel",{Size=UDim2.new(1,-50,0,16),Position=UDim2.new(0,8,0,5),BackgroundTransparency=1,Text="HITBOX: 1x",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(120,80,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=HBox})
local HBoxTrack=New("Frame",{Size=UDim2.new(0.75,0,0,4),Position=UDim2.new(0.07,0,0,36),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Parent=HBox})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=HBoxTrack})
local HBoxFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=HBoxTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=HBoxFill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(80,0,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,80,80))}),Parent=HBoxFill})
local HBoxThumb=New("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,-7,0.5,-7),BackgroundColor3=Color3.fromRGB(160,80,255),BorderSizePixel=0,Parent=HBoxTrack,Active=true})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=HBoxThumb})
New("Frame",{Size=UDim2.new(0.9,0,0,1),Position=UDim2.new(0.05,0,0,54),BackgroundColor3=Color3.fromRGB(30,20,50),BorderSizePixel=0,Parent=HBox})
New("TextLabel",{Size=UDim2.new(0.5,0,0,22),Position=UDim2.new(0,8,0,58),BackgroundTransparency=1,Text="RGB BORDA",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(120,80,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=HBox})
local HBoxRGBToggle=New("TextButton",{Size=UDim2.new(0,36,0,20),Position=UDim2.new(1,-44,0,60),BackgroundColor3=Color3.fromRGB(15,10,28),BorderSizePixel=0,Text="",Parent=HBox,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=HBoxRGBToggle})
New("UIStroke",{Color=Color3.fromRGB(70,0,150),Thickness=1,Parent=HBoxRGBToggle})
local HBoxRGBDot=New("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Color3.fromRGB(60,40,90),BorderSizePixel=0,Parent=HBoxRGBToggle})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=HBoxRGBDot})

New("TextLabel",{Size=UDim2.new(0.86,0,0,18),Position=UDim2.new(0.07,0,0,688),BackgroundTransparency=1,Text="── OPÇÕES AIMBOT ──",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,50,110),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame})

local function MakeRow(lbl,y)
	local row=New("Frame",{Size=UDim2.new(0.86,0,0,34),Position=UDim2.new(0.07,0,0,y),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScrollFrame,Active=true})
	New("UICorner",{CornerRadius=UDim.new(0,8),Parent=row})
	New("UIStroke",{Color=Color3.fromRGB(30,20,48),Thickness=1,Parent=row})
	New("TextLabel",{Size=UDim2.new(1,-54,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(150,130,190),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
	local tog=New("TextButton",{Size=UDim2.new(0,36,0,20),Position=UDim2.new(1,-44,0.5,-10),BackgroundColor3=Color3.fromRGB(15,10,28),BorderSizePixel=0,Text="",Parent=row,Active=true})
	New("UICorner",{CornerRadius=UDim.new(0,10),Parent=tog})
	New("UIStroke",{Color=Color3.fromRGB(70,0,150),Thickness=1,Parent=tog})
	local dot=New("Frame",{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,3,0.5,-7),BackgroundColor3=Color3.fromRGB(60,40,90),BorderSizePixel=0,Parent=tog})
	New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
	return tog,dot
end
local TeamToggle,TeamDot=MakeRow("IGNORAR PRÓPRIO TIME",714)
local WallToggle,WallDot=MakeRow("IGNORAR ATRAVÉS DA PAREDE",756)

New("TextLabel",{Size=UDim2.new(0.86,0,0,18),Position=UDim2.new(0.07,0,0,798),BackgroundTransparency=1,Text="── MEU TIME ──",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,50,110),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame})

local TeamBtnRed=New("TextButton",{Size=UDim2.new(0.41,0,0,36),Position=UDim2.new(0.07,0,0,824),BackgroundColor3=Color3.fromRGB(40,5,5),BorderSizePixel=0,Text="● TIME VERMELHO",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(229,72,72),TextSize=11,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=TeamBtnRed})
local TeamBtnRedStroke=New("UIStroke",{Color=Color3.fromRGB(100,20,20),Thickness=1.5,Parent=TeamBtnRed})

local TeamBtnBlue=New("TextButton",{Size=UDim2.new(0.41,0,0,36),Position=UDim2.new(0.52,0,0,824),BackgroundColor3=Color3.fromRGB(5,15,40),BorderSizePixel=0,Text="● TIME AZUL",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(72,171,229),TextSize=11,TextXAlignment=Enum.TextXAlignment.Center,Parent=ScrollFrame,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=TeamBtnBlue})
local TeamBtnBlueStroke=New("UIStroke",{Color=Color3.fromRGB(20,60,100),Thickness=1.5,Parent=TeamBtnBlue})

local Circle=New("Frame",{Size=UDim2.new(0,60,0,60),Position=UDim2.new(0.5,-30,0.5,-30),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=Circle})
local CircleStroke=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Transparency=0.25,Parent=Circle})
local CircleFill=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(80,0,200),BackgroundTransparency=0.95,BorderSizePixel=0,Parent=Circle})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CircleFill})

local Crosshair=New("Frame",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0.5,-11,0.5,-11),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Crosshair})
New("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Crosshair})
local CDot=New("Frame",{Size=UDim2.new(0,3,0,3),Position=UDim2.new(0.5,-1,0.5,-1),BackgroundColor3=Color3.fromRGB(180,80,255),BorderSizePixel=0,Parent=Crosshair})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CDot})

local LockFrame=New("Frame",{Size=UDim2.new(0,52,0,52),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,0),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=ScreenGui})
local cc=Color3.fromRGB(0,210,255)
local function CP(x,y,w,h,fx) New("Frame",{Size=UDim2.new(0,w,0,1),Position=UDim2.new(x,fx and -w or 0,y,0),BackgroundColor3=cc,BorderSizePixel=0,Parent=LockFrame}) New("Frame",{Size=UDim2.new(0,1,0,h),Position=UDim2.new(x,fx and -1 or 0,y,0),BackgroundColor3=cc,BorderSizePixel=0,Parent=LockFrame}) end
local function CPB(x,y,w,h,fx) New("Frame",{Size=UDim2.new(0,w,0,1),Position=UDim2.new(x,fx and -w or 0,y,-1),BackgroundColor3=cc,BorderSizePixel=0,Parent=LockFrame}) New("Frame",{Size=UDim2.new(0,1,0,h),Position=UDim2.new(x,fx and -1 or 0,y,-h),BackgroundColor3=cc,BorderSizePixel=0,Parent=LockFrame}) end
CP(0,0,11,11,false); CP(1,0,11,11,true); CPB(0,1,11,11,false); CPB(1,1,11,11,true)
local LockDot=New("Frame",{Size=UDim2.new(0,4,0,4),Position=UDim2.new(0.5,-2,0.5,-2),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockFrame})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=LockDot})

local PopUp=New("TextButton",{Size=UDim2.new(0,54,0,28),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Text="⬡ ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=ScreenGui,Active=true})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=PopUp})
New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.2,Parent=PopUp})

local aimOn=false; local aimFixOn=false; local rgbCircleOn=false
local espOn=false; local rgbEspOn=false; local rgbNameOn=false
local hitboxOn=false; local hitboxSize=1
local hitboxOriginals={}; local hitboxVisualCache={}; local rgbHitboxOn=false
local ignoreTeam=false; local ignoreWall=false
local circleRadius=30; local lockedPlayer=nil
local espCache={}; local espNameCache={}
local partMap={["Cabeça"]="Head",["Peito"]="UpperTorso",["Pé"]="LeftFoot"}

local function SetBtn(btn,state)
	btn.BackgroundColor3=state and Color3.fromRGB(22,0,44) or Color3.fromRGB(6,4,10)
	btn.TextColor3=state and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175)
	local s=btn:FindFirstChildOfClass("UIStroke")
	if s then s.Color=state and Color3.fromRGB(100,0,220) or Color3.fromRGB(35,25,52) end
end

local function SetToggle(tog,dot,state)
	tog.BackgroundColor3=state and Color3.fromRGB(40,0,80) or Color3.fromRGB(15,10,28)
	dot.BackgroundColor3=state and Color3.fromRGB(160,80,255) or Color3.fromRGB(60,40,90)
	Tween(dot,{Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
	local s=tog:FindFirstChildOfClass("UIStroke")
	if s then s.Color=state and Color3.fromRGB(120,0,220) or Color3.fromRGB(70,0,150) end
end

local function getTargetPart(player)
	if not player then return nil end
	local char = GetCharacterFromWorkspace(player)
	if not char then return nil end
	return char:FindFirstChild(partMap[aimPart] or "Head") or char:FindFirstChild("HumanoidRootPart")
end

local function isVisible(root)
	local cam=workspace.CurrentCamera
	if not cam then return false end
	local origin=cam.CFrame.Position
	local direction=root.Position-origin
	local params=RaycastParams.new()
	params.FilterDescendantsInstances={LocalPlayer.Character}
	params.FilterType=Enum.RaycastFilterType.Exclude
	local result=workspace:Raycast(origin,direction,params)
	if not result then return true end
	return result.Instance and result.Instance:FindFirstAncestorOfClass("Model")==root.Parent
end

local function getClosest(cam)
	local best, bd = nil, math.huge
	local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
	for _,player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end
		local char = GetCharacterFromWorkspace(player)
		if not char then continue end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		if not (hum and hum.Health > 0 and root) then continue end
		if ignoreTeam then
			if IsSameTeam(player) then continue end
		end
		if ignoreWall and not isVisible(root) then continue end
		local sp, onScreen = cam:WorldToViewportPoint(root.Position)
		if onScreen then
			local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
			if dist < bd then
				bd = dist
				best = player
			end
		end
	end
	return best
end

local function resetCam()
	local cam=workspace.CurrentCamera
	if cam then cam.CameraType=Enum.CameraType.Custom end
end

local function removeESPName(p)
	if espNameCache[p] then
		if espNameCache[p].Parent then espNameCache[p]:Destroy() end
		espNameCache[p]=nil
	end
end
local function createESPName(p)
	local char = GetCharacterFromWorkspace(p)
	if not char then return end
	local root=char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	removeESPName(p)
	local bb=Instance.new("BillboardGui")
	bb.Size=UDim2.new(0,120,0,26)
	bb.StudsOffset=Vector3.new(0,3.2,0)
	bb.AlwaysOnTop=true
	bb.ResetOnSpawn=false
	bb.Adornee=root
	bb.Parent=root
	New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=p.Name,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,130,255),TextSize=13,TextXAlignment=Enum.TextXAlignment.Center,TextStrokeTransparency=0.3,TextStrokeColor3=Color3.new(0,0,0),Parent=bb})
	espNameCache[p]=bb
end
local function removeESP(p)
	if espCache[p] then
		if espCache[p].Parent then espCache[p]:Destroy() end
		espCache[p]=nil
	end
	removeESPName(p)
end
local function removeHBVisual(p)
	if hitboxVisualCache[p] then
		if hitboxVisualCache[p].Parent then hitboxVisualCache[p]:Destroy() end
		hitboxVisualCache[p]=nil
	end
end
local function restoreHitboxes()
	for p,sz in pairs(hitboxOriginals) do
		if p ~= LocalPlayer then
			local char = GetCharacterFromWorkspace(p)
			if char then
				local r=char:FindFirstChild("HumanoidRootPart")
				if r and sz then r.Size=sz end
			end
		end
		removeHBVisual(p)
	end
	hitboxOriginals={}
	for p,sb in pairs(hitboxVisualCache) do
		if sb then sb:Destroy() end
	end
	hitboxVisualCache={}
end

BtnAim.MouseButton1Click:Connect(function()
	aimOn=not aimOn
	BtnAim.Text="⬡  MIRA: "..(aimOn and "ON" or "OFF")
	SetBtn(BtnAim,aimOn)
	Circle.Visible=aimOn
	if not aimOn then resetCam() end
	Notify("MIRA "..(aimOn and "ATIVADA" or "DESATIVADA"))
end)

BtnAimFix.MouseButton1Click:Connect(function()
	aimFixOn=not aimFixOn
	BtnAimFix.Text="⬡  AIMBOT FIX: "..(aimFixOn and "ON" or "OFF")
	SetBtn(BtnAimFix,aimFixOn)
	if not aimFixOn then lockedPlayer=nil; LockFrame.Visible=false; resetCam() end
	Notify("AIMBOT FIX "..(aimFixOn and "ATIVADO" or "DESATIVADO"))
end)

BtnCircle.MouseButton1Click:Connect(function()
	rgbCircleOn=not rgbCircleOn
	BtnCircle.Text="⬡  RGB CÍRCULO: "..(rgbCircleOn and "ON" or "OFF")
	SetBtn(BtnCircle,rgbCircleOn)
	Notify("RGB CÍRCULO "..(rgbCircleOn and "ATIVADO" or "DESATIVADO"))
end)

BtnESP.MouseButton1Click:Connect(function()
	espOn=not espOn
	BtnESP.Text="⬡  ESP: "..(espOn and "ON" or "OFF")
	SetBtn(BtnESP,espOn)
	if not espOn then
		for _,p in ipairs(Players:GetPlayers()) do removeESP(p) end
		espCache={}
	end
	Notify("ESP "..(espOn and "ATIVADO" or "DESATIVADO"))
end)

BtnRGBESP.MouseButton1Click:Connect(function()
	rgbEspOn=not rgbEspOn
	BtnRGBESP.Text="⬡  RGB ESP: "..(rgbEspOn and "ON" or "OFF")
	SetBtn(BtnRGBESP,rgbEspOn)
	Notify("RGB ESP "..(rgbEspOn and "ATIVADO" or "DESATIVADO"))
end)

BtnRGBName.MouseButton1Click:Connect(function()
	rgbNameOn=not rgbNameOn
	BtnRGBName.Text="⬡  ESP NOME RGB: "..(rgbNameOn and "ON" or "OFF")
	SetBtn(BtnRGBName,rgbNameOn)
	if not rgbNameOn then
		for _,p in ipairs(Players:GetPlayers()) do
			if espNameCache[p] and espNameCache[p].Parent then
				local lbl=espNameCache[p]:FindFirstChildOfClass("TextLabel")
				if lbl then lbl.TextColor3=Color3.fromRGB(190,130,255) end
			end
		end
	end
	Notify("ESP NOME RGB "..(rgbNameOn and "ATIVADO" or "DESATIVADO"))
end)

HBoxToggle.MouseButton1Click:Connect(function()
	hitboxOn=not hitboxOn
	SetToggle(HBoxToggle,HBoxDot,hitboxOn)
	if not hitboxOn then restoreHitboxes() end
	Notify("HITBOX "..(hitboxOn and "ATIVADO" or "DESATIVADO"))
end)

HBoxRGBToggle.MouseButton1Click:Connect(function()
	rgbHitboxOn=not rgbHitboxOn
	SetToggle(HBoxRGBToggle,HBoxRGBDot,rgbHitboxOn)
	Notify("RGB BORDA "..(rgbHitboxOn and "ATIVADO" or "DESATIVADO"))
end)

TeamToggle.MouseButton1Click:Connect(function()
	ignoreTeam=not ignoreTeam
	SetToggle(TeamToggle,TeamDot,ignoreTeam)
	if not ignoreTeam and aimFixOn then lockedPlayer=nil end
	Notify("IGNORAR TIME "..(ignoreTeam and "ON" or "OFF"))
end)

TeamBtnRed.MouseButton1Click:Connect(function()
	mySelectedTeam="red"
	TeamBtnRedStroke.Color=Color3.fromRGB(229,72,72)
	TeamBtnRedStroke.Thickness=2.5
	TeamBtnBlueStroke.Color=Color3.fromRGB(20,60,100)
	TeamBtnBlueStroke.Thickness=1.5
	TeamBtnRed.BackgroundColor3=Color3.fromRGB(60,8,8)
	TeamBtnBlue.BackgroundColor3=Color3.fromRGB(5,15,40)
	Notify("TIME: VERMELHO SELECIONADO")
end)

TeamBtnBlue.MouseButton1Click:Connect(function()
	mySelectedTeam="blue"
	TeamBtnBlueStroke.Color=Color3.fromRGB(72,171,229)
	TeamBtnBlueStroke.Thickness=2.5
	TeamBtnRedStroke.Color=Color3.fromRGB(100,20,20)
	TeamBtnRedStroke.Thickness=1.5
	TeamBtnBlue.BackgroundColor3=Color3.fromRGB(8,25,60)
	TeamBtnRed.BackgroundColor3=Color3.fromRGB(40,5,5)
	Notify("TIME: AZUL SELECIONADO")
end)

WallToggle.MouseButton1Click:Connect(function()
	ignoreWall=not ignoreWall
	SetToggle(WallToggle,WallDot,ignoreWall)
	if not ignoreWall and aimFixOn then lockedPlayer=nil end
	Notify("IGNORAR PAREDE "..(ignoreWall and "ON" or "OFF"))
end)

local menuOpen=true
local function CloseMenu()
	menuOpen=false
	Tween(Panel,{Position=UDim2.new(0.5,-145,0.5,1200)},0.4)
	task.wait(0.35)
	Panel.Visible=false
	PopUp.Size=UDim2.new(0,0,0,28)
	PopUp.Visible=true
	Tween(PopUp,{Size=UDim2.new(0,54,0,28)},0.35)
end
local function OpenMenu()
	menuOpen=true
	Tween(PopUp,{Size=UDim2.new(0,0,0,28)},0.25)
	task.wait(0.22)
	PopUp.Visible=false
	Panel.Visible=true
	Tween(Panel,{Position=UDim2.new(0.5,-145,0.5,-240)},0.45)
end
CloseBtn.MouseButton1Click:Connect(function() task.spawn(CloseMenu) end)

local draggingFOV=false
SliderThumb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingFOV=true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingFOV=false end end)
UserInputService.InputChanged:Connect(function(i)
	if draggingFOV and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
		local x=math.clamp((i.Position.X-SliderTrack.AbsolutePosition.X)/SliderTrack.AbsoluteSize.X,0,1)
		SliderFill.Size=UDim2.new(x,0,1,0)
		SliderThumb.Position=UDim2.new(x,-7,0.5,-7)
		circleRadius=math.floor(x*1490+10)
		SliderLabel.Text="RAIO: "..circleRadius
		Circle.Size=UDim2.new(0,circleRadius*2,0,circleRadius*2)
		Circle.Position=UDim2.new(0.5,-circleRadius,0.5,-circleRadius)
	end
end)

local draggingHB=false
HBoxThumb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingHB=true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingHB=false end end)
UserInputService.InputChanged:Connect(function(i)
	if draggingHB and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
		local x=math.clamp((i.Position.X-HBoxTrack.AbsolutePosition.X)/HBoxTrack.AbsoluteSize.X,0,1)
		HBoxFill.Size=UDim2.new(x,0,1,0)
		HBoxThumb.Position=UDim2.new(x,-7,0.5,-7)
		hitboxSize=math.floor(x*59+1)
		HBoxLabel.Text="HITBOX: "..hitboxSize.."x"
	end
end)

local draggingPanel=false; local pDragStart,pStart=nil,nil
TopBar.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
		draggingPanel=true
		pDragStart=i.Position
		pStart=Panel.Position
	end
end)
UserInputService.InputChanged:Connect(function(i)
	if draggingPanel and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
		local d=i.Position-pDragStart
		Panel.Position=UDim2.new(pStart.X.Scale,pStart.X.Offset+d.X,pStart.Y.Scale,pStart.Y.Offset+d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then draggingPanel=false end
end)

local draggingPopUp=false; local puDragStart,puStart=nil,nil; local puMoved=false
PopUp.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
		draggingPopUp=true
		puMoved=false
		puDragStart=i.Position
		puStart=PopUp.Position
	end
end)
UserInputService.InputChanged:Connect(function(i)
	if draggingPopUp and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
		local d=i.Position-puDragStart
		if d.Magnitude>6 then puMoved=true end
		PopUp.Position=UDim2.new(puStart.X.Scale,puStart.X.Offset+d.X,puStart.Y.Scale,puStart.Y.Offset+d.Y)
	end
end)
UserInputService.InputEnded:Connect(function(i)
	if draggingPopUp and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then
		draggingPopUp=false
		if not puMoved then task.spawn(OpenMenu) end
	end
end)

local function onCharAdded(p,char)
	char:WaitForChild("HumanoidRootPart",5)
	if espCache[p] then espCache[p]:Destroy(); espCache[p]=nil end
	if espNameCache[p] then espNameCache[p]:Destroy(); espNameCache[p]=nil end
	removeHBVisual(p)
	hitboxOriginals[p]=nil
end

for _,p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then p.CharacterAdded:Connect(function(c) onCharAdded(p,c) end) end
end
Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c) onCharAdded(p,c) end)
end)
Players.PlayerRemoving:Connect(function(p)
	removeESP(p)
	removeHBVisual(p)
	hitboxOriginals[p]=nil
	if lockedPlayer==p then lockedPlayer=nil; LockFrame.Visible=false; resetCam() end
end)

RunService:BindToRenderStep("ZxAimFix",Enum.RenderPriority.Camera.Value+1,function()
	if not aimFixOn then return end
	local cam=workspace.CurrentCamera
	if not cam then return end
	local needsNew = not lockedPlayer or not GetCharacterFromWorkspace(lockedPlayer) or not GetCharacterFromWorkspace(lockedPlayer):FindFirstChildOfClass("Humanoid") or GetCharacterFromWorkspace(lockedPlayer):FindFirstChildOfClass("Humanoid").Health <= 0
	if needsNew then
		lockedPlayer = getClosest(cam)
		if lockedPlayer then Notify("FIXADO: "..lockedPlayer.Name) end
	end
	if lockedPlayer then
		local part = getTargetPart(lockedPlayer)
		if part and part.Parent then
			cam.CFrame = CFrame.new(cam.CFrame.Position, part.Position)
			local sp,on = cam:WorldToViewportPoint(part.Position)
			if on then
				Crosshair.Position = UDim2.new(0,sp.X-11,0,sp.Y-11)
				LockFrame.Position = UDim2.new(0,sp.X,0,sp.Y)
				LockFrame.Visible = true
			else
				LockFrame.Visible = false
				Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
			end
		else
			LockFrame.Visible = false
			Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
		end
	else
		LockFrame.Visible = false
		Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
	end
end)

RunService.RenderStepped:Connect(function()
	local t = tick()
	PStroke.Color = RGB(t)

	if aimOn and not aimFixOn then
		local cam = workspace.CurrentCamera
		if cam then
			local closest = getClosest(cam)
			if closest then
				local part = getTargetPart(closest)
				if part and part.Parent then
					local sp,on = cam:WorldToViewportPoint(part.Position)
					if on then
						Crosshair.Position = UDim2.new(0,sp.X-11,0,sp.Y-11)
						cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, part.Position), 0.2)
					end
				end
			else
				Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
			end
			if rgbCircleOn then
				CircleStroke.Color = RGB(t)
				CircleFill.BackgroundColor3 = RGB(t)
			else
				CircleStroke.Color = Color3.fromRGB(100,0,220)
				CircleFill.BackgroundColor3 = Color3.fromRGB(80,0,200)
			end
		end
	elseif not aimFixOn then
		Crosshair.Position = UDim2.new(0.5,-11,0.5,-11)
		LockFrame.Visible = false
	end

	if LockFrame.Visible then
		local pulse = 0.1 + math.abs(math.sin(t*4))*0.5
		for _,c in ipairs(LockFrame:GetChildren()) do
			if c:IsA("Frame") and c ~= LockDot then
				c.BackgroundTransparency = pulse
			end
		end
	end

	if rgbNameOn and espOn then
		local nc = RGB(t)
		for _,p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and espNameCache[p] and espNameCache[p].Parent then
				local lbl = espNameCache[p]:FindFirstChildOfClass("TextLabel")
				if lbl then lbl.TextColor3 = nc end
			end
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if hitboxOn then
		local t = tick()
		local bc = rgbHitboxOn and RGB(t) or Color3.fromRGB(120,0,255)
		local ns = math.max(hitboxSize*4, 1)
		for _,p in ipairs(Players:GetPlayers()) do
			if p == LocalPlayer then continue end
			local char = GetCharacterFromWorkspace(p)
			if char then
				local root = char:FindFirstChild("HumanoidRootPart")
				local hum = char:FindFirstChildOfClass("Humanoid")
				if root and hum then
					if not hitboxOriginals[p] then
						hitboxOriginals[p] = root.Size
					end
					root.Size = Vector3.new(ns,ns,ns)
					local sb = hitboxVisualCache[p]
					if not sb or not sb.Parent or sb.Adornee ~= root then
						if sb then sb:Destroy() end
						sb = Instance.new("SelectionBox")
						sb.LineThickness = 0.05
						sb.SurfaceTransparency = 1
						sb.SurfaceColor3 = Color3.new(0,0,0)
						sb.Adornee = root
						sb.Parent = workspace
						hitboxVisualCache[p] = sb
					end
					sb.Color3 = bc
				end
			end
		end
	end

	if not espOn then return end
	local t = tick()
	local ec = rgbEspOn and RGB(t) or Color3.fromRGB(110,0,220)
	for _,p in ipairs(Players:GetPlayers()) do
		if p == LocalPlayer then continue end
		local char = GetCharacterFromWorkspace(p)
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 then
				if not espCache[p] or not espCache[p].Parent then
					if espCache[p] then espCache[p]:Destroy() end
					local h = Instance.new("Highlight")
					h.FillColor = ec
					h.OutlineColor = Color3.fromRGB(190,130,255)
					h.FillTransparency = 0.5
					h.OutlineTransparency = 0.08
					h.Adornee = char
					h.Parent = char
					espCache[p] = h
				else
					espCache[p].FillColor = ec
				end
				if not espNameCache[p] or not espNameCache[p].Parent then
					createESPName(p)
				end
			else
				removeESP(p)
			end
		else
			removeESP(p)
		end
	end
end)

local smsgs={"[ CARREGANDO MÓDULOS ]","[ INICIANDO ESP ]","[ COMPILANDO MIRA ]","[ APLICANDO PATCHES ]","[ FINALIZANDO SISTEMA ]"}
task.spawn(function()
	for i=0,100 do
		LBFill.Size=UDim2.new(i/100,0,1,0)
		LPct.Text=i.."%"
		LCardStroke.Color=RGB(i*0.05)
		LSym.TextColor3=RGB(i*0.05)
		LStat.Text=smsgs[math.clamp(math.floor(i/21)+1,1,#smsgs)]
		task.wait(0.022)
	end
	Tween(LoadBG,{BackgroundTransparency=1},0.5)
	Tween(LCard,{BackgroundTransparency=1},0.4)
	Tween(LCardStroke,{Transparency=1},0.3)
	Tween(LTitle,{TextTransparency=1},0.3)
	Tween(LSub,{TextTransparency=1},0.3)
	Tween(LPct,{TextTransparency=1},0.3)
	Tween(LStat,{TextTransparency=1},0.3)
	Tween(LSym,{TextTransparency=1},0.3)
	Tween(LBFill,{BackgroundTransparency=1},0.3)
	Tween(LTopLine,{BackgroundTransparency=1},0.3)
	Tween(LBotLine,{BackgroundTransparency=1},0.3)
	Tween(GTop,{BackgroundTransparency=1},0.4)
	Tween(GBot,{BackgroundTransparency=1},0.4)
	task.wait(0.5)
	LoadBG:Destroy()
	Panel.Visible=true
	Tween(Panel,{Position=UDim2.new(0.5,-145,0.5,-240)},0.55)
	Notify("ZX CARREGADO!")
end)
