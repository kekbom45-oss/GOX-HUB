--[[
    MM2 PREMIUM SCRIPT (GOX-HUB Edition)
    GitHub: https://github.com/kekbom45-oss/GOX-HUB
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ล้าง UI เก่าป้องกันการซ้อนทับ
if playerGui:FindFirstChild("MM2_Premium_UI") then
    playerGui:FindFirstChild("MM2_Premium_UI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2_Premium_UI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- ระบบสีรุ้ง (Rainbow System)
local function applyRainbow(object)
    task.spawn(function()
        local hue = 0
        while object and object.Parent do
            hue = hue + (1/400)
            if hue > 1 then hue = 0 end
            local color = Color3.fromHSV(hue, 0.7, 1)
            if object:IsA("TextLabel") or object:IsA("TextButton") then
                object.TextColor3 = color
            elseif object:IsA("UIStroke") then
                object.Color = color
            end
            task.wait()
        end
    end)
end

-- [1] Intro: MM2 Rainbow Fade Out
local introLabel = Instance.new("TextLabel")
introLabel.Size = UDim2.new(0, 400, 0, 100)
introLabel.Position = UDim2.new(0.5, -200, 0.4, 0)
introLabel.BackgroundTransparency = 1
introLabel.Text = "MM2"
introLabel.TextSize = 100
introLabel.Font = Enum.Font.LuckiestGuy
introLabel.Parent = screenGui
applyRainbow(introLabel)

task.wait(1.5)
TweenService:Create(introLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
task.wait(1.5)
introLabel:Destroy()

-- [2] Loading Bar: Green Download
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(0, 300, 0, 10)
loadFrame.Position = UDim2.new(0.5, -150, 0.5, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadFrame.BorderSizePixel = 0
loadFrame.Parent = screenGui

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
bar.BorderSizePixel = 0
bar.Parent = loadFrame

for i = 1, 100 do
    bar.Size = UDim2.new(i/100, 0, 1, 0)
    task.wait(0.02)
end
loadFrame:Destroy()

-- [3] Ready Alert: Red & Explosion
local readyLabel = Instance.new("TextLabel")
readyLabel.Size = UDim2.new(0, 400, 0, 50)
readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25)
readyLabel.BackgroundTransparency = 1
readyLabel.Text = "ระบบพร้อมแล้ว"
readyLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
readyLabel.TextSize = 50
readyLabel.Font = Enum.Font.GothamBold
readyLabel.Parent = screenGui

task.wait(0.5)
TweenService:Create(readyLabel, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 800, 0, 200),
    Position = UDim2.new(0.5, -400, 0.5, -100),
    TextTransparency = 1
}):Play()
task.wait(1.5)
readyLabel:Destroy()

-- [4] Main UI: Elegant Design
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 350)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 3
uiStroke.Parent = mainFrame
applyRainbow(uiStroke)

-- Lightning Effect (เอฟเฟกต์สายฟ้าตรงกรอบ)
task.spawn(function()
    while mainFrame and mainFrame.Parent do
        task.wait(math.random(3, 8))
        uiStroke.Color = Color3.fromRGB(255, 255, 255)
        uiStroke.Thickness = 5
        task.wait(0.1)
        uiStroke.Thickness = 3
    end
end)

local title = Instance.new("TextLabel")
title.Text = "MM2 PREMIUM HUB"
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.Parent = mainFrame
applyRainbow(title)

-- Minimize Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local minimized = false
closeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainFrame:TweenSize(UDim2.new(0, 280, 0, 50), "Out", "Back", 0.5, true)
    else
        mainFrame:TweenSize(UDim2.new(0, 280, 0, 350), "Out", "Back", 0.5, true)
    end
end)

-- ฟังก์ชัน 1: Warp Loop
local tpActive = false
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9, 0, 0, 50)
tpBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
tpBtn.Text = "Auto Warp: OFF"
tpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.Font = Enum.Font.GothamMedium
tpBtn.Parent = mainFrame
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 10)

tpBtn.MouseButton1Click:Connect(function()
    tpActive = not tpActive
    tpBtn.Text = tpActive and "Auto Warp: ON" or "Auto Warp: OFF"
    tpBtn.TextColor3 = tpActive and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    
    while tpActive do
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and tpActive then
                player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                task.wait(0.2)
            end
        end
        task.wait(0.1)
    end
end)

-- ฟังก์ชัน 2: Run Pastebin Script (อัปเดตแล้ว)
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0.9, 0, 0, 50)
runBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
runBtn.Text = "Execute External Script"
runBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.Font = Enum.Font.GothamMedium
runBtn.Parent = mainFrame
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0, 10)

runBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/sY1Y3TpH"))()
end)
