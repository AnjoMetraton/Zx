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

local Load = New("Frame",{Size=UDim2.new(0,420,0,250),Position=UDim2.new(0.5,-210,0.5,-125),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0,18),Parent=Load})
local LS = New("UIStroke",{Color=RGB(0),Thickness=2.5,Transparency=0.3,Parent=Load})
New("TextLabel",{Size=UDim2.new(1,0,0,50),BackgroundTransparency=1,Text="Zx v2026",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=28,Parent=Load})
local LB = New("Frame",{Size=UDim2.new(0,0,0,8),Position=UDim2.new(0.5,-180,0.5,40),BackgroundColor3=RGB(1),BorderSizePixel=0,Parent=Load})
New("UICorner",{CornerRadius=UDim.new(0,4),Parent=LB})
local LT = New("TextLabel",{Size=UDim2.new(1,0,0,30),Position=UDim2.new(0,0,0,60),BackgroundTransparency=1,Text="0%",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(180,180,180),TextSize=16,Parent=Load})

local Notif = New("Frame",{Name="Notifs",Size=UDim2.new(0,320,0,400),Position=UDim2.new(0.5,-160,0.85,0),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
local NList = {}
local function Notify(txt)
    local n = New("Frame",{Size=UDim2.new(1,0,0,46),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(14,14,14),BorderSizePixel=0,Parent=Notif})
    New("UICorner",{CornerRadius=UDim.new(0,10),Parent=n})
    New("UIStroke",{Color=RGB(0),Thickness=1.5,Parent=n})
    New("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=15,Parent=n})
    T(n,{Position=UDim2.new(0,0,1-(#NList+1)*0.13,0)},0.35)
    table.insert(NList,n)
    task.delay(3.5,function()
        T(n,{Position=UDim2.new(0,0,1.5,0),BackgroundTransparency=1},0.3)
        T(n.UIStroke,{Transparency=1},0.3)
        task.wait(0.3); n:Destroy()
        table.remove(NList,1)
    end)
end

local Panel = New("Frame",{Name="Main",Size=UDim2.new(0,350,0,560),Position=UDim2.new(0.5,-175,0.5,1000),BackgroundColor3=Color3.fromRGB(8,8,8),BorderSizePixel=0,Parent=ScreenGui,Visible=false})
New("UICorner",{CornerRadius=UDim.new(0,18),Parent=Panel})
local PS = New("UIStroke",{Color=RGB(0),Thickness=2.5,Transparency=0.2,Parent=Panel})
local TB = New("Frame",{Size=UDim2.new(1,0,0,60),BackgroundColor3=Color3.fromRGB(12,12,12),Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,18),Parent=TB})
New("TextLabel",{Size=UDim2.new(0.85,0,1,0),BackgroundTransparency=1,Text="Zx MENU",Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=24,Parent=TB})
New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,0),BackgroundColor3=RGB(1),BorderSizePixel=0,Parent=TB})

local function Btn(txt,y,s)    local b = New("TextButton",{Size=UDim2.new(0.88,0,0,48),Position=UDim2.new(0.06,0,y,0),BackgroundColor3=s and Color3.fromRGB(0,90,0) or Color3.fromRGB(22,22,22),BorderSizePixel=0,Text=txt,Font=Enum.Font.GothamBold,TextColor3=Color3.new(1,1,1),TextSize=16,Parent=Panel})
    New("UICorner",{CornerRadius=UDim.new(0,10),Parent=b})
    local bs = New("UIStroke",{Color=s and Color3.fromRGB(0,140,0) or Color3.fromRGB(50,50,50),Thickness=1.5,Parent=b})
    b.MouseEnter:Connect(function() T(b,{BackgroundTransparency=0.1},0.15) end)
    b.MouseLeave:Connect(function() T(b,{BackgroundTransparency=0},0.15) end)
    return b
end

local AB = Btn("Mira: OFF",0.13,false)
local CB = Btn("RGB Círculo: OFF",0.36,false)
local EB = Btn("ESP: OFF",0.59,false)
local RB = Btn("RGB ESP: OFF",0.82,false)

local SL = New("Frame",{Size=UDim2.new(0.88,0,0,66),Position=UDim2.new(0.06,0,0.21,0),BackgroundColor3=Color3.fromRGB(16,16,16),BorderSizePixel=0,Parent=Panel})
New("UICorner",{CornerRadius=UDim.new(0,10),Parent=SL})
local SLT = New("TextLabel",{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,Text="Raio: 500",Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(200,200,200),TextSize=14,Parent=SL})
local STR = New("Frame",{Size=UDim2.new(0.85,0,0,8),Position=UDim2.new(0.075,0,0.58,0),BackgroundColor3=Color3.fromRGB(30,30,30),BorderSizePixel=0,Parent=SL})
New("UICorner",{CornerRadius=UDim.new(0,4),Parent=STR})
local SF = New("Frame",{Size=UDim2.new(0.5,0,1,0),BackgroundColor3=RGB(2),BorderSizePixel=0,Parent=STR})
New("UICorner",{CornerRadius=UDim.new(0,4),Parent=SF})
local ST = New("Frame",{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0.5,-8,0.5,-8),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Parent=STR})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=ST})

local CV = New("Frame",{Name="Circle",Size=UDim2.new(0,1000,0,1000),Position=UDim2.new(0.5,-500,0.5,-500),BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=ScreenGui})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CV})
local CVS = New("UIStroke",{Color=Color3.new(0.6,0,1),Thickness=2,Transparency=0.3,Parent=CV})
local CVF = New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.new(0.6,0,1),BackgroundTransparency=0.9,BorderSizePixel=0,Parent=CV})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CVF})

local CH = New("Frame",{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0.5,-11,0.5,-11),BackgroundTransparency=1,BorderSizePixel=0,Parent=ScreenGui})
New("Frame",{Size=UDim2.new(0,4,0,4),Position=UDim2.new(0.5,-2,0.5,-2),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Parent=CH})
New("UICorner",{CornerRadius=UDim.new(0.5,0),Parent=CH.Frame})
New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,0.5,-1),BackgroundColor3=Color3.fromRGB(220,220,220),BorderSizePixel=0,Parent=CH})
New("Frame",{Size=UDim2.new(0,2,1,0),Position=UDim2.new(0.5,-1,0,0),BackgroundColor3=Color3.fromRGB(220,220,220),BorderSizePixel=0,Parent=CH})

local aO,rCO,eO,rEO = false,false,false,false
local cS = 500
local tgt = nil
local eC = {}

AB.MouseButton1Click:Connect(function() aO=not aO AB.Text="Mira: "..(aO and "ON" or "OFF") AB.BackgroundColor3=aO and Color3.fromRGB(0,90,0) or Color3.fromRGB(22,22,22) Notify("Mira "..(aO and "Ativada" or "Desativada")) CV.Visible=aO end)
CB.MouseButton1Click:Connect(function() rCO=not rCO CB.Text="RGB Círculo: "..(rCO and "ON" or "OFF") Notify("RGB Círculo "..(rCO and "Ativado" or "Desativado")) end)
EB.MouseButton1Click:Connect(function() eO=not eO EB.Text="ESP: "..(eO and "ON" or "OFF") EB.BackgroundColor3=eO and Color3.fromRGB(0,90,0) or Color3.fromRGB(22,22,22) Notify("ESP "..(eO and "Ativado" or "Desativado")) if not eO then for _,o in pairs(eC) do o:Destroy() end eC={} end end)
RB.MouseButton1Click:Connect(function() rEO=not rEO RB.Text="RGB ESP: "..(rEO and "ON" or "OFF") Notify("RGB ESP "..(rEO and "Ativado" or "Desativado")) end)

local dS=false
ST.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dS=true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dS=false end end)
UserInputService.InputChanged:Connect(function(i)
    if dS and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then        local x=math.clamp((i.Position.X-STR.AbsolutePosition.X)/STR.AbsoluteSize.X,0,1)
        SF.Size=UDim2.new(x,0,1,0); ST.Position=UDim2.new(x,-8,0.5,-8)
        cS=math.floor(x*900+100); SLT.Text="Raio: "..cS
        CV.Size=UDim2.new(0,cS*2,0,cS*2); CV.Position=UDim2.new(0.5,-cS,0.5,-cS)
    end
end)

local dP,dSt,pSt=false,nil,nil
Panel.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        local rx=i.Position.X-Panel.AbsolutePosition.X
        if rx<35 or rx>Panel.AbsoluteSize.X-35 then dP=true; dSt=i.Position; pSt=Panel.Position end
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dP and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-dSt
        Panel.Position=UDim2.new(pSt.X.Scale,pSt.X.Offset+d.X,pSt.Y.Scale,pSt.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dP=false end end)

RunService.RenderStepped:Connect(function()
    local cam=workspace.CurrentCamera
    if aO and cam then
        local best,bD=nil,cS
        local c=Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/2)
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local v,on=cam:WorldToViewportPoint(p.Character.Head.Position)
                local d=(Vector2.new(v.X,v.Y)-c).Magnitude
                if d<bD and on then bD=d; best=p end
            end
        end
        tgt=best
        if tgt and tgt.Character and tgt.Character:FindFirstChild("Head") then
            local v,on=cam:WorldToViewportPoint(tgt.Character.Head.Position)
            if on then CH.Position=UDim2.new(0,v.X-11,0,v.Y-11); cam.CFrame=cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position,tgt.Character.Head.Position),0.18) end
        end
    end
    local t=tick()
    PS.Color=RGB(t)
    if rCO and CV.Visible then CVS.Color=RGB(t); CVF.BackgroundColor3=RGB(t) elseif CV.Visible then CVS.Color=Color3.new(0.6,0,1); CVF.BackgroundColor3=Color3.new(0.6,0,1) end
end)

RunService.Heartbeat:Connect(function()
    if eO then
        local t=tick()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer and p.Character then                if not eC[p] then
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
        LB.Size=UDim2.new(0,i*3.6,0,8); LB.Position=UDim2.new(0.5,-180+i*1.8,0.5,40); LB.BackgroundColor3=RGB(i*0.05)
        LT.Text=i.."%"; LS.Color=RGB(i*0.08); task.wait(0.018)
    end
    T(Load,{BackgroundTransparency=1,Size=UDim2.new(0,440,0,270)},0.4)
    T(LS,{Transparency=1},0.3); T(LB,{BackgroundTransparency=1},0.3); T(LT,{TextTransparency=1},0.3)
    task.wait(0.4); Load:Destroy()
    Panel.Visible=true; T(Panel,{Position=UDim2.new(0.5,-175,0.5,-280)},0.65)
    Notify("Zx Carregado")
end)
