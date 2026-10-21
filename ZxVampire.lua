local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local TS=game:GetService("TweenService")
local Http=game:GetService("HttpService")
repeat task.wait() until Players.LocalPlayer
local LP=Players.LocalPlayer
local GEN=(_G.ZxVampGen or 0)+1
_G.ZxVampGen=GEN
local FUNCS="Fun\195\167\195\181es"
pcall(function()
local old=LP.PlayerGui:FindFirstChild("ZxVampire")
if old then old:Destroy() end
end)
pcall(function() RS:UnbindFromRenderStep("ZxVamp") end)
local function New(c,p)
local o=Instance.new(c)
for k,v in pairs(p or {}) do o[k]=v end
return o
end
local function Tween(o,p,d)
TS:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play()
end
local function GetChar()
local f=workspace:FindFirstChild("Players")
if f then
local m=f:FindFirstChild(LP.Name)
if m then return m end
end
return LP.Character
end
local function GetHum()
local ch=GetChar()
if not ch then return nil,nil end
local h=ch:FindFirstChildOfClass("Humanoid")
return ch,h
end
local function GetRoot()
local ch=GetChar()
if not ch then return nil end
return ch:FindFirstChild("HumanoidRootPart")
end
local function PosOf(m)
local p=nil
pcall(function() p=m:GetPivot().Position end)
if not p then
local r=m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Head") or m:FindFirstChild("Torso")
if r then p=r.Position end
end
return p
end
local farmOn=false
local fistOn=true
local walkOn=true
local lookOn=true
local espOn=true
local markerOn=true
local antiAfkOn=true
local tpOn=false
local atkDist=7
local keepDist=4
local walkSpeed=24
local atkInterval=0.45
local wantLevel=0
local curTarget=nil
lastTarget=nil
local targetInfo=nil
local npcs={}
local levelsFound={}
local lvlSig=""
local scanT=0
local atkT=0
local equipT=0
local lastAtk=0
local lastWalk=0
local deadT=0
local aliveOnce=false
local lmap={}
local lvlCache={}
local cfg={}
local CFGFILE="ZXVL_CONFIG.json"
local function LoadCfg()
pcall(function()
if not readfile then return end
local s=readfile(CFGFILE)
if not s or s=="" then return end
local d=Http:JSONDecode(s)
if type(d)=="table" then
lmap=d.lmap or {}
cfg=d.cfg or {}
end
end)
end
local function SaveCfg()
pcall(function()
if not writefile then return end
writefile(CFGFILE,Http:JSONEncode({lmap=lmap,cfg=cfg,place=game.PlaceId}))
end)
end
LoadCfg()
local function NumOf(v)
if type(v)=="number" then return v end
if type(v)=="string" then
local n=tonumber(v)
if n then return n end
end
return nil
end
local LVKEYS={"Level","Levels","NPCLevel","HunterLevel","MobLevel","LevelValue","EnemyLevel","Years","Rank","Grade","Tier","Level_","Nivel"}
local function AttrLevel(m,hum)
local v=NumOf(m:GetAttribute("Level"))
if v then return v,"ATTR" end
for _,k in ipairs(LVKEYS) do
local a=NumOf(m:GetAttribute(k))
if a then return a,"ATTR" end
end
if hum then
for _,k in ipairs(LVKEYS) do
local a=NumOf(hum:GetAttribute(k))
if a then return a,"ATTR" end
end
end
local root=m:FindFirstChild("HumanoidRootPart")
if root then
for _,k in ipairs(LVKEYS) do
local a=NumOf(root:GetAttribute(k))
if a then return a,"ATTR" end
end
end
return nil,nil
end
local function LabelLevel(m)
local best=nil
for _,d in ipairs(m:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
local tx=""
pcall(function() tx=d.Text end)
if tx and tx~="" then
local low=string.lower(tx)
local n=tonumber(string.match(tx,"(%d+)"))
if n then
if string.find(low,"lv") or string.find(low,"level") or string.find(low,"nivel") or string.find(low,"n\195\161vel") then
return n,"LABEL"
end
if not best then best=n end
end
end
end
end
return best,"LABEL"
end
local function EstLevel(hp)
if not hp or hp<=0 then return 0 end
return math.floor(math.pow(hp/1288,1/0.3088)+0.5)
end
local function NPCLevel(m,hum)
local c=lvlCache[m]
local now=os.clock()
if c and now-c.t<5 then return c.l,c.s end
local v,s=AttrLevel(m,hum)
if v then lvlCache[m]={l=v,s=s,t=now} return v,s end
v,s=LabelLevel(m)
if v then lvlCache[m]={l=v,s=s,t=now} return v,s end
local n=tonumber(string.match(m.Name,"(%d+)%s*$"))
if not n then
local all={}
for w in string.gmatch(m.Name,"(%d+)") do table.insert(all,w) end
if #all>0 then n=tonumber(all[#all]) end
end
if n then lvlCache[m]={l=n,s="NOME",t=now} return n,"NOME" end
local hp=0
pcall(function() hp=hum and hum.MaxHealth or 0 end)
if hp>0 then
local key=string.format("%d",math.floor(hp+0.5))
if lmap[key] then lvlCache[m]={l=lmap[key],s="MAPA",t=now} return lmap[key],"MAPA" end
local est=EstLevel(hp)
lvlCache[m]={l=est,s="EST",t=now}
return est,"EST"
end
return 0,nil
end
local BADWORDS={"corpse","quest","shop","buyer","keeper","giver","campfire","dummy","aura","marquee","star","totem","sign"}
local GOODWORDS={"hunter","guard","human","mobs","mob","enemy","npc","zombie"}
local function IsPlayerModel(m)
for _,p in ipairs(Players:GetPlayers()) do
if p.Character==m then return true end
end
return false
end
local function KindOf(m)
local p=""
pcall(function() p=m:GetFullName() end)
local low=string.lower(p)
if string.find(low,"hunters") then return "HUNTER" end
if string.find(low,"guards") or string.find(low,"guard") then return "GUARD" end
if string.find(low,"humans") then return "HUMAN" end
if string.find(low,"npcs") then return "NPC" end
return "OUTRO"
end
local function IsFarmable(m)
if not m:IsA("Model") then return false end
local nm=string.lower(m.Name)
for _,w in ipairs(BADWORDS) do
if string.find(nm,w,1,true) then return false end
end
local hum=m:FindFirstChildOfClass("Humanoid")
if not hum then return false end
if not m:FindFirstChild("HumanoidRootPart") then return false end
if IsPlayerModel(m) then return false end
local k=KindOf(m)
if k=="HUNTER" or k=="GUARD" or k=="HUMAN" then return true end
for _,w in ipairs(GOODWORDS) do
if string.find(nm,w,1,true) then return true end
end
return false
end
local function ScanNPCs()
npcs={}
levelsFound={}
local seen={}
local list={}
local root=workspace:FindFirstChild("NPCS")
local scan=root and root:GetDescendants() or workspace:GetDescendants()
for _,d in ipairs(scan) do
if d:IsA("Model") and not seen[d] then
seen[d]=true
if IsFarmable(d) then table.insert(list,d) end
end
end
if #list<10 then
for _,d in ipairs(workspace:GetDescendants()) do
if d:IsA("Model") and not seen[d] then
seen[d]=true
if IsFarmable(d) then table.insert(list,d) end
end
end
end
local r=GetRoot()
local rp=r and r.Position or nil
for _,m in ipairs(list) do
local hum=m:FindFirstChildOfClass("Humanoid")
local hp=0
local mh=0
pcall(function() hp=hum.Health end)
pcall(function() mh=hum.MaxHealth end)
if hp<=0 then
table.insert(npcs,{m=m,dead=true,name=m.Name,kind=KindOf(m),hp=hp,mh=mh,lvl=0,src="MORTO",dist=99999})
else
local lv,src=NPCLevel(m,hum)
local p=PosOf(m)
local dist=99999
if p and rp then dist=math.floor((p-rp).Magnitude*10)/10 end
table.insert(npcs,{m=m,dead=false,name=m.Name,kind=KindOf(m),hp=hp,mh=mh,lvl=lv,src=src or "?",dist=dist,pos=p})
end
end
for _,e in ipairs(npcs) do
if e.lvl>0 then levelsFound[e.lvl]=true end
end
if next(lvlCache) then
for k in pairs(lvlCache) do
if not k.Parent then lvlCache[k]=nil end
end
end
return npcs
end
local function PickTarget()
local list={}
for _,e in ipairs(npcs) do
if not e.dead then
local ok=true
if wantLevel>0 and e.lvl~=wantLevel then ok=false end
if ok then table.insert(list,e) end
end
end
if #list==0 then return nil end
table.sort(list,function(a,b) return a.dist<b.dist end)
return list[1]
end
local function GetCombatRemote()
local rs=game:GetService("ReplicatedStorage")
local r=nil
pcall(function()
local f=rs:FindFirstChild(FUNCS)
if f then
local g=f:FindFirstChild("Game15Fists")
if g then r=g:FindFirstChild("CombatRemote") end
end
end)
if r then return r end
for _,d in ipairs(rs:GetDescendants()) do
if d:IsA("RemoteEvent") and d.Name=="CombatRemote" then return d end
end
return nil
end
local combatRem=nil
local function FindFists(ch)
if not ch then return nil end
local bp=LP:FindFirstChildOfClass("Backpack")
local f=nil
pcall(function() if bp then f=bp:FindFirstChild("Fists") end end)
if not f then pcall(function() f=ch:FindFirstChild("Fists") end) end
if not f then
pcall(function()
for _,d in ipairs(ch:GetDescendants()) do
if d:IsA("Tool") and string.find(string.lower(d.Name),"fist") then f=d break end
end
end)
end
return f
end
local function DoAttack()
local ch,hum=GetHum()
if not ch or not hum then return end
if hum.Health<=0 then return end
if ch:GetAttribute("ActionLocked")==true then return end
local fists=FindFists(ch)
if not fists then return end
if fists.Parent~=ch then
pcall(function() hum:EquipTool(fists) end)
equipT=os.clock()
return
end
if os.clock()-equipT<0.14 then return end
if os.clock()-lastAtk<atkInterval then return end
if not combatRem then combatRem=GetCombatRemote() end
if not combatRem then return end
local ok=pcall(function() combatRem:FireServer("Attack",false) end)
if not ok then pcall(function() combatRem:FireServer("Attack") end) end
lastAtk=os.clock()
end
local function DoMove()
if not walkOn then return end
if not curTarget then return end
local ch,hum=GetHum()
if not ch or not hum then return end
if hum.Health<=0 then return end
local root=ch:FindFirstChild("HumanoidRootPart")
if not root then return end
local tp=curTarget.pos
if not tp then
tp=PosOf(curTarget.m)
curTarget.pos=tp
end
if not tp then return end
local d=(root.Position-tp).Magnitude
if tpOn then
if d>keepDist then
local dir=tp-root.Position
local dm=dir.Magnitude
if dm>0.01 then root.CFrame=CFrame.lookAt(root.Position+dir*(0.6/dm),tp) end
end
return
end
if d>atkDist then
hum:MoveTo(tp)
elseif d<keepDist and keepDist<atkDist then
local back=root.Position-tp
local mag=back.Magnitude
if mag>0.01 then hum:MoveTo(root.Position+back*(5/mag)) end
else
hum:MoveTo(root.Position)
end
end
local function DoLook()
if not lookOn then return end
if not curTarget then return end
local tp=curTarget.pos or PosOf(curTarget.m)
if not tp then return end
local cam=workspace.CurrentCamera
if not cam then return end
local ch=GetChar()
local root=ch and ch:FindFirstChild("HumanoidRootPart")
if not root then return end
local dist=(root.Position-tp).Magnitude
if dist>atkDist+12 then return end
local cf=CFrame.lookAt(cam.CFrame.Position,tp)
cam.CFrame=cf
end
local function FaceTarget()
if not lookOn then return end
if not curTarget then return end
local ch=GetChar()
local root=ch and ch:FindFirstChild("HumanoidRootPart")
if not root then return end
local tp=curTarget.pos or PosOf(curTarget.m)
if not tp then return end
local d=(root.Position-tp).Magnitude
if d>atkDist+2 then return end
local dir=(tp-root.Position)
if dir.Magnitude<0.01 then return end
pcall(function() root.CFrame=CFrame.lookAt(root.Position,tp) end)
end
SG=New("ScreenGui",{Name="ZxVampire",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,310,0,220),Position=UDim2.new(0.5,-155,0.5,-110),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,36),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=26,ZIndex=13,Parent=LCard})
LTitle=New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,50),BackgroundTransparency=1,Text="ZX VAMPIRE LIFE",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=19,ZIndex=13,Parent=LCard})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(180,80,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,200,255))}),Parent=LTitle})
LSub=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,80),BackgroundTransparency=1,Text="AUTO FARM PUNHO  V2026",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(100,60,180),TextSize=10,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.82,0,0,4),Position=UDim2.new(0.09,0,0,112),BackgroundColor3=Color3.fromRGB(8,5,15),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(120,0,255),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(100,0,200)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,210,255))}),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,18),Position=UDim2.new(0,0,0,124),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=12,ZIndex=13,Parent=LCard})
LStat=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,148),BackgroundTransparency=1,Text="CARREGANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(70,45,110),TextSize=10,ZIndex=13,Parent=LCard})
local Nlist={}
local function Notify(txt)
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
Panel=New("Frame",{Size=UDim2.new(0,340,0,540),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.8,Parent=Panel})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(8,4,18)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}),Rotation=135,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(12,5,28)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}),Rotation=90,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(0,28,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(140,0,255),TextSize=15,Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-110,1,0),Position=UDim2.new(0,40,0,0),BackgroundTransparency=1,Text="ZX VAMPIRE LIFE",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
MinBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-78,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="-",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=16,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=MinBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1.2,Parent=MinBtn})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=13,Parent=TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
New("UIStroke",{Color=Color3.fromRGB(80,0,160),Thickness=1.2,Parent=CloseBtn})
TabBar=New("Frame",{Size=UDim2.new(1,0,0,38),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,Parent=Panel})
TabBtns={}
Pages={}
local tabNames={"FARM","NPCS","CONFIG"}
for i,nm in ipairs(tabNames) do
local b=New("TextButton",{Size=UDim2.new(0.32,0,0,30),Position=UDim2.new(0.01 + (i-1)*0.33,0,0,4),BackgroundColor3=i==1 and Color3.fromRGB(22,0,44) or Color3.fromRGB(8,5,15),BorderSizePixel=0,Text=nm,Font=Enum.Font.GothamBold,TextColor3=i==1 and Color3.fromRGB(200,140,255) or Color3.fromRGB(120,110,140),TextSize=11,Parent=TabBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
New("UIStroke",{Color=i==1 and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50),Thickness=1.2,Parent=b})
TabBtns[i]=b
end
for i=1,3 do
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
local function SetBtn(b,st,txt)
b.BackgroundColor3=st and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12)
local t=b:FindFirstChild("Txt")
local ic=b:FindFirstChild("Ico")
if t then
t.TextColor3=st and Color3.fromRGB(200,140,255) or Color3.fromRGB(160,155,175)
if txt then t.Text=txt end
end
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
local function MakeInput(parent,title,ph,cb)
local outer=New("Frame",{Size=UDim2.new(0.92,0,0,46),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Parent=parent})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=outer})
New("UIStroke",{Color=Color3.fromRGB(30,20,50),Thickness=1,Parent=outer})
New("TextLabel",{Size=UDim2.new(0.44,0,0,16),Position=UDim2.new(0,10,0,4),BackgroundTransparency=1,Text=title,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(130,100,200),TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,Parent=outer})
local tb=New("TextBox",{Size=UDim2.new(0.46,0,0,28),Position=UDim2.new(0.5,0,0.5,-14),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Text="",PlaceholderText=ph,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,150,255),TextSize=13,ClearTextOnFocus=false,Parent=outer})
New("UICorner",{CornerRadius=UDim.new(0,7),Parent=tb})
tb.FocusLost:Connect(function()
cb(tb.Text)
end)
return outer,tb
end
P1=Pages[1]
P2=Pages[2]
P3=Pages[3]
local FarmStat=New("TextLabel",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="PARADO",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=11,TextWrapped=true,Parent=P1})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=FarmStat})
Section(P1,"FARM PUNHO")
BFarm=MakeBtn(P1,"AUTO FARM OFF",false)
BFist=MakeBtn(P1,"PUNHO ON",true)
BWalk=MakeBtn(P1,"ANDAR ATE O NPC ON",true)
Section(P1,"MIRA E MOVIMENTO")
TLook,TDLook=MakeRow(P1,"OLHAR PARA O NPC",true)
TTp,TDTp=MakeRow(P1,"TELEPORTE",false)
TAnti,TDAnti=MakeRow(P1,"ANTI AFK",true)
Section(P1,"AJUSTES")
MakeSlider(P1,"DIST ATAQUE",3,25,atkDist,function(v) atkDist=v end)
MakeSlider(P1,"DIST MINIMA",1,20,keepDist,function(v) keepDist=v end)
MakeSlider(P1,"VELOCIDADE",8,80,walkSpeed,function(v) walkSpeed=v end)
MakeSlider(P1,"INTERVALO ATAQUE",1,20,4,function(v) atkInterval=v/10 end)
Section(P1,"NIVEL DO NPC")
local LevelBox,LvlInput=MakeInput(P1,"NIVEL","0 = TODOS",function(txt)
local n=tonumber(txt)
wantLevel=n or 0
Notify("NIVEL "..(wantLevel>0 and wantLevel or "TODOS"))
RefreshNPCList()
end)
Section(P1,"ALVO")
BRescan=MakeBtn(P1,"REESCANEAR NPCS")
BPick=MakeBtn(P1,"MARCAR ALVO NO ESP")
BStop=MakeBtn(P1,"PARAR FARM")
Section(P2,"LISTA DE NPCS")
NpcInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,30),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="NPCS 0",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=11,TextWrapped=true,Parent=P2})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=NpcInfo})
NpcRows=New("Frame",{Size=UDim2.new(1,0,0,10),BackgroundTransparency=1,Parent=P2})
NpcRowLay=New("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=NpcRows})
Section(P2,"ESP DE NPCS")
TEsp,TEspD=MakeRow(P2,"MOSTRAR ESP NPC",true)
TMark,TMarkD=MakeRow(P2,"MARCAR ALVO",true)
Section(P2,"NIVEL RAPIDO")
LvlBtns=New("Frame",{Size=UDim2.new(1,0,0,10),BackgroundTransparency=1,Parent=P2})
LvlLay=New("UIListLayout",{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=LvlBtns})
Section(P3,"AJUSTES DE NIVEL")
BTeach=MakeBtn(P3,"APRENDER NIVEL DO ALVO")
LvlInfo=New("TextLabel",{Size=UDim2.new(0.92,0,0,50),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="MAPA DE NIVEL VAZIO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(140,120,190),TextSize=11,TextWrapped=true,Parent=P3})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=LvlInfo})
Section(P3,"SISTEMA")
TEsp2,TEsp2D=MakeRow(P3,"ESP NPCS",true)
TSave,TSaveD=MakeRow(P3,"SALVAR CONFIG",false)
BReset=MakeBtn(P3,"LIMPAR MAPA DE NIVEL")
BReload=MakeBtn(P3,"RECARREGAR MAPA")
local function RefreshLvlInfo()
local ks={}
for k,v in pairs(lmap) do table.insert(ks,k.."="..v) end
table.sort(ks)
LvlInfo.Text=#ks>0 and table.concat(ks,"  ") or "MAPA DE NIVEL VAZIO"
end
local function RefreshNpcList()
for _,c in ipairs(NpcRows:GetChildren()) do
if c:IsA("TextButton") then pcall(function() c:Destroy() end) end
end
local list={}
for _,e in ipairs(npcs) do table.insert(list,e) end
table.sort(list,function(a,b) return a.dist<b.dist end)
local n=0
for _,e in ipairs(list) do
if n>=24 then break end
n=n+1
local col=e.dead and Color3.fromRGB(120,60,60) or (e.kind=="HUNTER" and Color3.fromRGB(200,120,90) or Color3.fromRGB(120,170,220))
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,34),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,LayoutOrder=n,Parent=NpcRows})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(28,16,50),Thickness=1,Parent=b})
local txt=e.name.."  LV"..e.lvl.." ("..e.src..")  HP"..math.floor(e.hp).."/"..math.floor(e.mh).."  D"..e.dist
New("TextLabel",{Size=UDim2.new(1,-16,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=col,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=b})
b.MouseButton1Click:Connect(function()
if e.dead then Notify("NPC MORTO") return end
curTarget=e
targetInfo=e
Notify("ALVO "..e.name.." LV"..e.lvl)
SetBtn(BFarm,farmOn,farmOn and "AUTO FARM ON" or "AUTO FARM OFF")
end)
end
NpcInfo.Text="NPCS "..#npcs.."  ALVO "..(curTarget and curTarget.name or "NENHUM")
end
local function RefreshLvlButtons()
local ks={}
for k in pairs(levelsFound) do table.insert(ks,k) end
table.sort(ks)
local sig=table.concat(ks,",")
if sig==lvlSig then return end
lvlSig=sig
for _,c in ipairs(LvlBtns:GetChildren()) do
if c:IsA("TextButton") then pcall(function() c:Destroy() end) end
end
local all=New("TextButton",{Size=UDim2.new(0.92,0,0,32),BackgroundColor3=wantLevel==0 and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,LayoutOrder=0,Parent=LvlBtns})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=all})
New("UIStroke",{Color=wantLevel==0 and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50),Thickness=1,Parent=all})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,6,0,0),BackgroundTransparency=1,Text="TODOS OS NIVEIS",Font=Enum.Font.GothamBold,TextColor3=wantLevel==0 and Color3.fromRGB(200,140,255) or Color3.fromRGB(150,140,170),TextSize=11,Parent=all})
all.MouseButton1Click:Connect(function()
wantLevel=0
LvlInput.Text=""
Notify("NIVEL TODOS")
RefreshLvlButtons()
RefreshNpcList()
end)
for i,k in ipairs(ks) do
if i>12 then break end
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,32),BackgroundColor3=wantLevel==k and Color3.fromRGB(22,0,44) or Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,LayoutOrder=i,Parent=LvlBtns})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
New("UIStroke",{Color=wantLevel==k and Color3.fromRGB(100,0,220) or Color3.fromRGB(30,20,50),Thickness=1,Parent=b})
local cnt=0
for _,e in ipairs(npcs) do
if e.lvl==k then cnt=cnt+1 end
end
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,6,0,0),BackgroundTransparency=1,Text="NIVEL "..k.."  ("..cnt.." NPCS)",Font=Enum.Font.GothamBold,TextColor3=wantLevel==k and Color3.fromRGB(200,140,255) or Color3.fromRGB(150,140,170),TextSize=11,Parent=b})
b.MouseButton1Click:Connect(function()
wantLevel=k
LvlInput.Text=tostring(k)
Notify("NIVEL "..k)
RefreshLvlButtons()
RefreshNpcList()
end)
end
end
local function SetFarm(st)
farmOn=st
SetBtn(BFarm,farmOn,farmOn and "AUTO FARM ON" or "AUTO FARM OFF")
FarmStat.Text=farmOn and "FARM ATIVO" or "PARADO"
if not farmOn then
local ch,hum=GetHum()
if ch and hum then pcall(function() hum:MoveTo(ch:FindFirstChild("HumanoidRootPart").Position) end) end
end
end
BFarm.MouseButton1Click:Connect(function()
SetFarm(not farmOn)
Notify(farmOn and "FARM LIGADO" or "FARM DESLIGADO")
if farmOn then
ScanNPCs()
RefreshLvlButtons()
RefreshNpcList()
end
end)
BFist.MouseButton1Click:Connect(function()
fistOn=not fistOn
SetBtn(BFist,fistOn,fistOn and "PUNHO ON" or "PUNHO OFF")
end)
BWalk.MouseButton1Click:Connect(function()
walkOn=not walkOn
SetBtn(BWalk,walkOn,walkOn and "ANDAR ATE O NPC ON" or "ANDAR ATE O NPC OFF")
end)
TLook.MouseButton1Click:Connect(function()
lookOn=not lookOn
SetTog(TLook,TDLook,lookOn)
end)
TTp.MouseButton1Click:Connect(function()
tpOn=not tpOn
SetTog(TTp,TDTp,tpOn)
Notify(tpOn and "TELEPORTE ON" or "TELEPORTE OFF")
end)
TAnti.MouseButton1Click:Connect(function()
antiAfkOn=not antiAfkOn
SetTog(TAnti,TDAnti,antiAfkOn)
end)
TEsp.MouseButton1Click:Connect(function()
espOn=not espOn
SetTog(TEsp,TEspD,espOn)
if not espOn then ClearESP() end
end)
TMark.MouseButton1Click:Connect(function()
markerOn=not markerOn
SetTog(TMark,TMarkD,markerOn)
if not markerOn then pcall(function() if Marker then Marker:Destroy() Marker=nil end end) end
end)
TEsp2.MouseButton1Click:Connect(function()
espOn=not espOn
SetTog(TEsp2,TEsp2D,espOn)
SetTog(TEsp,TEspD,espOn)
if not espOn then ClearESP() end
end)
TSave.MouseButton1Click:Connect(function()
SaveCfg()
SetTog(TSave,TSaveD,true)
Notify("CONFIG SALVA")
end)
BReset.MouseButton1Click:Connect(function()
lmap={}
SaveCfg()
RefreshLvlInfo()
Notify("MAPA LIMPO")
end)
BReload.MouseButton1Click:Connect(function()
LoadCfg()
RefreshLvlInfo()
Notify("MAPA RECARREGADO")
end)
BTeach.MouseButton1Click:Connect(function()
if not curTarget then Notify("MARQUE UM ALVO NA LISTA") return end
local inp=New("TextBox",{Size=UDim2.new(0.6,0,0,30),Position=UDim2.new(0.5,0,0.5,-15),BackgroundColor3=Color3.fromRGB(10,7,18),BorderSizePixel=0,Text="",PlaceholderText="NIVEL",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(200,150,255),TextSize=13,ClearTextOnFocus=false,Parent=P3})
New("UICorner",{CornerRadius=UDim.new(0,7),Parent=inp})
inp.FocusLost:Connect(function()
local n=tonumber(inp.Text)
if n and curTarget and curTarget.mh>0 then
lmap[string.format("%d",math.floor(curTarget.mh+0.5))]=n
SaveCfg()
RefreshLvlInfo()
ScanNPCs()
RefreshLvlButtons()
RefreshNpcList()
Notify("NIVEL "..n.." APRENDIDO PARA HP "..math.floor(curTarget.mh))
end
pcall(function() inp:Destroy() end)
end)
end)
BRescan.MouseButton1Click:Connect(function()
ScanNPCs()
RefreshLvlButtons()
RefreshNpcList()
Notify("NPCS "..#npcs)
end)
BPick.MouseButton1Click:Connect(function()
local best=nil
local root=GetRoot()
if not root then return end
for _,e in ipairs(npcs) do
if not e.dead and e.pos then
local d=(e.pos-root.Position).Magnitude
if not best or d<best.d then best={e=e,d=d} end
end
end
if best then
curTarget=best.e
targetInfo=best.e
Notify("ALVO "..curTarget.name.." LV"..curTarget.lvl)
RefreshNpcList()
end
end)
BStop.MouseButton1Click:Connect(function()
SetFarm(false)
curTarget=nil
RefreshNpcList()
end)
Nh=New("Frame",{Size=UDim2.new(0,270,0,320),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
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
if dragPop and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1) then
dragPop=false
if not moved then task.spawn(OpenMenu) end
end
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
MinBtn.MouseButton1Click:Connect(function()
Tween(Panel,{Size=UDim2.new(0,340,0,250)},0.25)
end)
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
local ESPFolder=New("Folder",{Name="ZxVampireESP",Parent=SG})
local ESPCache={}
local Marker=nil
local function ClearESP()
for _,d in ipairs(ESPFolder:GetChildren()) do
pcall(function() d:Destroy() end)
end
ESPCache={}
end
local function MakeESP(e)
if ESPCache[e.m] then return end
local holder=New("Folder",{Parent=ESPFolder})
local bb=New("BillboardGui",{Size=UDim2.new(0,150,0,40),StudsOffset=Vector3.new(0,3,0),AlwaysOnTop=true,MaxDistance=900,Parent=holder})
New("TextLabel",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Text=e.name.." LV"..e.lvl,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,190,120),TextSize=13,TextStrokeTransparency=0.4,Parent=bb})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,18),BackgroundTransparency=1,Text="HP"..math.floor(e.hp).."/"..math.floor(e.mh).." D"..e.dist,Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(160,230,255),TextSize=11,TextStrokeTransparency=0.4,Parent=bb})
ESPCache[e.m]={holder=holder,bb=bb,t1=bb:FindFirstChildOfClass("TextLabel")}
if e.m:FindFirstChild("HumanoidRootPart") then
bb.Adornee=e.m:FindFirstChild("HumanoidRootPart")
end
end
local function UpdateESP()
if not espOn then return end
for _,e in ipairs(npcs) do
if not e.dead and e.dist<800 then
MakeESP(e)
local c=ESPCache[e.m]
if c then
local hp=0
pcall(function() hp=e.m:FindFirstChildOfClass("Humanoid").Health end)
e.hp=hp
if c.t1 then c.t1.Text=e.name.." LV"..e.lvl end
local t2=c.bb:FindFirstChildOfClass("TextLabel",false)
if t2 then t2.Text="HP"..math.floor(hp).."/"..math.floor(e.mh).." D"..e.dist end
end
end
end
end
local function UpdateMarker()
if not markerOn then return end
if not curTarget or curTarget.dead then
pcall(function() if Marker then Marker:Destroy() Marker=nil end end)
return
end
local root=curTarget.m:FindFirstChild("HumanoidRootPart") or curTarget.m:FindFirstChild("Head")
if not root then return end
if not Marker then
Marker=New("BillboardGui",{Size=UDim2.new(0,60,0,60),StudsOffset=Vector3.new(0,4,0),AlwaysOnTop=true,Parent=SG})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="▼",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(255,60,120),TextSize=30,TextStrokeTransparency=0.3,Parent=Marker})
end
Marker.Adornee=root
Marker.Visible=true
end
task.spawn(function()
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LStat.Text="CARREGANDO "..i.."%"
task.wait(0.012)
end
Tween(BG,{BackgroundTransparency=1},0.4)
task.wait(0.4)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-260)},0.5)
ScanNPCs()
RefreshLvlButtons()
RefreshNpcList()
RefreshLvlInfo()
Notify("ZX VAMPIRE LIFE PRONTO")
end)
task.spawn(function()
local tick=0
while task.wait(0.4) do
if _G.ZxVampGen~=GEN then break end
ScanNPCs()
RefreshLvlButtons()
tick=tick+1
if tick%3==0 then RefreshNpcList() end
end
end)
task.spawn(function()
while task.wait(0.2) do
if _G.ZxVampGen~=GEN then break end
if farmOn then
local ch,hum=GetHum()
if ch and hum and hum.Health<=0 then
deadT=deadT+0.2
if deadT>3 then
deadT=0
curTarget=nil
Notify("VOCE MORREU - RESPAWN")
end
else
deadT=0
aliveOnce=true
if not curTarget or curTarget.dead or not curTarget.m.Parent or (curTarget.hp<=0) then
if curTarget and curTarget.hp<=0 then
Notify("NPC "..curTarget.name.." MORREU - TROCA")
end
curTarget=PickTarget()
targetInfo=curTarget
if curTarget then Notify("NOVO ALVO "..curTarget.name.." LV"..curTarget.lvl) end
else
local h2=curTarget.m:FindFirstChildOfClass("Humanoid")
if h2 then curTarget.hp=h2.Health end
end
if curTarget then
if walkSpeed and hum then
pcall(function() hum.WalkSpeed=walkSpeed end)
end
DoMove()
DoLook()
FaceTarget()
if fistOn then
local root=GetRoot()
local d=root and curTarget.pos and (root.Position-curTarget.pos).Magnitude or 99999
if d<=atkDist then DoAttack() end
end
end
end
end
end
end)
task.spawn(function()
while task.wait(1) do
if _G.ZxVampGen~=GEN then break end
if antiAfkOn then
pcall(function()
LP:MoveTo(LP.Character and LP.Character:GetPivot().Position or Vector3.new(0,0,0),true)
end)
end
UpdateESP()
UpdateMarker()
end
end)
RS.RenderStepped:Connect(function()
if _G.ZxVampGen~=GEN then return end
PStroke.Color=Color3.fromRGB(100,0,220)
end)
