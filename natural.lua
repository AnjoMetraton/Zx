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
local function Notify(txt)
pcall(function()
local sg=LP:WaitForChild("PlayerGui"):FindFirstChild("ZxNatural")
local h=sg and sg:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(2,12,10),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
local CTRL_ON=false
local MODE="CIMA"
local CTRL_DIST=10
local CTRL_MAX=28
local SEL=1
local SELX=0
local SELY=0
local SELZ=0
local VOID_ON=true
local speedOn=false
local speedVal=30
local flyOn=false
local flySpeed=70
local noclipOn=false
local afkOn=true
local fbOn=false
local blocks={}
local lastPos={}
local lastT={}
local voidBusy=false
local flyBV=nil
local flyGyro=nil
local origB=nil
local origC=nil
local function Char()
return LP.Character
end
local function Root(ch)
if not ch then return nil end
return ch:FindFirstChild("HumanoidRootPart")
end
local function IsCharPart(p)
local m=nil
pcall(function() m=p:FindFirstAncestorOfClass("Model") end)
if m then
local h=nil
pcall(function() h=m:FindFirstChildOfClass("Humanoid") end)
if h then return true end
end
return false
end
local function ValidBlock(p,hrp)
if not p:IsA("BasePart") then return false end
if p.Anchored then return false end
if p:IsA("Terrain") then return false end
if IsCharPart(p) then return false end
local s=p.Size
if s.Magnitude>45 or s.Magnitude<0.5 then return false end
if not p.Parent then return false end
return true
end
local function Build()
local n=#blocks
for i,b in ipairs(blocks) do
local off=CFrame.new(0,8,0)
if MODE=="CIMA" then
local a=(i-1)/math.max(n,1)*math.pi*2
local ring=math.floor((i-1)/8)
local rad=4.5+ring*2.5+CTRL_DIST*0.25
off=CFrame.new(math.cos(a)*rad,7+ring*1.6+CTRL_DIST*0.25,math.sin(a)*rad)
elseif MODE=="ASA" then
local side=1
if i%2==0 then side=-1 end
local row=math.floor((i-1)/2)
local spread=3.2+row*1.1+CTRL_DIST*0.12
off=CFrame.new(side*spread,2.6+row*0.95,-2.6-row*0.45)
elseif MODE=="CASA" then
local w=(i-1)%4
local lvl=math.floor((i-1)/4)%3
local d=math.max(4.2,CTRL_DIST*0.5)
if w==0 then off=CFrame.new(-d,1.2+lvl*2.2,0) end
if w==1 then off=CFrame.new(d,1.2+lvl*2.2,0) end
if w==2 then off=CFrame.new(0,1.2+lvl*2.2,-d) end
if w==3 then off=CFrame.new(0,7.6,d*0.55) end
else
local col=(i-1)%5
local row2=math.floor((i-1)/5)
off=CFrame.new((col-2)*3,6.5+row2*1.6,0)
if i==SEL then off=off*CFrame.new(SELX,SELY,SELZ) end
end
b.off=off
end
end
local function Refresh()
local hrp=Root(Char())
if not hrp then return end
local found={}
local n=0
for _,v in ipairs(workspace:GetDescendants()) do
if n%700==0 then task.wait() end
n=n+1
if v:IsA("BasePart") and not v.Anchored and not IsCharPart(v) then
local s=v.Size
if s.Magnitude<=45 and s.Magnitude>=0.5 and v.Parent then
local d=99999
pcall(function() d=(hrp.Position-v.Position).Magnitude end)
if d<220 then table.insert(found,{p=v,d=d}) end
end
end
end
table.sort(found,function(a,b) return a.d<b.d end)
blocks={}
for i=1,math.min(CTRL_MAX,#found) do blocks[i]={p=found[i].p,off=CFrame.new(0,8,0)} end
if SEL>#blocks then SEL=1 end
Build()
end
local function Build()
local n=#blocks
for i,b in ipairs(blocks) do
local off=CFrame.new(0,8,0)
if MODE=="CIMA" then
local a=(i-1)/math.max(n,1)*math.pi*2
local ring=math.floor((i-1)/8)
local rad=4.5+ring*2.5+CTRL_DIST*0.25
off=CFrame.new(math.cos(a)*rad,7+ring*1.6+CTRL_DIST*0.25,math.sin(a)*rad)
elseif MODE=="ASA" then
local side=1
if i%2==0 then side=-1 end
local row=math.floor((i-1)/2)
local spread=3.2+row*1.1+CTRL_DIST*0.12
off=CFrame.new(side*spread,2.6+row*0.95,-2.6-row*0.45)
elseif MODE=="CASA" then
local w=(i-1)%4
local lvl=math.floor((i-1)/4)%3
local d=math.max(4.2,CTRL_DIST*0.5)
if w==0 then off=CFrame.new(-d,1.2+lvl*2.2,0) end
if w==1 then off=CFrame.new(d,1.2+lvl*2.2,0) end
if w==2 then off=CFrame.new(0,1.2+lvl*2.2,-d) end
if w==3 then off=CFrame.new(0,7.6,d*0.55) end
else
local col=(i-1)%5
local row2=math.floor((i-1)/5)
off=CFrame.new((col-2)*3,6.5+row2*1.6,0)
if i==SEL then off=off*CFrame.new(SELX,SELY,SELZ) end
end
b.off=off
end
end
local function ScoreAttacker(p,hrp,now)
local ch=p.Character
if not ch then return 0,false end
local r=Root(ch)
local h=ch:FindFirstChildOfClass("Humanoid")
if not r or not h or h.Health<=0 then return 0,false end
local d=(hrp.Position-r.Position).Magnitude
if d>16 then return 0,false end
local toHim=r.Position-hrp.Position
local back=hrp.CFrame.LookVector
local behind=false
if toHim.Magnitude>0.5 then
local dot=toHim.Unit:Dot(back)
if dot<-0.25 then behind=true end
end
if not behind then return 0,false end
local score=0
local lp=lastPos[p.Name]
local lt=lastT[p.Name] or 0
local dt=now-lt
if lp and dt>0.05 and dt<1 then
local jump=(r.Position-lp).Magnitude
local spd=jump/dt
if jump>25 then score=score+3 end
if spd>55 then score=score+2 end
end
pcall(function() if h.WalkSpeed>30 then score=score+1 end end)
local tool=nil
pcall(function() tool=ch:FindFirstChildOfClass("Tool") end)
if tool then
local tn=string.lower(tool.Name)
if string.find(tn,"bang") or string.find(tn,"gun") or string.find(tn,"kill") or string.find(tn,"shoot") then score=score+2 end
end
local aim=false
pcall(function()
local dir=r.CFrame.LookVector
local toMe=(hrp.Position-r.Position).Unit
if dir:Dot(toMe)>0.9 then aim=true end
end)
if aim then score=score+1 end
return score,true
end
local function VoidHop(who)
if voidBusy then return end
voidBusy=true
task.spawn(function()
local ch=Char()
local r=Root(ch)
local cam=workspace.CurrentCamera
if not r or not cam then voidBusy=false return end
local home=nil
pcall(function() home=r.CFrame end)
local camHome=nil
pcall(function() camHome=cam.CFrame end)
pcall(function() cam.CameraType=Enum.CameraType.Scriptable end)
pcall(function() cam.CFrame=camHome end)
pcall(function() r.CFrame=CFrame.new(home.X,-380,home.Z) end)
pcall(function() r.Velocity=Vector3.new(0,0,0) end)
Notify("VOID "..who)
local t0=tick()
while tick()-t0<2.2 do
task.wait(0.2)
local gone=true
pcall(function()
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local c2=p.Character
local r2=c2 and c2:FindFirstChild("HumanoidRootPart")
if r2 and (r2.Position-Vector3.new(home.X,home.Y,home.Z)).Magnitude<18 then gone=false end
end
end
end)
if gone then break end
end
pcall(function() r.CFrame=home end)
pcall(function() r.Velocity=Vector3.new(0,0,0) end)
pcall(function() cam.CameraType=Enum.CameraType.Custom end)
voidBusy=false
end)
end
SG=New("ScreenGui",{Name="ZxNatural",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,160),Position=UDim2.new(0.5,-150,0.5,-80),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(0,200,160),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX NATURAL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="BLOCOS VOID SOBREVIVER",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(110,220,190),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,76),BackgroundColor3=Color3.fromRGB(4,16,13),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(0,200,160),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,90),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,220,190),TextSize=12,ZIndex=13,Parent=LCard})
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(0,200,160),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX NATURAL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(3,26,21),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,220,190),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
Scroll=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-52),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(0,200,160),CanvasSize=UDim2.new(0,0,0,900),ScrollingDirection=Enum.ScrollingDirection.Y,Parent=Panel})
Lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=Scroll})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=Scroll})
Lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Scroll.CanvasSize=UDim2.new(0,0,0,Lay.AbsoluteContentSize.Y+16) end)
local function Section(txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=Scroll})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(90,180,155),TextSize=10,Parent=f})
end
local function BigBtn(txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(10,45,38),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(205,230,222),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
Tween(b,{Size=UDim2.new(0.88,0,0,40)},0.08)
task.delay(0.09,function() pcall(function() Tween(b,{Size=UDim2.new(0.92,0,0,44)},0.16) end) end)
end)
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(5,35,29) or Color3.fromRGB(3,11,9)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(140,255,225) or Color3.fromRGB(205,230,222) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(195,225,215),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(0,130,105) or Color3.fromRGB(9,18,15),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(140,255,225) or Color3.fromRGB(70,100,90),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(0,130,105) or Color3.fromRGB(9,18,15)
dot.BackgroundColor3=st and Color3.fromRGB(140,255,225) or Color3.fromRGB(70,100,90)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
Section("BLOCOS")
BCtrl=BigBtn("CONTROLE OFF")
BMode=BigBtn("MODO CIMA")
BScan=BigBtn("BUSCAR BLOCOS")
DistLab=New("TextLabel",{Size=UDim2.new(0.92,0,0,24),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="DIST 10",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,210,195),TextSize=11,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=DistLab})
DistRow=New("Frame",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=Scroll})
BDM=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="DIST MENOS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=DistRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BDM})
BDP=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0.52,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="DIST MAIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=DistRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BDP})
Section("DESENHO BLOCO A BLOCO")
SelLab=New("TextLabel",{Size=UDim2.new(0.92,0,0,24),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="BLOCO 1",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,210,195),TextSize=11,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=SelLab})
SelRow=New("Frame",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=Scroll})
BSM=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="ANT",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=SelRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BSM})
BSP=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0.52,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="PROX",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=SelRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BSP})
XRow=New("Frame",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=Scroll})
BXM=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="X MENOS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=XRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BXM})
BXP=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0.52,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="X MAIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=XRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BXP})
YRow=New("Frame",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=Scroll})
BYM=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="Y MENOS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=YRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BYM})
BYP=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0.52,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="Y MAIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=YRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BYP})
ZRow=New("Frame",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=Scroll})
BZM=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="Z MENOS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=ZRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BZM})
BZP=New("TextButton",{Size=UDim2.new(0.48,0,0,34),Position=UDim2.new(0.52,0,0,3),BackgroundColor3=Color3.fromRGB(3,11,9),BorderSizePixel=0,Text="Z MAIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,AutoButtonColor=false,Parent=ZRow})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=BZP})
Section("ANTI BANG")
TVoid,TVoidD=MakeRow("VOID FALSO",true)
Section("RITMO")
TSpd,TSpdD=MakeRow("SPEED",false)
TFly,TFD=MakeRow("FLY",false)
TNoc,TND=MakeRow("NOCLIP",false)
TAfk,TAD=MakeRow("ANTI AFK",true)
TFb,TFD2=MakeRow("FULLBRIGHT",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(2,12,10),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,255,225),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local flyBV=nil
local flyGyro=nil
local speedVal=30
local flySpeed=70
BCtrl.MouseButton1Click:Connect(function()
CTRL_ON=not CTRL_ON
SetTxt(BCtrl,CTRL_ON and "CONTROLE ON" or "CONTROLE OFF")
SetBtn(BCtrl,CTRL_ON)
if CTRL_ON then task.spawn(function() Refresh() Notify("BLOCOS "..#blocks) end) end
end)
BMode.MouseButton1Click:Connect(function()
local nx="CIMA"
if MODE=="CIMA" then nx="ASA" end
if MODE=="ASA" and nx=="CIMA" then nx="CASA" end
if MODE=="CASA" and (nx=="CIMA" or nx=="ASA") then nx="DESENHO" end
if MODE=="DESENHO" then nx="CIMA" end
MODE=nx
SetTxt(BMode,"MODO "..nx)
Build()
end)
BScan.MouseButton1Click:Connect(function()
task.spawn(function() Refresh() Notify("BLOCOS "..#blocks) SelLab.Text="BLOCO "..SEL end)
end)
BDM.MouseButton1Click:Connect(function() CTRL_DIST=math.max(4,CTRL_DIST-1) DistLab.Text="DIST "..CTRL_DIST Build() end)
BDP.MouseButton1Click:Connect(function() CTRL_DIST=math.min(30,CTRL_DIST+1) DistLab.Text="DIST "..CTRL_DIST Build() end)
BSM.MouseButton1Click:Connect(function() SEL=SEL-1 if SEL<1 then SEL=math.max(#blocks,1) end SelLab.Text="BLOCO "..SEL end)
BSP.MouseButton1Click:Connect(function() SEL=SEL+1 if SEL>#blocks then SEL=1 end SelLab.Text="BLOCO "..SEL end)
BXM.MouseButton1Click:Connect(function() SELX=SELX-1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
BXP.MouseButton1Click:Connect(function() SELX=SELX+1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
BYM.MouseButton1Click:Connect(function() SELY=SELY-1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
BYP.MouseButton1Click:Connect(function() SELY=SELY+1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
BZM.MouseButton1Click:Connect(function() SELZ=SELZ-1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
BZP.MouseButton1Click:Connect(function() SELZ=SELZ+1 MODE="DESENHO" SetTxt(BMode,"MODO DESENHO") Build() end)
TVoid.MouseButton1Click:Connect(function() VOID_ON=not VOID_ON SetTog(TVoid,TVoidD,VOID_ON) Notify(VOID_ON and "VOID ON" or "VOID OFF") end)
TSpd.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpd,TSpdD,speedOn) if not speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFD,flyOn)
local ch=Char()
if ch then local r=Root(ch) if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TND,noclipOn) end)
TAfk.MouseButton1Click:Connect(function() afkOn=not afkOn SetTog(TAfk,TAD,afkOn) end)
TFb.MouseButton1Click:Connect(function()
fbOn=not fbOn
SetTog(TFb,TFD2,fbOn)
if fbOn then origB=Lighting.Brightness origC=Lighting.ClockTime Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
else if origB then Lighting.Brightness=origB Lighting.ClockTime=origC Lighting.GlobalShadows=true end end
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
task.spawn(function()
while task.wait(1) do
pcall(function() if CTRL_ON then Refresh() end end)
end
end)
task.spawn(function()
while task.wait(0.3) do
pcall(function()
local hrp=Root(Char())
if hrp and VOID_ON and not voidBusy then
local now=tick()
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local sc,ok=ScoreAttacker(p,hrp,now)
local ch=p.Character
local r=ch and ch:FindFirstChild("HumanoidRootPart")
if r then lastPos[p.Name]=r.Position lastT[p.Name]=now end
if ok and sc>=3 then VoidHop(p.Name) break end
end
end
end
end)
end
end)
RS.Heartbeat:Connect(function()
local ch=Char()
if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h and speedOn then h.WalkSpeed=speedVal end end
if flyOn and ch then
local r=Root(ch)
local hum=ch:FindFirstChildOfClass("Humanoid")
if r and hum then
local vel=hum.MoveDirection*flySpeed
if UIS:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,flySpeed*0.7,0) end
if flyBV then flyBV.Velocity=vel end
if flyGyro then flyGyro.CFrame=workspace.CurrentCamera.CFrame end
end
end
if noclipOn and ch then for _,v in pairs(ch:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
if afkOn then pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(0.3) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0)) end) end
end)
RS.RenderStepped:Connect(function()
PStroke.Color=RGB(tick())
if CTRL_ON then
local hrp=Root(Char())
if hrp then
for _,b in ipairs(blocks) do
local p=b.p
if p and p.Parent then
pcall(function()
p.CanCollide=false
p.CanTouch=false
p.CFrame=hrp.CFrame*b.off
end)
end
end
end
end
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
Notify("ZX NATURAL PRONTO")
end)
