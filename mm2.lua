--[[
    MM2 PREMIUM SCRIPT
    Description: Elegant Rainbow UI with Lightning Effects
    Features: Auto Warp, Custom Loadstring, Smooth Intro
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ลบ UI เก่าถ้ามีอยู่
if playerGui:FindFirstChild("MM2_Premium_UI") then
    playerGui:FindFirstChild("MM2_Premium_UI"):Destroy()
end

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2_Premium_UI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- ฟังก์ชันรุ้ง (Rainbow System)
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

-- [1] Intro: MM2 Rainbow Text
local introLabel = Instance.new("TextLabel")
introLabel.Size = UDim2.new(0, 400, 0, 100)
introLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
introLabel.BackgroundTransparency = 1
introLabel.Text = "MM2"
introLabel.TextSize = 100
introLabel.Font = Enum.Font.LuckiestGuy
introLabel.Parent = screenGui
applyRainbow(introLabel)

task.wait(1.5)
TweenService:Create(introLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
task.wait(1)
introLabel:Destroy()

-- [2] Loading Bar
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(0, 300, 0, 10)
loadFrame.Position = UDim2.new(0.5, -150, 0.5, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadFrame.BorderSizePixel = 0
loadFrame.Parent = screenGui

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 127) -- สีเขียวสด
bar.BorderSizePixel = 0
bar.Parent = loadFrame

for i = 1, 100 do
    bar:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Quad", 0.05, true)
    task.wait(0.02)
end
loadFrame:Destroy()

-- [3] Ready Message + Explosion
local readyLabel = Instance.new("TextLabel")
readyLabel.Size = UDim2.new(0, 400, 0, 50)
readyLabel.Position = UDim2.new(0.5, -200, 0.5, -25)
readyLabel.BackgroundTransparency = 1
readyLabel.Text = "ระบบพร้อมแล้ว"
readyLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- สีแดง
readyLabel.TextSize = 50
readyLabel.Font = Enum.Font.GothamBold
readyLabel.Parent = screenGui

task.wait(1)
-- Effect ระเบิดหายไปภายใน 3 วิ
TweenService:Create(readyLabel, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 1000, 0, 300),
    Position = UDim2.new(0.5, -500, 0.5, -150),
    TextTransparency = 1
}):Play()
task.wait(1.5)
readyLabel:Destroy()

-- [4] Main UI Design
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 350)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- สำหรับ Executor ทั่วไป
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2.5
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = mainFrame
applyRainbow(uiStroke)

-- Lightning Effect (เอฟเฟกต์สายฟ้าตรงกรอบ)
task.spawn(function()
    while mainFrame and mainFrame.Parent do
        task.wait(math.random(3, 7))
        local originalColor = uiStroke.Color
        uiStroke.Color = Color3.fromRGB(255, 255, 255)
        uiStroke.Thickness = 4
        task.wait(0.1)
        uiStroke.Thickness = 2.5
        -- ปล่อยให้ระบบรุ้งเปลี่ยนสีกลับเอง
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

-- ปุ่มย่อเมนู (Minimize X)
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = closeBtn

local isMinimized = false
closeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame:TweenSize(UDim2.new(0, 280, 0, 50), "Out", "Back", 0.5, true)
    else
        mainFrame:TweenSize(UDim2.new(0, 280, 0, 350), "Out", "Back", 0.5, true)
    end
end)

-- Function Container
local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 2
container.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

-- ปุ่มฟังก์ชัน 1: Warp Loop
local tpActive = false
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9, 0, 0, 45)
tpBtn.Text = "Warp To Players: OFF"
tpBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.Font = Enum.Font.GothamMedium
tpBtn.Parent = container
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 10)

tpBtn.MouseButton1Click:Connect(function()
    tpActive = not tpActive
    tpBtn.Text = tpActive and "Warp To Players: ON" or "Warp To Players: OFF"
    tpBtn.TextColor3 = tpActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
    
    while tpActive do
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and tpActive then
                player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                task.wait(0.2) -- ความเร็วในการวาร์ปหาแต่ละคน
            end
        end
        task.wait(0.1)
    end
end)

-- ปุ่มฟังก์ชัน 2: Run External Script
local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(0.9, 0, 0, 45)
runBtn.Text = "Execute Pastebin Script"
runBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
runBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
runBtn.Font = Enum.Font.GothamMedium
runBtn.Parent = container
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0, 10)

runBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/sY1Y3TpH"))()
    end)
    if not success then
        warn("Script Error: " .. err)
    end
end)

-- เครดิตเล็กๆ
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Text = "Created by YourName"
credit.TextColor3 = Color3.fromRGB(100, 100, 100)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.SourceSansItalic
credit.TextSize = 12
credit.Parent = container
