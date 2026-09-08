local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
repeat task.wait() until Players.LocalPlayer
local LP=Players.LocalPlayer
local function New(c,p)
local o=Instance.new(c)
for k,v in pairs(p or {}) do o[k]=v end
return o
end
local function Tween(o,p,d)
TS:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play()
end
local function RGB(t)
return Color3.fromRGB(math.floor(math.sin(t*1.8)*127+128),math.floor(math.sin(t*1.8+2.094)*127+128),math.floor(math.sin(t*1.8+4.189)*127+128))
end
local spyOn=true
local lastPkt=nil
local lastName="NENHUM"
local pktCount=0
local spamOn=false
local spamDelay=0.5
local autoLaunchOn=false
local cityEspOn=false
local playerEspOn=false
local flyOn=false
local flySpeed=80
local speedOn=false
local speedVal=32
local noclipOn=false
local jumpOn=false
local afkOn=true
local fbOn=false
local fpsOn=false
local origB=nil
local origC=nil
local flyBV=nil
local flyGyro=nil
local espCache={}
local function Char()
return LP.Character
end
local function Root(ch)
if not ch then return nil end
return ch:FindFirstChild("HumanoidRootPart")
end
local function NetEv()
local ok,r=pcall(function()
return game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable",5)
end)
if ok then return r end
return nil
end
local function Summ(v,d)
if d>2 then return type(v) end
local t=type(v)
if t=="table" then
local s="{"
local n=0
for k2,v2 in pairs(v) do
if n>5 then break end
s=s..tostring(k2).."="
if type(v2)=="Vector3" then s=s.."V3" end
if type(v2)=="CFrame" then s=s.."CF" end
if type(v2)=="Instance" then s=s..v2.ClassName..":"..v2.Name end
if type(v2)~="Vector3" and type(v2)~="CFrame" and type(v2)~="Instance" then s=s..tostring(v2):sub(1,24) end
s=s.." "
n=n+1
end
return s.."}"
elseif t=="Instance" then return v.ClassName..":"..v.Name
elseif t=="Vector3" then return "V3 "..math.floor(v.X)..","..math.floor(v.Y)..","..math.floor(v.Z) end
elseif t=="CFrame" then return "CF "..math.floor(v.Position.X)..","..math.floor(v.Position.Y)..","..math.floor(v.Position.Z) end
return tostring(v):sub(1,60)
end
SG=New("ScreenGui",{Name="ZxMissil",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(255,60,0),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX MISSIL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="MISSEIS VS CITYS",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(255,140,60),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(18,8,4),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(255,60,0),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,140,60),TextSize=12,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(12,5,2),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,540),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(255,60,0),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX MISSIL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(30,10,4),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,140,60),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"ATAQUE","ESP","PLAYER"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.31,0,0,28),Position=UDim2.new(0.015+(i-1)*0.328,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(40,14,4) or Color3.fromRGB(10,6,4),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(255,170,110) or Color3.fromRGB(140,120,110),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,3 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(255,60,0),CanvasSize=UDim2.new(0,0,0,800),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(40,14,4) or Color3.fromRGB(10,6,4)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,110,50),TextSize=10,Parent=f})
end
local function BigBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(10,6,4),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(50,25,10),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(225,205,190),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
Tween(b,{Size=UDim2.new(0.88,0,0,40)},0.08)
task.delay(0.09,function() pcall(function() Tween(b,{Size=UDim2.new(0.92,0,0,44)},0.16) end) end)
end)
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(40,14,4) or Color3.fromRGB(10,6,4)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(255,170,110) or Color3.fromRGB(225,205,190) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(10,6,4),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(215,195,180),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(140,50,0) or Color3.fromRGB(22,14,8),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(255,140,60) or Color3.fromRGB(95,80,65),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(140,50,0) or Color3.fromRGB(22,14,8)
dot.BackgroundColor3=st and Color3.fromRGB(255,140,60) or Color3.fromRGB(95,80,65)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(10,6,4),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(215,150,100),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(20,12,6),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(255,60,0),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),-9,0.5,-9),BackgroundColor3=Color3.fromRGB(255,140,60),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
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
thumb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
track.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true upd(i) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then upd(i) end end)
return outer
end
P1=Pages[1]
P2=Pages[2]
P3=Pages[3]
Section(P1,"LANCAMENTO")
BLaunch=BigBtn(P1,"AUTO LANCAR OFF")
MakeSlider(P1,"DELAY SPAM",0.1,5,0.5,function(v) spamDelay=v end)
BReplay=BigBtn(P1,"REPETIR ULTIMO")
BSpam=BigBtn(P1,"SPAM PACOTE OFF")
Section(P1,"SPY REDE")
TSpy,TSD=MakeRow(P1,"SPY BYTENET",true)
PktInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,60),BackgroundColor3=Color3.fromRGB(10,6,4),BorderSizePixel=0,Text="LANCE 1 MISSIL MANUAL",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(215,170,130),TextSize=11,TextWrapped=true,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=PktInfo})
Section(P2,"VISAO")
TCity,TCD=MakeRow(P2,"ESP CIDADE",false)
TPlay,TPD=MakeRow(P2,"ESP JOGADORES",false)
BBase=BigBtn(P2,"TP BASE INIMIGA")
BSilo=BigBtn(P2,"TP SILO")
Section(P3,"MOVIMENTO")
TFly,TFD=MakeRow(P3,"FLY",false)
MakeSlider(P3,"VEL FLY",10,300,80,function(v) flySpeed=v end)
TSpd,TSpdD=MakeRow(P3,"SPEED",false)
MakeSlider(P3,"VALOR SPEED",16,200,32,function(v) speedVal=v end)
TNoc,TND=MakeRow(P3,"NOCLIP",false)
TJump,TJD=MakeRow(P3,"PULO INFINITO",false)
Section(P3,"MUNDO")
TAfk,TAD=MakeRow(P3,"ANTI AFK",true)
TFb,TFD2=MakeRow(P3,"FULLBRIGHT",false)
TFps,TFD3=MakeRow(P3,"FPS BOOST",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(12,6,2),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,140,60),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local function SendPkt(args)
local ev=NetEv()
if not ev then return false end
local ok=false
pcall(function() ev:FireServer(unpack(args)) ok=true end)
return ok
end
local function Replay()
if not lastPkt then Notify("SEM PACOTE") return false end
return SendPkt(lastPkt)
end
BLaunch.MouseButton1Click:Connect(function()
autoLaunchOn=not autoLaunchOn
SetTxt(BLaunch,autoLaunchOn and "AUTO LANCAR ON" or "AUTO LANCAR OFF")
SetBtn(BLaunch,autoLaunchOn)
Notify(autoLaunchOn and "CHUVA LIGADA" or "CHUVA DESLIGADA")
end)
BReplay.MouseButton1Click:Connect(function()
if Replay() then Notify("PACOTE REPETIDO") else Notify("SEM PACOTE") end
end)
BSpam.MouseButton1Click:Connect(function()
spamOn=not spamOn
SetTxt(BSpam,spamOn and "SPAM PACOTE ON" or "SPAM PACOTE OFF")
SetBtn(BSpam,spamOn)
end)
TSpy.MouseButton1Click:Connect(function() spyOn=not spyOn SetTog(TSpy,TSD,spyOn) end)
TCity.MouseButton1Click:Connect(function()
cityEspOn=not cityEspOn
SetTog(TCity,TCD,cityEspOn)
if not cityEspOn then for p,_ in pairs(espCache) do pcall(function() espCache[p]:Destroy() end) end espCache={} end
end)
TPlay.MouseButton1Click:Connect(function() playerEspOn=not playerEspOn SetTog(TPlay,TPD,playerEspOn) end)
BBase.MouseButton1Click:Connect(function()
task.spawn(function()
local best=nil
local bd=99999
local lr=Root(Char())
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") then
local n=string.lower(v.Name)
if string.find(n,"city") or string.find(n,"base") or string.find(n,"enemy") or string.find(n,"hq") then
if lr then
local d=(lr.Position-v.Position).Magnitude
if d>200 and d<bd then bd=d best=v end
else best=v break end
end
end
end
if best and lr then lr.CFrame=best.CFrame+Vector3.new(0,10,0) Notify("TP BASE") else Notify("BASE NAO ACHADA") end
end)
end)
BSilo.MouseButton1Click:Connect(function()
task.spawn(function()
local best=nil
local bd=99999
local lr=Root(Char())
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") then
local n=string.lower(v.Name)
if string.find(n,"silo") or string.find(n,"launch") or string.find(n,"pad") then
if lr then
local d=(lr.Position-v.Position).Magnitude
if d<bd then bd=d best=v end
else best=v break end
end
end
end
if best and lr then lr.CFrame=best.CFrame+Vector3.new(0,8,0) Notify("TP SILO") else Notify("SILO NAO ACHADO") end
end)
end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFD,flyOn)
local ch=Char()
if ch then local r=Root(ch) if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
end)
TSpd.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpd,TSpdD,speedOn) if not speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TND,noclipOn) end)
TJump.MouseButton1Click:Connect(function() jumpOn=not jumpOn SetTog(TJump,TJD,jumpOn) end)
TAfk.MouseButton1Click:Connect(function() afkOn=not afkOn SetTog(TAfk,TAD,afkOn) end)
TFb.MouseButton1Click:Connect(function()
fbOn=not fbOn
SetTog(TFb,TFD2,fbOn)
if fbOn then origB=Lighting.Brightness origC=Lighting.ClockTime Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
else if origB then Lighting.Brightness=origB Lighting.ClockTime=origC Lighting.GlobalShadows=true end end
end)
TFps.MouseButton1Click:Connect(function()
fpsOn=not fpsOn
SetTog(TFps,TFD3,fpsOn)
if fpsOn then for _,v in pairs(workspace:GetDescendants()) do pcall(function() if v:IsA("BasePart") then v.Material=Enum.Material.SmoothPlastic v.CastShadow=false elseif v:IsA("ParticleEmitter") or v:IsA("Explosion") then v.Enabled=false end end) end Lighting.GlobalShadows=false end
end)
local function CloseMenu()
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,1200)},0.4)
task.wait(0.35)
Panel.Visible=false
Pop.Visible=true
end
local function OpenMenu()
Pop.Visible=false
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-260)},0.45)
end
CloseBtn.MouseButton1Click:Connect(function() task.spawn(CloseMenu) end)
local dragP=false
local dStart=nil
local pStart=nil
TopBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragP=true dStart=i.Position pStart=Panel.Position end end)
UIS.InputChanged:Connect(function(i) if dragP and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-dStart Panel.Position=UDim2.new(pStart.X.Scale,pStart.X.Offset+d.X,pStart.Y.Scale,pStart.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragP=false end end)
local dragPop=false
local ppStart=nil
local puStart=nil
local moved=false
Pop.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragPop=true moved=false ppStart=i.Position puStart=Pop.Position end end)
UIS.InputChanged:Connect(function(i) if dragPop and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-ppStart if d.Magnitude>6 then moved=true end Pop.Position=UDim2.new(puStart.X.Scale,puStart.X.Offset+d.X,puStart.Y.Scale,puStart.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if dragPop and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then dragPop=false if not moved then task.spawn(OpenMenu) end end end)
UIS.JumpRequest:Connect(function() if jumpOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end end)
task.spawn(function()
pcall(function()
local rs=game:GetService("ReplicatedStorage")
rs:WaitForChild("ByteNetReliable",10)
end)
pcall(function()
if getrawmetatable and newcclosure and getnamecallmethod and setreadonly then
local mt=getrawmetatable(game)
setreadonly(mt,false)
local old=mt.__namecall
mt.__namecall=newcclosure(function(self,...)
local m=""
pcall(function() m=getnamecallmethod() end)
if spyOn and self and self.Name=="ByteNetReliable" and (m=="FireServer" or m=="InvokeServer") then
local a={...}
lastPkt=a
pktCount=pktCount+1
lastName="PKT "..pktCount
pcall(function()
local s=""
for i,v in ipairs(a) do
if i>3 then break end
s=s..Summ(v,0).." "
end
PktInfo.Text="PKT "..pktCount.." "..s:sub(1,90)
end)
end
return old(self,...)
end)
setreadonly(mt,true)
end
end)
end)
task.spawn(function()
while task.wait(0.4) do
pcall(function()
if spamOn or autoLaunchOn then
Replay()
task.wait(spamDelay)
end
end)
end
end)
RS.Heartbeat:Connect(function()
if speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=speedVal end end end
if flyOn then
local ch=Char()
if ch then
local r=Root(ch)
local hum=ch:FindFirstChildOfClass("Humanoid")
if r and hum then
local vel=hum.MoveDirection*flySpeed
if UIS:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,flySpeed*0.7,0) end
if flyBV then flyBV.Velocity=vel end
if flyGyro then flyGyro.CFrame=workspace.CurrentCamera.CFrame end
end
end
end
if noclipOn then local ch=Char() if ch then for _,v in pairs(ch:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end end
if afkOn then pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(0.3) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0)) end) end
if cityEspOn then
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") or v:IsA("Model") then
local n=string.lower(v.Name)
if string.find(n,"city") or string.find(n,"silo") or string.find(n,"base") or string.find(n,"turret") then
local tgt=v
if v:IsA("Model") then tgt=v:FindFirstChildWhichIsA("BasePart",true) end
if tgt and not espCache[tgt] then
local h=Instance.new("Highlight")
h.FillColor=Color3.fromRGB(255,60,0)
h.FillTransparency=0.5
h.Adornee=v
h.Parent=v
espCache[tgt]=h
end
end
end
end
end
if playerEspOn then
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local ch=p.Character
if ch and not espCache[ch] then
local h=Instance.new("Highlight")
h.FillColor=Color3.fromRGB(255,60,0)
h.FillTransparency=0.5
h.Adornee=ch
h.Parent=ch
espCache[ch]=h
end
end
end
end
end)
RS.RenderStepped:Connect(function()
PStroke.Color=RGB(tick())
end)
task.spawn(function()
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LS.Color=RGB(i*0.05)
task.wait(0.012)
end
Tween(BG,{BackgroundTransparency=1},0.4)
task.wait(0.4)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-260)},0.5)
Notify("ZX MISSIL PRONTO LANCE 1 MANUAL")
end)
