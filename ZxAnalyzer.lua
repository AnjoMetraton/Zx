local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local Lighting=game:GetService("Lighting")
local Http=game:GetService("HttpService")
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
local function CD(a,b)
local x=a.R-b.R
local y=a.G-b.G
local z=a.B-b.B
return x*x+y*y+z*z
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
local function TeamColor(ch)
if not ch then return nil end
local n=ch:FindFirstChild("Nametag")
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
local aimOn=false
local aimFixOn=false
local espOn=false
local rgbEspOn=false
local hitboxOn=false
local hitboxSize=4
local ignoreTeam=true
local ignoreWall=false
local checkFov=true
local circleRadius=140
local smoothVal=18
local maxDist=2000
local espMaxDist=2000
local espColor=Color3.fromRGB(120,0,255)
local flyOn=false
local flySpeed=55
local speedOn=false
local speedVal=26
local noclipOn=false
local fullbrightOn=false
local lockedPlayer=nil
local aimPart="Head"
local myTeam=nil
local autoTeam=true
local scanTxt=""
local remoteList={}
local localList={}
local moduleList={}
local detectInfo="AGUARDANDO SCAN"
local espCache={}
local espNameCache={}
local hitboxOrig={}
local hitboxVis={}
local flyBV=nil
local flyGyro=nil
local origLight={}
SG=New("ScreenGui",{Name="ZxAnalyzer",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,320,0,200),Position=UDim2.new(0.5,-160,0.5,-100),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,30),Position=UDim2.new(0,0,0,14),BackgroundTransparency=1,Text="ZX ANALYZER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,48),BackgroundTransparency=1,Text="LENDO CLIENT SEM FALTA",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(120,90,200),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,90),BackgroundColor3=Color3.fromRGB(10,6,18),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(120,0,255),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,0,104),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=12,ZIndex=13,Parent=LCard})
LStat=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,130),BackgroundTransparency=1,Text="INICIANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(90,70,130),TextSize=10,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(5,2,12),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("UIStroke",{Color=Color3.fromRGB(110,0,230),Thickness=1.2,Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.5,function() pcall(function() n:Destroy() end) end)
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
if t and myTeam~=t then
myTeam=t
if not silent then Notify(t=="red" and "TIME AUTO VERMELHO" or "TIME AUTO AZUL") end
return true
end
return false
end
local function SameTeam(pb)
if not myTeam then return false end
local cb=GetChar(pb)
local nb=TeamColor(cb)
if not nb then
pcall(function()
if pb.Team and LP.Team and pb.Team==LP.Team then nb=Color3.new(0,0,0) end
end)
if not nb then return false end
if nb==Color3.new(0,0,0) then return true end
end
local tb=ClassTeam(nb)
if not tb then return false end
return myTeam==tb
end
local function ScanClient()
remoteList={}
localList={}
moduleList={}
local counts={}
local total=0
pcall(function()
for _,d in ipairs(game:GetDescendants()) do
total=total+1
local cn=d.ClassName
counts[cn]=(counts[cn] or 0)+1
if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") or d:IsA("BindableEvent") or d:IsA("BindableFunction") then
if #remoteList<120 then table.insert(remoteList,d:GetFullName()) end
end
if d:IsA("LocalScript") then
if #localList<120 then table.insert(localList,d:GetFullName()) end
end
if d:IsA("ModuleScript") then
local okParent=pcall(function() return d.Parent end)
if okParent then
if #moduleList<120 then table.insert(moduleList,d:GetFullName()) end
end
end
end
end)
local wsN=0
local rsN=0
local guiN=0
local toolN=0
pcall(function() wsN=#workspace:GetDescendants() end)
pcall(function()
local rs=game:GetService("ReplicatedStorage")
rsN=#rs:GetDescendants()
for _,d in ipairs(rs:GetDescendants()) do
if d:IsA("Tool") then toolN=toolN+1 end
end
end)
pcall(function() guiN=#LP:WaitForChild("PlayerGui"):GetDescendants() end)
local teamSys="SEM NAMETAG"
pcall(function()
local ch=GetChar(LP)
local c=TeamColor(ch)
local t=ClassTeam(c)
if t then teamSys="NAMETAG "..string.upper(t) else teamSys="NAMETAG NAO DETECTADO" end
end)
local charPath="Character"
pcall(function()
local f=workspace:FindFirstChild("Players")
if f and f:FindFirstChild(LP.Name) then charPath="workspace.Players" end
end)
local parts="Head"
pcall(function()
local ch=GetChar(LP)
if ch then
local h={}
if ch:FindFirstChild("Head") then table.insert(h,"Head") end
if ch:FindFirstChild("UpperTorso") then table.insert(h,"UpperTorso") end
if ch:FindFirstChild("HumanoidRootPart") then table.insert(h,"HumanoidRootPart") end
if #h>0 then parts=table.concat(h," ") end
end
end)
detectInfo="TOTAL "..total.." WS "..wsN.." RS "..rsN.." GUI "..guiN.." TOOLS "..toolN.." TEAM "..teamSys.." PATH "..charPath.." PARTS "..parts
local out={}
table.insert(out,"ZX CLIENT DUMP "..game.PlaceId)
table.insert(out,detectInfo)
table.insert(out,"REMOTES "..#remoteList)
for _,r in ipairs(remoteList) do table.insert(out,"R "..r) end
table.insert(out,"LOCALSCRIPTS "..#localList)
for _,r in ipairs(localList) do table.insert(out,"L "..r) end
table.insert(out,"MODULES "..#moduleList)
for _,r in ipairs(moduleList) do table.insert(out,"M "..r) end
table.insert(out,"SERVICOS NAO REPLICAM ServerScriptService ServerStorage")
scanTxt=table.concat(out,"\n")
pcall(function()
local js=Http:JSONEncode({place=game.PlaceId,info=detectInfo,remotes=remoteList,locals=localList,modules=moduleList})
if writefile then writefile("ZX_CLIENT_DUMP.json",js) end
if setclipboard then setclipboard(scanTxt:sub(1,8000)) end
end)
pcall(function() SendDump() end)
return scanTxt
end
if not _G.ZxDumpUrl then _G.ZxDumpUrl="https://stroke-handle-replica-adjust.trycloudflare.com/dump" end
local function SendDump()
local url=_G.ZxDumpUrl
if not url or url=="" then return false end
local payload=""
pcall(function() payload=Http:JSONEncode({place=game.PlaceId,info=detectInfo,remotes=remoteList,locals=localList,modules=moduleList}) end)
if payload=="" then return false end
local req=request or http_request or syn_request or fluxus_request or (syn and syn.request)
if req then
pcall(function() req({Url=url,Method="POST",Headers={["Content-Type"]="application/json"},Body=payload}) end)
return true
end
pcall(function() Http:PostAsync(url,payload,Enum.HttpContentType.ApplicationJson) end)
return true
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,540),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-90,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX CLIENT MENU",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"DADOS","AIM","ESP","MISC"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.23,0,0,28),Position=UDim2.new(0.015+(i-1)*0.247,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(22,0,44) or Color3.fromRGB(8,5,15),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(200,140,255) or Color3.fromRGB(120,110,140),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
TabBtns[i]=b
end
for i=1,4 do
local s=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-94),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(120,0,240),CanvasSize=UDim2.new(0,0,0,900),ScrollingDirection=Enum.ScrollingDirection.Y,Visible=i==1,Parent=Panel})
local lay=New("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=s})
New("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,12),Parent=s})
lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end)
Pages[i]=s
end
local function SelectTab(idx)
for i,b in ipairs(TabBtns) do
local on=i==idx
b.BackgroundColor3=on and Color3.fromRGB(22,0,44) or Color3.fromRGB(8,5,15)
b.TextColor3=on and Color3.fromRGB(200,140,255) or Color3.fromRGB(120,110,140)
Pages[i].Visible=on
end
end
for i,b in ipairs(TabBtns) do b.MouseButton1Click:Connect(function() SelectTab(i) end) end
local function Section(parent,txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=parent})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,80,160),TextSize=10,Parent=f})
end
local function MakeBtn(parent,txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,42),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(30,20,50),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(170,160,190),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
return b
end
local function SetBtn(b,st)
b.BackgroundColor3=st and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.TextColor3=st and Color3.fromRGB(200,140,255) or Color3.fromRGB(170,160,190) end end
local s=b:FindFirstChildOfClass("UIStroke")
if s then s.Color=st and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50) end
end
local function SetTxt(b,txt)
for _,d in ipairs(b:GetDescendants()) do if d:IsA("TextLabel") then d.Text=txt end end
end
local function MakeRow(parent,lbl,def)
local r=New("Frame",{Size=UDim2.new(0.92,0,0,38),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=r})
New("TextLabel",{Size=UDim2.new(1,-58,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=lbl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(170,150,210),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=r})
local tog=New("TextButton",{Size=UDim2.new(0,38,0,22),Position=UDim2.new(1,-46,0.5,-11),BackgroundColor3=def and Color3.fromRGB(40,0,80) or Color3.fromRGB(15,10,28),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=r})
New("UICorner",{CornerRadius=UDim.new(0,11),Parent=tog})
local dot=New("Frame",{Size=UDim2.new(0,15,0,15),Position=def and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7),BackgroundColor3=def and Color3.fromRGB(160,80,255) or Color3.fromRGB(60,40,90),BorderSizePixel=0,Parent=tog})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=dot})
return tog,dot
end
local function SetTog(tog,dot,st)
tog.BackgroundColor3=st and Color3.fromRGB(40,0,80) or Color3.fromRGB(15,10,28)
dot.BackgroundColor3=st and Color3.fromRGB(160,80,255) or Color3.fromRGB(60,40,90)
Tween(dot,{Position=st and UDim2.new(1,-18,0.5,-7) or UDim2.new(0,3,0.5,-7)},0.2)
end
local function MakeSlider(parent,title,minv,maxv,defv,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
local lab=New("TextLabel",{Size=UDim2.new(1,-20,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=title.." "..defv,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(130,100,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local track=New("Frame",{Size=UDim2.new(0.86,0,0,6),Position=UDim2.new(0.07,0,0,32),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=track})
local fill=New("Frame",{Size=UDim2.new((defv-minv)/math.max(maxv-minv,0.001),0,1,0),BackgroundColor3=Color3.fromRGB(100,0,220),BorderSizePixel=0,Parent=track})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=fill})
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
thumb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
track.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true upd(i) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then upd(i) end end)
return outer
end
P1=Pages[1]
P2=Pages[2]
P3=Pages[3]
P4=Pages[4]
Section(P1,"ANALISE DO CLIENT")
InfoBox=New("TextLabel",{Size=UDim2.new(0.92,0,0,70),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="TOQUE EM ESCANEAR",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(150,130,200),TextSize=11,TextWrapped=true,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=InfoBox})
BScan=MakeBtn(P1,"ESCANEAR CLIENT")
BDump=MakeBtn(P1,"COPIAR DUMP")
BSave=MakeBtn(P1,"SAVEINSTANCE CLIENT")
Section(P1,"DUMP")
DumpBox=New("TextBox",{Size=UDim2.new(0.92,0,0,220),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",Font=Enum.Font.Code,TextColor3=Color3.fromRGB(140,220,255),TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,MultiLine=true,ClearTextOnFocus=false,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=DumpBox})
Section(P2,"MIRA AUTO CONFIG")
BAim=MakeBtn(P2,"MIRA OFF")
BFix=MakeBtn(P2,"AIMBOT FIX OFF")
MakeSlider(P2,"RAIO FOV",10,800,140,function(v) circleRadius=v Circle.Size=UDim2.new(0,v*2,0,v*2) Circle.Position=UDim2.new(0.5,-v,0.5,-v) end)
MakeSlider(P2,"SUAVIDADE",1,100,18,function(v) smoothVal=v end)
MakeSlider(P2,"DIST MAX",100,5000,2000,function(v) maxDist=v end)
TFov,TDFov=MakeRow(P2,"CHECAR FOV",true)
TTeam,TDTeam=MakeRow(P2,"IGNORAR TIME AUTO",true)
TWall,TDWall=MakeRow(P2,"WALLCHECK",false)
TAuto,TDAuto=MakeRow(P2,"AUTO DETECT TIME",true)
Section(P3,"ESP AUTO")
BEsp=MakeBtn(P3,"ESP OFF")
BRgb=MakeBtn(P3,"RGB ESP OFF")
MakeSlider(P3,"DIST MAX ESP",100,5000,2000,function(v) espMaxDist=v end)
Section(P4,"MISC CLIENT")
TFly,TFlyD=MakeRow(P4,"FLY",false)
MakeSlider(P4,"VEL FLY",10,200,55,function(v) flySpeed=v end)
TSpeed,TSpeedD=MakeRow(P4,"SPEED",false)
MakeSlider(P4,"VALOR SPEED",16,150,26,function(v) speedVal=v end)
TNoc,TNocD=MakeRow(P4,"NOCLIP",false)
TFb,TFbD=MakeRow(P4,"FULLBRIGHT",false)
Circle=New("Frame",{Size=UDim2.new(0,280,0,280),Position=UDim2.new(0.5,-140,0.5,-140),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=Circle})
CircleStroke=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Parent=Circle})
Cross=New("Frame",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0.5,-11,0.5,-11),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Cross})
New("Frame",{Size=UDim2.new(0,1,1,0),Position=UDim2.new(0.5,0,0,0),BackgroundColor3=Color3.fromRGB(210,170,255),BorderSizePixel=0,Parent=Cross})
LockF=New("Frame",{Size=UDim2.new(0,52,0,52),Position=UDim2.new(0.5,0,0.5,0),AnchorPoint=Vector2.new(0.5,0.5),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=SG})
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
local function getPart(plr)
if not plr then return nil end
local ch=GetChar(plr)
if not ch then return nil end
local p=ch:FindFirstChild(aimPart)
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
local center=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
for _,plr in ipairs(Players:GetPlayers()) do
if plr==LP then continue end
local ch=GetChar(plr)
if not ch then continue end
local hum=ch:FindFirstChildOfClass("Humanoid")
local root=ch:FindFirstChild("HumanoidRootPart")
if not (hum and hum.Health>0 and root) then continue end
if ignoreTeam and SameTeam(plr) then continue end
if ignoreWall and not Visible(root) then continue end
local d=(root.Position-cam.CFrame.Position).Magnitude
if d>maxDist then continue end
local sp,on=cam:WorldToViewportPoint(root.Position)
if not on then continue end
local sd=(Vector2.new(sp.X,sp.Y)-center).Magnitude
if checkFov and sd>circleRadius then continue end
if sd<bd then bd=sd best=plr end
end
return best
end
local function resetCam()
local cam=workspace.CurrentCamera
if cam then cam.CameraType=Enum.CameraType.Custom end
end
local function remEsp(p)
if espCache[p] then pcall(function() espCache[p]:Destroy() end) espCache[p]=nil end
if espNameCache[p] then pcall(function() espNameCache[p]:Destroy() end) espNameCache[p]=nil end
end
BScan.MouseButton1Click:Connect(function()
InfoBox.Text="ESCANEANDO CLIENT"
local txt=ScanClient()
InfoBox.Text=detectInfo
DumpBox.Text=txt:sub(1,6000)
Notify("SCAN COMPLETO")
AutoDetect(false)
end)
BDump.MouseButton1Click:Connect(function()
if setclipboard and scanTxt~="" then setclipboard(scanTxt:sub(1,15000)) Notify("DUMP COPIADO") else Notify("ESCANEIE PRIMEIRO") end
end)
BSave.MouseButton1Click:Connect(function()
Notify("SALVANDO CLIENT")
task.spawn(function()
local ok=pcall(function()
local P={RepoURL="https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/",SSI="saveinstance"}
local f=loadstring(game:HttpGet(P.RepoURL..P.SSI..".luau",true),P.SSI)()
f({Decompile=true,SavePlayers=false})
end)
Notify(ok and "SAVE OK" or "SAVE FALHOU")
end)
end)
BAim.MouseButton1Click:Connect(function()
aimOn=not aimOn
SetTxt(BAim,aimOn and "MIRA ON" or "MIRA OFF")
SetBtn(BAim,aimOn)
Circle.Visible=aimOn
if not aimOn then resetCam() end
end)
BFix.MouseButton1Click:Connect(function()
aimFixOn=not aimFixOn
SetTxt(BFix,aimFixOn and "AIMBOT FIX ON" or "AIMBOT FIX OFF")
SetBtn(BFix,aimFixOn)
if not aimFixOn then lockedPlayer=nil LockF.Visible=false resetCam() end
end)
BEsp.MouseButton1Click:Connect(function()
espOn=not espOn
SetTxt(BEsp,espOn and "ESP ON" or "ESP OFF")
SetBtn(BEsp,espOn)
if not espOn then for _,p in ipairs(Players:GetPlayers()) do remEsp(p) end end
end)
BRgb.MouseButton1Click:Connect(function()
rgbEspOn=not rgbEspOn
SetTxt(BRgb,rgbEspOn and "RGB ESP ON" or "RGB ESP OFF")
SetBtn(BRgb,rgbEspOn)
end)
TFov.MouseButton1Click:Connect(function() checkFov=not checkFov SetTog(TFov,TDFov,checkFov) end)
TTeam.MouseButton1Click:Connect(function() ignoreTeam=not ignoreTeam SetTog(TTeam,TDTeam,ignoreTeam) end)
TWall.MouseButton1Click:Connect(function() ignoreWall=not ignoreWall SetTog(TWall,TDWall,ignoreWall) end)
TAuto.MouseButton1Click:Connect(function() autoTeam=not autoTeam SetTog(TAuto,TDAuto,autoTeam) if autoTeam then AutoDetect(false) end end)
TFly.MouseButton1Click:Connect(function()
flyOn=not flyOn SetTog(TFly,TFlyD,flyOn)
local ch=LP.Character
if ch then local r=ch:FindFirstChild("HumanoidRootPart") if r then if flyOn then flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.new(0,0,0) flyBV.Parent=r flyGyro=Instance.new("BodyGyro") flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9) flyGyro.CFrame=r.CFrame flyGyro.Parent=r else pcall(function() flyBV:Destroy() end) pcall(function() flyGyro:Destroy() end) flyBV=nil flyGyro=nil end end end
end)
TSpeed.MouseButton1Click:Connect(function() speedOn=not speedOn SetTog(TSpeed,TSpeedD,speedOn) if not speedOn then local ch=LP.Character if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=16 end end end end)
TNoc.MouseButton1Click:Connect(function() noclipOn=not noclipOn SetTog(TNoc,TNocD,noclipOn) end)
TFb.MouseButton1Click:Connect(function()
fullbrightOn=not fullbrightOn SetTog(TFb,TFbD,fullbrightOn)
if fullbrightOn then origLight={B=Lighting.Brightness,C=Lighting.ClockTime} Lighting.Brightness=2 Lighting.ClockTime=14 Lighting.GlobalShadows=false
else if origLight.B then Lighting.Brightness=origLight.B Lighting.ClockTime=origLight.C Lighting.GlobalShadows=true end end
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
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-270)},0.45)
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
LP.CharacterAdded:Connect(function(c) c:WaitForChild("HumanoidRootPart",5) task.wait(1) if autoTeam then AutoDetect(true) end end)
task.spawn(function()
while task.wait(1) do
if autoTeam then pcall(function() AutoDetect(true) end) end
end
end)
Players.PlayerRemoving:Connect(function(p) remEsp(p) if lockedPlayer==p then lockedPlayer=nil LockF.Visible=false resetCam() end end)
RS:BindToRenderStep("ZxA",Enum.RenderPriority.Camera.Value+1,function()
if not aimFixOn then return end
local cam=workspace.CurrentCamera
if not cam then return end
if not lockedPlayer then lockedPlayer=Closest(cam) end
if lockedPlayer then
local ch=GetChar(lockedPlayer)
if not ch then lockedPlayer=nil return end
local hum=ch:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health<=0 then lockedPlayer=nil return end
local pt=getPart(lockedPlayer)
if pt then
local sm=math.clamp(smoothVal,1,100)
local f=1-(sm/105)
if f>=0.95 then cam.CFrame=CFrame.new(cam.CFrame.Position,pt.Position) else cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,pt.Position),f) end
local sp,on=cam:WorldToViewportPoint(pt.Position)
if on then Cross.Position=UDim2.new(0,sp.X-11,0,sp.Y-11) LockF.Position=UDim2.new(0,sp.X,0,sp.Y) LockF.Visible=true else LockF.Visible=false end
end
else LockF.Visible=false end
end)
RS.RenderStepped:Connect(function()
local t=tick()
PStroke.Color=RGB(t)
CircleStroke.Color=RGB(t)
if aimOn and not aimFixOn then
local cam=workspace.CurrentCamera
if cam then
local cl=Closest(cam)
if cl then
local pt=getPart(cl)
if pt then
local sp,on=cam:WorldToViewportPoint(pt.Position)
if on then Cross.Position=UDim2.new(0,sp.X-11,0,sp.Y-11) cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,pt.Position),0.2) end
end
end
end
elseif not aimFixOn then Cross.Position=UDim2.new(0.5,-11,0.5,-11) LockF.Visible=false end
end)
RS.Heartbeat:Connect(function()
if speedOn then local ch=LP.Character if ch then local h=ch:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=speedVal end end end
if flyOn then
local ch=LP.Character
if ch then
local r=ch:FindFirstChild("HumanoidRootPart")
local hum=ch:FindFirstChildOfClass("Humanoid")
if r and hum then
local mv=hum.MoveDirection
local vel=mv*flySpeed
if UIS:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,flySpeed*0.7,0) end
if flyBV then flyBV.Velocity=vel end
if flyGyro then flyGyro.CFrame=workspace.CurrentCamera.CFrame end
end
end
end
if noclipOn then local ch=LP.Character if ch then for _,v in pairs(ch:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end end
if hitboxOn then
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
if not sb or not sb.Parent then
if sb then pcall(function() sb:Destroy() end) end
sb=Instance.new("SelectionBox")
sb.LineThickness=0.05
sb.SurfaceTransparency=1
sb.Adornee=root
sb.Parent=workspace
hitboxVis[p]=sb
end
sb.Color3=Color3.fromRGB(120,0,255)
end
end
end
end
if not espOn then return end
local ec=rgbEspOn and RGB(tick()) or espColor
for _,p in ipairs(Players:GetPlayers()) do
if p==LP then continue end
if ignoreTeam and myTeam and SameTeam(p) then continue end
local ch=GetChar(p)
if ch then
local hum=ch:FindFirstChildOfClass("Humanoid")
local root=ch:FindFirstChild("HumanoidRootPart")
if hum and hum.Health>0 and root then
local d=(root.Position-workspace.CurrentCamera.CFrame.Position).Magnitude
if d<espMaxDist then
if not espCache[p] or not espCache[p].Parent then
if espCache[p] then pcall(function() espCache[p]:Destroy() end) end
local h=Instance.new("Highlight")
h.FillColor=ec
h.FillTransparency=0.5
h.Adornee=ch
h.Parent=ch
espCache[p]=h
else espCache[p].FillColor=ec end
if not espNameCache[p] or not espNameCache[p].Parent then
local bb=Instance.new("BillboardGui")
bb.Size=UDim2.new(0,130,0,28)
bb.StudsOffset=Vector3.new(0,3.4,0)
bb.AlwaysOnTop=true
bb.Adornee=root
bb.Parent=root
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=p.Name.." "..math.floor(d).."m",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(190,130,255),TextSize=13,TextStrokeTransparency=0.3,Parent=bb})
espNameCache[p]=bb
end
else
if espCache[p] then pcall(function() espCache[p]:Destroy() end) espCache[p]=nil end
if espNameCache[p] then pcall(function() espNameCache[p]:Destroy() end) espNameCache[p]=nil end
end
else
if espCache[p] then pcall(function() espCache[p]:Destroy() end) espCache[p]=nil end
end
else
if espCache[p] then pcall(function() espCache[p]:Destroy() end) espCache[p]=nil end
end
end
end)
task.spawn(function()
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LS.Color=RGB(i*0.05)
LStat.Text="LENDO "..i.."%"
task.wait(0.015)
end
Tween(BG,{BackgroundTransparency=1},0.4)
task.wait(0.4)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-270)},0.5)
ScanClient()
InfoBox.Text=detectInfo
DumpBox.Text=scanTxt:sub(1,6000)
AutoDetect(false)
Notify("ZX CLIENT PRONTO")
end)
