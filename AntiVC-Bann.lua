-- Sorin Anti-VC UI

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

if not game:IsLoaded() then game.Loaded:Wait() end
_G.SorinOpenCount = (_G.SorinOpenCount or 0) + 1

if player:FindFirstChild("PlayerGui"):FindFirstChild("SorinUI") then
    if _G.SorinOpenCount == 1 then
        StarterGui:SetCore("SendNotification", {
            Title = "Sorin läuft bereits",
            Text = "Der Anti-VC-Schutz ist schon aktiv!",
            Duration = 5
        })
    elseif _G.SorinOpenCount >= 2 then
        local ui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        ui.ResetOnSpawn = false
        local bg = Instance.new("Frame", ui)
        bg.BackgroundColor3 = Color3.new(0, 0, 0)
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundTransparency = 1
        local msg = Instance.new("TextLabel", bg)
        msg.Size = UDim2.new(1, 0, 1, 0)
        msg.BackgroundTransparency = 1
        msg.TextScaled = true
        msg.Font = Enum.Font.GothamBlack
        msg.TextColor3 = Color3.new(1, 1, 1)
        msg.Text = ""
        TweenService:Create(bg, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        task.spawn(function()
            local text = "ICH BIN SCHON OFFEN, WIE OFT DENN NOCH?"
            for i = 1, #text do
                msg.Text = string.sub(text, 1, i)
                task.wait(0.05)
            end
            task.wait(2.5)
            ui:Destroy()
        end)
    end
    return
end

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SorinUI"
gui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 120)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = gui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", loadingFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "SorinHub - Anti-VC-Ban v2"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(1, -20, 0, 20)
barBG.Position = UDim2.new(0, 10, 1, -30)
barBG.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
barBG.BorderSizePixel = 0
barBG.Parent = loadingFrame
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 10)

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 0, 20)
progressBar.Position = UDim2.new(0, 10, 1, -30)
progressBar.BackgroundColor3 = Color3.fromRGB(60, 200, 130)
progressBar.BorderSizePixel = 0
progressBar.Parent = loadingFrame
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 10)

TweenService:Create(progressBar, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -20, 0, 20)}):Play()

-- Weiter nach 3 Sekunden
task.delay(3, function()
    loadingFrame:Destroy()

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 150)
    Frame.Position = UDim2.new(1, -260, 1, -180)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Frame.BorderSizePixel = 0
    Frame.Name = "SorinFrame"
    Frame.Parent = gui
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

    local drag = false
    local offset = Vector2.new()
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            offset = Vector2.new(input.Position.X - Frame.AbsolutePosition.X, input.Position.Y - Frame.AbsolutePosition.Y)
        end
    end)
    Frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
            }):Play()
        end
    end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = "🎧 Voice Control"
    Title.TextColor3 = Color3.fromRGB(180, 180, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamSemibold
    Title.Parent = Frame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 7)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Frame
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0.9, 0, 0, 35)
    JoinBtn.Position = UDim2.new(0.05, 0, 0, 60)
    JoinBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 130)
    JoinBtn.Text = "🎧 Voice aktivieren"
    JoinBtn.TextColor3 = Color3.new(1, 1, 1)
    JoinBtn.TextScaled = true
    JoinBtn.Font = Enum.Font.GothamBold
    JoinBtn.Parent = Frame
    Instance.new("UICorner", JoinBtn).CornerRadius = UDim.new(0, 6)

    local MadeBy = Instance.new("TextLabel")
    MadeBy.Size = UDim2.new(1, -10, 0, 15)
    MadeBy.Position = UDim2.new(0, 5, 1, -20)
    MadeBy.BackgroundTransparency = 1
    MadeBy.Text = "Made by SorinHub"
    MadeBy.TextColor3 = Color3.fromRGB(100, 100, 120)
    MadeBy.TextScaled = true
    MadeBy.Font = Enum.Font.Code
    MadeBy.Parent = Frame

    CloseBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    JoinBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Wyattluber/SorinLoader/refs/heads/main/anti-vc.lua"))()
        end)

        if success then
            StarterGui:SetCore("SendNotification", {
                Title = "Voice aktiviert",
                Text = "Sorin Voice-Modul wurde geladen.",
                Duration = 3
            })
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Fehler",
                Text = "Voice-Modul konnte nicht geladen werden.",
                Duration = 3
            })
            warn("SorinLoader Error:", err)
        end

        local dWin = Instance.new("Frame")
        dWin.Size = UDim2.new(0, 300, 0, 150)
        dWin.Position = UDim2.new(0.5, -150, 0.5, -75)
        dWin.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        dWin.BorderSizePixel = 0
        dWin.Parent = gui
        Instance.new("UICorner", dWin).CornerRadius = UDim.new(0, 10)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Position = UDim2.new(0, 0, 0, 10)
        title.Text = "Join our Discord"
        title.BackgroundTransparency = 1
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextColor3 = Color3.new(1, 1, 1)
        title.Parent = dWin

        local join = Instance.new("TextButton")
        join.Size = UDim2.new(0.4, 0, 0, 30)
        join.Position = UDim2.new(0.1, 0, 1, -50)
        join.BackgroundColor3 = Color3.fromRGB(60, 200, 130)
        join.Text = "Join"
        join.TextScaled = true
        join.Font = Enum.Font.Gotham
        join.TextColor3 = Color3.new(1, 1, 1)
        join.Parent = dWin
        Instance.new("UICorner", join).CornerRadius = UDim.new(0, 6)

        local cancel = Instance.new("TextButton")
        cancel.Size = UDim2.new(0.4, 0, 0, 30)
        cancel.Position = UDim2.new(0.5, 20, 1, -50)
        cancel.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
        cancel.Text = "Fuck off"
        cancel.TextScaled = true
        cancel.Font = Enum.Font.Gotham
        cancel.TextColor3 = Color3.new(1, 1, 1)
        cancel.Parent = dWin
        Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

        join.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/yXgtrQ4kPg")
            StarterGui:SetCore("SendNotification", {
                Title = "Discord-Link kopiert",
                Text = "Jetzt einfach im Browser einfügen!",
                Duration = 3
            })
            dWin:Destroy()
        end)

        cancel.MouseButton1Click:Connect(function()
            dWin:Destroy()
        end)
    end)
end)
