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
local autoGuessOn=false
local perfectOn=false
local queueOn=false
local dodgeOn=false
local lastAnim={}
local myTurn=false
local firedTurn=false
local function GetBar()
local pg=LP:FindFirstChildOfClass("PlayerGui")
if not pg then return nil end
local sg=pg:FindFirstChild("ScreenGui")
local mt=sg and sg:FindFirstChild("meter")
if not mt or mt.Visible==false then return nil end
local cl=mt:FindFirstChild("color")
local bar=cl and cl:FindFirstChild("bar")
if not bar then return nil end
return bar
end
local function HookAnims(ch,plr)
pcall(function()
local hum=ch and ch:FindFirstChildOfClass("Humanoid")
local an=hum and hum:FindFirstChildOfClass("Animator")
if an then
an.AnimationPlayed:Connect(function(tr)
local id=""
pcall(function() id=tr.Animation.AnimationId end)
lastAnim[plr.Name]={id=id,t=os.clock()}
end)
end
end)
end
local forceVal=50
local speedOn=false
local speedVal=26
local jumpOn=false
local flyOn=false
local flySpeed=55
local noclipOn=false
local antiAfkOn=false
local fbOn=false
local fpsOn=false
local origB=nil
local origC=nil
local flyBV=nil
local flyGyro=nil
local suspects={}
local slapLog={}
local function Ev(n)
local ok,r=pcall(function()
local rs=game:GetService("ReplicatedStorage")
local e=rs:FindFirstChild("events")
if e then return e:FindFirstChild(n) end
return nil
end)
if ok then return r end
return nil
end
local function Char(plr)
return plr.Character
end
local function Root(ch)
if not ch then return nil end
return ch:FindFirstChild("HumanoidRootPart")
end
local function Alive(plr)
local ch=Char(plr)
if not ch then return false end
local h=ch:FindFirstChildOfClass("Humanoid")
return h and h.Health>0
end
local function FireGuess(target)
local ev=Ev("Guess")
if not ev then return false end
local ok=false
pcall(function() ev:FireServer(target) ok=true end)
pcall(function() ev:FireServer(target.Name) ok=true end)
local ch=Char(target)
if ch then pcall(function() ev:FireServer(ch) ok=true end) end
return ok
end
local function FireSlapOnce()
local ev=Ev("SendSlap")
if not ev then return end
pcall(function() ev:FireServer() end)
end
local function NearPlayers(maxd)
local out={}
local lr=Root(Char(LP))
if not lr then return out end
for _,p in ipairs(Players:GetPlayers()) do
if p==LP then continue end
if not Alive(p) then continue end
local r=Root(Char(p))
if not r then continue end
local d=(lr.Position-r.Position).Magnitude
if d<=maxd then table.insert(out,{p=p,d=d}) end
end
table.sort(out,function(a,b) return a.d<b.d end)
return out
end
SG=New("ScreenGui",{Name="ZxSlapper",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(255,60,120),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX SLAPPER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="ADIVINHE QUEM SLAPOU",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(255,120,160),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(18,6,12),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(255,60,120),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,120,160),TextSize=12,ZIndex=13,Parent=LCard})
LStat=New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,118),BackgroundTransparency=1,Text="CARREGANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(130,80,100),TextSize=10,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(12,3,8),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(255,60,120),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX SLAPPER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(30,6,14),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,120,160),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"DESCOBRIR","SLAP","PLAYER"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.31,0,0,28),Position=UDim2.new(0.015+(i-1)*0.328,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(40,6,16) or Color3.fromRGB(10,5,8),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(255,150,180) or Color3.fromRGB(130,110,120),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,3 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(255,60,120),CanvasSize=UDim2.new(0,0,0,800),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(40,6,16) or Color3.fromRGB(10,5,8)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,90,120),TextSize=10,Parent=f})
end
local function BigBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(8,4,7),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(50,20,30),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(220,200,210),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(40,6,16) or Color3.fromRGB(8,4,7)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(255,150,180) or Color3.fromRGB(220,200,210) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(8,4,7),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(210,190,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(120,20,50) or Color3.fromRGB(20,12,15),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(255,120,160) or Color3.fromRGB(90,70,80),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(120,20,50) or Color3.fromRGB(20,12,15)
dot.BackgroundColor3=st and Color3.fromRGB(255,120,160) or Color3.fromRGB(90,70,80)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(8,4,7),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,150,170),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(16,8,11),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(255,60,120),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),-9,0.5,-9),BackgroundColor3=Color3.fromRGB(255,120,160),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
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
Section(P1,"QUEM TE SLAPOU")
LogBox=New("TextLabel",{Size=UDim2.new(0.92,0,0,80),BackgroundColor3=Color3.fromRGB(8,4,7),BorderSizePixel=0,Text="AGUARDANDO SLAP",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(220,180,195),TextSize=11,TextWrapped=true,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=LogBox})
Section(P1,"SUSPEITOS NA HORA")
SBox=New("Frame",{Size=UDim2.new(0.92,0,0,150),BackgroundColor3=Color3.fromRGB(8,4,7),BorderSizePixel=0,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=SBox})
New("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=SBox})
New("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,6),Parent=SBox})
TAuto,TAD=MakeRow(P1,"AUTO GUESS SUSPEITO",false)
BClear=BigBtn(P1,"LIMPAR LOG")
Section(P2,"QUANDO VOCE E O SLAPPER")
BSlap=BigBtn(P2,"DAR SLAP AGORA")
BPerfect=BigBtn(P2,"AUTO PERFECT OFF")
BDodge=BigBtn(P2,"AUTO DODGE OFF")
BQueue=BigBtn(P2,"AUTO QUEUE OFF")
BForce=BigBtn(P2,"FORCA 50")
Section(P3,"MOVIMENTO")
TSpeed,TSD=MakeRow(P3,"SPEED",false)
MakeSlider(P3,"VALOR SPEED",16,150,26,function(v) speedVal=v end)
TFly,TFD=MakeRow(P3,"FLY",false)
MakeSlider(P3,"VEL FLY",10,200,55,function(v) flySpeed=v end)
TNoc,TND=MakeRow(P3,"NOCLIP",false)
TJump,TJD=MakeRow(P3,"PULO INFINITO",false)
Section(P3,"MUNDO")
TAfk,TAD2=MakeRow(P3,"ANTI AFK",false)
TFb,TFD2=MakeRow(P3,"FULLBRIGHT",false)
TFps,TFD3=MakeRow(P3,"FPS BOOST",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(10,3,7),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,120,160),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local function RefreshSuspects()
for _,c in ipairs(SBox:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
for i,s in ipairs(suspects) do
if i>5 then break end
local b=New("TextButton",{Size=UDim2.new(0.94,0,0,24),BackgroundColor3=Color3.fromRGB(30,8,15),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=SBox})
New("UICorner",{CornerRadius=UDim.new(0,6),Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text=i.." "..s.p.Name.." "..math.floor(s.d).."m GUESS",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
b.MouseButton1Click:Connect(function()
FireGuess(s.p)
Notify("GUESS "..s.p.Name)
end)
end
end
local function OnSlapped()
local near=NearPlayers(45)
local now=os.clock()
local ranked={}
for _,s in ipairs(near) do
local sc=s.d
local la=lastAnim[s.p.Name]
if la and (now-la.t)<4 then sc=sc-100 end
table.insert(ranked,{p=s.p,d=s.d,sc=sc})
end
table.sort(ranked,function(a,b) return a.sc<b.sc end)
suspects={}
for _,s in ipairs(ranked) do table.insert(suspects,{p=s.p,d=s.d}) end
if #suspects>0 then
local top=suspects[1].p.Name
LogBox.Text="SLAP SUSPEITO "..top.." + "..(#suspects-1)
table.insert(slapLog,top)
else
LogBox.Text="SLAP RECEBIDO SEM NINGUEM PERTO"
end
RefreshSuspects()
if autoGuessOn and #suspects>0 then
FireGuess(suspects[1].p)
Notify("AUTO GUESS "..suspects[1].p.Name)
end
end
TAuto.MouseButton1Click:Connect(function() autoGuessOn=not autoGuessOn SetTog(TAuto,TAD,autoGuessOn) Notify(autoGuessOn and "AUTO GUESS ON" or "AUTO GUESS OFF") end)
BClear.MouseButton1Click:Connect(function() suspects={} slapLog={} LogBox.Text="LOG LIMPO" RefreshSuspects() end)
BSlap.MouseButton1Click:Connect(function() FireSlapOnce() Notify("SLAP ENVIADO") end)
BDodge.MouseButton1Click:Connect(function()
dodgeOn=not dodgeOn
SetTxt(BDodge,dodgeOn and "AUTO DODGE ON" or "AUTO DODGE OFF")
SetBtn(BDodge,dodgeOn)
Notify(dodgeOn and "DODGE ON" or "DODGE OFF")
end)
BPerfect.MouseButton1Click:Connect(function()
perfectOn=not perfectOn
SetTxt(BPerfect,perfectOn and "AUTO PERFECT ON" or "AUTO PERFECT OFF")
SetBtn(BPerfect,perfectOn)
Notify(perfectOn and "PERFECT ON" or "PERFECT OFF")
end)
BQueue.MouseButton1Click:Connect(function()
queueOn=not queueOn
SetTxt(BQueue,queueOn and "AUTO QUEUE ON" or "AUTO QUEUE OFF")
SetBtn(BQueue,queueOn)
end)
BForce.MouseButton1Click:Connect(function()
forceVal=forceVal+10
if forceVal>200 then forceVal=10 end
SetTxt(BForce,"FORCA "..forceVal)
local ev=Ev("SlapPercent")
if ev then pcall(function() ev:FireServer(forceVal) end) end
end)
TSpeed.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpeed,TSD,speedOn) if not speedOn then local ch=Char(LP) if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFD,flyOn)
local ch=Char(LP)
if ch then local r=Root(ch) if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TND,noclipOn) end)
TJump.MouseButton1Click:Connect(function() jumpOn=not jumpOn SetTog(TJump,TJD,jumpOn) end)
TAfk.MouseButton1Click:Connect(function() antiAfkOn=not antiAfkOn SetTog(TAfk,TAD2,antiAfkOn) end)
TFb.MouseButton1Click:Connect(function()
fbOn=not fbOn SetTog(TFb,TFD2,fbOn)
if fbOn then origB=Lighting.Brightness origC=Lighting.ClockTime Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
else if origB then Lighting.Brightness=origB Lighting.ClockTime=origC Lighting.GlobalShadows=true end end
end)
TFps.MouseButton1Click:Connect(function()
fpsOn=not fpsOn SetTog(TFps,TFD3,fpsOn)
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
UIS.JumpRequest:Connect(function() if jumpOn then local ch=Char(LP) if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end end)
task.spawn(function()
local ev=Ev("ShowSlap")
if ev and ev:IsA("RemoteEvent") then
ev.OnClientEvent:Connect(function()
OnSlapped()
end)
end
local ev2=Ev("ImpactEffect")
if ev2 and ev2:IsA("RemoteEvent") then
ev2.OnClientEvent:Connect(function()
OnSlapped()
end)
end
local evR=Ev("RunMeter")
if evR then
pcall(function()
evR.OnClientEvent:Connect(function(on)
if on then
myTurn=true
firedTurn=false
Notify("SUA VEZ")
if perfectOn then
local evS=Ev("SendSlap")
if evS then pcall(function() evS:FireServer(1) end) end
firedTurn=true
task.delay(0.5,function() if myTurn then firedTurn=false end end)
end
else
myTurn=false
firedTurn=false
end
end)
end)
end
local evD=Ev("DodgePrompt")
if evD then
pcall(function()
evD.OnClientEvent:Connect(function()
if dodgeOn then
local evDo=Ev("Dodge")
if evDo then pcall(function() evDo:FireServer(true) end) end
Notify("DODGE AUTO")
end
end)
end)
end
for _,p in ipairs(Players:GetPlayers()) do
if p.Character then HookAnims(p.Character,p) end
end
Players.PlayerAdded:Connect(function(p)
p.CharacterAdded:Connect(function(c)
task.wait(1)
HookAnims(c,p)
end)
end)
LP.CharacterAdded:Connect(function(c)
task.wait(1)
HookAnims(c,LP)
end)
if LP.Character then HookAnims(LP.Character,LP) end
local ev3=Ev("Guess")
if ev3 and (ev3:IsA("RemoteEvent") or ev3:IsA("RemoteFunction")) then
pcall(function()
ev3.OnClientEvent:Connect(function(list)
if type(list)~="table" then return end
local lr=Root(Char(LP))
suspects={}
for _,plr in ipairs(list) do
if typeof(plr)=="Instance" and plr:IsA("Player") and plr~=LP then
local d=999
if lr then
local r=Root(Char(plr))
if r then d=(lr.Position-r.Position).Magnitude end
end
table.insert(suspects,{p=plr,d=d})
end
end
table.sort(suspects,function(a,b) return a.d<b.d end)
if #suspects>0 then
LogBox.Text="SERVER MANDOU "..#suspects.." SUSPEITOS TOP "..suspects[1].p.Name
RefreshSuspects()
if autoGuessOn then FireGuess(suspects[1].p) Notify("AUTO GUESS "..suspects[1].p.Name) end
end
end)
end)
end
end)
task.spawn(function()
while task.wait(0.5) do
pcall(function()
if queueOn then
local ev=Ev("SlapQueue")
if ev then ev:FireServer() end
end
end)
end
end)
RS.Heartbeat:Connect(function()
if speedOn then local ch=Char(LP) if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=speedVal end end end
if flyOn then
local ch=Char(LP)
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
if noclipOn then local ch=Char(LP) if ch then for _,v in pairs(ch:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end end
if antiAfkOn then pcall(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(0.3) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0)) end) end
end)
RS.RenderStepped:Connect(function()
PStroke.Color=RGB(tick())
if perfectOn and myTurn and not firedTurn then
local bar=GetBar()
if bar then
local y=bar.Position.Y.Scale
if y>0.94 then
firedTurn=true
local ev=Ev("SendSlap")
if ev then pcall(function() ev:FireServer(1) end) end
Notify("PERFECT 1.0")
end
end
end
end)
task.spawn(function()
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LS.Color=RGB(i*0.05)
LStat.Text="MONTANDO "..i.."%"
task.wait(0.012)
end
Tween(BG,{BackgroundTransparency=1},0.4)
task.wait(0.4)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-260)},0.5)
Notify("ZX SLAPPER PRONTO")
end)
