local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Http=game:GetService("HttpService")
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
local scanTxt=""
local remoteList={}
local localList={}
local moduleList={}
local detectInfo="AGUARDANDO"
local sendStat="NAO ENVIADO"
if not _G.ZxDumpUrl then _G.ZxDumpUrl="https://thinkpad-maternity-bench-presently.trycloudflare.com/dump" end
_G.ZxDumpUrl="https://thinkpad-maternity-bench-presently.trycloudflare.com/dump"
SG=New("ScreenGui",{Name="ZxAnalyzer",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,Parent=LP:WaitForChild("PlayerGui")})
BG=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=10,Parent=SG})
LCard=New("Frame",{Size=UDim2.new(0,300,0,170),Position=UDim2.new(0.5,-150,0.5,-85),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ZIndex=12,Parent=BG})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=LCard})
LS=New("UIStroke",{Color=Color3.fromRGB(120,0,255),Thickness=1.5,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,28),Position=UDim2.new(0,0,0,12),BackgroundTransparency=1,Text="ZX ANALYZER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,ZIndex=13,Parent=LCard})
New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,44),BackgroundTransparency=1,Text="SOMENTE LEITURA DO CLIENT",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(120,90,200),TextSize=11,ZIndex=13,Parent=LCard})
LBTrack=New("Frame",{Size=UDim2.new(0.8,0,0,4),Position=UDim2.new(0.1,0,0,80),BackgroundColor3=Color3.fromRGB(10,6,18),BorderSizePixel=0,ZIndex=13,Parent=LCard})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBTrack})
LBFill=New("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(120,0,255),BorderSizePixel=0,ZIndex=14,Parent=LBTrack})
New("UICorner",{CornerRadius=UDim.new(0,2),Parent=LBFill})
LPct=New("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,94),BackgroundTransparency=1,Text="0%",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=12,ZIndex=13,Parent=LCard})
LStat=New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,118),BackgroundTransparency=1,Text="INICIANDO",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(90,70,130),TextSize=10,ZIndex=13,Parent=LCard})
local function Notify(txt)
pcall(function()
local h=SG:FindFirstChild("Nh")
if not h then return end
local n=New("Frame",{Size=UDim2.new(1,0,0,40),BackgroundColor3=Color3.fromRGB(5,2,12),BorderSizePixel=0,Parent=h})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=n})
task.delay(2.5,function() pcall(function() n:Destroy() end) end)
end)
end
local function ScanClient()
remoteList={}
localList={}
moduleList={}
local total=0
pcall(function()
for _,d in ipairs(game:GetDescendants()) do
total=total+1
if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") or d:IsA("BindableEvent") or d:IsA("BindableFunction") then
if #remoteList<150 then table.insert(remoteList,d:GetFullName()) end
end
if d:IsA("LocalScript") then
if #localList<150 then table.insert(localList,d:GetFullName()) end
end
if d:IsA("ModuleScript") then
if #moduleList<150 then table.insert(moduleList,d:GetFullName()) end
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
local f=workspace:FindFirstChild("Players")
local ch=nil
if f then ch=f:FindFirstChild(LP.Name) end
if not ch then ch=LP.Character end
if ch then
local n=ch:FindFirstChild("Nametag")
if n then
local l=n:FindFirstChild("Player")
if l then teamSys="COM NAMETAG" end
end
end
end)
local charPath="Character"
pcall(function()
local f=workspace:FindFirstChild("Players")
if f and f:FindFirstChild(LP.Name) then charPath="workspace.Players" end
end)
detectInfo="TOTAL "..total.." WS "..wsN.." RS "..rsN.." GUI "..guiN.." TOOLS "..toolN.." "..teamSys.." "..charPath.." PLACE "..game.PlaceId
local out={}
table.insert(out,"ZX CLIENT DUMP "..game.PlaceId)
table.insert(out,detectInfo)
table.insert(out,"REMOTES "..#remoteList)
for _,r in ipairs(remoteList) do table.insert(out,"R "..r) end
table.insert(out,"LOCALSCRIPTS "..#localList)
for _,r in ipairs(localList) do table.insert(out,"L "..r) end
table.insert(out,"MODULES "..#moduleList)
for _,r in ipairs(moduleList) do table.insert(out,"M "..r) end
table.insert(out,"SERVER NAO REPLICA ServerScriptService ServerStorage")
scanTxt=table.concat(out,"\n")
pcall(function()
local js=Http:JSONEncode({place=game.PlaceId,info=detectInfo,remotes=remoteList,locals=localList,modules=moduleList})
if writefile then writefile("ZX_CLIENT_DUMP.json",js) end
end)
return scanTxt
end
local function SendDump()
local url=_G.ZxDumpUrl
if UrlBox and UrlBox.Text and #UrlBox.Text>8 then url=UrlBox.Text _G.ZxDumpUrl=url end
if not url or url=="" then sendStat="SEM URL" SendStat.Text=sendStat return false end
local payload=""
local okj=pcall(function() payload=Http:JSONEncode({place=game.PlaceId,info=detectInfo,remotes=remoteList,locals=localList,modules=moduleList}) end)
if not okj or payload=="" then sendStat="JSON FALHOU" SendStat.Text=sendStat return false end
sendStat="ENVIANDO"
SendStat.Text=sendStat
local done=false
local errmsg=""
local req=request or http_request or syn_request or fluxus_request or request_async or http_request_async
if req then
local ok,res=pcall(function() return req({Url=url,Method="POST",Headers={["Content-Type"]="application/json"},Body=payload}) end)
if ok and res then
local code=res.StatusCode or res.Status or 0
if code==200 or code==0 then done=true else errmsg="HTTP "..code end
else errmsg="REQ FALHOU" end
end
if not done then
local ok2,err2=pcall(function() Http:PostAsync(url,payload,Enum.HttpContentType.ApplicationJson) end)
if ok2 then done=true else errmsg="POSTASYNC BLOQUEADO" end
end
if done then sendStat="ENVIADO OK" else sendStat="FALHA ENVIO" end
SendStat.Text=sendStat
Notify(sendStat)
return done
end
Panel=New("Frame",{Size=UDim2.new(0,340,0,520),Position=UDim2.new(0.5,-170,0.5,1200),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,ClipsDescendants=true,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=Panel})
PStroke=New("UIStroke",{Color=Color3.fromRGB(100,0,220),Thickness=1.8,Parent=Panel})
TopBar=New("Frame",{Size=UDim2.new(1,0,0,52),BackgroundColor3=Color3.new(0,0,0),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,16),Parent=TopBar})
New("TextLabel",{Size=UDim2.new(1,-60,1,0),Position=UDim2.new(0,14,0,0),BackgroundTransparency=1,Text="ZX ANALYZER",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,TextXAlignment=Enum.TextXAlignment.Left,Parent=TopBar})
CloseBtn=New("TextButton",{Size=UDim2.new(0,30,0,30),Position=UDim2.new(1,-42,0.5,-15),BackgroundColor3=Color3.fromRGB(18,5,35),BorderSizePixel=0,Text="X",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(180,80,255),TextSize=13,Parent=CloseBtn and TopBar or TopBar})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=CloseBtn})
Scroll=New("ScrollingFrame",{Size=UDim2.new(1,0,1,-52),Position=UDim2.new(0,0,0,52),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=Color3.fromRGB(120,0,240),CanvasSize=UDim2.new(0,0,0,900),ScrollingDirection=Enum.ScrollingDirection.Y,Parent=Panel})
Lay=New("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,HorizontalAlignment=Enum.HorizontalAlignment.Center,Parent=Scroll})
New("UIPadding",{PaddingTop=UDim.new(0,8),PaddingBottom=UDim.new(0,14),Parent=Scroll})
Lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Scroll.CanvasSize=UDim2.new(0,0,0,Lay.AbsoluteContentSize.Y+16) end)
local function Section(txt)
local f=New("Frame",{Size=UDim2.new(0.92,0,0,22),BackgroundTransparency=1,Parent=Scroll})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(110,80,160),TextSize=10,Parent=f})
end
local function BigBtn(txt)
local b=New("TextButton",{Size=UDim2.new(0.92,0,0,44),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
New("UIStroke",{Color=Color3.fromRGB(30,20,50),Thickness=1.2,Parent=b})
New("TextLabel",{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(170,160,190),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=b})
return b
end
Section("STATUS CLIENT")
InfoBox=New("TextLabel",{Size=UDim2.new(0.92,0,0,66),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="TOQUE EM ESCANEAR",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(150,130,200),TextSize=11,TextWrapped=true,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=InfoBox})
SendStat=New("TextLabel",{Size=UDim2.new(0.92,0,0,26),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="NAO ENVIADO",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,100,255),TextSize=11,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=SendStat})
Section("URL DESTINO")
UrlBox=New("TextBox",{Size=UDim2.new(0.92,0,0,40),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text=_G.ZxDumpUrl,Font=Enum.Font.Code,TextColor3=Color3.fromRGB(140,220,255),TextSize=10,TextWrapped=true,MultiLine=true,ClearTextOnFocus=false,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=UrlBox})
Section("ACOES")
BScan=BigBtn("ESCANEAR CLIENT")
BSend=BigBtn("ENVIAR PARA IA")
BCopy=BigBtn("COPIAR DUMP")
BSave=BigBtn("SAVEINSTANCE CLIENT")
Section("DUMP")
DumpBox=New("TextBox",{Size=UDim2.new(0.92,0,0,240),BackgroundColor3=Color3.fromRGB(5,3,12),BorderSizePixel=0,Text="",Font=Enum.Font.Code,TextColor3=Color3.fromRGB(140,220,255),TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,MultiLine=true,ClearTextOnFocus=false,Parent=Scroll})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=DumpBox})
Pop=New("TextButton",{Size=UDim2.new(0,58,0,30),Position=UDim2.new(1,-70,0,60),BackgroundColor3=Color3.fromRGB(4,2,10),BorderSizePixel=0,Text="ZX",Font=Enum.Font.GothamBold,TextColor3=Color3.fromRGB(160,80,255),TextSize=12,Visible=false,Parent=SG})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=Pop})
Nh=New("Frame",{Size=UDim2.new(0,270,0,200),Position=UDim2.new(0.5,-135,0.78,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=SG})
BScan.MouseButton1Click:Connect(function()
InfoBox.Text="ESCANEANDO"
local txt=ScanClient()
InfoBox.Text=detectInfo
DumpBox.Text=txt:sub(1,6000)
Notify("SCAN OK")
task.spawn(function() SendDump() end)
end)
BSend.MouseButton1Click:Connect(function()
task.spawn(function() SendDump() end)
end)
BCopy.MouseButton1Click:Connect(function()
if setclipboard and scanTxt~="" then setclipboard(scanTxt:sub(1,15000)) Notify("DUMP COPIADO") else Notify("ESCANEIE PRIMEIRO") end
end)
BSave.MouseButton1Click:Connect(function()
Notify("SALVANDO")
task.spawn(function()
local ok=pcall(function()
local P={RepoURL="https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/",SSI="saveinstance"}
local f=loadstring(game:HttpGet(P.RepoURL..P.SSI..".luau",true),P.SSI)()
f({Decompile=true,SavePlayers=false})
end)
Notify(ok and "SAVE OK" or "SAVE FALHOU")
end)
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
for i=0,100 do
LBFill.Size=UDim2.new(i/100,0,1,0)
LPct.Text=i.."%"
LS.Color=Color3.fromRGB(math.floor(100+i*0.8),0,255-math.floor(i*0.8))
LStat.Text="LENDO "..i.."%"
task.wait(0.012)
end
Tween(BG,{BackgroundTransparency=1},0.4)
task.wait(0.4)
BG:Destroy()
Panel.Visible=true
Tween(Panel,{Position=UDim2.new(0.5,-170,0.5,-260)},0.5)
local txt=ScanClient()
InfoBox.Text=detectInfo
DumpBox.Text=txt:sub(1,6000)
Notify("ANALYZER PRONTO")
task.spawn(function() SendDump() end)
end)
