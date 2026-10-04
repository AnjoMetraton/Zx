local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local RStore = game:GetService("ReplicatedStorage")
repeat task.wait() until Players.LocalPlayer
local LP = Players.LocalPlayer
local GEN = (_G.DBGT_FarmGen or 0) + 1
_G.DBGT_FarmGen = GEN
pcall(function()
local old = LP.PlayerGui:FindFirstChild("DBGT_Farm")
if old then old:Destroy() end
end)
local ATK_SECONDS = 60
local DEF_SECONDS = 60
local ENERGY_LOW = 5
local ENERGY_OK = 95
local ATK_DELAY = 0.12
local KI_EVERY = 3
local DEF_DELAY = 0.3
local NO_BAR_ATK = 9
local NO_BAR_REST = 3
local ATK_NAMES = {"Punch","Attack","Hit","Melee","Combat","Damage","Slash","Fight","TapDamage"}
local KI_NAMES = {"KiBlast","Ki","Blast","Kamehameha","Beam","Skill","Shoot","Fire","Special"}
local UP_NAMES = {"Charge","Recharge","Meditate","Rest","Energy","Regen","KiCharge"}
local DEF_NAMES = {"Defense","Defence","Block","Guard","TrainDefense","UpgradeDefense","AddDefense","Tank","Train"}
local KI_KEYS = {Enum.KeyCode.E,Enum.KeyCode.R,Enum.KeyCode.F,Enum.KeyCode.Q}
local UP_KEYS = {Enum.KeyCode.C}
local DEF_KEYS = {Enum.KeyCode.G,Enum.KeyCode.T}
local function New(c,p)
local o = Instance.new(c)
for k,v in pairs(p or {}) do o[k] = v end
return o
end
local SG = New("ScreenGui",{Name = "DBGT_Farm",ResetOnSpawn = false,ZIndexBehavior = Enum.ZIndexBehavior.Sibling,Parent = LP:WaitForChild("PlayerGui")})
local Box = New("Frame",{Size = UDim2.new(0,220,0,64),Position = UDim2.new(0,10,0,10),BackgroundColor3 = Color3.fromRGB(6,3,14),BorderSizePixel = 0,Parent = SG})
New("UICorner",{CornerRadius = UDim.new(0,10),Parent = Box})
New("UIStroke",{Color = Color3.fromRGB(0,170,255),Thickness = 1.2,Parent = Box})
local PhaseLab = New("TextLabel",{Size = UDim2.new(1,-16,0,22),Position = UDim2.new(0,8,0,8),BackgroundTransparency = 1,Text = "DBGT FARM INICIANDO",Font = Enum.Font.GothamBold,TextColor3 = Color3.fromRGB(120,220,255),TextSize = 13,TextXAlignment = Enum.TextXAlignment.Left,Parent = Box})
local EnergyLab = New("TextLabel",{Size = UDim2.new(1,-16,0,22),Position = UDim2.new(0,8,0,34),BackgroundTransparency = 1,Text = "ENERGIA ?",Font = Enum.Font.GothamBold,TextColor3 = Color3.fromRGB(255,220,120),TextSize = 13,TextXAlignment = Enum.TextXAlignment.Left,Parent = Box})
local function SetPhase(t)
pcall(function() PhaseLab.Text = t end)
end
local function SetEnergy(t)
pcall(function() EnergyLab.Text = t end)
end
local function FindRemote(names)
for _,n in ipairs(names) do
local f = RStore:FindFirstChild(n,true)
if f and (f:IsA("RemoteEvent") or f:IsA("RemoteFunction")) then return f end
end
return nil
end
local function UseRemote(r,...)
if not r then return false end
local a = {...}
if r:IsA("RemoteEvent") then
local ok = pcall(function() r:FireServer(table.unpack(a)) end)
return ok
end
local ok = pcall(function() r:InvokeServer(table.unpack(a)) end)
return ok
end
local function Press(k)
pcall(function()
VIM:SendKeyEvent(true,k,false,game)
task.wait(0.06)
VIM:SendKeyEvent(false,k,false,game)
end)
end
local function Tap()
pcall(function()
VIM:SendMouseButtonEvent(400,300,0,true,game,1)
task.wait(0.05)
VIM:SendMouseButtonEvent(400,300,0,false,game,1)
end)
end
local function Alive()
local ch = LP.Character
if not ch then return nil end
local h = ch:FindFirstChildOfClass("Humanoid")
if not h or h.Health <= 0 then return nil end
return ch
end
local function BarName(n)
n = string.lower(n)
if string.find(n,"energy") then return true end
if string.find(n,"stamina") then return true end
if string.find(n,"chakra") then return true end
if n == "ki" then return true end
if string.find(n,"ki bar") then return true end
if string.find(n,"kibar") then return true end
if string.find(n,"power") and string.find(n,"bar") then return true end
return false
end
local function ReadEnergy()
local pct = nil
pcall(function()
for _,d in ipairs(LP.PlayerGui:GetDescendants()) do
if d:IsA("TextLabel") then
local pn = d.Parent and d.Parent.Name or ""
if BarName(d.Name .. " " .. pn) then
local a,b = string.match(d.Text,"(%d+)%s*/%s*(%d+)")
if a and b and tonumber(b) > 0 then pct = math.clamp(tonumber(a) / tonumber(b) * 100,0,100) break end
end
end
end
end)
if pct then return pct end
pcall(function()
for _,d in ipairs(LP.PlayerGui:GetDescendants()) do
if (d:IsA("Frame") or d:IsA("ImageLabel")) and BarName(d.Name) and d.Size.X.Scale > 0 and d.Size.X.Scale <= 1 then
pct = math.clamp(d.Size.X.Scale * 100,0,100) break
end
end
end)
if pct then return pct end
pcall(function()
local ls = LP:FindFirstChild("leaderstats")
if ls then
for _,v in ipairs(ls:GetChildren()) do
if (v:IsA("NumberValue") or v:IsA("IntValue")) and BarName(v.Name) then
pct = math.clamp(v.Value,0,100) break
end
end
end
end)
if pct then return pct end
pcall(function()
local ch = LP.Character
if ch then
for _,v in ipairs(ch:GetChildren()) do
if (v:IsA("NumberValue") or v:IsA("IntValue")) and BarName(v.Name) then
pct = math.clamp(v.Value,0,100) break
end
end
end
end)
return pct
end
local function FaceNear()
pcall(function()
local ch = Alive()
if not ch then return end
local root = ch:FindFirstChild("HumanoidRootPart")
if not root then return end
local best = nil
local bd = 30
for _,m in ipairs(workspace:GetDescendants()) do
if m:IsA("Humanoid") and m.Health > 0 and m.Parent ~= ch and not Players:GetPlayerFromCharacter(m.Parent) then
local r = m.Parent:FindFirstChild("HumanoidRootPart")
if r then
local d = (r.Position - root.Position).Magnitude
if d < bd then bd = d best = r end
end
end
end
if best then root.CFrame = CFrame.new(root.Position,Vector3.new(best.Position.X,root.Position.Y,best.Position.Z)) end
end)
end
local AtkRemote = FindRemote(ATK_NAMES)
local KiRemote = FindRemote(KI_NAMES)
local UpRemote = FindRemote(UP_NAMES)
local DefRemote = FindRemote(DEF_NAMES)
task.spawn(function()
task.wait(5)
if _G.DBGT_FarmGen ~= GEN then return end
if not AtkRemote then AtkRemote = FindRemote(ATK_NAMES) end
if not KiRemote then KiRemote = FindRemote(KI_NAMES) end
if not UpRemote then UpRemote = FindRemote(UP_NAMES) end
if not DefRemote then DefRemote = FindRemote(DEF_NAMES) end
end)
local function FillEnergy()
local t0 = tick()
while _G.DBGT_FarmGen == GEN do
local p = ReadEnergy()
if p and p >= ENERGY_OK then break end
if not p and tick() - t0 > 6 then break end
if UpRemote then UseRemote(UpRemote) else for _,k in ipairs(UP_KEYS) do Press(k) end end
task.wait(0.25)
end
end
local function HitPhase(dur)
local t0 = tick()
local n = 0
local burst = tick()
while _G.DBGT_FarmGen == GEN and tick() - t0 < dur do
local ch = Alive()
if not ch then
SetPhase("MORTO AGUARDANDO RESPAWN")
task.wait(1)
t0 = t0 + 1
else
local p = ReadEnergy()
if p then SetEnergy("ENERGIA " .. math.floor(p) .. "%") else SetEnergy("ENERGIA MODO TEMPO") end
if p and p <= ENERGY_LOW then
SetPhase("RECARREGANDO ENERGIA")
FillEnergy()
else
if not p and tick() - burst > NO_BAR_ATK then
SetPhase("RECARREGANDO ENERGIA")
local c0 = tick()
while _G.DBGT_FarmGen == GEN and tick() - c0 < NO_BAR_REST do
if UpRemote then UseRemote(UpRemote) else for _,k in ipairs(UP_KEYS) do Press(k) end end
task.wait(0.25)
end
burst = tick()
else
SetPhase("ATACANDO + KI BLAST")
FaceNear()
if AtkRemote then UseRemote(AtkRemote) else Tap() end
n = n + 1
if n % KI_EVERY == 0 then
if KiRemote then UseRemote(KiRemote) else Press(KI_KEYS[1]) end
end
end
end
end
task.wait(ATK_DELAY)
end
end
local function GuardPhase(dur)
local t0 = tick()
while _G.DBGT_FarmGen == GEN and tick() - t0 < dur do
local ch = Alive()
if not ch then
SetPhase("MORTO AGUARDANDO RESPAWN")
task.wait(1)
t0 = t0 + 1
else
SetPhase("AUMENTANDO DEFESA")
local p = ReadEnergy()
if p then SetEnergy("ENERGIA " .. math.floor(p) .. "%") end
if DefRemote then UseRemote(DefRemote) else for _,k in ipairs(DEF_KEYS) do Press(k) end end
end
task.wait(DEF_DELAY)
end
end
while _G.DBGT_FarmGen == GEN do
local ok = pcall(function()
AtkRemote = AtkRemote or FindRemote(ATK_NAMES)
KiRemote = KiRemote or FindRemote(KI_NAMES)
UpRemote = UpRemote or FindRemote(UP_NAMES)
DefRemote = DefRemote or FindRemote(DEF_NAMES)
HitPhase(ATK_SECONDS)
GuardPhase(DEF_SECONDS)
end)
if not ok then task.wait(1) end
end
