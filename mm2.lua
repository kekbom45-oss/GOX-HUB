--[[
    ============================================================
    MM2 BY GOX HUB - ANIMATED ULTIMATE EDITION
    ============================================================
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("GoxHub_Final") then playerGui.GoxHub_Final:Destroy() end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "GoxHub_Final"
screenGui.ResetOnSpawn = false

local function applyRainbow(object)
    task.spawn(function()
        local hue = 0
        while object and object.Parent do
            hue = hue + (1/400)
            if hue > 1 then hue = 0 end
            local color = Color3.fromHSV(hue, 0.7, 1)
            if object:IsA("TextLabel") or object:IsA("TextButton") then object.TextColor3 = color
            elseif object:IsA("UIStroke") then object.Color = color end
            task.wait()
        end
    end)
end

local function Notify(title, text)
    local notifyFrame = Instance.new("Frame", screenGui)
    notifyFrame.Size = UDim2.new(0, 250, 0, 70)
    notifyFrame.Position = UDim2.new(1, 10, 0, 30)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", notifyFrame)
    local nStroke = Instance.new("UIStroke", notifyFrame); nStroke.Thickness = 2; applyRainbow(nStroke)
    local tLabel = Instance.new("TextLabel", notifyFrame)
    tLabel.Text = title; tLabel.Size = UDim2.new(1, -20, 0, 25); tLabel.Position = UDim2.new(0, 10, 0, 8)
    tLabel.BackgroundTransparency = 1; tLabel.Font = Enum.Font.FredokaOne; tLabel.TextSize = 18; applyRainbow(tLabel)
    local mLabel = Instance.new("TextLabel", notifyFrame)
    mLabel.Text = text; mLabel.Size = UDim2.new(1, -20, 0, 30); mLabel.Position = UDim2.new(0, 10, 0, 35)
    mLabel.BackgroundTransparency = 1; mLabel.TextColor3 = Color3.fromRGB(255, 255, 255); mLabel.Font = Enum.Font.Gotham; mLabel.TextSize = 14
    notifyFrame:TweenPosition(UDim2.new(1, -270, 0, 30), "Out", "Back", 0.5, true)
    task.delay(3, function()
        notifyFrame:TweenPosition(UDim2.new(1, 10, 0, 30), "In", "Quad", 0.5, true)
        task.wait(0.5); notifyFrame:Destroy()
    end)
end

local introLabel = Instance.new("TextLabel", screenGui)
introLabel.Size = UDim2.new(0, 500, 0, 100); introLabel.Position = UDim2.new(0.5, -250, 0.4, -50)
introLabel.BackgroundTransparency = 1; introLabel.Text = "MM2 BY GOX HUB"; introLabel.Font = Enum.Font.FredokaOne; introLabel.TextSize = 60; applyRainbow(introLabel)

local startBtn = Instance.new("TextButton", screenGui)
startBtn.Size = UDim2.new(0, 200, 0, 50); startBtn.Position = UDim2.new(0.5, -100, 0.55, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); startBtn.Text = "กดเพื่อไปต่อ"; startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold; startBtn.TextSize = 18; Instance.new("UICorner", startBtn)
local bStroke = Instance.new("UIStroke", startBtn); bStroke.Thickness = 3; applyRainbow(bStroke)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 530); mainFrame.Position = UDim2.new(0.5, -150, 0.5, -265)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12); mainFrame.Visible = false; mainFrame.Active = true; mainFrame.Draggable = true; mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
local mStroke = Instance.new("UIStroke", mainFrame); mStroke.Thickness = 2.5; applyRainbow(mStroke)

local miniBtn = Instance.new("TextButton", screenGui)
miniBtn.Size = UDim2.new(0, 65, 0, 65); miniBtn.Position = UDim2.new(0, 20, 0.5, -32)
miniBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10); miniBtn.Text = "GOX"; miniBtn.Visible = false; miniBtn.Active = true; miniBtn.Draggable = true
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1, 0); applyRainbow(miniBtn)

local dragStartPos
local isDragging = false
miniBtn.MouseButton1Down:Connect(function() dragStartPos = miniBtn.Position; isDragging = false end)
miniBtn.MouseButton1Up:Connect(function()
    if dragStartPos then
        local delta = (Vector2.new(miniBtn.Position.X.Offset, miniBtn.Position.Y.Offset) - Vector2.new(dragStartPos.X.Offset, dragStartPos.Y.Offset)).Magnitude
        isDragging = delta > 5
    end
end)
miniBtn.MouseButton1Click:Connect(function()
    if not isDragging then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 300, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 300, 0, 530)}):Play()
        miniBtn.Visible = false
    end
end)

startBtn.MouseButton1Click:Connect(function()
    introLabel:Destroy(); startBtn:Destroy(); mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 300, 0, 0)
    TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 530)}):Play()
    Notify("GOX HUB", "สคริปต์เริ่มทำงานแล้ว!")
end)

local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -20, 1, -100); scroll.Position = UDim2.new(0, 10, 0, 85); scroll.BackgroundTransparency = 1; scroll.ScrollBarThickness = 0; scroll.CanvasSize = UDim2.new(0, 0, 2.5, 0)
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 10)

local function createBtn(text, color, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 45); btn.Text = text; btn.BackgroundColor3 = color; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 13; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local speedActive = false
local speedBtn = createBtn("🏃 วิ่งเร็ว (Speed 60): OFF", Color3.fromRGB(40, 40, 40), function()
    speedActive = not speedActive
    Notify("Speed", speedActive and "เปิดความเร็ว 60" or "ปิดความเร็ว 60")
end)
RunService.Heartbeat:Connect(function()
    if speedActive and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 60
        speedBtn.Text = "🏃 วิ่งเร็ว (Speed 60): ON"; speedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    else
        speedBtn.Text = "🏃 วิ่งเร็ว (Speed 60): OFF"; speedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

createBtn("🛡️ สะท้อนการเตะ (Reflect)", Color3.fromRGB(120, 60, 0), function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Fing.lua"))() end)
end)

createBtn("🌀 ระบบวาร์ป (GitHub)", Color3.fromRGB(0, 60, 120), function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kekbom45-oss/GOX-HUB/main/Wa.lua"))() end)
end)

local lockOn = false
createBtn("🎯 Silent Aim ฆาตกร", Color3.fromRGB(30, 30, 30), function()
    lockOn = not lockOn
    Notify("Silent Aim", lockOn and "เปิดล็อกเป้า" or "ปิดล็อกเป้า")
end)

local mt = getrawmetatable(game); local oldNm = mt.__namecall; setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if (method == "FireServer" or method == "InvokeServer") and tostring(self):find("Remote") then
        local args = {...}
        if args[1] == "KickPlayer" or args[1] == "Crash" then return nil end
    end
    return oldNm(self, ...)
end)
setreadonly(mt, true)
hookfunction(player.Kick, function() return nil end)

local oldIdx; oldIdx = hookmetamethod(game, "__index", function(self, k)
    if lockOn and self == mouse and k == "Hit" then
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
                return v.Character.Head.CFrame
            end
        end
    end
    return oldIdx(self, k)
end)
