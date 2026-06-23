task.spawn(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Debris = game:GetService("Debris")
    local TweenService = game:GetService("TweenService")

    local LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then
        local waitLoaded = game and game.FindFirstChildOfClass and game:FindFirstChildOfClass("Chat")
        repeat task.wait() LocalPlayer = Players.LocalPlayer until LocalPlayer
    end

    local Camera = Workspace.CurrentCamera
    if not Camera then Camera = Workspace:WaitForChild("Camera") end
    local Mouse = LocalPlayer:GetMouse()
    local isMobile = UserInputService.TouchEnabled

    local THEME_PRIMARY = Color3.fromRGB(0, 255, 255)
    local THEME_BG = Color3.fromRGB(8, 8, 12)
    local THEME_TEXT = Color3.fromRGB(230, 230, 240)
    local UI_CARD = Color3.fromRGB(14, 14, 20)
    local UI_SIDEBAR = Color3.fromRGB(10, 10, 16)
    local UI_BUTTON = Color3.fromRGB(20, 20, 28)
    local UI_BUTTON_HOVER = Color3.fromRGB(0, 120, 140)
    local UI_TOGGLE_OFF = Color3.fromRGB(55, 55, 65)

    local COLOR_LOCKED = Color3.fromRGB(0, 255, 255)
    local COLOR_VISIBLE = Color3.fromRGB(0, 180, 255)
    local COLOR_HIDDEN = Color3.fromRGB(0, 80, 120)

    local menuWidth = isMobile and 360 or 340
    local menuHeight = isMobile and 360 or 320
    local btnSize = isMobile and 60 or 50

    local Settings = {
        Combat = {
            Enabled = false, CamLock = false, FreeCombat = false, Mode = "Dynamic",
            AimPart = "HumanoidRootPart", AimAtBack = false, BackOffset = 3.5,
            WallCheck = false, TargetNPCs = true, MaxDistance = 9e9, FOV = 400,
            ShowFOV = false, Triggerbot = false, TriggerKey = Enum.UserInputType.MouseButton1,
            TriggerDelay = 0.1, AntiAim = false, AntiAimAngle = 30, AutoDodge = false,
            DodgeRange = 15, DodgeCooldown = 0.5, DodgeStyle = "Tween", DodgeDirection = "Back"
        },
        Movement = {
            SpiderEnabled = false, InfJump = false, Noclip = false, SpeedHackEnabled = false,
            NormalSpeed = 50, ClimbSpeed = 40, SprintMult = 1.5, WallJumpForce = 110,
            RayLength = 6.0, InfJumpForce = 50
        },
        Visuals = {ESPEnabled = true, ESPShowWeapon = true, FPSBoost = false, ESPBox = true, ESPTracer = true},
        Players = {SelectedPlayer = nil, Spectating = false}
    }

    local LockedTarget, isClimbing, isSprinting = nil, false, false
    local canDodge, lastJumpTime, lastShotTime = true, 0, 0
    local character, humanoid, rootPart, animator, climbTrack
    local climbAtt, climbLV, climbAV
    local AnimIds = { R15 = "rbxassetid://507765644", R6 = "rbxassetid://180436334" }

    local function safeCall(f)
        local ok, err = pcall(f)
        if not ok then warn("[AdminNillo] " .. tostring(err)) end
    end

    safeCall(function()
        for _, v in pairs(CoreGui:GetChildren()) do
            if string.match(v.Name, "AdminNillo") or v.Name == "Nillo_ESP" or v.Name == "Nillo_ESP2D" then v:Destroy() end
        end
        for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
            if string.match(v.Name, "AdminNillo") or v.Name == "Nillo_ESP" or v.Name == "Nillo_ESP2D" then v:Destroy() end
        end
    end)

    local ESP_Folder = Instance.new("Folder", CoreGui)
    ESP_Folder.Name = "Nillo_ESP"
    local ESP2D_Gui = Instance.new("ScreenGui", CoreGui)
    ESP2D_Gui.Name = "Nillo_ESP2D"
    ESP2D_Gui.IgnoreGuiInset = true

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "AdminNillo_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Backdrop = Instance.new("Frame", ScreenGui)
    Backdrop.Name = "Backdrop"
    Backdrop.Size = UDim2.new(1, 0, 1, 0)
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = 1
    Backdrop.Visible = false
    Backdrop.ZIndex = 0
    Backdrop.Active = true
    local backGrad = Instance.new("UIGradient", Backdrop)
    backGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 5))})
    backGrad.Rotation = 90

    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Name = "NotifArea"
    NotifFrame.Size = UDim2.new(0, 280, 1, -20)
    NotifFrame.Position = UDim2.new(1, -300, 0, 10)
    NotifFrame.BackgroundTransparency = 1
    local NotifLayout = Instance.new("UIListLayout", NotifFrame)
    NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifLayout.Padding = UDim.new(0, 10)

    local function SendNotification(title, text, duration)
        duration = duration or 3
        local notif = Instance.new("Frame", NotifFrame)
        notif.Size = UDim2.new(1, 0, 0, 70)
        notif.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        notif.Position = UDim2.new(1, 80, 0, 0)
        notif.BackgroundTransparency = 0.15
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)
        local nGrad = Instance.new("UIGradient", notif)
        nGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 14))})
        nGrad.Rotation = 90

        local stroke = Instance.new("UIStroke", notif)
        stroke.Color = THEME_PRIMARY
        stroke.Thickness = 1.5
        stroke.Transparency = 0.3

        local lblTitle = Instance.new("TextLabel", notif)
        lblTitle.Size = UDim2.new(1, -20, 0, 20)
        lblTitle.Position = UDim2.new(0, 15, 0, 8)
        lblTitle.BackgroundTransparency = 1
        lblTitle.Text = title
        lblTitle.Font = Enum.Font.GothamBlack
        lblTitle.TextColor3 = THEME_PRIMARY
        lblTitle.TextSize = 13
        lblTitle.TextXAlignment = Enum.TextXAlignment.Left

        local lblText = Instance.new("TextLabel", notif)
        lblText.Size = UDim2.new(1, -20, 0, 28)
        lblText.Position = UDim2.new(0, 15, 0, 30)
        lblText.BackgroundTransparency = 1
        lblText.Text = text
        lblText.Font = Enum.Font.GothamMedium
        lblText.TextColor3 = THEME_TEXT
        lblText.TextSize = 11
        lblText.TextXAlignment = Enum.TextXAlignment.Left
        lblText.TextWrapped = true

        local barBg = Instance.new("Frame", notif)
        barBg.Size = UDim2.new(1, 0, 0, 3)
        barBg.Position = UDim2.new(0, 0, 1, -3)
        barBg.BackgroundColor3 = UI_TOGGLE_OFF
        barBg.BorderSizePixel = 0
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

        local barFill = Instance.new("Frame", barBg)
        barFill.Size = UDim2.new(1, 0, 1, 0)
        barFill.BackgroundColor3 = THEME_PRIMARY
        barFill.BorderSizePixel = 0
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

        TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(barFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

        task.delay(duration, function()
            local fadeOut = TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 80, 0, 0)})
            fadeOut:Play()
            fadeOut.Completed:Wait()
            notif:Destroy()
        end)
    end

    local function Drag(obj)
        local drag, start, startPos
        obj.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = true
                start = i.Position
                startPos = obj.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local d = i.Position - start
                obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
        obj.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
        end)
    end

    local MainBtn = Instance.new("TextButton", ScreenGui)
    MainBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    MainBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
    MainBtn.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
    MainBtn.BackgroundTransparency = 0.2
    MainBtn.Text = "N"
    MainBtn.Font = Enum.Font.GothamBlack
    MainBtn.TextSize = isMobile and 30 or 25
    MainBtn.TextColor3 = THEME_PRIMARY
    MainBtn.AutoButtonColor = false
    Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(1, 0)
    local btnStroke = Instance.new("UIStroke", MainBtn)
    btnStroke.Color = THEME_PRIMARY
    btnStroke.Thickness = 2.5
    btnStroke.Transparency = 0.2
    local btnGrad = Instance.new("UIGradient", MainBtn)
    btnGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 18)), ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 4, 8))})
    btnGrad.Rotation = 90
    Drag(MainBtn)

    MainBtn.MouseEnter:Connect(function() TweenService:Create(MainBtn, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, btnSize + 6, 0, btnSize + 6)}):Play() end)
    MainBtn.MouseLeave:Connect(function() TweenService:Create(MainBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, btnSize, 0, btnSize)}):Play() end)

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, menuWidth, 0, menuHeight)
    Main.Position = UDim2.new(0.5, -menuWidth / 2, 0.5, -menuHeight / 2)
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
    Main.BackgroundTransparency = 0.1
    Main.ClipsDescendants = true
    Main.Visible = false
    Main.ZIndex = 1
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
    local mainStroke = Instance.new("UIStroke", Main)
    mainStroke.Color = THEME_PRIMARY
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 0.4
    local mainGrad = Instance.new("UIGradient", Main)
    mainGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 16, 24)), ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 10))})
    mainGrad.Rotation = 135
    Drag(Main)

    local function ToggleMenu()
        if Main.Visible then
            TweenService:Create(Backdrop, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
            local tween = TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
            tween:Play()
            tween.Completed:Wait()
            Main.Visible = false
            Backdrop.Visible = false
        else
            Main.Visible = true
            Backdrop.Visible = true
            Backdrop.BackgroundTransparency = 1
            Main.Size = UDim2.new(0, 0, 0, 0)
            Main.BackgroundTransparency = 0.6
            TweenService:Create(Backdrop, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5}):Play()
            TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, menuWidth, 0, menuHeight), BackgroundTransparency = 0.1}):Play()
        end
    end
    MainBtn.MouseButton1Click:Connect(ToggleMenu)
    UserInputService.InputBegan:Connect(function(i, gpe) if not gpe and (i.KeyCode == Enum.KeyCode.Insert or i.KeyCode == Enum.KeyCode.RightControl) then ToggleMenu() end end)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 38)
    Title.BackgroundTransparency = 1
    Title.Text = "  ADMIN NILLO [CYAN]"
    Title.TextColor3 = THEME_PRIMARY
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", Main)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -34, 0, 5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = THEME_TEXT
    CloseBtn.Font = Enum.Font.GothamMedium
    CloseBtn.TextSize = 16
    CloseBtn.AutoButtonColor = false
    CloseBtn.MouseButton1Click:Connect(ToggleMenu)

    local Divider = Instance.new("Frame", Main)
    Divider.Size = UDim2.new(1, -20, 0, 1)
    Divider.Position = UDim2.new(0, 10, 0, 38)
    Divider.BackgroundColor3 = THEME_PRIMARY
    Divider.BorderSizePixel = 0
    Divider.BackgroundTransparency = 0.6

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, isMobile and 100 or 105, 1, -50)
    Sidebar.Position = UDim2.new(0, 10, 0, 48)
    Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
    Sidebar.BackgroundTransparency = 0.2
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
    local sideStroke = Instance.new("UIStroke", Sidebar)
    sideStroke.Color = Color3.fromRGB(255, 255, 255)
    sideStroke.Thickness = 0.5
    sideStroke.Transparency = 0.85
    local sideGrad = Instance.new("UIGradient", Sidebar)
    sideGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 14, 22)), ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 6, 10))})
    sideGrad.Rotation = 90

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    local SidebarPadding = Instance.new("UIPadding", Sidebar)
    SidebarPadding.PaddingTop = UDim.new(0, 8)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -(isMobile and 120 or 125), 1, -50)
    Content.Position = UDim2.new(0, (isMobile and 115 or 120), 0, 48)
    Content.BackgroundTransparency = 1

    local Tabs = {}
    local function AddTab(name)
        local p = Instance.new("ScrollingFrame", Content)
        p.Size = UDim2.new(1, 0, 1, 0)
        p.BackgroundTransparency = 1
        p.Visible = false
        p.ScrollBarThickness = 3
        p.ScrollBarImageColor3 = THEME_PRIMARY
        p.BorderSizePixel = 0
        p.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
        p.CanvasSize = UDim2.new(0, 0, 0, 0)
        local pLayout = Instance.new("UIListLayout", p)
        pLayout.Padding = UDim.new(0, 6)
        pLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            p.CanvasSize = UDim2.new(0, 0, 0, pLayout.AbsoluteContentSize.Y + 10)
        end)
        Instance.new("UIPadding", p).PaddingRight = UDim.new(0, 6)

        local b = Instance.new("TextButton", Sidebar)
        b.Size = UDim2.new(0.88, 0, 0, isMobile and 36 or 32)
        b.BackgroundColor3 = UI_BUTTON
        b.Text = name
        b.TextColor3 = THEME_TEXT
        b.Font = Enum.Font.GothamBold
        b.TextSize = isMobile and 10 or 11
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
        local bGrad = Instance.new("UIGradient", b)
        bGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 24))})
        bGrad.Rotation = 90

        b.MouseEnter:Connect(function() if not p.Visible then TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = UI_BUTTON_HOVER}):Play() end end)
        b.MouseLeave:Connect(function() if not p.Visible then TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = UI_BUTTON}):Play() end end)

        b.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.P.Visible = false
                TweenService:Create(t.B, TweenInfo.new(0.25), {BackgroundColor3 = UI_BUTTON, TextColor3 = THEME_TEXT}):Play()
            end
            p.Visible = true
            TweenService:Create(b, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundColor3 = THEME_PRIMARY, TextColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        end)
        table.insert(Tabs, {P = p, B = b, Name = name})
        return p
    end

    local function AddToggle(parent, text, default, callback)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, 0, 0, isMobile and 46 or 40)
        b.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
        b.BackgroundTransparency = 0.15
        b.Text = "   " .. text
        b.TextColor3 = THEME_TEXT
        b.Font = Enum.Font.GothamSemibold
        b.TextSize = isMobile and 13 or 12
        b.TextXAlignment = Enum.TextXAlignment.Left
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
        local tStroke = Instance.new("UIStroke", b)
        tStroke.Color = Color3.fromRGB(255, 255, 255)
        tStroke.Thickness = 0.5
        tStroke.Transparency = 0.85

        local ind = Instance.new("Frame", b)
        ind.Size = UDim2.new(0, isMobile and 46 or 42, 0, isMobile and 24 or 22)
        ind.Position = UDim2.new(1, -(isMobile and 54 or 50), 0.5, -(isMobile and 12 or 11))
        ind.BackgroundColor3 = default and THEME_PRIMARY or UI_TOGGLE_OFF
        Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

        local circle = Instance.new("Frame", ind)
        local circleSize = isMobile and 20 or 18
        circle.Size = UDim2.new(0, circleSize, 0, circleSize)
        circle.Position = default and UDim2.new(1, -(circleSize + 2), 0.5, -circleSize / 2) or UDim2.new(0, 2, 0.5, -circleSize / 2)
        circle.BackgroundColor3 = THEME_TEXT
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        local s = default
        local func = function(state)
            if state ~= nil then s = state else s = not s end
            TweenService:Create(ind, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundColor3 = s and THEME_PRIMARY or UI_TOGGLE_OFF}):Play()
            TweenService:Create(circle, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = s and UDim2.new(1, -(circleSize + 2), 0.5, -circleSize / 2) or UDim2.new(0, 2, 0.5, -circleSize / 2)}):Play()
            callback(s)
            if state == nil then SendNotification("Configuração Alterada", text .. " agora está " .. (s and "ATIVADO" or "DESATIVADO"), 2) end
        end
        b.MouseButton1Click:Connect(func)
        return {SetState = func}
    end

    local function AddSlider(parent, text, min, max, default, callback, suffix)
        local b = Instance.new("Frame", parent)
        b.Size = UDim2.new(1, 0, 0, isMobile and 65 or 55)
        b.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
        b.BackgroundTransparency = 0.15
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
        local sStroke = Instance.new("UIStroke", b)
        sStroke.Color = Color3.fromRGB(255, 255, 255)
        sStroke.Thickness = 0.5
        sStroke.Transparency = 0.85

        local lbl = Instance.new("TextLabel", b)
        lbl.Size = UDim2.new(1, -20, 0, 20)
        lbl.Position = UDim2.new(0, 12, 0, 5)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = THEME_TEXT
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = isMobile and 13 or 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Text = text .. ": " .. default .. (suffix or "")

        local bar = Instance.new("Frame", b)
        bar.Size = UDim2.new(1, -24, 0, isMobile and 10 or 8)
        bar.Position = UDim2.new(0, 12, 0, 32)
        bar.BackgroundColor3 = UI_TOGGLE_OFF
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = THEME_PRIMARY
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local thumb = Instance.new("Frame", bar)
        local thumbSize = isMobile and 16 or 14
        thumb.Size = UDim2.new(0, thumbSize, 0, thumbSize)
        thumb.Position = UDim2.new((default - min) / (max - min), -(thumbSize / 2), 0.5, -(thumbSize / 2))
        thumb.BackgroundColor3 = THEME_TEXT
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

        local btn = Instance.new("TextButton", b)
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""

        local dragging = false
        btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

        local function update(input)
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = min + ((max - min) * pos)
            val = math.floor(val * 10) / 10
            TweenService:Create(fill, TweenInfo.new(0.08), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
            TweenService:Create(thumb, TweenInfo.new(0.08), {Position = UDim2.new(pos, -(thumbSize / 2), 0.5, -(thumbSize / 2))}):Play()
            lbl.Text = text .. ": " .. val .. (suffix or "")
            callback(val)
        end
        UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
        btn.MouseButton1Click:Connect(function() update(Mouse) end)
    end

    local function AddButton(parent, text, callback)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, 0, 0, isMobile and 42 or 36)
        b.BackgroundColor3 = UI_BUTTON
        b.Text = text
        b.TextColor3 = THEME_TEXT
        b.Font = Enum.Font.GothamBold
        b.TextSize = isMobile and 13 or 12
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        local bGrad = Instance.new("UIGradient", b)
        bGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 24))})
        bGrad.Rotation = 90

        b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = THEME_PRIMARY, TextColor3 = Color3.fromRGB(0, 0, 0)}):Play() end)
        b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = UI_BUTTON, TextColor3 = THEME_TEXT}):Play() end)

        b.MouseButton1Click:Connect(function()
            callback()
            SendNotification("Ação Executada", text, 2)
        end)
        return b
    end

    local TabCombat = AddTab("⚔️ COMBATE")
    local TabAimbot = AddTab("🎯 AIMBOT")
    local TabMovement = AddTab("🏃 MOV.")
    local TabPlayers = AddTab("👥 JOG.")
    local TabVisual = AddTab("👁️ VISUAL")
    local TabMisc = AddTab("🔧 MISC")

    AddToggle(TabCombat, "Ligar Sistema", false, function(v) Settings.Combat.Enabled = v; LockedTarget = nil end)
    AddToggle(TabCombat, "Travar Câmera", false, function(v) Settings.Combat.CamLock = v end)
    AddToggle(TabCombat, "Combate Livre", false, function(v) Settings.Combat.FreeCombat = v end)

    local BtnDynamic, BtnSticky
    BtnDynamic = AddToggle(TabCombat, "Modo Dinâmico", true, function(v) if v then Settings.Combat.Mode = "Dynamic"; if BtnSticky then BtnSticky.SetState(false) end end end)
    BtnSticky = AddToggle(TabCombat, "Modo Fixo (Sticky)", false, function(v) if v then Settings.Combat.Mode = "Sticky"; LockedTarget = nil; if BtnDynamic then BtnDynamic.SetState(false) end end end)

    AddToggle(TabCombat, "Mirar na Cabeça (Off = Corpo)", false, function(v) Settings.Combat.AimPart = v and "Head" or "HumanoidRootPart"; LockedTarget = nil end)
    AddToggle(TabCombat, "Mirar nas Costas (Bypass)", false, function(v) Settings.Combat.AimAtBack = v end)
    AddSlider(TabCombat, "Distância das Costas", 1, 10, 3.5, function(v) Settings.Combat.BackOffset = v end, " stds")

    AddToggle(TabCombat, "Mirar em NPCs", true, function(v) Settings.Combat.TargetNPCs = v; LockedTarget = nil end)
    AddToggle(TabCombat, "Check de Parede", false, function(v) Settings.Combat.WallCheck = v end)

    AddSlider(TabAimbot, "Distância Máx", 100, 5000, 2500, function(v) Settings.Combat.MaxDistance = v end, " s")
    AddSlider(TabAimbot, "FOV (Giro Total)", 1, 400, 400, function(v) Settings.Combat.FOV = v end, "°")
    AddToggle(TabAimbot, "Mostrar FOV", false, function(v) Settings.Combat.ShowFOV = v end)
    AddToggle(TabAimbot, "Triggerbot", false, function(v) Settings.Combat.Triggerbot = v end)
    AddSlider(TabAimbot, "Delay Trigger", 0, 1000, 50, function(v) Settings.Combat.TriggerDelay = v / 1000 end, " ms")

    AddToggle(TabMovement, "Modo Aranha", false, function(v) Settings.Movement.SpiderEnabled = v; if not v then stopClimbing() end end)
    AddToggle(TabMovement, "Noclip", false, function(v) Settings.Movement.Noclip = v end)
    AddToggle(TabMovement, "Pulo Infinito", false, function(v) Settings.Movement.InfJump = v end)
    AddToggle(TabMovement, "Speed Hack", false, function(v) Settings.Movement.SpeedHackEnabled = v; if not v and humanoid then humanoid.WalkSpeed = 16 end end)
    AddSlider(TabMovement, "Velocidade", 16, 350, 50, function(v) Settings.Movement.NormalSpeed = v end)

    local PlayerListIndex = 1
    local PlayerSelectFrame = Instance.new("Frame", TabPlayers)
    PlayerSelectFrame.Size = UDim2.new(1, 0, 0, isMobile and 46 or 40)
    PlayerSelectFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
    PlayerSelectFrame.BackgroundTransparency = 0.15
    Instance.new("UICorner", PlayerSelectFrame).CornerRadius = UDim.new(0, 9)
    local psStroke = Instance.new("UIStroke", PlayerSelectFrame)
    psStroke.Color = Color3.fromRGB(255, 255, 255)
    psStroke.Thickness = 0.5
    psStroke.Transparency = 0.85

    local BtnPrev = Instance.new("TextButton", PlayerSelectFrame)
    BtnPrev.Size = UDim2.new(0, 32, 1, 0)
    BtnPrev.BackgroundTransparency = 1
    BtnPrev.Text = "◀"
    BtnPrev.TextColor3 = THEME_PRIMARY
    BtnPrev.Font = Enum.Font.GothamBold
    BtnPrev.TextSize = 14
    BtnPrev.AutoButtonColor = false

    local BtnNext = Instance.new("TextButton", PlayerSelectFrame)
    BtnNext.Size = UDim2.new(0, 32, 1, 0)
    BtnNext.Position = UDim2.new(1, -32, 0, 0)
    BtnNext.BackgroundTransparency = 1
    BtnNext.Text = "▶"
    BtnNext.TextColor3 = THEME_PRIMARY
    BtnNext.Font = Enum.Font.GothamBold
    BtnNext.TextSize = 14
    BtnNext.AutoButtonColor = false

    local PlayerNameLabel = Instance.new("TextLabel", PlayerSelectFrame)
    PlayerNameLabel.Size = UDim2.new(1, -64, 1, 0)
    PlayerNameLabel.Position = UDim2.new(0, 32, 0, 0)
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.TextColor3 = THEME_PRIMARY
    PlayerNameLabel.Font = Enum.Font.GothamBold
    PlayerNameLabel.TextSize = isMobile and 13 or 12

    local function UpdatePlayerSelection()
        local allPlayers = Players:GetPlayers()
        local validPlayers = {}
        for _, p in pairs(allPlayers) do if p ~= LocalPlayer then table.insert(validPlayers, p) end end
        if #validPlayers == 0 then PlayerNameLabel.Text = "Nenhum Jogador"; Settings.Players.SelectedPlayer = nil; return end
        if PlayerListIndex > #validPlayers then PlayerListIndex = 1 end
        if PlayerListIndex < 1 then PlayerListIndex = #validPlayers end
        Settings.Players.SelectedPlayer = validPlayers[PlayerListIndex]
        PlayerNameLabel.Text = Settings.Players.SelectedPlayer.Name
        if Settings.Players.Spectating and Settings.Players.SelectedPlayer.Character then Camera.CameraSubject = Settings.Players.SelectedPlayer.Character:FindFirstChild("Humanoid") end
    end

    BtnNext.MouseButton1Click:Connect(function() PlayerListIndex = PlayerListIndex + 1; UpdatePlayerSelection() end)
    BtnPrev.MouseButton1Click:Connect(function() PlayerListIndex = PlayerListIndex - 1; UpdatePlayerSelection() end)
    Players.PlayerAdded:Connect(UpdatePlayerSelection)
    Players.PlayerRemoving:Connect(UpdatePlayerSelection)

    AddButton(TabPlayers, "Teleportar (TP)", function()
        local target = Settings.Players.SelectedPlayer
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end)

    AddToggle(TabPlayers, "Espectar", false, function(v)
        Settings.Players.Spectating = v
        if v then UpdatePlayerSelection() else if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LocalPlayer.Character.Humanoid end end
    end)

    AddToggle(TabVisual, "Ligar ESP Global", true, function(v) Settings.Visuals.ESPEnabled = v end)
    AddToggle(TabVisual, "Caixa (Box 2D)", true, function(v) Settings.Visuals.ESPBox = v end)
    AddToggle(TabVisual, "Linha (Tracer)", true, function(v) Settings.Visuals.ESPTracer = v end)
    AddToggle(TabVisual, "Mostrar Arma", true, function(v) Settings.Visuals.ESPShowWeapon = v end)
    AddToggle(TabVisual, "FPS Boost", false, function(v) Settings.Visuals.FPSBoost = v; if v then ApplyFPSBoost() end end)

    AddToggle(TabMisc, "Anti-Aim", false, function(v) Settings.Combat.AntiAim = v end)
    AddSlider(TabMisc, "Ângulo Anti-Aim", 5, 180, 30, function(v) Settings.Combat.AntiAimAngle = v end, "°")
    AddToggle(TabMisc, "Esquiva Automática", false, function(v) Settings.Combat.AutoDodge = v end)
    AddSlider(TabMisc, "Distância Esquiva", 5, 50, 15, function(v) Settings.Combat.DodgeRange = v end)
    AddSlider(TabMisc, "Cooldown Esquiva", 0.1, 2, 0.5, function(v) Settings.Combat.DodgeCooldown = v end, " s")

    Tabs[1].P.Visible = true
    Tabs[1].B.BackgroundColor3 = THEME_PRIMARY
    Tabs[1].B.TextColor3 = Color3.fromRGB(0, 0, 0)
    UpdatePlayerSelection()
    SendNotification("Sistema Inicializado", "Admin Nillo - Mira Instantânea", 4)

    local FOVCircle = Instance.new("Frame", ESP2D_Gui)
    FOVCircle.Name = "FOVCircle"
    FOVCircle.Size = UDim2.new(0, 0, 0, 0)
    FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
    FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    FOVCircle.BackgroundTransparency = 1
    FOVCircle.Visible = false
    Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
    local fovStroke = Instance.new("UIStroke", FOVCircle)
    fovStroke.Color = THEME_PRIMARY
    fovStroke.Thickness = 1
    fovStroke.Transparency = 0.6

    local function GetIsVisible(targetChar, part)
        local origin = Camera.CFrame.Position
        local direction = part.Position - origin
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character, targetChar, Camera}
        return Workspace:Raycast(origin, direction, params) == nil
    end

    local function IsValidTarget(target)
        if not target then return false end
        local hum = target:FindFirstChild("Humanoid")
        local root = target:FindFirstChild(Settings.Combat.AimPart) or target:FindFirstChild("Head")
        if hum and hum.Health > 0 and root then
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return false end
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
            if dist > Settings.Combat.MaxDistance then return false end
            if Settings.Combat.WallCheck and not GetIsVisible(target, root) then return false end
            return true
        end
        return false
    end

    local function GetAngleToTarget(targetPart)
        if not targetPart then return 180 end
        local cameraCF = Camera.CFrame
        local toTarget = (targetPart.Position - cameraCF.Position).Unit
        local cameraDirection = cameraCF.LookVector
        local dot = cameraDirection:Dot(toTarget)
        local angle = math.acos(math.clamp(dot, -1, 1)) * (180 / math.pi)
        return angle
    end

    local function GetClosestToPlayer()
        local shortestDist = Settings.Combat.MaxDistance
        local bestAngle = Settings.Combat.FOV
        local chosenTarget = nil
        if not LocalPlayer.Character then return nil end
        local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end

        local potential = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then table.insert(potential, p.Character) end
        end
        if Settings.Combat.TargetNPCs then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(v) then
                    table.insert(potential, v)
                end
            end
        end

        for _, char in pairs(potential) do
            local root = char:FindFirstChild(Settings.Combat.AimPart) or char:FindFirstChild("Head")
            local hum = char:FindFirstChild("Humanoid")
            if root and hum and hum.Health > 0 then
                local dist = (myRoot.Position - root.Position).Magnitude
                local angle = GetAngleToTarget(root)
                if angle <= bestAngle and dist <= Settings.Combat.MaxDistance then
                    if not Settings.Combat.WallCheck or GetIsVisible(char, root) then
                        if angle < bestAngle or (angle == bestAngle and dist < shortestDist) then
                            bestAngle = angle
                            shortestDist = dist
                            chosenTarget = char
                        end
                    end
                end
            end
        end
        return chosenTarget
    end

    function ApplyFPSBoost()
        if not Settings.Visuals.FPSBoost then return end
        for _, v in pairs(Workspace:GetDescendants()) do
            if LocalPlayer.Character and v:IsDescendantOf(LocalPlayer.Character) then continue end
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
                if v:IsA("MeshPart") then v.TextureID = "" end
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
    end

    task.spawn(function()
        while task.wait(5) do
            safeCall(ApplyFPSBoost)
        end
    end)

    local function PerformDodge(target)
        if not canDodge or not rootPart then return end
        canDodge = false
        local dodgeDir = Vector3.new()
        local forward = rootPart.CFrame.LookVector
        local right = rootPart.CFrame.RightVector
        if Settings.Combat.DodgeDirection == "Back" then dodgeDir = -forward * 8
        elseif Settings.Combat.DodgeDirection == "Side" then dodgeDir = right * (math.random() > 0.5 and 6 or -6)
        else dodgeDir = Vector3.new(math.random(-8,8), 0, math.random(-8,8)) end
        local targetPos = rootPart.Position + dodgeDir
        if Settings.Combat.DodgeStyle == "Tween" then
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local goal = {CFrame = CFrame.new(targetPos)}
            local tween = TweenService:Create(rootPart, tweenInfo, goal)
            tween:Play()
            tween.Completed:Wait()
        else
            rootPart.CFrame = CFrame.new(targetPos)
        end
        task.wait(Settings.Combat.DodgeCooldown)
        canDodge = true
    end

    local function CheckDodge(target)
        if not Settings.Combat.AutoDodge or not canDodge then return end
        if not target or not target:FindFirstChild("Humanoid") then return end
        if not rootPart then return end
        local dist = (target.HumanoidRootPart.Position - rootPart.Position).Magnitude
        if dist > Settings.Combat.DodgeRange then return end
        local targetRoot = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Head")
        if not targetRoot then return end
        local toTarget = (rootPart.Position - targetRoot.Position).Unit
        local targetLook = targetRoot.CFrame.LookVector
        local dot = targetLook:Dot(toTarget)
        local angle = math.acos(math.clamp(dot, -1, 1)) * (180 / math.pi)
        if angle < 45 then
            local enemyAnim = target.Humanoid:FindFirstChild("Animator")
            if enemyAnim then
                for _, track in pairs(enemyAnim:GetPlayingAnimationTracks()) do
                    if track.Priority == Enum.AnimationPriority.Action or track.Priority == Enum.AnimationPriority.Movement then
                        if track.Speed > 0 then
                            PerformDodge(target)
                            break
                        end
                    end
                end
            end
        end
    end

    local function CheckTrigger()
        if not Settings.Combat.Triggerbot then return end
        if not LockedTarget then return end
        local aimPart = LockedTarget:FindFirstChild(Settings.Combat.AimPart) or LockedTarget:FindFirstChild("Head")
        if not aimPart then return end
        local angle = GetAngleToTarget(aimPart)
        if angle <= 5 then
            local now = tick()
            if now - lastShotTime >= Settings.Combat.TriggerDelay then
                mouse1click()
                lastShotTime = now
            end
        end
    end

    local function ApplyAntiAim()
        if not Settings.Combat.AntiAim or not rootPart then return end
        if humanoid and humanoid.MoveDirection.Magnitude < 0.1 then
            local randomAngle = math.rad(math.random(-Settings.Combat.AntiAimAngle, Settings.Combat.AntiAimAngle))
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, randomAngle, 0)
        end
    end

    task.spawn(function()
        while task.wait(0.1) do
            safeCall(function()
                local targets = {}
                for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then table.insert(targets, p.Character) end end
                if Settings.Combat.TargetNPCs then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(v) then table.insert(targets, v) end
                    end
                end

                for _, char in pairs(targets) do
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")
                    local id = char:GetDebugId()

                    if Settings.Combat.AutoDodge and root then CheckDodge(char) end

                    if Settings.Visuals.ESPEnabled and root and hum and hum.Health > 0 then
                        local isLocked = (char == LockedTarget)
                        local isVisible = GetIsVisible(char, root)
                        local finalColor = isLocked and COLOR_LOCKED or (isVisible and COLOR_VISIBLE or COLOR_HIDDEN)

                        local hl = ESP_Folder:FindFirstChild(id.."_HL") or Instance.new("Highlight", ESP_Folder)
                        hl.Name = id.."_HL"
                        hl.Adornee = char
                        hl.FillColor = finalColor
                        hl.OutlineColor = finalColor
                        hl.FillTransparency = 0.6
                        hl.OutlineTransparency = 0

                        local bb = ESP_Folder:FindFirstChild(id.."_BB") or Instance.new("BillboardGui", ESP_Folder)
                        bb.Name = id.."_BB"
                        bb.Adornee = char:FindFirstChild("Head") or root
                        bb.Size = UDim2.new(0, 200, 0, 60)
                        bb.AlwaysOnTop = true
                        bb.StudsOffset = Vector3.new(0, 3, 0)

                        local txt = bb:FindFirstChild("Text") or Instance.new("TextLabel", bb)
                        txt.Name = "Text"
                        txt.BackgroundTransparency = 1
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.Font = Enum.Font.GothamBold
                        txt.TextSize = 13
                        txt.TextColor3 = finalColor
                        txt.TextStrokeTransparency = 0.8

                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                            local name = char.Name
                            if not Players:GetPlayerFromCharacter(char) then name = "[NPC] " .. name end
                            local weapon = ""
                            if Settings.Visuals.ESPShowWeapon then
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then weapon = " [" .. tool.Name .. "]" end
                            end
                            txt.Text = string.format("%s%s%s\n[%dm] HP: %d", (isLocked and "🎯 " or ""), name, weapon, dist, math.floor(hum.Health))
                        end
                    else
                        if ESP_Folder:FindFirstChild(id.."_HL") then ESP_Folder[id.."_HL"]:Destroy() end
                        if ESP_Folder:FindFirstChild(id.."_BB") then ESP_Folder[id.."_BB"]:Destroy() end
                    end
                end

                if not Settings.Visuals.ESPEnabled then ESP_Folder:ClearAllChildren() end
            end)
        end
    end)

    RunService.RenderStepped:Connect(function()
        for _, v in pairs(ESP2D_Gui:GetChildren()) do
            if v.Name ~= "FOVCircle" then v.Visible = false end
        end
        if not Settings.Visuals.ESPEnabled then return end

        if Settings.Combat.ShowFOV then
            local fovRad = Settings.Combat.FOV
            local camFov = Camera.FieldOfView
            local radiusPixels = (math.tan(math.rad(fovRad / 2)) / math.tan(math.rad(camFov / 2))) * (Camera.ViewportSize.Y / 2)
            FOVCircle.Size = UDim2.new(0, radiusPixels * 2, 0, radiusPixels * 2)
            FOVCircle.Visible = true
            fovStroke.Transparency = Settings.Combat.Enabled and 0.4 or 0.7
        else
            FOVCircle.Visible = false
        end

        local targets = {}
        for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then table.insert(targets, p.Character) end end
        if Settings.Combat.TargetNPCs then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(v) then table.insert(targets, v) end
            end
        end

        for _, char in pairs(targets) do
            local root = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            local hum = char:FindFirstChild("Humanoid")
            if root and head and hum and hum.Health > 0 then
                local isLocked = (char == LockedTarget)
                local isVisible = GetIsVisible(char, root)
                local finalColor = isLocked and COLOR_LOCKED or (isVisible and COLOR_VISIBLE or COLOR_HIDDEN)
                local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local id = char:GetDebugId()

                    if Settings.Visuals.ESPTracer then
                        local lineName = id .. "_Tracer"
                        local line = ESP2D_Gui:FindFirstChild(lineName)
                        if not line then
                            line = Instance.new("Frame", ESP2D_Gui)
                            line.Name = lineName
                            line.AnchorPoint = Vector2.new(0.5, 0.5)
                            line.BorderSizePixel = 0
                        end
                        line.Visible = true
                        line.BackgroundColor3 = finalColor

                        local bottomCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        local targetPos = Vector2.new(rootPos.X, rootPos.Y)
                        local dist = (bottomCenter - targetPos).Magnitude

                        line.Size = UDim2.new(0, 1.5, 0, dist)
                        line.Position = UDim2.new(0, (bottomCenter.X + targetPos.X) / 2, 0, (bottomCenter.Y + targetPos.Y) / 2)
                        line.Rotation = math.deg(math.atan2(targetPos.Y - bottomCenter.Y, targetPos.X - bottomCenter.X)) + 90
                    end

                    if Settings.Visuals.ESPBox then
                        local headPos, _ = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos, _ = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

                        local height = math.abs(headPos.Y - legPos.Y)
                        local width = height / 1.5

                        local boxName = id .. "_Box"
                        local box = ESP2D_Gui:FindFirstChild(boxName)
                        if not box then
                            box = Instance.new("Frame", ESP2D_Gui)
                            box.Name = boxName
                            box.BackgroundTransparency = 1
                            local stroke = Instance.new("UIStroke", box)
                            stroke.Thickness = 1.5
                        end
                        box.Visible = true
                        box.Size = UDim2.new(0, width, 0, height)
                        box.Position = UDim2.new(0, headPos.X - width/2, 0, headPos.Y)
                        box:FindFirstChild("UIStroke").Color = finalColor
                    end
                end
            end
        end
    end)

    function stopClimbing()
        isClimbing = false
        if humanoid then humanoid.WalkSpeed = Settings.Movement.SpeedHackEnabled and Settings.Movement.NormalSpeed or 16; humanoid.AutoRotate = true end
        if climbAtt then climbAtt:Destroy() climbAtt = nil end
        if climbLV then climbLV:Destroy() climbLV = nil end
        if climbAV then climbAV:Destroy() climbAV = nil end
        if climbTrack then climbTrack:Stop(0.1) end
    end

    function playSound(id, vol, pitch)
        if not rootPart and not LocalPlayer.PlayerGui then return end
        local s = Instance.new("Sound", rootPart or LocalPlayer.PlayerGui)
        s.SoundId = "rbxassetid://"..tostring(id)
        s.Volume = vol or 0.5
        s.Pitch = pitch or 1
        s:Play()
        Debris:AddItem(s, 2)
    end

    local function onChar(char)
        character = char
        humanoid = char:WaitForChild("Humanoid")
        rootPart = char:WaitForChild("HumanoidRootPart")
        animator = humanoid:WaitForChild("Animator")
        local animId = (humanoid.RigType == Enum.HumanoidRigType.R15) and AnimIds.R15 or AnimIds.R6
        local animObj = Instance.new("Animation")
        animObj.AnimationId = animId
        safeCall(function() climbTrack = animator:LoadAnimation(animObj) end)
    end

    if LocalPlayer.Character then onChar(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(onChar)

    UserInputService.JumpRequest:Connect(function()
        if isClimbing and Settings.Movement.SpiderEnabled then
            stopClimbing()
            lastJumpTime = tick()
            local wallJumpDir = (rootPart.CFrame.LookVector * -1.5) + Vector3.new(0, 1.2, 0)
            rootPart.Velocity = wallJumpDir.Unit * Settings.Movement.WallJumpForce
            playSound(1428652081, 0.5, 1)
            return
        end
        if Settings.Movement.InfJump and rootPart then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, Settings.Movement.InfJumpForce, rootPart.Velocity.Z)
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

    UserInputService.InputBegan:Connect(function(i, gpe)
        if gpe then return end
        if i.KeyCode == Enum.KeyCode.LeftShift then isSprinting = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.KeyCode == Enum.KeyCode.LeftShift then isSprinting = false end
    end)

    RunService.RenderStepped:Connect(function()
        safeCall(function()
            if Settings.Combat.Enabled then
                if Settings.Combat.Mode == "Dynamic" then
                    LockedTarget = GetClosestToPlayer()
                elseif Settings.Combat.Mode == "Sticky" then
                    if not IsValidTarget(LockedTarget) then
                        LockedTarget = GetClosestToPlayer()
                    end
                end

                if LockedTarget then
                    local aimRoot = LockedTarget:FindFirstChild(Settings.Combat.AimPart) or LockedTarget:FindFirstChild("Head")
                    if aimRoot then
                        local targetPosition = aimRoot.Position

                        if Settings.Combat.AimAtBack then
                            targetPosition = (aimRoot.CFrame * CFrame.new(0, 0, Settings.Combat.BackOffset)).Position
                        end

                        if Settings.Combat.CamLock then
                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
                        end

                        if Settings.Combat.FreeCombat and rootPart and humanoid then
                            humanoid.AutoRotate = false
                            rootPart.CFrame = CFrame.lookAt(rootPart.Position, Vector3.new(targetPosition.X, rootPart.Position.Y, targetPosition.Z))
                        end
                        CheckTrigger()
                    end
                else
                    if humanoid and not isClimbing then humanoid.AutoRotate = true end
                end
            else
                LockedTarget = nil
                if humanoid and not isClimbing then humanoid.AutoRotate = true end
            end

            ApplyAntiAim()

            if Settings.Movement.Noclip and character then
                for _, v in pairs(character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                end
            end
        end)
    end)

    RunService.Heartbeat:Connect(function()
        if not rootPart or not humanoid then return end
        safeCall(function()
            if Settings.Movement.SpeedHackEnabled and not isClimbing then
                local baseSpeed = Settings.Movement.NormalSpeed
                humanoid.WalkSpeed = isSprinting and (baseSpeed * Settings.Movement.SprintMult) or baseSpeed
            end

            if not Settings.Movement.SpiderEnabled then return end
            if tick() - lastJumpTime < 0.4 then return end

            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {character}
            local dirs = {
                rootPart.CFrame.LookVector,
                (rootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)).LookVector,
                (rootPart.CFrame * CFrame.Angles(0, math.rad(-30), 0)).LookVector
            }

            local result = nil
            for _, dir in pairs(dirs) do
                local cast = Workspace:Raycast(rootPart.Position, dir * Settings.Movement.RayLength, rayParams)
                if cast then result = cast break end
            end

            if result then
                if not isClimbing then
                    isClimbing = true
                    humanoid.AutoRotate = false

                    climbAtt = Instance.new("Attachment", rootPart)
                    climbAtt.Name = "ClimbAttachment"

                    climbLV = Instance.new("LinearVelocity", rootPart)
                    climbLV.Name = "ClimbLinearVelocity"
                    climbLV.Attachment0 = climbAtt
                    climbLV.VectorVelocity = Vector3.new(0, 0.1, 0)
                    climbLV.ForceLimitMode = Enum.ForceLimitMode.PerAxis
                    climbLV.MaxAxesForce = Vector3.new(9e9, 9e9, 9e9)

                    climbAV = Instance.new("AngularVelocity", rootPart)
                    climbAV.Name = "ClimbAngularVelocity"
                    climbAV.Attachment0 = climbAtt
                    climbAV.AngularVelocity = Vector3.new(0, 0, 0)
                    climbAV.MaxAngularVelocity = 9e9

                    if climbTrack then climbTrack:Play() end
                    playSound(4806082497, 0.3, 1.1)
                end

                local targetCF = CFrame.lookAt(rootPart.Position, result.Position + result.Normal * -1)
                local targetAxis, targetAngle = targetCF:ToAxisAngle()
                climbAV.AngularVelocity = targetAxis * (targetAngle / 0.1)

                local move = humanoid.MoveDirection
                local speed = isSprinting and (Settings.Movement.ClimbSpeed * Settings.Movement.SprintMult) or Settings.Movement.ClimbSpeed

                if move.Magnitude > 0.1 then
                    local v = move:Dot(rootPart.CFrame.LookVector)
                    local h = move:Dot(rootPart.CFrame.RightVector)
                    climbLV.VectorVelocity = (Vector3.new(0, 1, 0) * v * speed) + (rootPart.CFrame.RightVector * h * speed)
                    if climbTrack then climbTrack:AdjustSpeed(isSprinting and 2.2 or 1.4) end
                else
                    climbLV.VectorVelocity = Vector3.new(0, 0.1, 0)
                    if climbTrack then climbTrack:AdjustSpeed(0) end
                end
            else
                if isClimbing then
                    stopClimbing()
                    if humanoid.MoveDirection.Magnitude > 0 then
                        rootPart.Velocity = Vector3.new(0, 45, 0) + (rootPart.CFrame.LookVector * 30)
                    end
                end
            end
        end)
    end)

    print("Admin Nillo CYAN DARK EDITION carregado!")
end)
