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
local hitOn=false
local smartHit=true
local smashJump=false
local hitType=0
local hitRange=30
local serveOn=false
local servePower=100
local serveRot=0
local ballEspOn=false
local trajOn=false
local landMark=nil
local speedOn=false
local speedVal=26
local jumpOn=false
local afkOn=false
local fbOn=false
local fpsOn=false
local origB=nil
local origC=nil
local function Remotes()
local ok,r=pcall(function()
return game:GetService("ReplicatedStorage"):WaitForChild("Remotes",5)
end)
if ok then return r end
return nil
end
local function HitRF()
local r=Remotes()
if not r then return nil end
return r:FindFirstChild("HitBallRF")
end
local function ServeRF()
local r=Remotes()
if not r then return nil end
return r:FindFirstChild("ServeRF")
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
if v:IsA("BasePart") and v.Name=="Ball" then
local lr=Root(Char())
if lr then
local d=(lr.Position-v.Position).Magnitude
if d<bd then bd=d best=v end
else best=v break end
end
end
return best,bd
end
local function DoHit(power,typeUse)
local rf=HitRF()
if not rf then return false end
local cam=workspace.CurrentCamera
local ch=Char()
local hum=ch and ch:FindFirstChildOfClass("Humanoid")
local ball=FindBall()
local cp=Vector3.new(0,0,0)
local cd=Vector3.new(0,0,1)
if cam then cp=cam.CFrame.Position cd=cam.CFrame.LookVector end
local hp=cp
if ball then hp=ball.Position end
local mv=Vector3.new(0,0,0)
if hum then mv=hum.MoveDirection*(hum.WalkSpeed or 16) end
local ok=false
pcall(function()
rf:InvokeServer({CamPos=cp,HitPos=hp,HitBallType=typeUse or hitType,ClientTick=tick(),CamDir=cd,AttackMoveSpeed=mv})
ok=true
end)
return ok
end
local function DoServe()
local rf=ServeRF()
if not rf then return false end
local ok=false
pcall(function()
rf:InvokeServer({RotateType=serveRot,Power=servePower})
ok=true
end)
return ok
end
SG=New("ScreenGui",{Name="ZxTennis",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(80,255,120),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX TENNIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="NEO TENNIS AUTO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(120,220,140),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(6,16,8),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(80,255,120),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,255,160),TextSize=12,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(3,12,5),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(80,255,120),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX TENNIS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(6,30,12),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,255,160),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"JOGO","SAQUE","PLAYER"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.31,0,0,28),Position=UDim2.new(0.015+(i-1)*0.328,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(8,40,14) or Color3.fromRGB(6,10,7),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(160,255,180) or Color3.fromRGB(120,140,125),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,3 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(80,255,120),CanvasSize=UDim2.new(0,0,0,800),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(8,40,14) or Color3.fromRGB(6,10,7)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,180,125),TextSize=10,Parent=f})
end
local function BigBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,10,6),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(20,50,25),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,220,205),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
Tween(b,{Size=UDim2.new(0.88,0,0,40)},0.08)
task.delay(0.09,function() pcall(function() Tween(b,{Size=UDim2.new(0.92,0,0,44)},0.16) end) end)
end)
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(8,40,14) or Color3.fromRGB(5,10,6)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(160,255,180) or Color3.fromRGB(200,220,205) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(5,10,6),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,210,195),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(20,120,40) or Color3.fromRGB(12,20,13),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(140,255,160) or Color3.fromRGB(70,90,75),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(20,120,40) or Color3.fromRGB(12,20,13)
dot.BackgroundColor3=st and Color3.fromRGB(140,255,160) or Color3.fromRGB(70,90,75)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(5,10,6),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(150,200,160),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(8,18,9),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(80,255,120),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),-9,0.5,-9),BackgroundColor3=Color3.fromRGB(140,255,160),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
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
Section(P1,"AUTO HIT")
BAuto=BigBtn(P1,"AUTO HIT OFF")
TSmart,TSD=MakeRow(P1,"SO NA MEDIDA",true)
TSmash,TSMD=MakeRow(P1,"SMASH PULANDO",true)
MakeSlider(P1,"ALCANCE",5,80,30,function(v) hitRange=v end)
Section(P1,"BOLA")
BBall=BigBtn(P1,"BALL ESP OFF")
BallInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,30),BackgroundColor3=Color3.fromRGB(5,10,6),BorderSizePixel=0,Text="BOLA -m",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(150,200,160),TextSize=11,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=BallInfo})
BTraj=BigBtn(P1,"TRAJETORIA OFF")
TrajInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,30),BackgroundColor3=Color3.fromRGB(5,10,6),BorderSizePixel=0,Text="QUEDA -m",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(150,200,160),TextSize=11,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=TrajInfo})
Section(P2,"SAQUE AUTO")
BSaque=BigBtn(P2,"AUTO SERVE OFF")
MakeSlider(P2,"POWER",10,100,100,function(v) servePower=v end)
MakeSlider(P2,"ROTATE 0-3",0,3,0,function(v) serveRot=math.floor(v) end)
Section(P3,"MOVIMENTO")
TSpd,TSpdD=MakeRow(P3,"SPEED",false)
MakeSlider(P3,"VALOR SPEED",16,150,26,function(v) speedVal=v end)
TJump,TJD=MakeRow(P3,"PULO INFINITO",false)
Section(P3,"MUNDO")
TAfk,TAD=MakeRow(P3,"ANTI AFK",false)
TFb,TFD=MakeRow(P3,"FULLBRIGHT",false)
TFps,TFD2=MakeRow(P3,"FPS BOOST",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,12,5),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,255,160),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local ballHl=nil
BAuto.MouseButton1Click:Connect(function()
hitOn=not hitOn
SetTxt(BAuto,hitOn and "AUTO HIT ON" or "AUTO HIT OFF")
SetBtn(BAuto,hitOn)
Notify(hitOn and "AUTO HIT ON" or "AUTO HIT OFF")
end)
TSmart.MouseButton1Click:Connect(function() smartHit=not smartHit SetTog(TSmart,TSD,smartHit) end)
TSmash.MouseButton1Click:Connect(function() smashJump=not smashJump SetTog(TSmash,TSMD,smashJump) end)
BSaque.MouseButton1Click:Connect(function()
serveOn=not serveOn
SetTxt(BSaque,serveOn and "AUTO SERVE ON" or "AUTO SERVE OFF")
SetBtn(BSaque,serveOn)
end)
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
if not trajOn and landMark then pcall(function() landMark:Destroy() end) landMark=nil TrajInfo.Text="QUEDA -m" end
Notify(trajOn and "TRAJETORIA ON" or "TRAJETORIA OFF")
end)
TSpd.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpd,TSpdD,speedOn) if not speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TJump.MouseButton1Click:Connect(function() jumpOn=not jumpOn SetTog(TJump,TJD,jumpOn) end)
TAfk.MouseButton1Click:Connect(function() afkOn=not afkOn SetTog(TAfk,TAD,afkOn) end)
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
while task.wait(0.12) do
pcall(function()
if hitOn then
local ball,d=FindBall()
local ch=Char()
local hum=ch and ch:FindFirstChildOfClass("Humanoid")
local jumping=false
if hum then jumping=hum:GetState()==Enum.HumanoidStateType.Jumping or hum:GetState()==Enum.HumanoidStateType.Freefall end
local tp=hitType
if smashJump and jumping then tp=1 end
if smartHit then
if ball and d and d<=hitRange then DoHit(100,tp) end
else
DoHit(100,tp)
end
end
if serveOn then DoServe() task.wait(1.2) end
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
ballHl.FillColor=Color3.fromRGB(80,255,120)
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
landMark.Color=Color3.fromRGB(80,255,120)
landMark.Material=Enum.Material.Neon
landMark.Parent=workspace
end
landMark.Position=land
local lr=Root(Char())
local dd=0
if lr then dd=(lr.Position-land).Magnitude end
TrajInfo.Text="QUEDA "..math.floor(dd).."m"
else
TrajInfo.Text="QUEDA FORA"
end
else
TrajInfo.Text="BOLA PARADA"
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
Notify("ZX TENNIS PRONTO")
end)
