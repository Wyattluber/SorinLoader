-- Sorin Debug UI v6  (Delta-stabil, sichtbarer Text, kräftiger Intro)
-- Keys: J Größe | M Extras (LuaHeap/FrameTime) | H Hide/Show

-- ===== Singleton + Run Counter =====
local env = getgenv and getgenv() or _G
env.SorinDebugRuns = (env.SorinDebugRuns or 0) + 1
for _, g in ipairs(game:GetService("CoreGui"):GetChildren()) do
    if g.Name == "SorinDebugUI" or g.Name == "SorinDebugOverlay" then g:Destroy() end
end
local lp = game:GetService("Players").LocalPlayer
local pg = lp:FindFirstChildOfClass("PlayerGui"); if pg and pg:FindFirstChild("SorinDebugUI") then pg.SorinDebugUI:Destroy() end

if env.SorinDebugRuns >= 3 then
    env.SorinDebugRuns = 0
    local sg = Instance.new("ScreenGui"); sg.Name="SorinDebugOverlay"; sg.IgnoreGuiInset=true
    sg.ZIndexBehavior=Enum.ZIndexBehavior.Global; sg.DisplayOrder=2^31-1
    (gethui and gethui() or game:GetService("CoreGui")).Parent = sg.Parent and sg.Parent or nil
    sg.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    local bg = Instance.new("Frame"); bg.Size = UDim2.fromScale(1,1); bg.BackgroundColor3 = Color3.new(0,0,0); bg.Parent = sg
    local t = Instance.new("TextLabel", bg)
    t.BackgroundTransparency=1; t.Size=UDim2.fromScale(1,1)
    t.Text="BIN DOCH SCHON OFFEN DU TROTTEL!!!"; t.TextColor3=Color3.fromRGB(255,80,100)
    t.TextStrokeTransparency=0.3; t.TextStrokeColor3=Color3.new(0,0,0); t.Font=Enum.Font.SourceSansBold; t.TextScaled=true
    local sub=Instance.new("TextLabel", bg); sub.BackgroundTransparency=1; sub.Size=UDim2.fromScale(1,0); sub.Position=UDim2.fromScale(0,0.85)
    sub.Text="Taste drücken oder klicken zum Schließen"; sub.TextColor3=Color3.fromRGB(200,200,220); sub.Font=Enum.Font.SourceSans; sub.TextScaled=true
    local UIS=game:GetService("UserInputService"); local function close() if sg then sg:Destroy() end end; UIS.InputBegan:Once(close); bg.InputBegan:Once(close)
    return
end

-- ===== Services =====
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- ===== Settings =====
local SHOW_EXTRAS=false
local THEME={bg=Color3.fromRGB(15,15,25), text=Color3.fromRGB(235,240,255), accent=Color3.fromRGB(125,180,255)}
local SIZES={Compact=Vector2.new(240,120), Regular=Vector2.new(300,160), Large=Vector2.new(380,200)}
local ORDER={"Compact","Regular","Large"}; local sizeIndex=2

-- ===== GUI (on-top, executor-sicher) =====
local gui = Instance.new("ScreenGui")
gui.Name="SorinDebugUI"; gui.IgnoreGuiInset=true
gui.ZIndexBehavior=Enum.ZIndexBehavior.Global; gui.DisplayOrder=2^31-1
pcall(function()
    local hui=(gethui and gethui()) or (get_hidden_gui and get_hidden_gui())
    if hui then gui.Parent=hui else gui.Parent=lp:WaitForChild("PlayerGui") end
end)

local frame = Instance.new("Frame", gui)
frame.Active=true; frame.BackgroundColor3=THEME.bg; frame.BorderSizePixel=0; frame.ZIndex=2^31-1
local function applySize()
    local v=SIZES[ORDER[sizeIndex]]; frame.Size=UDim2.fromOffset(v.X, v.Y)
end
applySize()
frame.Position=UDim2.new(1, -(frame.AbsoluteSize.X+20), 0, 50)
Instance.new("UICorner", frame).CornerRadius=UDim.new(0,12)
local stroke=Instance.new("UIStroke", frame); stroke.Thickness=1.6; stroke.Color=THEME.accent; stroke.Transparency=0.25

local title = Instance.new("TextLabel", frame)
title.BackgroundTransparency=1; title.Text="🚀 Sorin Debug Monitor"
title.Font=Enum.Font.SourceSansBold; title.TextSize=18
title.TextColor3=Color3.fromRGB(180,200,255); title.TextXAlignment=Enum.TextXAlignment.Left
title.Size=UDim2.new(1,-14,0,24); title.Position=UDim2.new(0,7,0,6); title.ZIndex=frame.ZIndex

local info = Instance.new("TextLabel", frame)
info.BackgroundTransparency=1; info.Font=Enum.Font.SourceSans; info.TextSize=16
info.TextColor3=THEME.text; info.TextXAlignment=Enum.TextXAlignment.Left; info.TextYAlignment=Enum.TextYAlignment.Top
info.TextWrapped=true; info.Size=UDim2.new(1,-14,1,-40); info.Position=UDim2.new(0,7,0,34); info.ZIndex=frame.ZIndex
info.Text = "🎮 FPS: …\n📶 Ping: …\n👥 Spieler: …" -- 👉 sofort sichtbar

-- ===== kräftiges Intro (Scale+Pop + Glow-Pulse), kein Blur =====
local scale = Instance.new("UIScale", frame); scale.Scale=0.6
frame.Rotation = -6
TweenService:Create(scale, TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Scale=1}):Play()
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Position=UDim2.new(1, -(frame.AbsoluteSize.X+20), 0, 50), Rotation=0
}):Play()
task.spawn(function() -- Glow-Pulse Loop
    while stroke.Parent do
        TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Transparency=0.05}):Play()
        task.wait(0.6)
        TweenService:Create(stroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Transparency=0.3}):Play()
        task.wait(0.6)
    end
end)

-- ===== Subtile Glitch-Akzente (nur Optik) =====
local function glitch(y)
    local l=Instance.new("Frame", frame); l.Size=UDim2.new(0.6,0,0,1); l.Position=UDim2.new(0.05,0,0,y)
    l.BackgroundColor3=THEME.accent; l.Transparency=0.7
    task.spawn(function()
        while l.Parent do
            l.Visible = math.random()<0.22
            l.Position=UDim2.new(0.05+math.random()*0.15,0,0,y+math.random(-1,1))
            task.wait(0.12+math.random()*0.2)
        end
    end)
end
glitch(36); glitch(58)

-- ===== FPS (Zähler pro Sekunde) =====
local frames=0; local lastReport=os.clock(); local FPS=60; local FTms=16.7
RunService.RenderStepped:Connect(function(dt)
    frames += 1
    if os.clock()-lastReport >= 1 then
        FPS = frames
        FTms = math.floor((1000/math.max(FPS,1))*10+0.5)/10
        frames=0; lastReport=os.clock()
    end
end)

-- ===== Ping (robust) =====
local function getPing()
    local p=-1
    pcall(function()
        local net=Stats:FindFirstChild("Network")
        local ssi=net and net:FindFirstChild("ServerStatsItem")
        local dp=ssi and ssi:FindFirstChild("Data Ping")
        if dp then p=math.floor(dp:GetValue()) end
    end)
    if p<0 then
        pcall(function()
            local perf=Stats:FindFirstChild("PerformanceStats")
            if perf and perf:FindFirstChild("Ping") then p=math.floor(perf.Ping:GetValue()) end
        end)
    end
    return p
end

local function luaHeapMB()
    local kb=collectgarbage("count"); return math.floor((kb/1024)*10+0.5)/10
end

-- ===== Update Loop (Text garantiert) =====
task.spawn(function()
    while gui.Parent do
        local ping = getPing()
        local players = #Players:GetPlayers()
        local warn = (ping>=130 and "  ⚠️ Verbindung instabil?") or ""
        local lines = {
            ("🎮 FPS: %d"):format(FPS),
            ("📶 Ping: %s ms%s"):format(ping>=0 and tostring(ping) or "–", warn),
            ("👥 Spieler: %d"):format(players),
        }
        if SHOW_EXTRAS then
            table.insert(lines, ("📦 LuaHeap: %.1f MB"):format(luaHeapMB()))
            table.insert(lines, ("⏱ FrameTime: %.1f ms"):format(FTms))
        end
        info.Text = table.concat(lines, "\n")  -- <- immer Text!
        task.wait(0.3)
    end
end)

-- ===== Drag =====
local dragging=false; local dragStart; local startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true; dragStart=input.Position; startPos=frame.Position
        input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
        local d=input.Position-dragStart
        frame.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)

-- ===== Hotkeys =====
local function resize()
    local v=SIZES[ORDER[sizeIndex]]
    TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.fromOffset(v.X,v.Y)}):Play()
    task.delay(0.01,function()
        frame.Position=UDim2.new(1, -(frame.AbsoluteSize.X+20), frame.Position.Y.Scale, frame.Position.Y.Offset)
    end)
end
UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.J then sizeIndex=sizeIndex%#ORDER+1; resize()
    elseif input.KeyCode==Enum.KeyCode.M then SHOW_EXTRAS=not SHOW_EXTRAS
    elseif input.KeyCode==Enum.KeyCode.H then frame.Visible=not frame.Visible end
end)
