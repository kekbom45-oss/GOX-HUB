--[[
    MM2 PREMIUM SCRIPT (GOX-HUB)
    Created by: Bamboo_3NgU
    GitHub: https://github.com/kekbom45-oss/GOX-HUB
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [0] Setup & Anti-Duplicate
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

-- [1] Intro Animation: MM2 Rainbow Text
local introLabel = Instance.new("TextLabel")
introLabel.Size = UDim2.new(0, 400, 0, 100)
introLabel.Position = UDim2.new(0.5, -200, 0.4, 0)
introLabel.BackgroundTransparency = 1
introLabel.Text = "MM2"
introLabel.TextSize = 1
introLabel.Font = Enum.Font.LuckiestGuy
introLabel.TextTransparency = 1
introLabel.Parent = screenGui
applyRainbow(introLabel)

TweenService:Create(introLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextSize = 120, TextTransparency = 0}):Play()
task.wait(1.8)
TweenService:Create(introLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextSize = 250, TextTransparency = 1}):Play()
task.wait(0.8)
introLabel:Destroy()

-- [2] Loading Bar: Green Download
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(0, 300, 0, 8)
loadFrame.Position = UDim2.new(0.5, -150, 0.5, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadFrame.BorderSizePixel = 0
loadFrame.Parent = screenGui
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(1, 0)

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
bar.BorderSizePixel = 0
bar.Parent = loadFrame
Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

bar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quart", 2, true)
task.wait(2.2)
loadFrame:Destroy()

-- [3] Ready Alert: Red Explosion (3 Seconds Total)
local readyLabel = Instance.new("TextLabel")
readyLabel.Size = UDim2.new(0, 400, 0, 50)
readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25)
readyLabel.BackgroundTransparency = 1
readyLabel.Text = "ระบบพร้อมแล้ว"
readyLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
readyLabel.TextSize = 50
readyLabel.Font = Enum.Font.GothamBold
readyLabel.Parent = screenGui

task.wait(1)
TweenService:Create(readyLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
    Size = UDim2.new(0, 1200, 0, 300), 
    Position = UDim2.new(0.5, -600, 0.5, -150), 
    TextTransparency = 1
}):Play()
task.wait(1)
readyLabel:Destroy()

-- [4] Main UI Design & Lightning Effect
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 3
uiStroke.Parent = mainFrame
applyRainbow(uiStroke)

-- เอฟเฟกต์สายฟ้าตรงกรอบ
task.spawn(function()
    while mainFrame and mainFrame.Parent do
        task.wait(math.random(4, 10))
        uiStroke.Color = Color3.fromRGB(255, 255, 255)
        uiStroke.Thickness = 6
        task.wait(0.1)
        uiStroke.Thickness = 3
    end
end)

local title = Instance.new("TextLabel")
title.Text = "MM2 PREMIUM HUB"
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.Parent = mainFrame
applyRainbow(title)

-- [Credit] ชื่อคนสร้าง Bamboo_3NgU
local devName = Instance.new("TextLabel")
devName.Text = "By Bamboo_3NgU"
devName.Size = UDim2.new(1, 0, 0, 20)
devName.Position = UDim2.new(0, 0, 0, 42)
devName.BackgroundTransparency = 1
devName.Font = Enum.Font.SourceSansBold
devName.TextSize = 14
devName.Parent = mainFrame
applyRainbow(devName)

-- ปุ่มย่อเมนู (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local minimized = false
closeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    mainFrame:TweenSize(minimized and UDim2.new(0, 280, 0, 50) or UDim2.new(0, 280, 0, 380), "Out", "Quart", 0.5, true)
end)

-- ปุ่มฟังก์ชันต่างๆ
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -30, 0, 250)
container.Position = UDim2.new(0, 15, 0, 80)
container.BackgroundTransparency = 1
container.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

-- ฟังก์ชันที่ 1: Auto Warp
local tpActive = false
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, 0, 0, 50)
tpBtn.Text = "Auto Warp: OFF"
tpBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.Font = Enum.Font.GothamMedium
tpBtn.Parent = container
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 12)

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

-- ฟังก์ชันที่ 2: รันสคริปต์จาก Pastebin (ตามที่คุณระบุ)
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(1, 0, 0, 50)
runBtn.Text = "Execute External Script"
runBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.Font = Enum.Font.GothamMedium
runBtn.Parent = container
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0, 12)

runBtn.MouseButton1Click:Connect(function()
    -- รันสคริปต์ตามที่คุณต้องการ
    loadstring(game:HttpGet("https://pastebin.com/raw/sY1Y3TpH"))()
end)

-- ฟังก์ชันที่ 3: ปิดสคริปต์
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(1, 0, 0, 50)
exitBtn.Text = "Exit Script"
exitBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
exitBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
exitBtn.Font = Enum.Font.GothamMedium
exitBtn.Parent = container
Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 12)

exitBtn.MouseButton1Click:Connect(function()
    tpActive = false
    mainFrame:TweenSize(UDim2.new(0, 280, 0, 0), "In", "Quart", 0.5, true)
    task.wait(0.5)
    screenGui:Destroy()
end)
