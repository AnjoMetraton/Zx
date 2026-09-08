local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
local CS=game:GetService("CollectionService")
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
local farmOn=false
local doorOn=false
local itemEspOn=true
local spiderEspOn=true
local playerEspOn=false
local webOff=false
local speedOn=false
local speedVal=24
local flyOn=false
local flySpeed=55
local noclipOn=false
local jumpOn=false
local afkOn=true
local fbOn=false
local fpsOn=false
local origB=nil
local origC=nil
local flyBV=nil
local flyGyro=nil
local espC={}
local function Net()
local ok,r=pcall(function()
return require(game.ReplicatedStorage.modules.up).Network
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
local function Grabbables()
local out={}
pcall(function()
for _,v in ipairs(CS:GetTagged("GrabbableItem")) do
if v:IsDescendantOf(workspace) then table.insert(out,v) end
end
end)
if #out==0 then
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("Tool") then table.insert(out,v) end
end
end
return out
end
local function TakeItem(part)
local ch=Char()
local r=Root(ch)
local tp=nil
if part:IsA("BasePart") then tp=part.Position
elseif part:IsA("Tool") and part:FindFirstChild("Handle") then tp=part.Handle.Position end
if r and tp then
r.CFrame=CFrame.new(tp+Vector3.new(0,3,0))
task.wait(0.35)
end
local n=Net()
if n then
pcall(function() n.InvokeServer("AttemptSwapItems",part) end)
end
end
local function Doors()
local out={}
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") then
local n=string.lower(v.Name)
if string.find(n,"door") or string.find(n,"porta") then table.insert(out,v) end
end
end
return out
end
local function ToggleDoor(m)
local ch=Char()
local r=Root(ch)
if r then
local p=m:FindFirstChildWhichIsA("BasePart",true)
if p and (r.Position-p.Position).Magnitude>12 then
r.CFrame=p.CFrame+Vector3.new(0,3,3)
task.wait(0.3)
end
end
local n=Net()
if n then
pcall(function() n.FireServer("AttemptToggleDoor",m,true) end)
task.wait(0.2)
pcall(function() n.FireServer("AttemptToggleDoor",m,false) end)
end
end
local spiderList={}
local spiderTick=0
local function SpiderChar()
if os.clock()-spiderTick>4 then
spiderTick=os.clock()
spiderList={}
local n=Net()
if n then
pcall(function()
local res=n.InvokeServer("GetSpiderCharactersInWorld")
if type(res)=="table" then
for _,v in pairs(res) do
local ch=nil
if type(v)=="table" then ch=v.Character or v[1] end
if typeof(ch)=="Instance" and ch:IsDescendantOf(workspace) then
table.insert(spiderList,ch)
end
end
end
end)
end
end
for _,ch in ipairs(spiderList) do
if ch:IsDescendantOf(workspace) then
local h=ch:FindFirstChildOfClass("Humanoid")
if h and h.Health>0 then return ch end
end
end
return nil
end
local function ClearEsp()
for k,v in pairs(espC) do pcall(function() v:Destroy() end) end
espC={}
end
local genNames={Hitbox=true,Handle=true,Part=true,MeshPart=true,Mesh=true,Union=true,Base=true,HitBox=true}
local function ItemName(it)
if it:IsA("Tool") then return it.Name end
if not genNames[it.Name] then return it.Name end
local p=it.Parent
while p and p~=workspace and p~=game do
if (p:IsA("Tool") or p:IsA("Model")) and not genNames[p.Name] then return p.Name end
p=p.Parent
end
return it.Name
end
local function MkEsp(ad,color,txt)
local b=Instance.new("BillboardGui")
b.Size=UDim2.new(0,120,0,30)
b.StudsOffset=Vector3.new(0,3,0)
b.AlwaysOnTop=true
b.Adornee=ad
b.Parent=ad
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=color,TextSize=13,TextStrokeTransparency=0.2,Parent=b})
local h=Instance.new("Highlight")
h.FillColor=color
h.FillTransparency=0.6
h.Adornee=ad.Parent:IsA("Model") and ad.Parent or ad
h.Parent=ad
return b
end
SG=New("ScreenGui",{Name="ZxSpider",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(150,0,200),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX SPIDER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="FUJA PEGUE ESCAPE",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(190,120,255),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(12,4,18),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(150,0,200),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,120,255),TextSize=12,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(8,2,12),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.4,function() pcall(function() n:Destroy() end) end)
end)
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(150,0,200),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX SPIDER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(20,4,28),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,120,255),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"FUGA","ARANHA","PLAYER"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.31,0,0,28),Position=UDim2.new(0.015+(i-1)*0.328,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(28,6,38) or Color3.fromRGB(8,4,10),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(220,150,255) or Color3.fromRGB(130,115,140),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,3 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(150,0,200),CanvasSize=UDim2.new(0,0,0,800),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(28,6,38) or Color3.fromRGB(8,4,10)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(150,90,190),TextSize=10,Parent=f})
end
local function BigBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(7,3,10),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(35,15,45),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(215,200,225),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
Tween(b,{Size=UDim2.new(0.88,0,0,40)},0.08)
task.delay(0.09,function() pcall(function() Tween(b,{Size=UDim2.new(0.92,0,0,44)},0.16) end) end)
end)
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(28,6,38) or Color3.fromRGB(7,3,10)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(220,150,255) or Color3.fromRGB(215,200,225) end end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(7,3,10),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(205,190,215),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(100,0,150) or Color3.fromRGB(16,10,18),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(220,150,255) or Color3.fromRGB(85,70,95),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(100,0,150) or Color3.fromRGB(16,10,18)
dot.BackgroundColor3=st and Color3.fromRGB(220,150,255) or Color3.fromRGB(85,70,95)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
P1=Pages[1]
P2=Pages[2]
P3=Pages[3]
Section(P1,"CHAVES E ITENS")
BFarm=BigBtn(P1,"AUTO FARM OFF")
BItem=BigBtn(P1,"PEGAR ITEM")
BDoor=BigBtn(P1,"ABRIR PORTA")
TDoor,TDD=MakeRow(P1,"AUTO PORTAS",false)
Section(P1,"SAIDA")
BExit=BigBtn(P1,"TP SAIDA")
Section(P2,"ARANHA")
TSpider,TSD=MakeRow(P2,"ESP ARANHA",true)
TItem,TID=MakeRow(P2,"ESP ITENS",true)
TPlayer,TPD=MakeRow(P2,"ESP PLAYERS",false)
TWeb,TWD=MakeRow(P2,"IMUNE TEIA",false)
BSpiderTp=BigBtn(P2,"TP ARANHA VER")
Section(P3,"MOVIMENTO")
TSpd,TSpdD=MakeRow(P3,"SPEED",false)
local function SpdSlider()
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(7,3,10),BorderSizePixel=0,Parent=P3})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text="SPEED 24",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,140,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(12,6,16),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new(0.07,0,1,0),BackgroundColor3=Color3.fromRGB(150,0,200),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
local thumb=New("TextButton",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0.07,-9,0.5,-9),BackgroundColor3=Color3.fromRGB(220,150,255),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=thumb})
local drag=false
local function upd(inp)
local x=math.clamp((inp.Position.X-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
fill.Size=UDim2.new(x,0,1,0)
thumb.Position=UDim2.new(x,-9,0.5,-9)
speedVal=math.floor(16+x*134)
lab.Text="SPEED "..speedVal
end
thumb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
track.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true upd(i) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then upd(i) end end)
end
SpdSlider()
TFly,TFD=MakeRow(P3,"FLY",false)
TNoc,TND=MakeRow(P3,"NOCLIP",false)
TJump,TJD=MakeRow(P3,"PULO INFINITO",false)
Section(P3,"MUNDO")
TAfk,TAD=MakeRow(P3,"ANTI AFK",true)
TFb,TFD2=MakeRow(P3,"FULLBRIGHT",true)
TFps,TFD3=MakeRow(P3,"FPS BOOST",false)
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(8,2,12),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(220,150,255),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local flySpeed=55
local flyBV=nil
local flyGyro=nil
local origB=nil
local origC=nil
BFarm.MouseButton1Click:Connect(function()
farmOn=not farmOn
SetTxt(BFarm,farmOn and "AUTO FARM ON" or "AUTO FARM OFF")
SetBtn(BFarm,farmOn)
Notify(farmOn and "FARM ON" or "FARM OFF")
end)
BItem.MouseButton1Click:Connect(function()
local g=Grabbables()
if #g>0 then
local it=g[1]
local pos=nil
if it:IsA("BasePart") then pos=it.Position elseif it:IsA("Tool") and it:FindFirstChild("Handle") then pos=it.Handle.Position end
local r=Root(Char())
if r and pos then r.CFrame=CFrame.new(pos+Vector3.new(0,3,0)) end
TakeItem(it)
Notify("ITEM")
else Notify("SEM ITEM") end
end)
BDoor.MouseButton1Click:Connect(function()
local ds=Doors()
local r=Root(Char())
local best=nil
local bd=25
for _,m in ipairs(ds) do
local p=m:FindFirstChildWhichIsA("BasePart",true)
if p and r then
local d=(r.Position-p.Position).Magnitude
if d<bd then bd=d best=m end
end
end
if best then ToggleDoor(best) Notify("PORTA") else Notify("SEM PORTA") end
end)
TDoor.MouseButton1Click:Connect(function() doorOn=not doorOn SetTog(TDoor,TDD,doorOn) Notify(doorOn and "AUTO PORTA ON" or "AUTO PORTA OFF") end)
BExit.MouseButton1Click:Connect(function()
task.spawn(function()
local best=nil
for _,v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") then
local n=string.lower(v.Name)
if string.find(n,"exit") or string.find(n,"escape") or string.find(n,"saida") or string.find(n,"doorout") then best=v break end
end
end
local r=Root(Char())
if best and r then r.CFrame=best.CFrame+Vector3.new(0,5,0) Notify("SAIDA") else Notify("SAIDA NAO ACHADA") end
end)
end)
TSpider.MouseButton1Click:Connect(function() spiderEspOn=not spiderEspOn SetTog(TSpider,TSD,spiderEspOn) if not spiderEspOn then ClearEsp() end end)
TItem.MouseButton1Click:Connect(function() itemEspOn=not itemEspOn SetTog(TItem,TID,itemEspOn) if not itemEspOn then ClearEsp() end end)
TPlayer.MouseButton1Click:Connect(function() playerEspOn=not playerEspOn SetTog(TPlayer,TPD,playerEspOn) if not playerEspOn then ClearEsp() end end)
TWeb.MouseButton1Click:Connect(function()
webOff=not webOff
SetTog(TWeb,TWD,webOff)
if webOff then
for _,v in ipairs(workspace:GetDescendants()) do
pcall(function()
local n=string.lower(v.Name)
if string.find(n,"web") then
if v:IsA("BasePart") then v.CanCollide=false v.Transparency=0.9 end
end
end)
end
pcall(function()
local w=workspace:FindFirstChild("ignore")
if w then
local sw=w:FindFirstChild("SpiderWebs")
if sw then sw:ClearAllChildren() end
end
end)
Notify("TEIA OFF")
else Notify("TEIA ON") end
end)
BSpiderTp.MouseButton1Click:Connect(function()
local ch=SpiderChar()
local r=Root(Char())
if ch and r then
local hr=ch:FindFirstChild("HumanoidRootPart")
if hr then r.CFrame=hr.CFrame+Vector3.new(0,5,5) Notify("NA ARANHA") end
else Notify("ARANHA NAO ACHADA") end
end)
TSpd.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpd,TSpdD,speedOn) if not speedOn then local ch=Char() if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFD,flyOn)
local ch=Char()
if ch then local r=Root(ch) if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TND,noclipOn) end)
TJump.MouseButton1Click:Connect(function() jumpOn=not jumpOn SetTog(TJump,TJD,jumpOn) end)
TAfk.MouseButton1Click:Connect(function() afkOn=not afkOn SetTog(TAfk,TAD,afkOn) end)
TFb.MouseButton1Click:Connect(function()
fbOn=true
SetTog(TFb,TFD2,fbOn)
origB=Lighting.Brightness origC=Lighting.ClockTime Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
end)
TFps.MouseButton1Click:Connect(function()
fpsOn=not fpsOn
SetTog(TFps,TFD3,fpsOn)
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
local phase=0
while task.wait(0.6) do
pcall(function()
if farmOn then
phase=phase+1
if phase%2==1 then
local g=Grabbables()
if #g>0 then TakeItem(g[1]) end
else
local ds=Doors()
local r=Root(Char())
local best=nil
local bd=99999
for _,m in ipairs(ds) do
local p=m:FindFirstChildWhichIsA("BasePart",true)
if p and r then
local d=(r.Position-p.Position).Magnitude
if d<bd then bd=d best=m end
end
end
if best then ToggleDoor(best) end
end
end
if doorOn then
local ds=Doors()
local r=Root(Char())
for _,m in ipairs(ds) do
local p=m:FindFirstChildWhichIsA("BasePart",true)
if p and r and (r.Position-p.Position).Magnitude<20 then ToggleDoor(m) end
end
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
if webOff then
pcall(function()
local w=workspace:FindFirstChild("ignore")
if w then
local sw=w:FindFirstChild("SpiderWebs")
if sw then for _,c in ipairs(sw:GetChildren()) do c:Destroy() end end
end
end)
end
for k,v in pairs(espC) do
local ok=true
pcall(function()
if not k or not k.Parent then ok=false end
end)
if not ok then pcall(function() v:Destroy() end) espC[k]=nil end
end
if itemEspOn then
for _,it in ipairs(Grabbables()) do
local ad=it
if it:IsA("Tool") then ad=it:FindFirstChild("Handle") end
if ad and not espC[ad] then espC[ad]=MkEsp(ad,Color3.fromRGB(0,255,120),ItemName(it)) end
end
end
if playerEspOn then
for _,p in ipairs(Players:GetPlayers()) do
if p~=LP then
local ch=p.Character
local r=ch and ch:FindFirstChild("HumanoidRootPart")
if r and not espC[r] then espC[r]=MkEsp(r,Color3.fromRGB(120,170,255),p.Name) end
end
end
end
if spiderEspOn then
local ch=SpiderChar()
if ch then
local r=ch:FindFirstChild("HumanoidRootPart")
if r and not espC[r] then espC[r]=MkEsp(r,Color3.fromRGB(255,0,60),"ARANHA") end
end
end
end)
Lighting.Brightness=2
Lighting.ClockTime=14
Lighting.GlobalShadows=false
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
Notify("ZX SPIDER PRONTO")
end)
