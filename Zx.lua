local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zx"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function RGB(t) return Color3.fromRGB(math.sin(t*1.8)*127+128, math.sin(t*1.8+2.094)*127+128, math.sin(t*1.8+4.189)*127+128) end
local function New(t,p) local o=Instance.new(t) for k,v in pairs(p or {}) do o[k]=v end return o end
local function T(o,p,d) TweenService:Create(o,TweenInfo.new(d or 0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play() end

local Load = New("Frame",{Size=UDim2.new(0,360,0,200),Position=UDim2.new(0.5,-180,0.5,-100),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=Load})
local LS = New("UIStroke",{Color=RGB(0),Thickness=2.5,Transparency=0.3,Parent=Load})
New("TextLabel",{Size=UDim2.new(1,0,0,40),BackgroundTransparency=1,Text="Zx v2026",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=24,TextXAlignment=Enum.TextXAlignment.Center,Parent=Load})
local LD = New("TextLabel",{Size=UDim2.new(1,0,0,22),Position=UDim2.new(0,0,0,45),BackgroundTransparency=1,Text="Carregando.",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(180,180,180),TextSize=15,TextXAlignment=Enum.TextXAlignment.Center,Parent=Load})
local LB = New("Frame",{Size=UDim2.new(0,0,0,8),Position=UDim2.new(0.5,-160,0.5,80),BackgroundColor3=RGB(1),BorderSizePixel=0,Parent=Load})
New("UICorner",{CornerRadius=UDim.new(0,4),Parent=LB})
local LT = New("TextLabel",{Size=UDim2.new(1,0,0,25),Position=UDim2.new(0,0,0,100),BackgroundTransparency=1,Text="0%",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(180,180,180),TextSize=16,TextXAlignment=Enum.TextXAlignment.Center,Parent=Load})

local Notif = New("Frame",{Name="Notifs",Size=UDim2.new(0,260,0,300),Position=UDim2.new(0.5,-130,0.85,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
local NList = {}
local function Notify(txt)
    local n = New("Frame",{Size=UDim2.new(1,0,0,38),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(14,14,14),BorderSizePixel=0,Parent=Notif})
    New("UICorner",{CornerRadius=UDim.new(0,8),Parent=n})
    New("UIStroke",{Color=RGB(0),Thickness=1.5,Parent=n})
    New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=Enum.TextXAlignment.Center,Parent=n})
    T(n,{Position=UDim2.new(0,0,1-(#NList+1)*0.16,0)},0.3)
    table.insert(NList,n)
    task.delay(2.8,function()
        T(n,{Position=UDim2.new(0,0,1.5,0),BackgroundTransparency=1},0.25)
        task.wait(0.25); n:Destroy()
        table.remove(NList,1)
    end)
end

local Panel = New("Frame",{Name="Main",Size=UDim2.new(0,280,0,460),Position=UDim2.new(0.5,-140,0.5,1000),BackgroundColor3=Color3.fromRGB(8,8,8),BorderSizePixel=0,Parent=ScreenGui,Visible=false})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=Panel})
local PS = New("UIStroke",{Color=RGB(0),Thickness=2.5,Transparency=0.2,Parent=Panel})
local TB = New("Frame",{Size=UDim2.new(1,0,0,50),BackgroundColor3=Color3.fromRGB(12,12,12),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,14),Parent=TB})
New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="Zx MENU",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=20,TextXAlignment=Enum.TextXAlignment.Center,Parent=TB})
New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,0),BackgroundColor3=RGB(1),BorderSizePixel=0,Parent=TB})

local function Btn(txt,y,s)    local b = New("TextButton",{Size=UDim2.new(0.85,0,0,40),Position=UDim2.new(0.075,0,y,0),BackgroundColor3=s and Color3.fromRGB(0,80,0) or Color3.fromRGB(20,20,20),BorderSizePixel=0,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=Enum.TextXAlignment.Left,Parent=Panel})
    New("UICorner",{CornerRadius=UDim.new(0,8),Parent=b})
    New("UIStroke",{Color=s and Color3.fromRGB(0,120,0) or Color3.fromRGB(45,45,45),Thickness=1.5,Parent=b})
    b.MouseEnter:Connect(function() T(b,{BackgroundTransparency=0.1},0.15) end)
    b.MouseLeave:Connect(function() T(b,{BackgroundTransparency=0},0.15) end)
    return b
end

local AB = Btn("Mira: OFF",0.11,false)
local CB = Btn("RGB Círculo: OFF",0.23,false)
local EB = Btn("ESP: OFF",0.35,false)
local RB = Btn("RGB ESP: OFF",0.47,false)

local SL = New("Frame",{Size=UDim2.new(0.85,0,0,45),Position=UDim2.new(0.075,0,0.59,0),BackgroundColor3=Color3.fromRGB(16,16,16),BorderSizePixel=0,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,8),Parent=SL})
local SLT = New("TextLabel",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Text="Raio: 500",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(200,200,200),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=SL})
local STR = New("Frame",{Size=UDim2.new(0.85,0,0,6),Position=UDim2.new(0.075,0,0.52,0),BackgroundColor3=Color3.fromRGB(25,25,25),BorderSizePixel=0,Parent=SL})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=STR})
local SF = New("Frame",{Size=UDim2.new(0.5,0,1,0),BackgroundColor3=RGB(2),BorderSizePixel=0,Parent=STR})
New("UICorner",{CornerRadius=UDim.new(0,3),Parent=SF})
local ST = New("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(0.5,-6,0.5,-6),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Parent=STR})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=ST})

local aimPart = "Cabeça"
local checkboxes = {}
local function Checkbox(txt,y,active)
    local f = New("Frame",{Size=UDim2.new(0.85,0,0,24),Position=UDim2.new(0.075,0,y,0),BackgroundColor3=Color3.fromRGB(18,18,18),BorderSizePixel=0,Parent=Panel})
    New("UICorner",{CornerRadius=UDim.new(0,5),Parent=f})
    local ch = New("Frame",{Size=UDim2.new(0,12,0,12),Position=UDim2.new(0.04,0,0.5,-6),BackgroundColor3=active and Color3.fromRGB(0,90,0) or Color3.fromRGB(35,35,35),BorderSizePixel=0,Parent=f})
    New("UICorner",{CornerRadius=UDim.new(0,2),Parent=ch})
    if active then New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ch}) end
    New("TextLabel",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0.20,0,0,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,Parent=f})
    f.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            for _,cb in pairs(checkboxes) do
                cb.Indicator.BackgroundColor3 = Color3.fromRGB(35,35,35)
                local m = cb.Indicator:FindFirstChildOfClass("TextLabel")
                if m then m:Destroy() end
                cb.Active = false
            end
            ch.BackgroundColor3 = Color3.fromRGB(0,90,0)
            if not ch:FindFirstChildOfClass("TextLabel") then New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=10,TextXAlignment=Enum.TextXAlignment.Center,Parent=ch}) end
            aimPart = txt
            Notify("Alvo: "..txt)
        end
    end)
    table.insert(checkboxes, {Frame=f, Indicator=ch, Active=active})
end

Checkbox("Cabeça",0.71,true)Checkbox("Peito",0.77,false)
Checkbox("Pé",0.83,false)

local CV = New("Frame",{Name="Circle",Size=UDim2.new(0,1000,0,1000),Position=UDim2.new(0.5,-500,0.5,-500),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CV})
local CVS = New("UIStroke",{Color=Color3.new(0.6,0,1),Thickness=2,Transparency=0.3,Parent=CV})
local CVF = New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0.6,0,1),BackgroundTransparency=0.9,BorderSizePixel=0,Parent=CV})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CVF})

local CH = New("Frame",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0.5,-9,0.5,-9),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
local chDot = New("Frame",{Size=UDim2.new(0,3,0,3),Position=UDim2.new(0.5,-1.5,0.5,-1.5),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Parent=CH})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=chDot})
New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,0.5,-1),BackgroundColor3=Color3.fromRGB(220,220,220),BorderSizePixel=0,Parent=CH})
New("Frame",{Size=UDim2.new(0,2,1,0),Position=UDim2.new(0.5,-1,0,0),BackgroundColor3=Color3.fromRGB(220,220,220),BorderSizePixel=0,Parent=CH})

local aO,rCO,eO,rEO = false,false,false,false
local cS = 500
local tgt = nil
local eC = {}

AB.MouseButton1Click:Connect(function() aO=not aO AB.Text="Mira: "..(aO and "ON" or "OFF") AB.BackgroundColor3=aO and Color3.fromRGB(0,80,0) or Color3.fromRGB(20,20,20) Notify("Mira "..(aO and "Ativada" or "Desativada")) CV.Visible=aO end)
CB.MouseButton1Click:Connect(function() rCO=not rCO CB.Text="RGB Círculo: "..(rCO and "ON" or "OFF") Notify("RGB Círculo "..(rCO and "Ativado" or "Desativado")) end)
EB.MouseButton1Click:Connect(function() eO=not eO EB.Text="ESP: "..(eO and "ON" or "OFF") EB.BackgroundColor3=eO and Color3.fromRGB(0,80,0) or Color3.fromRGB(20,20,20) Notify("ESP "..(eO and "Ativado" or "Desativado")) if not eO then for _,o in pairs(eC) do o:Destroy() end eC={} end end)
RB.MouseButton1Click:Connect(function() rEO=not rEO RB.Text="RGB ESP: "..(rEO and "ON" or "OFF") Notify("RGB ESP "..(rEO and "Ativado" or "Desativado")) end)

local dS=false
ST.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dS=true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dS=false end end)
UserInputService.InputChanged:Connect(function(i)
    if dS and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local x=math.clamp((i.Position.X-STR.AbsolutePosition.X)/STR.AbsoluteSize.X,0,1)
        SF.Size=UDim2.new(x,0,1,0); ST.Position=UDim2.new(x,-6,0.5,-6)
        cS=math.floor(x*900+100); SLT.Text="Raio: "..cS
        CV.Size=UDim2.new(0,cS*2,0,cS*2); CV.Position=UDim2.new(0.5,-cS,0.5,-cS)
    end
end)

local dP,dSt,pSt=false,nil,nil
Panel.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        local rx=i.Position.X-Panel.AbsolutePosition.X
        if rx<25 or rx>Panel.AbsoluteSize.X-25 then dP=true; dSt=i.Position; pSt=Panel.Position end
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dP and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dSt
        Panel.Position=UDim2.new(pSt.X.Scale,pSt.X.Offset+d.X,pSt.Y.Scale,pSt.Y.Offset+d.Y)
    end
end)UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dP=false end end)

RunService.RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera
    if aO and cam then
        local best,bD=nil,cS
        local c=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
        local partMap = {Cabeça="Head", Peito="UpperTorso", Pé="LeftLowerLeg"}
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character then
                local pn = partMap[aimPart] or "Head"
                local part = p.Character:FindFirstChild(pn) or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local v,on=cam:WorldToViewportPoint(part.Position)
                    local d=(Vector2.new(v.X,v.Y)-c).Magnitude
                    if d<bD and on then bD=d; best=part end
                end
            end
        end
        tgt=best
        if tgt and tgt:IsA("BasePart") then
            local v,on=cam:WorldToViewportPoint(tgt.Position)
            if on then CH.Position=UDim2.new(0,v.X-9,0,v.Y-9) end
            cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,tgt.Position),0.18)
        else
            CH.Position=UDim2.new(0.5,-9,0.5,-9)
        end
    else
        CH.Position=UDim2.new(0.5,-9,0.5,-9)
    end
    local t=tick()
    PS.Color=RGB(t)
    if rCO and CV.Visible then CVS.Color=RGB(t); CVF.BackgroundColor3=RGB(t) elseif CV.Visible then CVS.Color=Color3.new(0.6,0,1); CVF.BackgroundColor3=Color3.new(0.6,0,1) end
end)

RunService.Heartbeat:Connect(function()
    if eO then
        local t=tick()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character then
                if not eC[p] then
                    local h=Instance.new("Highlight"); h.FillColor=rEO and RGB(t) or Color3.new(0.6,0,1); h.OutlineColor=Color3.new(1,1,1); h.FillTransparency=0.5; h.OutlineTransparency=0.15; h.Adornee=p.Character; h.Parent=p.Character; eC[p]=h
                else
                    if rEO then eC[p].FillColor=RGB(t) else eC[p].FillColor=Color3.new(0.6,0,1) end
                end
            end
        end
    end
end)
Players.PlayerRemoving:Connect(function(p) if eC[p] then eC[p]:Destroy(); eC[p]=nil end end)

task.spawn(function()
    for i=0,100,2 do
        LD.Text = "Carregando"..string.rep(".", math.floor(i/20)%3 + 1)
        LB.Size=UDim2.new(0,i*3.2,0,8); LB.Position=UDim2.new(0.5,-160+i*1.6,0.5,80); LB.BackgroundColor3=RGB(i*0.05)
        LT.Text=i.."%"; LS.Color=RGB(i*0.08); task.wait(0.018)
    end
    T(Load,{BackgroundTransparency=1,Size=UDim2.new(0,380,0,220)},0.4)
    T(LS,{Transparency=1},0.3); T(LB,{BackgroundTransparency=1},0.3); T(LD,{TextTransparency=1},0.3); T(LT,{TextTransparency=1},0.3)
    task.wait(0.4); Load:Destroy()
    Panel.Visible=true; T(Panel,{Position=UDim2.new(0.5,-140,0.5,-230)},0.65)
    Notify("Zx Carregado")
end)
