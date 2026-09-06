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
local autoKick=false
local kickPower=100
local aimGoal=true
local magnetOn=false
local magnetDist=14
local tackleOn=false
local tackleDist=12
local flickOn=false
local dashOn=false
local ballEspOn=false
local trajOn=false
local speedOn=false
local speedVal=30
local jumpOn=false
local afkOn=false
local fbOn=false
local fpsOn=false
local origB=nil
local origC=nil
local landMark=nil
local ballHl=nil
local goalA=nil
local goalB=nil
local gkOn=false
local gkDist=3
local function R(n)
local ok,r=pcall(function()
return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Ball"):WaitForChild(n,3)
end)
if ok then return r end
return nil
end
local function Char()
return LP.Character
end
local function Root(ch)
if not ch then return nil end
return ch:FindFirstChild("HumanoidRootPart")
end
local function FindBall()
local best=nil
local bd=99999
for _,v in ipairs(workspace:GetDescendants()) do
if (v:IsA("BasePart") or v:IsA("MeshPart")) and (v.Name=="Ball" or v.Name=="SoccerBall" or v.Name=="Football") then
local lr=Root(Char())
if lr then
local d=(lr.Position-v.Position).Magnitude
if d<bd then bd=d best=v end
else best=v break end
end
end
return best,bd
end
local function Flat(v)
return Vector3.new(v.X,0,v.Z).Unit
end
local function EnemyGoal()
local lr=Root(Char())
if not lr then return nil end
if goalA and goalB then
local da=(lr.Position-goalA).Magnitude
local db=(lr.Position-goalB).Magnitude
if da>db then return goalA else return goalB end
end
return nil
end
local function OwnGoal()
local lr=Root(Char())
if not lr then return nil end
if goalA and goalB then
local da=(lr.Position-goalA).Magnitude
local db=(lr.Position-goalB).Magnitude
if da<db then return goalA else return goalB end
end
return goalA
end
local function AimDir()
local lr=Root(Char())
local ball=FindBall()
if not lr or not ball then
local cam=workspace.CurrentCamera
if cam then return Flat(cam.CFrame.LookVector) end
return Vector3.new(0,0,1)
end
if aimGoal then
local g=EnemyGoal()
if g then
local d=g-ball.Position
if d.Magnitude>1 then return Flat(d) end
end
end
local op=nil
local bd=99999
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local ch=p.Character
local h=ch and ch:FindFirstChildOfClass("Humanoid")
local r=ch and ch:FindFirstChild("HumanoidRootPart")
if h and h.Health>0 and r then
local d=(lr.Position-r.Position).Magnitude
if d<bd then bd=d op=r end
end
end
end
if op then
local away=lr.Position-op.Position
away=Vector3.new(away.X,0,away.Z)
if away.Magnitude>1 then return away.Unit end
end
local cam=workspace.CurrentCamera
if cam then return Flat(cam.CFrame.LookVector) end
return Vector3.new(0,0,1)
end
local function DoKick(power)
local ev=R("Kick")
if not ev then return false end
local ball=FindBall()
local dir=AimDir()
local payload={ChargeSeconds=2,MaximumChargeSeconds=2,AimDirection={Direction=dir},KickDirection=dir,Power=power or kickPower}
local ok=false
pcall(function() ev:FireServer(payload) ok=true end)
pcall(function() ev:FireServer(ball,dir,power or kickPower) end)
pcall(function() ev:FireServer(dir,power or kickPower) end)
return ok
end
local function DoTackle(target)
local ev=R("Tackle")
if not ev then return end
pcall(function() ev:FireServer() end)
if target then
local ch=target.Character
local r=ch and ch:FindFirstChild("HumanoidRootPart")
pcall(function() ev:FireServer(r) end)
pcall(function() ev:FireServer(target) end)
end
end
local function Nearest(maxd)
local best=nil
local bd=maxd or 99999
local lr=Root(Char())
if not lr then return nil end
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local ch=p.Character
local h=ch and ch:FindFirstChildOfClass("Humanoid")
local r=ch and ch:FindFirstChild("HumanoidRootPart")
if h and h.Health>0 and r then
local d=(lr.Position-r.Position).Magnitude
if d<bd then bd=d best=p end
end
end
end
return best
end
SG=New("ScreenGui",{Name="ZxFutebol",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(255,170,0),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX FUTEBOL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="FUTEBOL ILEGAL",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(255,190,90),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(18,12,4),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(255,170,0),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,190,90),TextSize=12,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(12,8,2),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(255,170,0),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX FUTEBOL",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(30,18,4),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,190,90),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"BOLA","ILEGAL","PLAYER"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.31,0,0,28),Position=UDim2.new(0.015+(i-1)*0.328,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(40,24,4) or Color3.fromRGB(10,7,4),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(255,200,130) or Color3.fromRGB(140,125,110),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,3 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(255,170,0),CanvasSize=UDim2.new(0,0,0,800),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(40,24,4) or Color3.fromRGB(10,7,4)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,140,70),TextSize=10,Parent=f})
end
local function BigBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(10,7,4),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(50,35,12),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(225,210,190),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
Tween(b,{Size=UDim2.new(0.88,0,0,40)},0.08)
task.delay(0.09,function() pcall(function() Tween(b,{Size=UDim2.new(0.92,0,0,44)},0.16) end) end)
end)
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(40,24,4) or Color3.fromRGB(10,7,4)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(255,200,130) or Color3.fromRGB(225,210,190) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(10,7,4),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(215,195,175),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(140,80,0) or Color3.fromRGB(22,16,8),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(255,190,90) or Color3.fromRGB(95,80,60),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(140,80,0) or Color3.fromRGB(22,16,8)
dot.BackgroundColor3=st and Color3.fromRGB(255,190,90) or Color3.fromRGB(95,80,60)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(10,7,4),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(210,170,120),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(20,14,6),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(255,170,0),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),-9,0.5,-9),BackgroundColor3=Color3.fromRGB(255,190,90),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
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
Section(P1,"CHUTE AUTO")
BKick=BigBtn(P1,"AUTO KICK OFF")
MakeSlider(P1,"POWER",10,100,100,function(v) kickPower=v end)
TAim,TAD=MakeRow(P1,"MIRAR GOL",true)
TMag,TMD=MakeRow(P1,"GRUDAR NA BOLA",false)
MakeSlider(P1,"DIST GRUDE",6,30,14,function(v) magnetDist=v end)
Section(P1,"BOLA")
BBall=BigBtn(P1,"BALL ESP OFF")
BallInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,30),BackgroundColor3=Color3.fromRGB(10,7,4),BorderSizePixel=0,Text="BOLA -m",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(210,170,120),TextSize=11,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=BallInfo})
BTraj=BigBtn(P1,"TRAJETORIA OFF")
BGoal=BigBtn(P1,"ESCANEAR GOLS")
TGk,TGkD=MakeRow(P1,"AUTO GOLEIRO",false)
MakeSlider(P1,"LINHA GOL",1,10,3,function(v) gkDist=v end)
Section(P2,"ILEGAL")
TTackle,TTD=MakeRow(P2,"AUTO TACKLE",false)
MakeSlider(P2,"DIST TACKLE",4,30,12,function(v) tackleDist=v end)
BRain=BigBtn(P2,"RAINBOW FLICK")
BDash=BigBtn(P2,"VIOLENCE DASH")
BPass=BigBtn(P2,"PEDIR PASSE")
Section(P3,"MOVIMENTO")
TSpd,TSpdD=MakeRow(P3,"SPEED",false)
MakeSlider(P3,"VALOR SPEED",16,150,30,function(v) speedVal=v end)
TJump,TJD=MakeRow(P3,"PULO INFINITO",false)
Section(P3,"MUNDO")
TAfk,TAD2=MakeRow(P3,"ANTI AFK",false)
TFb,TFD=MakeRow(P3,"FULLBRIGHT",false)
TFps,TFD2=MakeRow(P3,"FPS BOOST",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(12,8,2),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,190,90),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
BKick.MouseButton1Click:Connect(function()
autoKick=not autoKick
SetTxt(BKick,autoKick and "AUTO KICK ON" or "AUTO KICK OFF")
SetBtn(BKick,autoKick)
Notify(autoKick and "KICK ON" or "KICK OFF")
end)
TAim.MouseButton1Click:Connect(function() aimGoal=not aimGoal SetTog(TAim,TAD,aimGoal) end)
TMag.MouseButton1Click:Connect(function() magnetOn=not magnetOn SetTog(TMag,TMD,magnetOn) end)
BBall.MouseButton1Click:Connect(function()
ballEspOn=not ballEspOn
SetTxt(BBall,ballEspOn and "BALL ESP ON" or "BALL ESP OFF")
SetBtn(BBall,ballEspOn)
if not ballEspOn and ballHl then pcall(function() ballHl:Destroy() end) ballHl=nil end
end)
BTraj.MouseButton1Click:Connect(function()
trajOn=not trajOn
SetTxt(BTraj,trajOn and "TRAJETORIA ON" or "TRAJETORIA OFF")
SetBtn(BTraj,trajOn)
if not trajOn and landMark then pcall(function() landMark:Destroy() end) landMark=nil end
end)
BGoal.MouseButton1Click:Connect(function()
task.spawn(function()
goalA=nil goalB=nil
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") and (v.Name=="Goal" or v.Name=="Gol" or string.find(string.lower(v.Name),"goal")) then
if not goalA then goalA=v.Position else goalB=v.Position end
end
end
if goalA then Notify("GOLS ACHADOS") else Notify("GOL NAO ACHADO") end
end)
end)
TGk.MouseButton1Click:Connect(function()
gkOn=not gkOn
SetTog(TGk,TGkD,gkOn)
if gkOn and not goalA then Notify("ESCANEIE GOLS PRIMEIRO") end
Notify(gkOn and "GOLEIRO ON" or "GOLEIRO OFF")
end)
TTackle.MouseButton1Click:Connect(function() tackleOn=not tackleOn SetTog(TTackle,TTD,tackleOn) Notify(tackleOn and "TACKLE ON" or "TACKLE OFF") end)
BRain.MouseButton1Click:Connect(function()
local ev=R("RainbowFlick")
if ev then pcall(function() ev:FireServer() end) Notify("FLICK") else Notify("SEM FLICK") end
end)
BDash.MouseButton1Click:Connect(function()
local ev=R("ViolenceDash")
if ev then
local lr=Root(Char())
local dir=Vector3.new(0,0,1)
if lr then dir=Flat((FindBall() or lr).Position-lr.Position) end
pcall(function() ev:FireServer(dir) end)
pcall(function() ev:FireServer() end)
Notify("DASH")
else Notify("SEM DASH") end
end)
BPass.MouseButton1Click:Connect(function()
local ev=R("CallForPass")
if ev then pcall(function() ev:FireServer() end) Notify("PASSE PEDIDO") else Notify("SEM PASSE") end
end)
TSpd.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpd,TSpdD,speedOn) if not speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TJump.MouseButton1Click:Connect(function() jumpOn=not jumpOn SetTog(TJump,TJD,jumpOn) end)
TAfk.MouseButton1Click:Connect(function() afkOn=not afkOn SetTog(TAfk,TAD2,afkOn) end)
TFb.MouseButton1Click:Connect(function()
fbOn=not fbOn
SetTog(TFb,TFD,fbOn)
if fbOn then origB=Lighting.Brightness origC=Lighting.ClockTime Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
else if origB then Lighting.Brightness=origB Lighting.ClockTime=origC Lighting.GlobalShadows=true end end
end)
TFps.MouseButton1Click:Connect(function()
fpsOn=not fpsOn
SetTog(TFps,TFD2,fpsOn)
if fpsOn then for _,v in pairs(workspace:GetDescendants()) do pcall(function() if v:IsA("BasePart") then v.Material=Enum.Material.SmoothPlastic v.CastShadow=false elseif v:IsA("ParticleEmitter") then v.Enabled=false end end) end Lighting.GlobalShadows=false end
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
while task.wait(0.15) do
pcall(function()
local ball,d=FindBall()
local lr=Root(Char())
if gkOn and ball and lr then
local og=OwnGoal()
if og then
local toBall=ball.Position-og
toBall=Vector3.new(toBall.X,0,toBall.Z)
if toBall.Magnitude>1 then
local spot=og+toBall.Unit*gkDist
spot=Vector3.new(spot.X,lr.Position.Y,spot.Z)
local far=(lr.Position-spot).Magnitude
if far>40 then
lr.CFrame=CFrame.new(spot)
else
local ch=Char()
local hum=ch and ch:FindFirstChildOfClass("Humanoid")
if hum then hum:MoveTo(spot) end
end
end
local eg=EnemyGoal()
if d<=10 and eg then
local dir=Flat(eg-ball.Position)
local ev=R("Kick")
if ev then
pcall(function() ev:FireServer({ChargeSeconds=2,MaximumChargeSeconds=2,AimDirection={Direction=dir},KickDirection=dir,Power=100}) end)
pcall(function() ev:FireServer(ball,dir,100) end)
end
end
end
end
if magnetOn and ball and lr and d>magnetDist then
lr.CFrame=ball.CFrame+Vector3.new(0,2,3)
end
if autoKick and ball and lr and d<=magnetDist+6 then
DoKick(kickPower)
end
if tackleOn then
local t=Nearest(tackleDist)
if t then DoTackle(t) end
end
end)
end
end)
RS.Heartbeat:Connect(function()
if speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=speedVal end end end
if afkOn then pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(0.3) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0)) end) end
local ball,d=FindBall()
if ball then
BallInfo.Text="BOLA "..math.floor(d or 0).."m"
if ballEspOn then
if not ballHl or not ballHl.Parent or ballHl.Adornee~=ball then
if ballHl then pcall(function() ballHl:Destroy() end) end
ballHl=Instance.new("Highlight")
ballHl.FillColor=Color3.fromRGB(255,170,0)
ballHl.FillTransparency=0.4
ballHl.Adornee=ball
ballHl.Parent=ball
end
end
if trajOn then
local vel=ball.Velocity
if vel.Magnitude>5 then
local g=workspace.Gravity
local p=ball.Position
local v=vel
local land=nil
for s=1,120 do
local dt=0.033
v=Vector3.new(v.X,v.Y-g*dt,v.Z)
p=p+v*dt
if p.Y<=1 then land=Vector3.new(p.X,1,p.Z) break end
end
if land then
if not landMark or not landMark.Parent then
landMark=Instance.new("Part")
landMark.Name="ZXLand"
landMark.Size=Vector3.new(3,0.5,3)
landMark.Anchored=true
landMark.CanCollide=false
landMark.Transparency=0.3
landMark.Color=Color3.fromRGB(255,170,0)
landMark.Material=Enum.Material.Neon
landMark.Parent=workspace
end
landMark.Position=land
end
end
end
else
BallInfo.Text="BOLA -m"
if ballHl then pcall(function() ballHl:Destroy() end) ballHl=nil end
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
Notify("ZX FUTEBOL PRONTO")
end)
