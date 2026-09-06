local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
repeat task.wait() until Players.LocalPlayer
local LP=Players.LocalPlayer
local function RGB(t)
return Color3.fromRGB(math.floor(math.sin(t*1.8)*127+128),math.floor(math.sin(t*1.8+2.094)*127+128),math.floor(math.sin(t*1.8+4.189)*127+128))
end
local function New(c,p)
local o=Instance.new(c)
for k,v in pairs(p or {}) do o[k]=v end
return o
end
local function Tween(o,p,d)
TS:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play()
end
local function CD(c1,c2)
local dr=c1.R-c2.R
local dg=c1.G-c2.G
local db=c1.B-c2.B
return dr*dr+dg*dg+db*db
end
local TR=Color3.fromRGB(229,72,72)
local TB=Color3.fromRGB(72,171,229)
local TH=0.15
local function GetChar(plr)
local f=workspace:FindFirstChild("Players")
if f then
local m=f:FindFirstChild(plr.Name)
if m then return m end
end
return plr.Character
end
local function TeamColor(char)
if not char then return nil end
local n=char:FindFirstChild("Nametag")
if not n then return nil end
local l=n:FindFirstChild("Player")
if not l then return nil end
if l:IsA("TextLabel") then return l.TextColor3 end
if l:IsA("ImageLabel") then return l.ImageColor3 end
if l:IsA("Frame") then return l.BackgroundColor3 end
return nil
end
local function ClassTeam(c)
if not c then return nil end
if CD(c,TR)<TH then return "red" end
if CD(c,TB)<TH then return "blue" end
return nil
end
local myTeam=nil
local autoTeam=true
local function SameTeam(pb)
if not myTeam then return false end
local cb=GetChar(pb)
local nb=TeamColor(cb)
if not nb then return false end
local tb=ClassTeam(nb)
if not tb then return false end
return myTeam==tb
end
local SG=New("ScreenGui",{Name="ZxDestruction",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
local BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
local LCard=New("Frame",{Size=UDim2.new(0,310,0,220),Position=UDim2.new(0.5,-155,0.5,-110),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
local LS=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Transparency=0.15,Parent=LCard})
local LSym=New("TextLabel",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=26,ZIndex=13,Parent=LCard})
local LTitle=New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,50),BackgroundTransparency=1,Text="ZX DESTRUCTION V2",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=19,ZIndex=13,Parent=LCard})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,80,255)),ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}),Parent=LTitle})
local LSub=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,80),BackgroundTransparency=1,Text="OTIMIZADO PARA CELULAR",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(100,60,180),TextSize=10,ZIndex=13,Parent=LCard})
local LBTrack=New("Frame",{Size=UDim2.new(0.82,0,0,4),Position=UDim2.new(0.09,0,0,112),BackgroundColor3=Color3.fromRGB(8,5,15),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
local LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(120,0,255),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(100,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,210,255))}),Parent=LBFill})
local LPct=New("TextLabel",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,0,124),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=12,ZIndex=13,Parent=LCard})
local LStat=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,148),BackgroundTransparency=1,Text="CARREGANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,45,110),TextSize=10,ZIndex=13,Parent=LCard})
local aimOn=false
local aimFixOn=false
local rgbCircleOn=false
local showFov=true
local espOn=false
local boxEspOn=true
local nameEspOn=true
local distEspOn=true
local hpEspOn=true
local tracerOn=false
local rgbEspOn=false
local rgbNameOn=false
local enemyOnly=true
local hitboxOn=false
local hitboxSize=1
local rgbHitboxOn=false
local ignoreTeam=true
local ignoreWall=false
local checkFov=true
local stickyLock=true
local targetMode="Near"
local circleRadius=120
local smoothVal=20
local predVal=0
local maxDist=1500
local espTrans=0.5
local espMaxDist=1500
local espColor=Color3.fromRGB(110,0,220)
local nameSize=13
local flyOn=false
local flySpeed=50
local speedOn=false
local speedVal=24
local jumpPower=50
local infJumpOn=false
local noclipOn=false
local antiAfkOn=false
local fullbrightOn=false
local fpsBoostOn=false
local camFov=70
local spinOn=false
local spinSpeed=20
local antiVoidOn=false
local showCross=true
local rgbCross=false
local showDot=true
local crossSize=22
local rgbLock=false
local lockSize=52
local panelTrans=0
local showFps=true
local showNotif=true
local showAimBtn=true
local stealthOn=false
local lockedPlayer=nil
local aimPart="Head"
local partMap={Cabeca="Head",Pescoco="Neck",Peito="UpperTorso",Barriga="LowerTorso",Braco="RightUpperArm",Perna="RightUpperLeg",Pe="RightFoot",Root="HumanoidRootPart"}
local espCache={}
local espNameCache={}
local tracerCache={}
local hitboxOrig={}
local hitboxVis={}
local flyUp=false
local flyDown=false
local flyBV=nil
local flyGyro=nil
local origLight={}
local Circle=nil
local CircleStroke=nil
local CircleFill=nil
local Cross=nil
local CH1=nil
local CH2=nil
local CDot=nil
local LockF=nil
local lockBars={}
local LockDot=nil
local HBLab=nil
local FpsLab=nil
local TracerHold=nil
local AimBtn=nil
local Pop=nil
local Panel=nil
local Nh=New("Frame",{Size=UDim2.new(0,270,0,320),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local Nlist={}
local function Notify(txt)
if not showNotif then return end
if #Nlist>=4 then
local old=Nlist[1]
table.remove(Nlist,1)
pcall(function() old:Destroy() end)
end
local n=New("Frame",{Size=UDim2.new(1,0,0,44),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Parent=Nh})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("UIStroke",{Color=Color3.fromRGB(110,0,230),Thickness=1.3,Parent=n})
local ac=New("Frame",{Size=UDim2.new(0,3,0.6,0),Position=UDim2.new(0,0,0.2,0),BackgroundColor3=Color3.fromRGB(140,0,255),BorderSizePixel=0,Parent=n})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=ac})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,180,255))}),Rotation=90,Parent=ac})
New("TextLabel",{Size=UDim2.new(0,28,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=11,Parent=n})
New("TextLabel",{Size=UDim2.new(1,-42,1,0),Position=UDim2.new(0,38,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
Tween(n,{Position=UDim2.new(0,0,1 - (#Nlist+1)*0.17,0)},0.35)
table.insert(Nlist,n)
task.delay(2.6,function()
pcall(function()
Tween(n,{Position=UDim2.new(0,0,1.6,0)},0.3)
task.wait(0.3)
n:Destroy()
end)
for i,v in ipairs(Nlist) do
if v==n then table.remove(Nlist,i) break end
end
end)
end
local function AutoDetect(silent)
local ch=GetChar(LP)
local c=TeamColor(ch)
local t=nil
if c then t=ClassTeam(c) end
if not t then
pcall(function()
local tm=LP.Team
if tm then
local nm=string.lower(tm.Name)
if string.find(nm,"red") or string.find(nm,"verm") or string.find(nm,"terror") then t="red" end
if string.find(nm,"blue") or string.find(nm,"azul") or string.find(nm,"counter") then t="blue" end
end
end)
end
if not t then
pcall(function()
local tc=LP.TeamColor
if tc then
if tc.Color==BrickColor.new("Bright red").Color then t="red" end
if tc.Color==BrickColor.new("Bright blue").Color then t="blue" end
end
end)
end
if t and myTeam~=t then
myTeam=t
if not silent then Notify(t=="red" and "TIME AUTO VERMELHO" or "TIME AUTO AZUL") end
return true
end
return false
end
Panel=New("Frame",{Size=UDim2.new(0,335,0,540),Position=UDim2.new(0.5,-167,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
local PStroke=New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.8,Transparency=0.15,Parent=Panel})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(8,4,18)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Rotation=135,Parent=Panel})
local PAcc=New("Frame",{Size=UDim2.new(0.5,0,0,2),Position=UDim2.new(0.25,0,0,0),BackgroundColor3=Color3.fromRGB(140,0,255),BorderSizePixel=0,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=PAcc})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,0,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,180,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,0,255))}),Parent=PAcc})
local TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(12,5,28)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0))}),Rotation=90,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(0,28,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=15,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-110,1,0),Position=UDim2.new(0,40,0,0),BackgroundTransparency=1,Text="ZX DESTRUCTION",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
local MinBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-78,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="-",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=16,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=MinBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1.2,Parent=MinBtn})
local CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1.2,Parent=CloseBtn})
local TabBar=New("Frame",{Size=UDim2.new(1,0,0,38),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
local TabBtns={}
local Pages={}
local tabNames={"LUTA","VISUAL","PLAYER","CONFIG"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.23,0,0,30),Position=UDim2.new(0.015 + (i-1)*0.247,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(22,0,44) or Color3.fromRGB(8,5,15),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(200,140,255) or Color3.fromRGB(120,110,140),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
New("UIStroke",{Color=i==1 and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50),Thickness=1.2,Parent=b})
TabBtns[i]=b
end
for i=1,4 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-96),Position=UDim2.new(0,0,0,96),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(120,0,240),ScrollBarImageTransparency=0.3,CanvasSize=UDim2.new(0,0,0,0),ScrollingDirection=Enum.ScrollingDirection.Y,ElasticBehavior=Enum.ElasticBehavior.Never,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,12),PaddingLeft=UDim.new(0,0),PaddingRight=UDim.new(0,0),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16)
end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(22,0,44) or Color3.fromRGB(8,5,15)
b.TextColor3=on and Color3.fromRGB(200,140,255) or Color3.fromRGB(120,110,140)
local st=b:FindFirstChildOfClass("UIStroke")
if st then st.Color=on and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50) end
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do
b.MouseButton1Click:Connect(function() SelectTab(i) end)
end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,LayoutOrder=0,Parent=parent})
New("Frame",{Size=UDim2.new(0.28,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=Color3.fromRGB(50,30,80),BackgroundTransparency=0.3,BorderSizePixel=0,Parent=f})
New("Frame",{Size=UDim2.new(0.28,0,0,1),Position=UDim2.new(0.72,0,0.5,0),BackgroundColor3=Color3.fromRGB(50,30,80),BackgroundTransparency=0.3,BorderSizePixel=0,Parent=f})
New("TextLabel",{Size=UDim2.new(0.44,0,1,0),Position=UDim2.new(0.28,0,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,80,160),TextSize=10,Parent=f})
end
local function MakeBtn(parent,txt,active)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,42),BackgroundColor3=active and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=active and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50),Thickness=1.2,Parent=b})
New("TextLabel",{Name="Ico",Size=UDim2.new(0,26,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=active and Color3.fromRGB(160,0,255) or Color3.fromRGB(70,50,100),TextSize=10,Parent=b})
New("TextLabel",{Name="Txt",Size=UDim2.new(1,-36,1,0),Position=UDim2.new(0,32,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=active and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12)
local t=b:FindFirstChild("Txt")
local ic=b:FindFirstChild("Ico")
if t then t.TextColor3=st and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175) end
if ic then ic.TextColor3=st and Color3.fromRGB(160,0,255) or Color3.fromRGB(70,50,100) end
local s=b:FindFirstChildOfClass("UIStroke")
if s then s.Color=st and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50) end
end
local function SetTxt(b,txt)
local t=b:FindFirstChild("Txt")
if t then t.Text=txt end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=r})
New("Frame",{Size=UDim2.new(0,3,0.6,0),Position=UDim2.new(0,0,0.2,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(170,150,210),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(40,0,80) or Color3.fromRGB(15,10,28),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
New("UIStroke",{Color=def and Color3.fromRGB(120,0,220) or Color3.fromRGB(70,0,150),Thickness=1,Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(160,80,255) or Color3.fromRGB(60,40,90),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(40,0,80) or Color3.fromRGB(15,10,28)
dot.BackgroundColor3=st and Color3.fromRGB(160,80,255) or Color3.fromRGB(60,40,90)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
local s=tog:FindFirstChildOfClass("UIStroke")
if s then s.Color=st and Color3.fromRGB(120,0,220) or Color3.fromRGB(70,0,150) end
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
New("UIStroke",{Color=Color3.fromRGB(30,20,50),Thickness=1,Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(130,100,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(80,0,180)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),-9,0.5,-9),BackgroundColor3=Color3.fromRGB(160,80,255),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=thumb})
local drag=false
local function upd(inp)
local x=math.clamp((inp.Position.X-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
fill.Size=UDim2.new(x,0,1,0)
thumb.Position=UDim2.new(x,-9,0.5,-9)
local v=minv+(maxv-minv)*x
if maxv>100 then v=math.floor(v) else v=math.floor(v*10)/10 end
lab.Text=title.." "..v
cb(v)
end
thumb.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end
end)
track.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true upd(i) end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)
UIS.InputChanged:Connect(function(i)
if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then upd(i) end
end)
return outer
end
local P1=Pages[1]
local P2=Pages[2]
local P3=Pages[3]
local P4=Pages[4]
Section(P1,"MIRA PRINCIPAL")
local BAim=MakeBtn(P1,"MIRA OFF",false)
local BFix=MakeBtn(P1,"AIMBOT FIX OFF",false)
local BCircle=MakeBtn(P1,"RGB CIRCULO OFF",false)
Section(P1,"AJUSTES DE MIRA")
MakeSlider(P1,"RAIO FOV",10,800,120,function(v) circleRadius=v Circle.Size=UDim2.new(0,v*2,0,v*2) Circle.Position=UDim2.new(0.5,-v,0.5,-v) end)
MakeSlider(P1,"SUAVIDADE",1,100,20,function(v) smoothVal=v end)
MakeSlider(P1,"PREDICAO",0,50,0,function(v) predVal=v/10 end)
MakeSlider(P1,"DIST MAX MIRA",100,5000,1500,function(v) maxDist=v end)
Section(P1,"PARTE DO ALVO")
local cbList={}
local cbFrames={}
local function RefreshCB()
for lbl,fr in pairs(cbFrames) do
local on=(lbl==aimPart)
fr.BackgroundColor3=on and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12)
local st=fr:FindFirstChildOfClass("UIStroke")
if st then st.Color=on and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50) end
local tx=fr:FindFirstChild("Txt")
if tx then tx.TextColor3=on and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175) end
end
end
local parts={"Head","Pescoco","Peito","Barriga","Braco","Perna","Pe","Root"}
for _,pn in ipairs(parts) do
local b=MakeBtn(P1,pn:upper(),pn=="Head")
cbFrames[pn]=b
b.MouseButton1Click:Connect(function()
aimPart=pn
RefreshCB()
Notify("ALVO "..pn:upper())
end)
end
Section(P1,"FILTROS DESTRUCTION")
local TFov,TDFov=MakeRow(P1,"CHECAR FOV",true)
local TSticky,TDSticky=MakeRow(P1,"STICKY LOCK",true)
local TShowFov,TDShowFov=MakeRow(P1,"MOSTRAR FOV",true)
local TTeam,TDTeam=MakeRow(P1,"IGNORAR TIME",true)
local TWall,TDWall=MakeRow(P1,"WALLCHECK",false)
local TMode,TDMode=MakeRow(P1,"ALVO MENOR HP",false)
local TFloat,DFTFloat=MakeRow(P1,"BOTAO AIM FLUTUANTE",true)
Section(P2,"ESP MASTER")
local BEsp=MakeBtn(P2,"ESP OFF",false)
local BRgbEsp=MakeBtn(P2,"RGB ESP OFF",false)
local BRgbName=MakeBtn(P2,"NOME RGB OFF",false)
Section(P2,"TIPOS DE ESP")
local TBox,TDBox=MakeRow(P2,"BOX CHAMS",true)
local TName,TDName=MakeRow(P2,"NOME",true)
local TDist,TDDist=MakeRow(P2,"DISTANCIA",true)
local THp,TDHp=MakeRow(P2,"BARRA DE VIDA",true)
local TTrace,TDTrace=MakeRow(P2,"TRACER LINHA",false)
local TEnemy,TDEnemy=MakeRow(P2,"APENAS INIMIGOS",true)
Section(P2,"AJUSTES ESP")
MakeSlider(P2,"TRANSPARENCIA",0,90,50,function(v) espTrans=v/100 end)
MakeSlider(P2,"DIST MAX ESP",100,5000,1500,function(v) espMaxDist=v end)
MakeSlider(P2,"TAMANHO NOME",10,20,13,function(v) nameSize=v end)
Section(P2,"COR DO ESP")
local colorRow=New("Frame",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=P2})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=colorRow})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=colorRow})
local cols={Color3.fromRGB(110,0,220),Color3.fromRGB(255,0,80),Color3.fromRGB(0,210,255),Color3.fromRGB(0,255,140),Color3.fromRGB(255,200,0),Color3.fromRGB(255,255,255)}
for i,c in ipairs(cols) do
local cb=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(0,10+(i-1)*36,0.5,-15),BackgroundColor3=c,BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=colorRow})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=cb})
cb.MouseButton1Click:Connect(function() espColor=c rgbEspOn=false SetBtn(BRgbEsp,false) SetTxt(BRgbEsp,"RGB ESP OFF") Notify("COR ESP ALTERADA") end)
end
Section(P3,"HITBOX")
local HBRowT,HBRowD=MakeRow(P3,"HITBOX",false)
MakeSlider(P3,"TAMANHO HITBOX",1,20,1,function(v) hitboxSize=v HBLab.Text="HITBOX "..v.."x" end)
HBLab=New("TextLabel",{Size=UDim2.new(0.92,0,0,18),BackgroundTransparency=1,Text="HITBOX 1x",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(130,90,210),TextSize=11,Parent=P3})
local HRgb,HRgbD=MakeRow(P3,"RGB BORDA HITBOX",false)
Section(P3,"MOVIMENTO CELULAR")
local TFly,TFlyD=MakeRow(P3,"FLY",false)
MakeSlider(P3,"VEL FLY",10,200,50,function(v) flySpeed=v end)
local FlyCtr=New("Frame",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=P3})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=FlyCtr})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=FlyCtr})
local BUp=New("TextButton",{Size=UDim2.new(0.46,0,0,30),Position=UDim2.new(0.02,0,0.5,-15),BackgroundColor3=Color3.fromRGB(22,0,44),BorderSizePixel=0,Text="SUBIR",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,AutoButtonColor=false,Parent=FlyCtr})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BUp})
local BDown=New("TextButton",{Size=UDim2.new(0.46,0,0,30),Position=UDim2.new(0.52,0,0.5,-15),BackgroundColor3=Color3.fromRGB(22,0,44),BorderSizePixel=0,Text="DESCER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,AutoButtonColor=false,Parent=FlyCtr})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BDown})
local TSpeed,TSpeedD=MakeRow(P3,"SPEED",false)
MakeSlider(P3,"VALOR SPEED",16,150,24,function(v) speedVal=v end)
local TInf,TInfD=MakeRow(P3,"PULO INFINITO",false)
MakeSlider(P3,"FORCA PULO",20,200,50,function(v) jumpPower=v local ch=LP.Character if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.JumpPower=v end end end)
local TNoc,TNocD=MakeRow(P3,"NOCLIP",false)
local TSpin,TSpinD=MakeRow(P3,"SPIN",false)
MakeSlider(P3,"VEL SPIN",5,100,20,function(v) spinSpeed=v end)
Section(P3,"MUNDO")
local TAfk,TAfkD=MakeRow(P3,"ANTI AFK",false)
local TFb,TFbD=MakeRow(P3,"FULLBRIGHT",false)
local TFps,TFpsD=MakeRow(P3,"FPS BOOST",false)
MakeSlider(P3,"FOV CAMERA",40,120,70,function(v) camFov=v local c=workspace.CurrentCamera if c then c.FieldOfView=v end end)
local TVoid,TVoidD=MakeRow(P3,"ANTI VOID",false)
Section(P4,"MEU TIME AUTO")
local TAuto,TDAuto=MakeRow(P4,"AUTO DETECT TIME",true)
local TeamRow=New("Frame",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=P4})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=TeamRow})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=TeamRow})
local TRed=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.02,0,0.5,-15),BackgroundColor3=Color3.fromRGB(35,5,5),BorderSizePixel=0,Text="VERMELHO",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(229,72,72),TextSize=10,AutoButtonColor=false,Parent=TeamRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=TRed})
local TBlue=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.35,0,0.5,-15),BackgroundColor3=Color3.fromRGB(5,12,35),BorderSizePixel=0,Text="AZUL",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(72,171,229),TextSize=10,AutoButtonColor=false,Parent=TeamRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=TBlue})
local TClear=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.68,0,0.5,-15),BackgroundColor3=Color3.fromRGB(12,12,18),BorderSizePixel=0,Text="LIMPAR",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,160,170),TextSize=10,AutoButtonColor=false,Parent=TeamRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=TClear})
Section(P4,"MIRA TELA")
local TCross,TCrossD=MakeRow(P4,"CROSSHAIR",true)
local TRgbC,TRgbCD=MakeRow(P4,"RGB CROSSHAIR",false)
local TDot,TDotD=MakeRow(P4,"PONTO CENTRAL",true)
MakeSlider(P4,"TAM CROSS",10,50,22,function(v) crossSize=v Cross.Size=UDim2.new(0,v,0,v) Cross.Position=UDim2.new(0.5,-v/2,0.5,-v/2) end)
local TRgbL,TRgbLD=MakeRow(P4,"RGB LOCK",false)
MakeSlider(P4,"TAM LOCK",30,120,52,function(v) lockSize=v LockF.Size=UDim2.new(0,v,0,v) end)
Section(P4,"PAINEL CELULAR")
MakeSlider(P4,"TRANS PAINEL",0,60,0,function(v) panelTrans=v/100 Panel.BackgroundTransparency=v/100 TopBar.BackgroundTransparency=v/100 end)
local SizeRow=New("Frame",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=P4})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=SizeRow})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=SizeRow})
local BS=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.02,0,0.5,-15),BackgroundColor3=Color3.fromRGB(15,8,30),BorderSizePixel=0,Text="PEQUENO",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=9,AutoButtonColor=false,Parent=SizeRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BS})
local BM=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.35,0,0.5,-15),BackgroundColor3=Color3.fromRGB(15,8,30),BorderSizePixel=0,Text="NORMAL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=9,AutoButtonColor=false,Parent=SizeRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BM})
local BL=New("TextButton",{Size=UDim2.new(0.3,0,0,30),Position=UDim2.new(0.68,0,0.5,-15),BackgroundColor3=Color3.fromRGB(15,8,30),BorderSizePixel=0,Text="GRANDE",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=9,AutoButtonColor=false,Parent=SizeRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BL})
local TFpsShow,TFpsShowD=MakeRow(P4,"MOSTRAR FPS",true)
local TNotif,TNotifD=MakeRow(P4,"NOTIFICACOES",true)
local TStealth,TStealthD=MakeRow(P4,"STEALTH",false)
local BKeys=MakeBtn(P4,"ALTERAR TECLAS",false)
local BReset=MakeBtn(P4,"RESETAR TUDO",false)
Circle=New("Frame",{Size=UDim2.new(0,240,0,240),Position=UDim2.new(0.5,-120,0.5,-120),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=Circle})
CircleStroke=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Transparency=0.25,Parent=Circle})
CircleFill=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(80,0,200),BackgroundTransparency=0.95,BorderSizePixel=0,Parent=Circle})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CircleFill})
Cross=New("Frame",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0.5,-11,0.5,-11),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
CH1=New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Cross})
CH2=New("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Cross})
CDot=New("Frame",{Size=UDim2.new(0,3,0,3),Position=UDim2.new(0.5,-1,0.5,-1),BackgroundColor3=Color3.fromRGB(180,80,255),BorderSizePixel=0,Parent=Cross})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CDot})
LockF=New("Frame",{Size=UDim2.new(0,52,0,52),Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=SG})
lockBars={}
local function CP(x,y,w,h,fx)
local a=New("Frame",{Size=UDim2.new(0,w,0,1),Position=UDim2.new(x,fx and -w or 0,y,0),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockF})
local b=New("Frame",{Size=UDim2.new(0,1,0,h),Position=UDim2.new(x,fx and -1 or 0,y,0),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockF})
table.insert(lockBars,a)
table.insert(lockBars,b)
end
local function CPB(x,y,w,h,fx)
local a=New("Frame",{Size=UDim2.new(0,w,0,1),Position=UDim2.new(x,fx and -w or 0,y,-1),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockF})
local b=New("Frame",{Size=UDim2.new(0,1,0,h),Position=UDim2.new(x,fx and -1 or 0,y,-h),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockF})
table.insert(lockBars,a)
table.insert(lockBars,b)
end
CP(0,0,11,11,false)
CP(1,0,11,11,true)
CPB(0,1,11,11,false)
CPB(1,1,11,11,true)
LockDot=New("Frame",{Size=UDim2.new(0,4,0,4),Position=UDim2.new(0.5,-2,0.5,-2),BackgroundColor3=Color3.fromRGB(0,210,255),BorderSizePixel=0,Parent=LockF})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=LockDot})
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.3,Parent=Pop})
AimBtn=New("TextButton",{Size=UDim2.new(0,64,0,64),Position=UDim2.new(1,-84,0.62,0),BackgroundColor3=Color3.fromRGB(8,2,18),BackgroundTransparency=0.25,BorderSizePixel=0,Text="AIM",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,100,255),TextSize=13,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=AimBtn})
New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=2,Transparency=0.2,Parent=AimBtn})
FpsLab=New("TextLabel",{Size=UDim2.new(0,170,0,22),Position=UDim2.new(0,8,0,8),BackgroundColor3=Color3.fromRGB(4,2,10),BackgroundTransparency=0.3,BorderSizePixel=0,Text="FPS 0 PING 0",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=11,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=FpsLab})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1,Parent=FpsLab})
TracerHold=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Parent=SG})
local function getPart(plr)
if not plr then return nil end
local ch=GetChar(plr)
if not ch then return nil end
local want=partMap[aimPart] or "Head"
local p=ch:FindFirstChild(want)
if p then return p end
return ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
end
local function Visible(root)
local cam=workspace.CurrentCamera
if not cam then return false end
local org=cam.CFrame.Position
local dir=root.Position-org
local pr=RaycastParams.new()
pr.FilterType=Enum.RaycastFilterType.Exclude
local lc=LP.Character
if lc then pr.FilterDescendantsInstances={lc} else pr.FilterDescendantsInstances={} end
local r=workspace:Raycast(org,dir,pr)
if not r then return true end
if r.Instance then
local m=r.Instance:FindFirstAncestorOfClass("Model")
if m and root.Parent and m==root.Parent then return true end
end
return false
end
local function Closest(cam)
local best=nil
local bd=math.huge
local bdHp=math.huge
local center=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
for _,plr in ipairs(Players:GetPlayers()) do
if plr==LP then continue end
local ch=GetChar(plr)
if not ch then continue end
local hum=ch:FindFirstChildOfClass("Humanoid")
local root=ch:FindFirstChild("HumanoidRootPart")
if not (hum and hum.Health>0 and root) then continue end
if ignoreTeam and SameTeam(plr) then continue end
if enemyOnly and SameTeam(plr) and myTeam then continue end
if ignoreWall and not Visible(root) then continue end
local d=(root.Position-cam.CFrame.Position).Magnitude
if d>maxDist then continue end
local sp,on=cam:WorldToViewportPoint(root.Position)
if not on then continue end
local sd=(Vector2.new(sp.X,sp.Y)-center).Magnitude
if checkFov and sd>circleRadius then continue end
if targetMode=="Hp" then
if hum.Health<bdHp then bdHp=hum.Health best=plr bd=sd end
else
if sd<bd then bd=sd best=plr end
end
end
return best
end
local function resetCam()
local cam=workspace.CurrentCamera
if cam then cam.CameraType=Enum.CameraType.Custom end
end
local function remName(p)
if espNameCache[p] then pcall(function() espNameCache[p]:Destroy() end) espNameCache[p]=nil end
end
local function remEsp(p)
if espCache[p] then pcall(function() espCache[p]:Destroy() end) espCache[p]=nil end
remName(p)
end
local function remTrace(p)
if tracerCache[p] then pcall(function() tracerCache[p]:Destroy() end) tracerCache[p]=nil end
end
local function remHbV(p)
if hitboxVis[p] then pcall(function() hitboxVis[p]:Destroy() end) hitboxVis[p]=nil end
end
local function restoreHb()
for p,sz in pairs(hitboxOrig) do
if p~=LP then
local ch=GetChar(p)
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r and sz then pcall(function() r.Size=sz end) end end
end
remHbV(p)
end
hitboxOrig={}
for _,sb in pairs(hitboxVis) do pcall(function() sb:Destroy() end) end
hitboxVis={}
end
local function makeName(p)
local ch=GetChar(p)
if not ch then return end
local root=ch:FindFirstChild("HumanoidRootPart")
if not root then return end
remName(p)
local bb=Instance.new("BillboardGui")
bb.Size=UDim2.new(0,140,0,40)
bb.StudsOffset=Vector3.new(0,3.6,0)
bb.AlwaysOnTop=true
bb.Adornee=root
bb.Parent=root
local tl=New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=p.Name,Font=Enum.Font.GothamBold,TextColor3=rgbNameOn and RGB(tick()) or Color3.fromRGB(190,130,255),TextSize=nameSize,TextStrokeTransparency=0.3,TextStrokeColor3=Color3.new(0,0,0),Parent=bb})
espNameCache[p]=bb
end
local stealthHide={}
local function SetStealth(st)
stealthOn=st
if st then
stealthHide={}
local tg={Panel,Pop,AimBtn,Circle,Cross,LockF,Nh,FpsLab}
for _,v in ipairs(tg) do stealthHide[v]=v.Visible v.Visible=false end
else
for v,vs in pairs(stealthHide) do pcall(function() v.Visible=vs end) end
stealthHide={}
end
end
BAim.MouseButton1Click:Connect(function()
aimOn=not aimOn
SetTxt(BAim,aimOn and "MIRA ON" or "MIRA OFF")
SetBtn(BAim,aimOn)
Circle.Visible=aimOn and showFov
if not aimOn then resetCam() end
Notify(aimOn and "MIRA ATIVADA" or "MIRA DESATIVADA")
end)
BFix.MouseButton1Click:Connect(function()
aimFixOn=not aimFixOn
SetTxt(BFix,aimFixOn and "AIMBOT FIX ON" or "AIMBOT FIX OFF")
SetBtn(BFix,aimFixOn)
AimBtn.BackgroundColor3=aimFixOn and Color3.fromRGB(40,0,80) or Color3.fromRGB(8,2,18)
if not aimFixOn then lockedPlayer=nil LockF.Visible=false resetCam() end
Notify(aimFixOn and "FIX ATIVADO" or "FIX DESATIVADO")
end)
BCircle.MouseButton1Click:Connect(function()
rgbCircleOn=not rgbCircleOn
SetTxt(BCircle,rgbCircleOn and "RGB CIRCULO ON" or "RGB CIRCULO OFF")
SetBtn(BCircle,rgbCircleOn)
Notify("RGB CIRCULO "..(rgbCircleOn and "ON" or "OFF"))
end)
AimBtn.MouseButton1Click:Connect(function()
aimFixOn=not aimFixOn
SetTxt(BFix,aimFixOn and "AIMBOT FIX ON" or "AIMBOT FIX OFF")
SetBtn(BFix,aimFixOn)
AimBtn.BackgroundColor3=aimFixOn and Color3.fromRGB(40,0,80) or Color3.fromRGB(8,2,18)
if not aimFixOn then lockedPlayer=nil LockF.Visible=false resetCam() else Notify("FIXADO PELO BOTAO") end
Notify(aimFixOn and "FIX ON" or "FIX OFF")
end)
BEsp.MouseButton1Click:Connect(function()
espOn=not espOn
SetTxt(BEsp,espOn and "ESP ON" or "ESP OFF")
SetBtn(BEsp,espOn)
if not espOn then for _,p in ipairs(Players:GetPlayers()) do remEsp(p) remTrace(p) end espCache={} end
Notify("ESP "..(espOn and "ON" or "OFF"))
end)
BRgbEsp.MouseButton1Click:Connect(function()
rgbEspOn=not rgbEspOn
SetTxt(BRgbEsp,rgbEspOn and "RGB ESP ON" or "RGB ESP OFF")
SetBtn(BRgbEsp,rgbEspOn)
Notify("RGB ESP "..(rgbEspOn and "ON" or "OFF"))
end)
BRgbName.MouseButton1Click:Connect(function()
rgbNameOn=not rgbNameOn
SetTxt(BRgbName,rgbNameOn and "NOME RGB ON" or "NOME RGB OFF")
SetBtn(BRgbName,rgbNameOn)
Notify("NOME RGB "..(rgbNameOn and "ON" or "OFF"))
end)
TFov.MouseButton1Click:Connect(function() checkFov=not checkFov SetTog(TFov,TDFov,checkFov) Notify("CHECAR FOV "..(checkFov and "ON" or "OFF")) end)
TSticky.MouseButton1Click:Connect(function() stickyLock=not stickyLock SetTog(TSticky,TDSticky,stickyLock) if not stickyLock then lockedPlayer=nil end Notify("STICKY "..(stickyLock and "ON" or "OFF")) end)
TShowFov.MouseButton1Click:Connect(function() showFov=not showFov SetTog(TShowFov,TDShowFov,showFov) Circle.Visible=aimOn and showFov Notify("FOV VISIVEL "..(showFov and "ON" or "OFF")) end)
TTeam.MouseButton1Click:Connect(function() ignoreTeam=not ignoreTeam SetTog(TTeam,TDTeam,ignoreTeam) Notify("IGNORAR TIME "..(ignoreTeam and "ON" or "OFF")) end)
TWall.MouseButton1Click:Connect(function() ignoreWall=not ignoreWall SetTog(TWall,TDWall,ignoreWall) Notify("WALLCHECK "..(ignoreWall and "ON" or "OFF")) end)
TMode.MouseButton1Click:Connect(function()
if targetMode=="Near" then targetMode="Hp" else targetMode="Near" end
SetTog(TMode,TDMode,targetMode=="Hp")
Notify("MODO "..targetMode)
end)
TFloat.MouseButton1Click:Connect(function() showAimBtn=not showAimBtn SetTog(TFloat,DFTFloat,showAimBtn) AimBtn.Visible=showAimBtn and Panel.Visible==false Notify("BOTAO AIM "..(showAimBtn and "ON" or "OFF")) end)
TBox.MouseButton1Click:Connect(function() boxEspOn=not boxEspOn SetTog(TBox,TDBox,boxEspOn) Notify("BOX "..(boxEspOn and "ON" or "OFF")) end)
TName.MouseButton1Click:Connect(function() nameEspOn=not nameEspOn SetTog(TName,TDName,nameEspOn) if not nameEspOn then for _,p in ipairs(Players:GetPlayers()) do remName(p) end end Notify("NOME "..(nameEspOn and "ON" or "OFF")) end)
TDist.MouseButton1Click:Connect(function() distEspOn=not distEspOn SetTog(TDist,TDDist,distEspOn) Notify("DISTANCIA "..(distEspOn and "ON" or "OFF")) end)
THp.MouseButton1Click:Connect(function() hpEspOn=not hpEspOn SetTog(THp,TDHp,hpEspOn) Notify("VIDA "..(hpEspOn and "ON" or "OFF")) end)
TTrace.MouseButton1Click:Connect(function() tracerOn=not tracerOn SetTog(TTrace,TDTrace,tracerOn) if not tracerOn then for _,p in ipairs(Players:GetPlayers()) do remTrace(p) end end Notify("TRACER "..(tracerOn and "ON" or "OFF")) end)
TEnemy.MouseButton1Click:Connect(function() enemyOnly=not enemyOnly SetTog(TEnemy,TDEnemy,enemyOnly) Notify("SOMENTE INIMIGOS "..(enemyOnly and "ON" or "OFF")) end)
HBRowT.MouseButton1Click:Connect(function() hitboxOn=not hitboxOn SetTog(HBRowT,HBRowD,hitboxOn) if not hitboxOn then restoreHb() end Notify("HITBOX "..(hitboxOn and "ON" or "OFF")) end)
HRgb.MouseButton1Click:Connect(function() rgbHitboxOn=not rgbHitboxOn SetTog(HRgb,HRgbD,rgbHitboxOn) Notify("RGB HITBOX "..(rgbHitboxOn and "ON" or "OFF")) end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFlyD,flyOn)
local ch=LP.Character
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
Notify("FLY "..(flyOn and "ON" or "OFF"))
end)
BUp.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then flyUp=true end end)
BUp.InputEnded:Connect(function(i) flyUp=false end)
BDown.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then flyDown=true end end)
BDown.InputEnded:Connect(function(i) flyDown=false end)
TSpeed.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpeed,TSpeedD,speedOn) if not speedOn then local ch=LP.Character if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end Notify("SPEED "..(speedOn and "ON" or "OFF")) end)
TInf.MouseButton1Click:Connect(function() infJumpOn=not infJumpOn SetTog(TInf,TInfD,infJumpOn) Notify("PULO INF "..(infJumpOn and "ON" or "OFF")) end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TNocD,noclipOn) Notify("NOCLIP "..(noclipOn and "ON" or "OFF")) end)
TSpin.MouseButton1Click:Connect(function() spinOn=not spinOn SetTog(TSpin,TSpinD,spinOn) Notify("SPIN "..(spinOn and "ON" or "OFF")) end)
TAfk.MouseButton1Click:Connect(function() antiAfkOn=not antiAfkOn SetTog(TAfk,TAfkD,antiAfkOn) Notify("ANTI AFK "..(antiAfkOn and "ON" or "OFF")) end)
TFb.MouseButton1Click:Connect(function()
fullbrightOn=not fullbrightOn SetTog(TFb,TFbD,fullbrightOn)
if fullbrightOn then origLight={B=Lighting.Brightness,C=Lighting.ClockTime,F=Lighting.FogEnd,G=Lighting.GlobalShadows,A=Lighting.OutdoorAmbient} Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.FogEnd=100000 Lighting.GlobalShadows=false Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
else if origLight.B then Lighting.Brightness=origLight.B Lighting.ClockTime=origLight.C Lighting.FogEnd=origLight.F Lighting.GlobalShadows=origLight.G Lighting.OutdoorAmbient=origLight.A end end
Notify("FULLBRIGHT "..(fullbrightOn and "ON" or "OFF"))
end)
TFps.MouseButton1Click:Connect(function()
fpsBoostOn=not fpsBoostOn SetTog(TFps,TFpsD,fpsBoostOn)
if fpsBoostOn then for _,v in pairs(workspace:GetDescendants()) do pcall(function() if v:IsA("BasePart") then v.Material=Enum.Material.SmoothPlastic v.Reflectance=0 v.CastShadow=false elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1 elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled=false end end) end Lighting.GlobalShadows=false end
Notify("FPS BOOST "..(fpsBoostOn and "ON" or "OFF"))
end)
TVoid.MouseButton1Click:Connect(function() antiVoidOn=not antiVoidOn SetTog(TVoid,TVoidD,antiVoidOn) Notify("ANTI VOID "..(antiVoidOn and "ON" or "OFF")) end)
TAuto.MouseButton1Click:Connect(function() autoTeam=not autoTeam SetTog(TAuto,TDAuto,autoTeam) if autoTeam then AutoDetect(false) else Notify("AUTO TIME OFF") end end)
TRed.MouseButton1Click:Connect(function() autoTeam=false SetTog(TAuto,TDAuto,false) myTeam="red" Notify("TIME VERMELHO MANUAL") end)
TBlue.MouseButton1Click:Connect(function() autoTeam=false SetTog(TAuto,TDAuto,false) myTeam="blue" Notify("TIME AZUL MANUAL") end)
TClear.MouseButton1Click:Connect(function() autoTeam=false SetTog(TAuto,TDAuto,false) myTeam=nil Notify("TIME LIMPO MANUAL") end)
TCross.MouseButton1Click:Connect(function() showCross=not showCross SetTog(TCross,TCrossD,showCross) Cross.Visible=showCross Notify("CROSSHAIR "..(showCross and "ON" or "OFF")) end)
TRgbC.MouseButton1Click:Connect(function() rgbCross=not rgbCross SetTog(TRgbC,TRgbCD,rgbCross) Notify("RGB CROSS "..(rgbCross and "ON" or "OFF")) end)
TDot.MouseButton1Click:Connect(function() showDot=not showDot SetTog(TDot,TDotD,showDot) CDot.Visible=showDot Notify("PONTO "..(showDot and "ON" or "OFF")) end)
TRgbL.MouseButton1Click:Connect(function() rgbLock=not rgbLock SetTog(TRgbL,TRgbLD,rgbLock) Notify("RGB LOCK "..(rgbLock and "ON" or "OFF")) end)
BS.MouseButton1Click:Connect(function() Panel.Size=UDim2.new(0,300,0,460) Notify("PAINEL PEQUENO") end)
BM.MouseButton1Click:Connect(function() Panel.Size=UDim2.new(0,335,0,540) Notify("PAINEL NORMAL") end)
BL.MouseButton1Click:Connect(function() Panel.Size=UDim2.new(0,370,0,600) Notify("PAINEL GRANDE") end)
TFpsShow.MouseButton1Click:Connect(function() showFps=not showFps SetTog(TFpsShow,TFpsShowD,showFps) FpsLab.Visible=showFps Notify("FPS LABEL "..(showFps and "ON" or "OFF")) end)
TNotif.MouseButton1Click:Connect(function() showNotif=not showNotif SetTog(TNotif,TNotifD,showNotif) end)
TStealth.MouseButton1Click:Connect(function() SetStealth(not stealthOn) SetTog(TStealth,TStealthD,stealthOn) end)
local function openKeys()
Notify("ABRINDO TECLAS")
task.spawn(function()
local ok,er=pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AnjoMetraton/Zx/main/keybind.lua"))() end)
if not ok then Notify("ERRO TECLAS") end
end)
end
BKeys.MouseButton1Click:Connect(openKeys)
BReset.MouseButton1Click:Connect(function()
aimOn=false aimFixOn=false espOn=false hitboxOn=false flyOn=false speedOn=false noclipOn=false spinOn=false tracerOn=false
SetTxt(BAim,"MIRA OFF") SetBtn(BAim,false)
SetTxt(BFix,"AIMBOT FIX OFF") SetBtn(BFix,false)
SetTxt(BEsp,"ESP OFF") SetBtn(BEsp,false)
Circle.Visible=false LockF.Visible=false
restoreHb()
for _,p in ipairs(Players:GetPlayers()) do remEsp(p) remTrace(p) end
if flyBV then pcall(function() flyBV:Destroy() end) flyBV=nil end
if flyGyro then pcall(function() flyGyro:Destroy() end) flyGyro=nil end
resetCam()
Notify("TUDO RESETADO")
end)
local menuOpen=true
local function CloseMenu()
menuOpen=false
Tween(Panel,{Position=UDim2.new(0.5,-167,0.5,1200)},0.4)
task.wait(0.35)
Panel.Visible=false
AimBtn.Visible=showAimBtn
Pop.Size=UDim2.new(0,0,0,30)
Pop.Visible=true
Tween(Pop,{Size=UDim2.new(0,58,0,30)},0.35)
end
local function OpenMenu()
menuOpen=true
Tween(Pop,{Size=UDim2.new(0,0,0,30)},0.25)
task.wait(0.22)
Pop.Visible=false
AimBtn.Visible=false
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-167,0.5,-270)},0.45)
end
CloseBtn.MouseButton1Click:Connect(function() task.spawn(CloseMenu) end)
MinBtn.MouseButton1Click:Connect(function() task.spawn(CloseMenu) end)
local dragP=false
local dStart=nil
local pStart=nil
TopBar.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragP=true dStart=i.Position pStart=Panel.Position end
end)
UIS.InputChanged:Connect(function(i)
if dragP and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
local d=i.Position-dStart
Panel.Position=UDim2.new(pStart.X.Scale,pStart.X.Offset+d.X,pStart.Y.Scale,pStart.Y.Offset+d.Y)
end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragP=false end
end)
local dragPop=false
local ppStart=nil
local puStart=nil
local moved=false
Pop.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragPop=true moved=false ppStart=i.Position puStart=Pop.Position end
end)
UIS.InputChanged:Connect(function(i)
if dragPop and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
local d=i.Position-ppStart
if d.Magnitude>6 then moved=true end
Pop.Position=UDim2.new(puStart.X.Scale,puStart.X.Offset+d.X,puStart.Y.Scale,puStart.Y.Offset+d.Y)
end
end)
UIS.InputEnded:Connect(function(i)
if dragPop and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then dragPop=false if not moved then task.spawn(OpenMenu) end end
end)
local dragAim=false
local paStart=nil
local aStart=nil
local aMoved=false
AimBtn.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragAim=true aMoved=false paStart=i.Position aStart=AimBtn.Position end
end)
UIS.InputChanged:Connect(function(i)
if dragAim and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
local d=i.Position-paStart
if d.Magnitude>12 then aMoved=true AimBtn.Position=UDim2.new(aStart.X.Scale,aStart.X.Offset+d.X,aStart.Y.Scale,aStart.Y.Offset+d.Y) end
end
end)
UIS.InputEnded:Connect(function(i)
if dragAim and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then
dragAim=false
if aMoved then return end
end
end)
UIS.JumpRequest:Connect(function()
if infJumpOn then local ch=LP.Character if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end
if flyOn and flyUp==false then flyUp=true task.delay(0.2,function() flyUp=false end) end
end)
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then p.CharacterAdded:Connect(function(c) c:WaitForChild("HumanoidRootPart",5) remEsp(p) remTrace(p) hitboxOrig[p]=nil end) end
end
LP.CharacterAdded:Connect(function(c) c:WaitForChild("HumanoidRootPart",5) task.wait(1) if autoTeam then AutoDetect(false) end end)
task.spawn(function()
while task.wait(2) do
if autoTeam then pcall(function() AutoDetect(true) end) end
end
end)
task.spawn(function()
task.wait(3)
if autoTeam then AutoDetect(false) end
end)
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) c:WaitForChild("HumanoidRootPart",5) remEsp(p) end) end)
Players.PlayerRemoving:Connect(function(p) remEsp(p) remTrace(p) remHbV(p) hitboxOrig[p]=nil if lockedPlayer==p then lockedPlayer=nil LockF.Visible=false resetCam() end end)
RS:BindToRenderStep("ZxFix",Enum.RenderPriority.Camera.Value+1,function()
if not aimFixOn then return end
local cam=workspace.CurrentCamera
if not cam then return end
local need=lockedPlayer==nil
if not need then
local ch=GetChar(lockedPlayer)
if not ch then need=true else local h=ch:FindFirstChildOfClass("Humanoid") if not h or h.Health<=0 then need=true end end
if not need and stickyLock==false then
local cur=Closest(cam)
if cur~=lockedPlayer then need=true end
end
end
if need then
local nl=Closest(cam)
if nl~=lockedPlayer and nl then Notify("TRAVADO "..nl.Name) end
lockedPlayer=nl
end
if lockedPlayer then
local pt=getPart(lockedPlayer)
if pt and pt.Parent then
local pp=pt.Position
if predVal>0 then
local ch=GetChar(lockedPlayer)
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r then pp=pp+r.Velocity*predVal end end
end
local sm=math.clamp(smoothVal,1,100)
local f=1 - (sm/105)
if f<0.05 then f=1 end
if f>=0.95 then cam.CFrame=CFrame.new(cam.CFrame.Position,pp)
else cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,pp),f) end
local sp,on=cam:WorldToViewportPoint(pp)
if on then Cross.Position=UDim2.new(0,sp.X-crossSize/2,0,sp.Y-crossSize/2) LockF.Position=UDim2.new(0,sp.X,0,sp.Y) LockF.Visible=true else LockF.Visible=false Cross.Position=UDim2.new(0.5,-crossSize/2,0.5,-crossSize/2) end
else LockF.Visible=false Cross.Position=UDim2.new(0.5,-crossSize/2,0.5,-crossSize/2) end
else LockF.Visible=false Cross.Position=UDim2.new(0.5,-crossSize/2,0.5,-crossSize/2) end
end)
RS.RenderStepped:Connect(function()
local t=tick()
PStroke.Color=RGB(t)
if rgbCircleOn then CircleStroke.Color=RGB(t) CircleFill.BackgroundColor3=RGB(t) else CircleStroke.Color=Color3.fromRGB(100,0,220) CircleFill.BackgroundColor3=Color3.fromRGB(80,0,200) end
if rgbCross then CH1.BackgroundColor3=RGB(t) CH2.BackgroundColor3=RGB(t) else CH1.BackgroundColor3=Color3.fromRGB(210,170,255) CH2.BackgroundColor3=Color3.fromRGB(210,170,255) end
if rgbLock then for _,b in ipairs(lockBars) do b.BackgroundColor3=RGB(t) end LockDot.BackgroundColor3=RGB(t) else for _,b in ipairs(lockBars) do b.BackgroundColor3=Color3.fromRGB(0,210,255) end LockDot.BackgroundColor3=Color3.fromRGB(0,210,255) end
Cross.Visible=showCross
CDot.Visible=showDot
if aimOn and not aimFixOn then
local cam=workspace.CurrentCamera
if cam then
local cl=Closest(cam)
if cl then
local pt=getPart(cl)
if pt and pt.Parent then
local pp=pt.Position
if predVal>0 then local ch=GetChar(cl) if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r then pp=pp+r.Velocity*predVal end end end
local sp,on=cam:WorldToViewportPoint(pp)
if on then
Cross.Position=UDim2.new(0,sp.X-crossSize/2,0,sp.Y-crossSize/2)
local sm=math.clamp(smoothVal,1,100)
local f=1 - (sm/120)
cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,pp),math.clamp(f,0.05,0.6))
end
end
else Cross.Position=UDim2.new(0.5,-crossSize/2,0.5,-crossSize/2) end
end
elseif not aimFixOn then Cross.Position=UDim2.new(0.5,-crossSize/2,0.5,-crossSize/2) LockF.Visible=false end
if LockF.Visible then
local pu=0.1+math.abs(math.sin(t*4))*0.5
for _,c in ipairs(LockF:GetChildren()) do if c:IsA("Frame") and c~=LockDot then c.BackgroundTransparency=pu end end
end
if rgbNameOn and espOn then
local nc=RGB(t)
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP and espNameCache[p] and espNameCache[p].Parent then
local bb=espNameCache[p]
for _,d in ipairs(bb:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=nc end end
end
end
end
if tracerOn and espOn then
local cam=workspace.CurrentCamera
if cam then
local bot=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y)
for _,p in ipairs(Players:GetPlayers()) do
if p==LP then continue end
local ch=GetChar(p)
if ch then
local hum=ch:FindFirstChildOfClass("Humanoid")
local root=ch:FindFirstChild("HumanoidRootPart")
if hum and hum.Health>0 and root then
local d=(root.Position-cam.CFrame.Position).Magnitude
if d>espMaxDist then remTrace(p) continue end
if enemyOnly and myTeam and SameTeam(p) then remTrace(p) continue end
local sp,on=cam:WorldToViewportPoint(root.Position)
if on then
local fr=tracerCache[p]
if not fr or not fr.Parent then
if fr then pcall(function() fr:Destroy() end) end
fr=New("Frame",{BackgroundColor3=rgbEspOn and RGB(t) or espColor,BorderSizePixel=0,AnchorPoint=Vector2.new(0.5,0.5),Parent=TracerHold})
tracerCache[p]=fr
end
fr.Visible=true
fr.BackgroundColor3=rgbEspOn and RGB(t) or espColor
local tp=Vector2.new(sp.X,sp.Y)
local mid=(bot+tp)/2
local ln=(bot-tp).Magnitude
fr.Size=UDim2.new(0,1.5,0,ln)
fr.Position=UDim2.new(0,mid.X,0,mid.Y)
fr.Rotation=math.deg(math.atan2(tp.Y-bot.Y,tp.X-bot.X))+90
else remTrace(p) end
else remTrace(p) end
else remTrace(p) end
end
end
end
end)
RS.Heartbeat:Connect(function(dt)
if antiVoidOn then
local ch=LP.Character
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r and r.Position.Y<-45 then r.CFrame=r.CFrame+Vector3.new(0,60,0) r.Velocity=Vector3.new(0,0,0) end end
end
if spinOn then
local ch=LP.Character
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r then r.CFrame=r.CFrame*CFrame.Angles(0,math.rad(spinSpeed),0) end end
end
if speedOn then
local ch=LP.Character
if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=speedVal end end
end
if flyOn then
local ch=LP.Character
if ch then
local r=ch:FindFirstChild("HumanoidRootPart")
local hum=ch:FindFirstChildOfClass("Humanoid")
if r and hum then
local cam=workspace.CurrentCamera
local mv=hum.MoveDirection
local vel=Vector3.new(0,0,0)
if cam then
local cf=cam.CFrame
vel=mv*flySpeed
if flyUp then vel=vel+Vector3.new(0,flySpeed,0) end
if flyDown then vel=vel+Vector3.new(0,-flySpeed,0) end
if UIS:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,flySpeed*0.7,0) end
if flyBV then flyBV.Velocity=vel end
if flyGyro then flyGyro.CFrame=cf end
end
end
end
end
if noclipOn then
local ch=LP.Character
if ch then for _,v in pairs(ch:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
end
if antiAfkOn then pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(0.2) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0)) end) end
if hitboxOn then
local t=tick()
local bc=rgbHitboxOn and RGB(t) or Color3.fromRGB(120,0,255)
local ns=math.max(hitboxSize*3.5,1)
for _,p in ipairs(Players:GetPlayers()) do
if p==LP then continue end
if ignoreTeam and SameTeam(p) then continue end
local ch=GetChar(p)
if ch then
local root=ch:FindFirstChild("HumanoidRootPart")
local hum=ch:FindFirstChildOfClass("Humanoid")
if root and hum and hum.Health>0 then
if not hitboxOrig[p] then hitboxOrig[p]=root.Size end
pcall(function() root.Size=Vector3.new(ns,ns,ns) end)
local sb=hitboxVis[p]
if not sb or not sb.Parent or sb.Adornee~=root then
if sb then pcall(function() sb:Destroy() end) end
sb=Instance.new("SelectionBox")
sb.LineThickness=0.05
sb.SurfaceTransparency=1
sb.SurfaceColor3=Color3.new(0,0,0)
sb.Adornee=root
sb.Parent=workspace
hitboxVis[p]=sb
end
sb.Color3=bc
end
end
end
end
if not espOn then return end
local t2=tick()
local ec=rgbEspOn and RGB(t2) or espColor
for _,p in ipairs(Players:GetPlayers()) do
if p==LP then continue end
if enemyOnly and myTeam and SameTeam(p) then remEsp(p) continue end
local ch=GetChar(p)
if ch then
local hum=ch:FindFirstChildOfClass("Humanoid")
local root=ch:FindFirstChild("HumanoidRootPart")
if hum and hum.Health>0 and root then
local d=(root.Position-workspace.CurrentCamera.CFrame.Position).Magnitude
if d>espMaxDist then remEsp(p) continue end
if boxEspOn then
if not espCache[p] or not espCache[p].Parent then
if espCache[p] then pcall(function() espCache[p]:Destroy() end) end
local h=Instance.new("Highlight")
h.FillColor=ec
h.OutlineColor=Color3.fromRGB(190,130,255)
h.FillTransparency=espTrans
h.OutlineTransparency=0.08
h.Adornee=ch
h.Parent=ch
espCache[p]=h
else espCache[p].FillColor=ec espCache[p].FillTransparency=espTrans end
else if espCache[p] then remEsp(p) end end
if nameEspOn then
if not espNameCache[p] or not espNameCache[p].Parent then makeName(p) end
local bb=espNameCache[p]
if bb then
for _,dsc in ipairs(bb:GetDescendants()) do
if dsc:IsA("TextLabel") then
dsc.TextSize=nameSize
if not rgbNameOn then dsc.TextColor3=Color3.fromRGB(190,130,255) end
local txt=p.Name
if distEspOn then txt=txt.." "..math.floor(d).."m" end
if hpEspOn then txt=txt.." "..math.floor(hum.Health).."HP" end
dsc.Text=txt
end
end
end
else remName(p) end
else remEsp(p) end
else remEsp(p) end
end
end)
local fpsC=0
local fpsT=0
RS.Heartbeat:Connect(function(d)
fpsC=fpsC+1
fpsT=fpsT+d
if fpsT>=0.5 then
local f=math.floor(fpsC/fpsT+0.5)
local ping=0
pcall(function() ping=math.floor(LP:GetNetworkPing()*1000) end)
FpsLab.Text="FPS "..f.." PING "..ping
FpsLab.Visible=showFps
fpsC=0
fpsT=0
end
end)
local function match(b,inp)
if not b then return false end
if b.type=="key" and inp.KeyCode==b.input then return true end
if b.type=="mouse" and inp.UserInputType==b.input then return true end
return false
end
UIS.InputBegan:Connect(function(inp,gp)
local isM=inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.MouseButton2 or inp.UserInputType==Enum.UserInputType.MouseButton3
if gp and not isM then return end
local kb=_G.ZxKeybindings
if not kb then return end
if match(kb["Mira (Aim)"],inp) then aimOn=not aimOn SetTxt(BAim,aimOn and "MIRA ON" or "MIRA OFF") SetBtn(BAim,aimOn) Circle.Visible=aimOn and showFov if not aimOn then resetCam() end Notify("MIRA "..(aimOn and "ON" or "OFF"))
elseif match(kb["Aimbot Fix"],inp) then aimFixOn=not aimFixOn SetTxt(BFix,aimFixOn and "AIMBOT FIX ON" or "AIMBOT FIX OFF") SetBtn(BFix,aimFixOn) if not aimFixOn then lockedPlayer=nil LockF.Visible=false resetCam() end Notify("FIX "..(aimFixOn and "ON" or "OFF"))
elseif match(kb["ESP"],inp) then espOn=not espOn SetTxt(BEsp,espOn and "ESP ON" or "ESP OFF") SetBtn(BEsp,espOn) if not espOn then for _,p in ipairs(Players:GetPlayers()) do remEsp(p) end end Notify("ESP "..(espOn and "ON" or "OFF"))
elseif match(kb["RGB ESP"],inp) then rgbEspOn=not rgbEspOn SetTxt(BRgbEsp,rgbEspOn and "RGB ESP ON" or "RGB ESP OFF") SetBtn(BRgbEsp,rgbEspOn)
elseif match(kb["RGB Círculo"],inp) then rgbCircleOn=not rgbCircleOn SetTxt(BCircle,rgbCircleOn and "RGB CIRCULO ON" or "RGB CIRCULO OFF") SetBtn(BCircle,rgbCircleOn)
elseif match(kb["Hitbox"],inp) then hitboxOn=not hitboxOn SetTog(HBRowT,HBRowD,hitboxOn) if not hitboxOn then restoreHb() end Notify("HITBOX "..(hitboxOn and "ON" or "OFF"))
elseif match(kb["Ignorar Time"],inp) then ignoreTeam=not ignoreTeam SetTog(TTeam,TDTeam,ignoreTeam)
elseif match(kb["Ignorar Parede"],inp) then ignoreWall=not ignoreWall SetTog(TWall,TDWall,ignoreWall)
elseif match(kb["Stealth"],inp) then SetStealth(not stealthOn) SetTog(TStealth,TStealthD,stealthOn) end
end)
local msgs={"CARREGANDO MODULOS","INICIANDO ESP","OTIMIZANDO MIRA","PATCH DESTRUCTION","FINALIZANDO"}
task.spawn(function()
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LS.Color=RGB(i*0.05)
LSym.TextColor3=RGB(i*0.05)
LStat.Text=msgs[math.clamp(math.floor(i/21)+1,1,#msgs)]
task.wait(0.018)
end
Tween(BG,{BackgroundTransparency=1},0.5)
Tween(LCard,{BackgroundTransparency=1},0.4)
task.wait(0.5)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-167,0.5,-270)},0.55)
Notify("ZX DESTRUCTION CARREGADO")
end)
